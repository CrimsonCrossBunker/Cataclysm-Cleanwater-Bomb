# CDDA 3D 渲染层 — 设计与现状

本文件是 3D 渲染工作的**唯一活文档**。历史计划（TP 系列）已折叠进文末"历史"一节。

- **分支**：`3D`，创建于 `27de780e67`（= `upstream/master`，2026-10-15）。
- **策略**：冻结维护。**不整体 merge `upstream/master`**；只按需 cherry-pick 安全/构建
  修复，每次改动后由用户实测。
- **为什么不基于 0.I**：`upstream/0.I-branch`（0.I-1，2026-09-19）仍是 SDL2-only
  （vcpkg 固定 sdl2 2.26.4，无 `cata_shader`、无 `data/shaders`、无 GPU API）。
  本渲染器依赖 SDL3 GPU（`SDL_GetGPURendererDevice` + shadercross），无法直接迁移；
  回移 SDL3 后端约 6,400 行 / 95 提交，风险远大于收益。

## 设计不变量

1. **2D 渲染路径绝不改动**。`draw_terrain`、`draw_from_id_string_internal`、
   `draw_sprite_at`、`get_rotation_and_subtile` 保持与基点逐字一致；
   `get_texture_draw_data` 不得加入 3D 专用参数或分支。3D 只使用新增函数
   （`cata_tiles::resolve_sprite_layers_3d`、`get_terrain_rota_subtile` 等）。
2. **3D 贴图选取与 2D 逐字同义**：
   - `find_tile_looks_like` → `found_id`；
   - multitile 子瓦片键在 **found_id** 上重新解析；
   - `!force_rota && !rotates && category ∉ {NONE, MONSTER}` → rota 取 0；
   - 变体种子只作用于 fg/bg 列表 >1 的情况；
   - fg 单 sprite → 渲染时旋 `rota % 4`；fg 多 sprite → 下标 `rota % size`；
     bg 单 sprite 不旋转，多 sprite 下标 `rota % size`；
   - **不做任何 1↔3 下标交换**（用户明确决定；见文末上游语义问题）。
3. 游戏模拟只读；3D 改动只允许出现在 `src/render3d.*`、着色器与
   `cata_tiles`/`sdltiles`/`options` 的**新增**代码路径中。

## 架构

### 文件

| 文件 | 作用 |
|---|---|
| `src/render3d.cpp` / `.h` | 渲染器全部实现（约 2,100 行） |
| `data/shaders/terrain3d.vert` / `.frag` | 世界 pass：实例几何、UV 旋转、太阳漫反射、软遮罩、ghost 抖动、镂空 |
| `data/shaders/sky.vert` / `.frag` | 天空 pass：渐变、太阳盘/光晕、fbm 云 |
| `src/cata_tiles.cpp` / `.h` | 新增 `sprite_layers_3d` / `resolve_sprite_layers_3d`（2D 不使用） |
| `src/sdltiles.cpp` | 运行时接入、相机输入、光标转发 |
| `src/options.cpp` | `RENDER3D_EXPERIMENTAL`（依赖 `USE_TILES`） |
| `msvc-full-features/Cataclysm-libMZ-vcpkg-static.vcxproj` | `data/shaders/*.vert` 编译为 SPIR-V/DXIL |

### GPU 管线

- 复用 `SDL_Renderer` 的 GPU 设备：`SDL_GetGPURendererDevice(renderer)`（与
  `cata_shader` 相同模式）。3D 场景渲染到离屏 color+depth 纹理，再经
  `SDL_RenderTexture` 合成进地形窗口矩形；UI/ImGui 零改动。
- 顶点缓冲 + 每实例 64B 数据；每个 `(mode, atlas)` 一个 draw call。
- 模式：`MODE_BOX=0`、`MODE_XQUAD=1`、`MODE_BILLBOARD=2`、
  `MODE_BILLBOARD_SNAP=3`、`MODE_LINEQUAD=4`、`MODE_FLATQUAD=5`（无厚度水平面片，
  用于覆盖层与镂空地板，避免盒子侧面的黑缝）。
- 实例 flags：bit0 有贴图；bit1 不镂空；bit2-3 顶面 UV 四分之一转；bit4 侧面条带；
  bit5 ghost（50% 抖动半透明）。
- 常量：`VIEW_RADIUS=60`、`REGION_RADIUS=24`、`LEVEL_HEIGHT=2.6`、
  `FLOOR_THICK=0.1`、`WALL_HEIGHT=2.49`；`MAX_DRAW_INSTANCES ≈ 37.6 万`
  （121²×6 + 49²×6×21，缓冲约 24 MB）。

### 天空 / 天气

- 先天空 pass（CLEAR 全屏三角形），后世界 pass（LOAD）。
- 太阳方向：`sun_azimuth_altitude(calendar::turn)`，映射到场景
  `dir = (-sin az·cos alt, cos az·cos alt, sin alt)`；夜晚不画太阳，场景光照回退
  固定方向。
- 云量 = `1 − incident_sunlight(weather) / incident_sunlight(WEATHER_CLEAR)`；
  风向/风速来自 `weather.h`，云沿风向漂移（程序化 fbm，无逐格云数据）。
- 夜晚天空压暗（zenith ≈ 0.004/0.005/0.012），场景亮度下限 0.045。

### 跨层 gather

- z 范围 = `[-OVERMAP_DEPTH, +OVERMAP_HEIGHT]`（±10 层）；近区 ±24 全逻辑，
  远环（24<d≤60）只画当前层。
- **可见性 = 2D 逐格判定**：`level_cache::visibility_cache[z][x][y]` 为
  `LOW/LIT/BRIGHT`（即 `map::get_visibility == CLEAR`）才算可见；该缓存同时包含
  视线遮挡、光照阈值与 `unimpaired_range`，与 2D 绘制使用同一份数据。
  `seen_cache` 只是纯视线投射，仅用于上层的“完整细节 vs 轮廓”区分。
- 当前层（dz=0）：不可见 → 近黑地板 slab（保留雾区效果），不读真实地形/家具/物品；
  可见性每帧由 `game::draw` 的 `update_visibility_cache` 保证新鲜。
- 下层（dz<0）：只有 `[lowest_vision_level, center.z]` 范围内有新鲜
  `visibility_cache`；范围外整层跳过，层内不可见格跳过。
- 上层（dz>0）：与视平层同一逐格可见度判定，**没有"整块建筑"例外**。
  `update_visibility_cache` 只刷新到 `center.z`，所以上层逐格用
  `map::apparent_light_at` 现算；`seen_cache`/`camera_cache` 均未命中且无
  clairvoyance 时直接判 BLANK。引擎对从下方看上层地板/屋顶本就按 `floor_block`
  视为不可见（`shadowcasting.cpp`），因此站在本层看不到上一层的房顶和墙；只有
  相机/透视照到的上层格才显示。可见但非直接视线的上层格只画地板+墙轮廓
  （`roof_unseen`），不画家具/物品。
- dollhouse：玩家 12 格内的室内**当前可见**可走列，其上方各层只保留 50% ghost
  地板（bit5），其余内容整列跳过；相机→玩家软遮罩仍会挖除视线内的部分。

### 光照等级（逐格 tone）

- 每格算一次 `tile_tone { shade, sat }`，该格上**所有实例**共享：地面、fg 覆盖层、
  树/灌木、门/窗/栅栏/墙、家具、物品、物品高亮、生物。
- 等级来源与 2D 平滑光照完全一致：`smooth_lighting::classify_light_cell`
  （BRIGHT=1；LOW/LIT 用 `apparent_light_helper` + `light_above_threshold`）；
  上层没有新鲜 `visibility_cache`，用该层 `lm.max()` 按同一阈值归一。
- `shade = mix(shadow_shade=0.625, 1.0, light)`；`sat = smoothstep(0, 0.75, light)`。
  实例颜色 alpha 槽携带 `sat`，`terrain3d.frag` 按 2D `lit.frag` 的方式向灰度混合，
  低光下物体整体变暗并去色。
- 不做的：彩色光染色（illumination hue / tint overlay）、夜视仪专用色调。

### 夜视仪（TP-6）

- 触发与 2D 的 `nv_color_active` 相同：`get_avatar().get_vision_modes()[NV_GOGGLES]`
  （`Character::has_nv_goggles()`：`GNV_EFFECT` / `NIGHT_VISION` / `NVG_GREEN` 物品或模块）
  且选项 `NV_GREEN_TOGGLE` 开。视距加成（`get_vision_threshold` 的 +10）本来就会进入
  3D 使用的可见性/光照缓存，本轮只补颜色。
- 世界 pass：`terrain3d.frag` 复用 `nightvision_presets.glsl`，按 2D
  `smooth_lighting::reference_night_rgb` 的同一公式把精灵色映射成绿色夜视：
  暗处用 `nightvision_rgb`（乘 `night_floor` 起的光照），越过 `overexpose_start`
  后过渡到 `overexposed_rgb`；最后仍乘 3D 的太阳面明暗 `v_shade`。
  两个常量由 C++ 传入 `nv_params`，不写死在着色器里。
- 逐格光照的传递：夜视帧里实例颜色 alpha 槽临时改存该格 light（正常帧仍是饱和度），
  所有地形/家具/物品/生物无需改调用点。雾块与非 `cll_clear` 兜底的 alpha 固定 0，
  夜视下保持近黑；记忆实例（bit6）在着色器里提前返回，继续按 `MEMORY_MAP_MODE` 着色。
- 天空 pass：`sky.frag` 用同样的绿色变换（`params.w` 为夜视标志，按 daylight 过渡到过曝），
  使整个 3D 视口与 2D 一样是绿色。这是 3D 专有延伸（2D 无天空）。
- 关闭 `NV_GREEN_TOGGLE` 时 3D 画面完全不变（视距加成仍在，与 2D 一致）。

### 记忆中的地形（map memory）

- **记忆写入**：Render3D 不经过 `cata_tiles::draw`，所以由
  `cata_tiles::memorize_map_memory(center)`（3D 专用新增方法）复刻 2D draw 末尾的
  sweep：逐格 `visibility_cache` 为 CLEAR 时 `draw_terrain/draw_furniture/...`
  以 `memorize_only=true` 把地形与装饰写进 avatar 的 `map_memory`。
  扫描层 = `map::vision_levels()`（avatar 层 + 本回合视线真正到达的下层，
  含透过洞口/楼梯看到的下层），每层用各自的 visibility cache；上层不主动写入
  （与 2D 的绘制范围一致，上层记忆来自玩家曾在该层）。触发：
  `map_memory_sweep_pending`、玩家位置、`calendar::turn` 或
  `level_cache::sight_revision` 变化（等价于 2D 每回合重扫一次）。
- **区域准备**：每帧对整个 reality bubble 调
  `avatar::prepare_map_memory_region`，角点 z 固定为 0，使 `prepare_region` 的
  `±fov_3d_z_range` 缓存窗口恰好覆盖渲染的全部 z 层
  `[-OVERMAP_DEPTH, +OVERMAP_HEIGHT]`（`static_assert` 固化前提）。
- **渲染**：**所有层**。任何 `dz` 下当前不可见的格子都用记忆里的 id +
  **存储的 subtile/rotation** 解析精灵，几何复用实时路径的形状（地板/树/灌木/
  门窗薄板/栅栏半段 quad/墙盒，家具 billboard）。视平层无记忆时仍画近黑雾块；
  其他层无记忆时什么都不画。**视平层以上的记忆只画结构（地板/墙/门窗/栅栏），
  不画记住的家具**；视平层及以下的记忆家具照常显示。dollhouse 挖空列不填记忆，
  保持室内可见。
  只读记忆数据，不读实时地图，避免泄露未见变化。`dz != 0` 仍只在近区
  ±`REGION_RADIUS` 内绘制。载具部件（`vp_`）与陷阱（`tr_`）记忆不渲染。
- **着色**：实例 flags bit6 标记 memory；`terrain3d.frag` 对其实例套用 2D 的
  `MEMORY_MAP_MODE` 预设（`memory_presets.glsl`，四个命名预设 + 自定义
  `MEMORY_RGB_*` / `MEMORY_GAMMA`），**不受光照/去色影响**，与 2D 记忆叠加一致。
- 有意不做：`LIGHTING_MEMORY_BLEND` 的视线边缘渐变。

### 相机与软遮罩

- 俯视轨道相机：中键拖拽旋转、滚轮缩放、俯角可到接近水平；失焦释放鼠标。
- 软遮罩（FS UBO set=3 binding=0）：以 eye→player 线段为轴的椭圆横截面，
  `smoothstep` + hash 抖动实现软边；`t` 向淡出让玩家面前的墙恢复；作用于
  BOX / LINEQUAD / FLATQUAD。

### 3D 相机相对移动（TP-7）

- **屏幕系**：相机地面朝向 `f = (cos g_yaw, sin g_yaw)` 就是屏幕"前方"；屏幕"右方"是
  相机基 `r = cross(up, f) = (−sin g_yaw, cos g_yaw)`（与投影和 `screen_to_tile` 用的
  `g_basis_r` 同一个向量；地图是左手系，详见 TP-8）。地图 +x=东、+y=南；
  罗盘序 N,NE,E,SE,S,SW,W,NW 为 0..7。
- **换帧公式**：动作键方向 `a`（FORTH=0=N，顺时针 FORTH_RIGHT=1 … FORTH_LEFT=7）→ 地图方向
  `w = (k + a) mod 8`，`k = round(bearing(f)/(π/4))`。加号来自相机右基在罗盘上位于前方
  +2 格（相机朝东时屏幕右方是南）。这是旋转、不是镜像，所以两个方向各用一个函数：
  `render3d::camera_screen_to_map_delta`（动作键→地图）与
  `camera_map_to_screen_delta`（地图→动作，供自动旅行闭环）。
- **挂点**：沿用 2D 等距模式的 `iso_rotate` 接口（`get_delta_from_movement_action` /
  `get_movement_action_from_delta`）与 `input_context::get_direction` 的 `iso_mode` 分支；
  3D 激活时相机变换**取代**等距的 45° 旋转。走路、自动旅行（世界路线经同一对函数闭环）、
  examine/open/投掷/look-around 的方向键因此全部与屏幕一致。载具驾驶（`iso_rotate::no`）
  与 overmap 不受影响。
- **前方落点标记**：gather 每帧按 `k` 在 Up 键落点画一格 `line_target` 角标（UC 为黄色，
  与鼠标 hover 的白色 `highlight` 明确区分），它相对玩家的位置直接表明这一步是正交（正向）
  还是斜向；载具操控时（方向键是转向）不画，与游戏光标或鼠标 hover 同格时去重
  （同坐标两块薄板会 z-fight，前进语义优先）。
- **V 菜单聚焦**：`surroundings_menu::update_path_end` 每帧把选中格作为游戏光标推给
  render3d；gather 在任何游戏光标存在时不再画原始鼠标 hover（游戏光标是权威标记）。
  这样按 V 选中远处物品、镜头随 `SHIFT_LIST_ITEM_VIEW=centered` 平移时，高亮停在选中格，
  不再有过期鼠标像素随视图扫动。look-around/瞄准/建造同理只保留游戏光标；
  平时游玩、边缘滚动、驾驶的 hover 行为不变。

### 相机手性（TP-8）

- 地图坐标 x=东、y=南、z=上 相对物理空间是**左手系**（东×南 = 上，物理上应为下）。
  按右手惯例取 `r = cross(f, up)` 会得到物理右方的反向，整幅画面水平镜像
  （面向北时屏幕右方是西）。TP-7 相机相对移动因此表现为"屏幕上向左、地图上向东"。
- 相机基改为 `r = cross(up, f)`、`u = cross(f, r)`（`mat4_lookat`、缓存的
  `g_basis_r/u`、顶点 UBO 的 `cam_right` 三处同步）。画面从此与 2D 地图/overmap 同向；
  鼠标拾取、天空太阳方位、软遮罩都由同一组基驱动，保持一致；billboard 是居中对称四边形，
  观感不变。
- 中键水平拖拽的 `g_yaw` 输入取反（`-= dx`），保持镜像修复前"画面跟手"的旋转手感；
  俯仰不变。

### 贴图解析（3D 专用）

`resolve_sprite_layers_3d(id, category, p, subtile, rota, force_rota)`：

1. `find_tile_looks_like` 得到 `found_id`（如 `t_water_pool_shallow_outdoors` →
   `t_water_pool`）；
2. 若 `subtile >= 0` 且 `display_tile.multitile` 且 `available_subtiles` 含该键，
   在 `found_id + "_" + key` 上重新解析；
3. 按第 2 条不变量选 fg/bg 变体与旋转；
4. 返回 fg/bg 图层、`multitile`、列表大小/选中下标、`rot4`、`resolved_id`。

地形 gather 的 `shaped`（plain floor）走 `get_terrain_rota_subtile` 计算
subtile/rota；墙/栅栏/门窗强制 `SUBTILE_EDGE`；bg 查找先试子瓦片 id、再回退基础 id；
有 bg 的地板 = 不透明 bg 盒 + fg 镂空面片；无 bg 的透明地板用 FLATQUAD 全 UV 镂空。

门窗上下夹块（窗台/窗楣/门楣）继承同一墙线上墙的中段贴图：连续的门窗（含打开的门、
空门框/空窗框）视为一段整体，沿墙线跨过整段到两端的第一堵真墙取贴图
（东/北端优先，与旧侧格顺序一致）；两端都没有真墙（空地、栅栏、地图边缘、记忆缺失）
时夹块直接留空，不再绘制灰色占位盒。实时与记忆两条路径规则一致。

门洞（打开的门/大门、空门框、空窗框）与普通门同样处理：bg（无 bg 用 `t_floor`
兜底）做地板，fg 贴图作为 0..1.4 的立板，`PANEL_HEIGHT..WALL_HEIGHT` 的门楣
切片同样继承自 run 端点的墙；地面上不再保留平铺的 fg 贴纸。**上锁（LOCKED）
且带 bg 的关门面板**是分层贴图（UC 的 `t_door_metal_pickable`：bg=金属门板、
fg=钥匙图标）：两层都立到门板上——bg 打底、fg 以居中对称方式两侧各外凸 5 mm
（总厚 +0.01，alpha cutout，防 z-fight，两面都可见）叠加，地板改用 `t_floor` 兜底。判据：可通行、
非 WINDOW/DOOR/WALL/THIN_OBSTACLE、`connects_to` 含 WALL，且有 `close`
（打开的门）或 `FLAT + SUPPORTS_ROOF`（空框/拱门）。薄板家族除
DOOR/WINDOW/open 外还覆盖四类 `BARRICADABLE_DOOR*` 与 `LOCKED`（排除
THIN_OBSTACLE）——上锁/破损门因此按门板渲染，而不是 movecost==0 的整块体素；
但**不含裸 `close`**（带 WALL 的百叶窗墙不能变薄板）。该判据已对 core+mods
全部地形做过类别 diff 审计，除上述门类外零地形变化。

### 上锁/报警物体的分层贴图（TP-4.3.4）

- 2D 的 `draw_tile_at` 对每格**总是先 bg 再 fg**（同一 `tile.offset`）。UC 把少数"上锁/报警"物体拆成
  **bg = 本体、fg = 小图标**：`f_displaycase`/`f_safe_l`/`f_gunsafe_ml`（fg=钥匙 1778）、
  `f_gun_safe_el`（fg=电子锁图标 13023）、`t_window_bars_alarm`（fg=红色报警 8855，bg=栅栏窗 8657）。
  3D 原来家具只用 fg、窗户把 fg 当窗面并把 bg 铺在地上，所以只剩图标。
- 判定 `wants_layered_face`：`LOCKED | ALARMED | PICKABLE` 或 examine action `safe` / `gunsafe_el`
  （保险箱没有 flag），**且**该 tileset 定义了 bg。**不能**对所有带 bg 的家具分层：`f_earthbag_half`
  的 bg=6734 是地面草地，立起来会变成绿墙；`f_LIXA_machinery_electronic` 的 bg 也是地面。
- 家具（实时 + 记忆）：本体用 bg 走原 billboard 几何，fg 图标用**同一四元**再画一层，
  沿相机方向偏移 0.02 m（家具 0 / 物品高亮 0.03 / 物品 0.06 之间），避免严格 LESS 深度淘汰。
- 门窗面板（实时 + 记忆）：`layered_face` 不再排除窗口；窗面本身用 bg，fg 图标以同一窗面盒
  对称外扩 5 mm 叠在玻璃上，地面回退 `t_floor`。已有上锁门面板行为不变。
- 栅栏路径不动：`t_chaingate_l`/`t_retractable_gate_l` 的 bg 是整块地面，不能立；
  `t_door_bar_locked`（栅栏路径）同类症状留待后续单独处理。
- UC 中命中对象仅 5 个：上面 4 个家具 + `t_window_bars_alarm`。

### 角色布娃娃（TP-5）

- 每个可见生物 = 基础精灵 billboard + 2D 的全部 overlay 图层，id 与顺序完全沿用
  `Character::get_overlay_ids()` / `monster::get_overlay_ids()`，逐层经
  `find_overlay_looks_like`（3D 包装器 `find_overlay_looks_like_3d` 转调同一实现）解析：
  效果图标 → 变异/生化（按 `get_overlay_order_of_mutation` 排序）→ worn 衣物（内层到外层，
  含 `sprite_override` 与烧蚀护甲）→ wielded 武器。带 `override_look` 的生效变异照 2D
  换成该外观，overlay 只剩效果/移动模式。
- **画布对齐**：2D 把每层画在 tile 原点 + `tile_type::offset`（tilesheet 的 sprite_offset，
  单位=贴图像素）。3D 用基础精灵的像素高度定出统一的 米/像素 比例，overlay 的高度、底边、
  水平中心都按画布像素差换算，因此帽子/眼镜/长杆武器各归其位；**不能用** overlay 自己的
  `base_drop`（帽子的不透明底边在头顶，不在脚下）。UC 中基础身体在 `human_body_plus.png`
  （32×48，offset_y=-16），装备多在 `human_body.png`（32×36，offset_y=-8），底边差由
  offset 精确抵消。
- **深度**：管线 compare_op 是严格 LESS，且 base 与 overlay 常在不同 tilesheet（不同 draw
  call），不能靠提交顺序。每层沿朝向相机方向递增 4 mm（最多 24 层 = 9.6 cm，与物品
  0.03/0.06 同一手法），不依赖绘制顺序、不改着色器。
- 有意不继承：左右朝向翻转（billboard 恒面向相机、相机可旋转）、`height_3d` 堆叠、
  overlay 自带的 bg 层、骑乘（`rid_` / `mounted_player`）与
  `COPY_AVATAR_LOOK` / `COPY_SUMMONER_LOOK`。
- 临时诊断：`doll: <base> overlays=N resolved=M ids=...`（每 base id 一次，上限 120 行）。

## 构建与实测

```bash
taskkill //F //IM cataclysm-tiles.exe 2>/dev/null || true
"C:/Program Files/Microsoft Visual Studio/18/Community/MSBuild/Current/Bin/MSBuild.exe" msvc-full-features/Cataclysm-vcpkg-static.sln //p:Configuration=Release //p:Platform=x64 //m //v:m
```

- 着色器由 MSBuild 通配自动编译；`data/shaders/*.spv|*.dxil` 已被 `.gitignore` 忽略。
- 实测由用户运行 `render3d\启动3D测试.bat`（`--userdir render3d\test-profile`）；
  不要把启动游戏作为自动验证步骤。

### 诊断

`<userdir>/config/render3d_status.txt` 追加 `shape:` 行（最多 400 条）：

```
shape: t_water_pool_shallow_outdoors sub=corner rota=2 -> t_water_pool_corner list=4 pick=2 rot4=0 bg=yes
```

含义：原始 id、子瓦片键、rota、解析后的 id、fg 列表大小、选中下标、UV 旋转、是否有 bg。

## 已知限制与后续路线

- **TP-5 载具渲染**：`draw_vpart` 的部件贴图 + 朝向旋转接入 3D。
- **稳定性**：GPU 探针失败自动回退 2D（已实现）；关注实例缓冲上限与 gather 成本
  （±60 约 2.9 万格/帧）。
- 已知未覆盖：粒子/动画帧、多 tileset 叠加、载具、非当前 z 的记忆。

## 历史

### 已完成

- FP-P0：方块世界最小验证；FP-P1/P2：贴图化。
- TP-1/1.1–1.3.6：相机（俯视+旋转/俯仰/缩放）、门薄板朝向、窗户三段式、
  栅栏轴对齐面片、水面两层合成、家具 90° 步进 billboard、multitile 朝向变体。
- TP-2.x：跨层渲染、门三段式、相机→玩家软遮罩、物品/家具 z-fighting、
  无贴图物品 ASCII 字形、ghost 屋顶取代娃娃屋挖除。
- TP-3.x：渲染距离 ±60、天空/太阳/云、dollhouse 半径、云增强与夜空压暗、
  全地形多瓦片连接、栅栏拐角、透明地板双层合成、FLATQUAD 消除黑缝、全 z 层。
- TP-3.7：3D 可见性对齐 2D——逐格 `visibility_cache`（遮挡 + 光照 + 距离）、
  上层同样逐格按 `apparent_light_at` 判定（取消整块建筑例外）、生物改用 `avatar::sees`。
- TP-3.8：光照等级系统——复用 `smooth_lighting` 的等级分类与 2D lit 色调
  （`shade`/`sat` 每格一次，应用到该格全部实例；alpha 槽传递饱和度）。
- TP-4：记忆中的地形——3D 侧复用 2D 的 map-memory sweep 写入 avatar 记忆；
  视平层不可见格用记忆里的 id/subtile/rotation 绘制，并按 `MEMORY_MAP_MODE`
  预设着色（实例 bit6 + `memory_presets.glsl`），只读记忆、不泄露实时变化。
- TP-4.1：跨层记忆——记忆渲染扩展到渲染范围内的**所有 z 层**（dollhouse 挖空列
  除外），sweep 扩展到 `vision_levels()`（当前层 + 看穿洞口/楼梯的下层），
  记忆区域准备固定以 z=0 为锚点覆盖全部渲染层。
- TP-4.2：门窗夹块继承——连续门窗视为一段整体，沿墙线跨过整段到两端第一堵真墙
  继承窗台/窗楣/门楣贴图（打开的门计入 run）；两端都无墙时留空，不再绘制灰色
  占位盒。实时与记忆路径同步。
- TP-4.3：门洞与锁门——打开的门/空门框/空窗框保留地板并继承墙上部（门楣切片）；
  上锁/破损门（LOCKED / BARRICADABLE_DOOR*）进入门板薄片分支，不再画成整块体素。
  判据对 core+mods 全量地形做过类别 diff，仅门类地形受影响。
- TP-4.3.1：门洞立板——打开的门/空门框/空窗框并入普通门的面板渲染：bg（或
  `t_floor` 兜底）地板 + 0..1.4 的 fg 立板 + 继承门楣；地板上的平铺 fg 贴纸取消。
- TP-4.3.3：分层门板——上锁（LOCKED）且带 bg 的门面板（如 UC 的
  `t_door_metal_pickable`：bg=金属门板、fg=钥匙图标）把两层都立到门板上，
  bg 打底 + fg 两侧对称外凸 5 mm 叠加（两面都可见）；地板改用 `t_floor` 兜底。
  其余门/窗不变。
- TP-4.3.4：上锁/报警物分层——家具（展柜/保险箱/枪柜）按 LOCKED|ALARMED|PICKABLE 或
  examine `safe`/`gunsafe_el` 判定，bg 本体 billboard + fg 图标同四元叠层（相机方向 0.02 m）；
  报警窗 `t_window_bars_alarm` 的 `layered_face` 扩展到窗口，fg 图标外凸 5 mm 叠在 bg 窗面上，
  地面回退 `t_floor`。带地面 bg 的家具/栅栏保持不变。
- TP-5：角色布娃娃——可见角色/怪物按 2D `draw_entity_with_overlays` 的 id 与顺序绘制
  全部装备/变异/武器 overlay 层；按 tilesheet 画布偏移对齐；每层沿相机方向 4 mm
  深度偏移保证叠放顺序。
- TP-6：夜视仪——按 2D `reference_night_rgb` 的同一公式给 3D 世界与天空加绿色夜视变换；
  逐格 light 经实例 alpha 槽传入着色器，记忆/雾块/未看见区域不受影响；
  `NV_GREEN_TOGGLE` 关闭时完全不变。
- TP-7：相机相对移动——移动键与方向提示按相机屏幕系解释（复用 `iso_rotate`/`iso_mode`
  挂点，`w = (k + a) mod 8` 旋转映射）；Up 落点用 `line_target` 角标标出（正交/斜向一眼可辨，
  与鼠标 hover 的 `highlight` 区分）；V 菜单选中格作为游戏光标推入，存在游戏光标时不再画
  原始鼠标 hover，修复镜头聚焦远处物品时标记随视图扫动的问题。
- TP-8：相机手性修复——地图坐标是左手系，旧的 `r = cross(f, up)` 使 3D 画面水平镜像
  （面向北时按左会向东走）。相机基改为 `r = cross(up, f)` / `u = cross(f, r)`（lookat、
  缓存基、顶点 UBO 同步），画面与 2D 地图同向；中键水平拖拽 yaw 输入取反保持原手感。
- 2D 隔离 + 忠实移植：恢复 `get_texture_draw_data` 为基点实现；新增 3D 专用解析器
  完整复刻 2D 选取语义。

### 上游 `bf50a850944`（2026-04-18，master）

该提交把 `rota` 改为顺时针并同步交换了 `get_rotation_and_subtile` 的下标 1↔3，
但 tileset 按 `doc/TILESET.md` 的文档顺序（转角 `[nw,sw,se,ne]`、T/端头
`[n,w,s,e]`，逆时针）编写，导致 2D 多 sprite 的东北/西南、宽路东西侧 T、
东西端头互换；同提交把大地图道路改为 `(4-rotation)%4`。**本分支不修 2D**；
3D 与 2D 保持完全一致的下标语义，不做补偿性交换（用户决定）。
