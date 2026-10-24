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

### field 渲染（TP-10）

- **2D 语义**：每个可见格按 field-map 顺序绘制**全部** displayable field 条目
  （`display_field=false` 跳过）；先试 `fd_xxx_int<N>` 再回退基础 id；四邻（S/E/W/N，
  邻居需同 field 且可见）经 `get_tile_values` 得到连接 subtile/rotation
  （`fd_blood` 等 multitile 的 center/corner/edge/… 子图）；FIELD 的 `looks_like`
  链与等级 0 的 ASCII 兜底；field 不进入地图记忆；2D 中 field 画在物品之前。
- **3D 呈现**：按 `field_type::phase` 分类（PNULL 沿 `looks_like` 链取相位）——
  LIQUID/SOLID 画贴地薄片（`wz+0.001`，同格按 field-map 顺序每层 +0.3 mm）；
  GAS/PLASMA（烟、雾、毒气、火、电、等离子）画面向相机的 billboard
  （高 1.4 m、宽按贴图纵横比，同格沿相机方向每层错开 8 mm）。
- 世界 pass 无混合：两种呈现都传 **bit7 软 alpha**，按贴图 alpha 抖动近似 2D 的半透明
  （烟雾 64–254、蛛网 128–191、火焰 64–254、血迹边缘抗锯齿）。
- 连接形状经新增的 3D 专用包装 `cata_tiles::get_field_rota_subtile_3d` 调用 2D 的
  `get_tile_values`；无贴图时用等级 0 符号/颜色的字形回退。
- 已知限制：tileset layering 的 field_variants（火盆/油桶的 `fd_smoke_overlay` 专用贴图）
  未实现，与物品 layering 现状一致。

### 载具渲染（TP-11 第一步：平铺）

- **分层**：一格可叠多个部件；显示件 = 2D 的同一调用
  `vehicle::get_display_of_tile(mount)`（默认 below_roof+roof），内部按
  `vpart_location::z_order` 取最高者（armor -2 < roof 等 -1 < fuel/battery 3
  < engine 4 < structure 5 < under(轮子) 6 < center 7 < on_cargo 8 < on_roof 9），
  玩家是乘客时 on_roof 件隐藏（舱内视角）；hidden 件不显示、fake 件参与。
  2D 的 no_roof/roof 两 pass 画的是同一部件（仅差 height_3d 累积），3D 每格画一次。
- **贴图选取**：id `vp_<part>` + variant（`vp_frame_wood` → 逐段砍尾 → 基础 id →
  `looks_like` 链，全在 `find_tile_looks_like` 内）；subtile 仅 open_/broken/center，
  在 resolved id 上重解析且 variant 置空（broken 子瓦片 = bg 朝向底图 + fg 破损覆盖，
  两层都画）；rota = `angle_to_dir4(face-270°)`，多帧选 `rota%size`、单帧转 `rota%4`。
  **载具没有邻接连接子瓦片**（全 tileset 扫描：仅 3 个复古 tileset 的船板定义了
  center/corner/…，2D 对它们也只传 center，传相同值自动一致）。
- **呈现**：每格 display 件 → 贴地薄片（footprint = 贴图像素/32，偏移 =
  `tile.offset`/32，越界大图自然溢出），z = wz+0.004 在 field 薄片之上
  （2D 里 vpart 在 field/item 之后画）；bg→fg→货舱高亮（`highlight_item`）→
  携带家具（`carried_furn`，FURNITURE 类 subtile=0）逐层 +0.0003。
- **共面重叠（z-fighting）修复**：UC 约 1/3 的 vp 贴图是跨格大图（门/座椅/风挡用
  32×48 溢出北 0.5 格；前/后门 32×64 溢出北 1 格；trunk door 等 64×64 溢出北 1 格
  + 东西各 0.5；后视镜 64×64 四向各 0.5），与邻格薄片同 z 共面必闪；任何 z 偏置
  要压住深度插值噪声需随视距放大到厘米级，不可行。改用 **MODE_FLATQUAD_DECAL**
  （=6）：几何同 FLATQUAD，管线**关深度写**（测试保留）——薄片间纯画家算法，
  且 decal 不进 (mode, atlas) 分桶，而是进**一条按 push 顺序（= gather 行序
  = 2D 的北→南、西→东行序；同格 bg→fg→高亮→携带家具按 push 序）的实例流**，
  段组装时按"连续同图集"切成 run（每 run 一个 draw call）排在所有桶段之后：
  跨图集 seam 也严格按 2D 行序决胜，与 2D 完全一致且永不闪；薄片 vs 地板/
  field/墙仍走深度测试（盖上地板、被墙遮挡）。
- 无贴图回退：变体的方向符号（`get_symbol_curses(90°*rota, broken)`，open 时 `'`）
  + `vpi.color` 的字形薄片。
- 已知限制：载具不进入 3D 地图记忆（2D 会记 decoration，留待后续）；`vd.color`
  的血迹/货舱反色只影响 ASCII 路径，贴图路径不用（与 2D tiles 一致）。

### 载具立体化（TP-12：双侧立板 + 固定朝向帧；侧板位置后被 TP-25 内收一格）

- 全量三纵层（蒙皮抬升、轮子几何、物品/生物抬升）实测不可行已回退；最终方案：
  **左右翼子板都立，贴图用固定朝向帧，彻底脱离东西南北**。
  （TP-25 起：行宽 ≥3 时侧板立在门板格**内缘**而非外缘，门板格不再有体素盒。）
- **固定朝向帧**：UC 的侧立面画随朝向换边（北→左翼、东→右翼、南→右翼、西→左翼，
  且北/南帧的立面在图像内转了 90°），用朝向自己的帧无法统一。改为：左板恒按
  vrota=3（朝西帧：左翼是完整侧立面、车头在图像左端）解析，右板恒按 vrota=1
  （朝东帧：车头在图像右端）；蒙皮（地面平铺）仍用真实朝向帧。
- **立板规则**：显示件贴图带北向溢出（立面画）的格子，在 mount 左 (0,-1) / 右
  (0,+1) 外侧面（`parts_at_relative(..., false).empty()`，fake 投影不算车体）的
  格边缘平面立板；底边 z=+0.02，高 = 贴图高/32×0.9。沿轴跨度**锚定车头**：
  贴图前端点 F = 格前缘 − sgn*ox（64×64 角部贴图前溢半格，与蒙皮溢出一致），
  中心 = F − sgn*plen/2；u 交换 `swap = (is_left == (sgn>0))` 使两板贴图的车头端
  都朝真实车头。破损 = bg 板 + fg 板按 push 序（同一固定帧解析）。
- **相机排序画家流**：面板进独立 panels 子流，段组装时按
  `sort_key = pos·相机地面朝向` **降序 stable_sort**（远→近）接在蒙皮 decal 段
  之后——近侧板后画覆盖远侧板；远侧板在蒙皮（贴地无厚度）上方露出背面镜像，
  即"从车左面看 = 左外侧 + 右内侧"的效果（双面渲染 cull NONE 天然提供）。
  面板走 MODE_LINEQUAD_DECAL（关深度写、深度测试保留：墙/家具/生物遮挡正确，
  相机→玩家软遮罩照常挖洞看车内玩家）。
- 已知近似：车尾排不立板（其贴图是顶盖）；无溢出贴图（32×32 俯视件、
  自行车轮）不立板；远侧板背面是镜像贴图。

### 载具车头（TP-13：迎风面立板）

- **车盖（迎风面下段）**：前排外格（mount (1,0) 方向无邻格）且贴图带溢出的格子，
  用固定帧 **vrota=2**（车正对 2D 相机的那帧）的贴图在前缘平面立板：底贴地
  （+0.02），高 = 贴图高/32×0.55（32×48 ≈ 0.83 m）——必须低于挡风玻璃顶。
- **挡风玻璃（迎风面上段）**：显示件 `WINDOW && !OPENABLE && !DOOR`（风挡/强化
  风挡命中；门、尾门排除）且本格没立侧板（A 柱拐角由侧板表达）→ 同一 vrota=2
  贴图在**本格前缘**（车盖排后一格的边缘）立板：底 0.55、高 0.8、顶 ≈1.35 与
  侧板顶齐平——黑色玻璃带露出在车盖之上（"车盖后上方"）。
- 朝向：u 交换规则 `swap_u = (板运行轴 != 车左方向)`（k=2 帧车左在图像右侧，
  与正视镜像一致）；沿轴跨度与侧板同式；两板都进相机排序子流（车头看车盖近、
  玻璃远；车内看玻璃背面镜像）。破损双层同立。前角件同时得车头板+侧板，成拐角。
- 不做：风挡斜面（现为竖直"后上方"）、车尾立面（无立面贴图）、车灯发光。

### 载具车尾（TP-14：尾门立面 + 后挡风玻璃）

- **尾门/后盖板**：车尾外格（mount (-1,0) 方向无邻格）且贴图带溢出的格子，用
  固定帧 **vrota=0**（车尾正对 2D 相机的那帧：尾门 `door#rear`、后板
  `board#horizontal_rear`、64×64 尾灯拐角 `door_trunk#horizontal_2` 等）在本格
  **后缘**平面立板：底贴地（+0.02），高 = 贴图高/32×0.9（与侧板同式，尾门
  到车顶线）。u 交换：图像 x+ = 车右，应出现在车尾观察者右手边
  （`swap = (板运行轴 != 车右方向)`）。尾角格同时得侧板+尾板成拐角。
- **后挡风玻璃**：TP-13 的风挡规则按"离哪头近"分流——沿 mount x 前后各走计数
  非空列（上限 40），`dist_rear < dist_front` 的（sedan/coupe 的
  `windshield#horizontal_rear` 等）在本格**后缘**立后玻璃板（vrota=0 帧，底
  0.55、高 0.8、顶 1.35）；否则保持前风挡行为（前缘、vrota=2）。翼侧 C 柱拐角
  仍由侧板表达。
- 破损双层同立；全部进相机排序子流。
- 已知缺口：旅行车后排中段（door_trunk 回退贴图无溢出）不立，车尾中段为平面
  缺口；皮卡货斗尾板（俯视贴图）不立；64×64 角部尾板沿边偏移为近似。

### 载具车顶（TP-15/16/17：体素车身 + 车顶设备）

- 覆盖规则（TP-17 行覆盖）：mount 行内有任何 ROOF 件 → 该行所有车体格有顶
  （两翼门板列没有 roof 件但纳入；TP-16 的行区间规则漏盖两翼，已修）。
  车盖排/风挡排/尾排没有 roof 件 → 不盖；removed 件不算（拆顶破洞）。
- 车体（TP-17 体素盒）：有顶格推一个 MODE_BOX 实心盒（1×1 占地，wz+0.02 →
  wz+VEH_ROOF_Z(1.35)），无贴图 0.6 灰（gray153，TP-21 与贴图车身灰对齐）×
  光照（`vp_roof`/`vp_hdroof` 是占位
  纯色图、部件 color 是 ASCII 色，均无车身色可用）——顶面齐平成车顶、侧面在
  车体轮廓成实体墙，车体有整体感。相邻盒共享面完全共面且顶点相同 → 严格 LESS
  下稳定不闪；**竖板沿外法向前移 5mm**（否则共面的竖板在严格 LESS 下输给盒面
  不可见）。BOX 在软遮罩名单里：坐进车里照常挖洞看玩家。
- 车顶设备（TP-16/17/21）：有顶格且显示件 `location == on_roof`（警灯
  light_red/light_blue、太阳能板、探照灯、炮塔、风车等；乘客时隐藏由
  `get_display_of_tile` 内置处理）→ 贴图以 decal 画在 `wz + VEH_ROOF_Z +
  0.005`（盖顶盖），**原生足迹 + sheet 偏移**（与地面蒙皮同位；TP-17 的居中
  1×1 压缩会把警灯条缩成碎块，TP-21 还原）。地面蒙皮照画（顶破洞时仍有内容）。
  **TP-29**：sheet 偏移恒向世界北——车朝东/西时溢出区是**侧向**的，而东西帧
  的设备画是"立起来"的、art 伸进溢出区（警灯条 frame1 art 占 0–33 行），
  TP-25 去掉门板格体素盒后这半格悬空探出收紧后的车顶边缘 → 东西朝向时车顶
  设备 decal 丢弃 oy（quad 顶边对齐本格北缘，art 恰好居中回本格）；南北帧
  art 本就在格内（22–35 行），保持 2D 足迹不变。
- 已知限制：高车身（32×64 侧贴图 → 1.8 侧板）顶盖仍 1.35（内凹顶）；盒内
  生物/物品被实心车身遮住（玩家经软遮罩除外）；纯色平顶是基线观感。

### 载具全车体素 + 近距隐藏（TP-18）

- **全车体素盒**：每个有显示件的车体格都推 MODE_BOX（不再限于有顶行）。高度按
  部位分层：有顶行（行内有 ROOF 件，行覆盖规则不变）→ `VEH_ROOF_Z`（1.35）；
  其余按显示贴图北向溢出量（溢出=部件高度）`VEH_BODY_BASE(0.35) +
  VEH_BODY_PER_SPILL(0.9)×spill`——32×32 车架/货台 0.35（底盘矮台）、32×48
  门/车盖/座舱件 0.80（车盖排盒顶与 0.83 的车盖板基本齐平；风挡排盒顶 0.80、
  玻璃板 0.55–1.35 探出如真风挡）、32×64 高件（货车车身）1.25。自行车等无
  溢出件 → 0.35 低盒。（TP-25 起侧板格与后视镜格不再放盒。）
- **近距隐藏外壳**（TP-20 改为整车判定）：玩家与该车**任一部件格**同层且水平
  距离 < `VEH_PROX_HIDE_DIST`（5 格）→ **整辆车**的全部竖板（侧/车头/车尾/
  风挡）、体素盒、车顶设备贴图同时隐藏（逐车缓存判定结果；TP-18 原为逐格
  2.2 格，长车会出现半截车）；蒙皮/货舱高亮/字形等地面 decal 保留——贴近
  修车/看货舱时回到 2D 平铺视图，走远整车同时恢复。（TP-27 起互补：远距时
  蒙皮也隐藏，只留 3D 外壳。）
- 已知限制：开门时门洞处内饰仍被盒挡（盒不随门开合）。

### 载具车盖平放 + 玻璃贴座舱面（TP-19）

- **车盖平放**：TP-13 的迎风面竖板取消，车盖贴图（仍 vrota=2 正视帧）改为平铺在
  机盖排体素盒顶面（本格 1×1、z = 盒顶+5mm、decal 流），flat-decal rot4 =
  `(vrota+2)&3` 让图像底边的格栅纹朝真实车头；车头正面立面由体素盒灰面充当。
- **挡风玻璃贴座舱面**：旧位置在风挡格前缘（机盖盒与风挡盒之间），下段埋进
  机盖盒、整体悬空且离座舱一格远。现改为：座舱侧行有顶且本行无顶时，玻璃贴在
  座舱体素盒朝向本格的暴露垂直面上（本格盒顶 0.80 → 车顶 1.35，恰好覆盖暴露段），
  push_panel 外移方向取反（proud=−1，朝本格一侧外凸 5mm）；后玻璃对称（贴座舱
  盒后面）。敞篷等无顶车保持旧位置（0.55–1.35）。
- push_panel 新增 proud 参数（±1 控制沿法向外移方向；侧板/车尾板 +1 不变）。

### 载具贴图核对（TP-21：UV 裁剪 + 车顶设备还原 + 体素色 153）

- **根因**（extract.py 逐像素扫描确认）：32×48 部件贴图（halfboard_cover_*、
  halfboard_nw/ne、windshield_cover_*、windshield_horizontal_rear、
  light_red/blue frame0）的**北溢区（源图 0–15 行，sheet 偏移 (0,−16) 对应行）
  全透明**，画面恰好填满底部 32×32 足迹区。把完整 48 行 UV 压进 1×1（或 0.55
  高暴露面）→ 1/3 面积是透明弃像素：车盖只剩一截、风挡玻璃带只剩细缝。
- **crop_spill lambda**：`v0 += (v1−v0) × (−offset.y / px_h)` 裁掉溢出行
  （oy=0 的贴图自动不裁）；rot4 朝向逻辑不变（格栅仍朝车头）。
- **车盖平放**：bg/fg 经 crop_spill → 画面铺满机盖盒顶 1×1，与 2D 足迹 1:1。
- **挡风玻璃**（flush 与非 flush 都裁）：暴露面 0.80–1.35 恢复"顶部玻璃带
  （12/32）+ 下部灰仪表台"的完整 2D 构图；后玻璃（百叶纹）同理。
- **车顶设备**：撤销 TP-17 的"居中 1×1 无偏移"——改为与地面蒙皮**相同的原生
  足迹 + sheet 偏移**（dx+ox, dy+oy, px_w/32 × px_h/32、不裁 UV、rot4 照旧），
  仅 z 抬到 `VEH_ROOF_Z + 0.005`。警车 light_red/light_blue 装在相邻两格
  （(-1,0)/(-1,1)），两半条重新拼成完整一根（带 2D 同款轻微偏移，用户认可）；
  light frame1（东西朝向竖条）画面含溢出区，原生足迹下完整。
- **体素盒颜色**：0.72 → **0.6**（= 153/255，与贴图车身灰 gray153 同色）。

### 载具风挡格拆分（TP-22：玻璃带竖立 + "前车盖"平放 → 平放块被 TP-23 废止）

- 2D 的风挡格画面 = 玻璃带 + 一块前车盖（足迹底部 20 行灰色 cowl）；3D 此前把
  整块竖在座舱面上，风挡排盒顶（0.80）却是纯灰——缺那块平躺的前车盖。
- **玻璃竖板只留玻璃带**（flush 模式，保留至今）：`glass_band` 在 crop_spill
  后再把 v1 收到足迹顶 `VEH_WSH_GLASS_FRAC`（12/32，UC 风挡贴图实测）→
  玻璃带拉伸铺满暴露面 0.80–1.35（回归 TP-19"玻璃恰好等于暴露面高度"的原意）；
  非 flush（敞篷）保持整块足迹。
- ~~风挡排盒顶平放 2D 画面~~（**已删除**）：v1 只放 cowl 灰部 → 灰盖是 gray153
  与盒顶同色 → 完全隐身（实测"什么贴图没有"）；v2 整块足迹平放 → 黑玻璃带
  落在盒顶被误读为玻璃缝（实测否决）。平放语义整体废止，风挡排盒顶的"车盖
  后半"改由 TP-23 的机盖 decal 跨两排表达；后玻璃排盒顶回到无贴图。

### 车前挡风盖跨两排（TP-23：机盖平放 decal 延伸到风挡排盒顶）

- 起因：警用 SUV 实测——车座排正下方的 4 格（风挡排）盒顶没有任何车盖画面，
  只有再下方的机盖排 4 格有。2D 里 `windshield#cover_*` 变体 = **风挡玻璃带 +
  车前挡风盖合一**，车盖面视觉占两格（suv_front_k2.png 拼装确认：机盖排灰盖 +
  风挡排 cowl 灰连成一片）。
- 调查结论：cowl（风挡贴图 28–47 行）是纯平 gray153、无任何内部细节
  （cowl_on_box.png 合成证实灰对灰隐身）——所以 cowl 平放必然不可见；机盖贴图
  的可见细节（斜向高光条纹在源图 17–37 行、格栅 39–47 行）只有**跨两排拉伸**
  才会延伸到风挡排盒顶。
- 实现：车盖平放块新增门控 `hood_two_rows`——后邻格（mount+(-1,0)）的显示件是
  非开门风挡（WINDOW && !OPENABLE && !DOOR）**且该行无顶**（`!row_has_roof`）时，
  平放 decal 从 1×1 拉伸为跨两格（本格 + 后一格，沿 rear_dir 方向扩一格；UC 风挡
  贴图均 32×48 → 两排盒顶同 0.80，假定写在注释）。格栅仍在最前缘，条纹横跨两排
  → 连续两格车盖，与 2D 一致。rot4 规则不变（shader 在 quad 内旋转，与尺寸无关）。
- 角列自动覆盖：机盖角件（halfboard#nw/ne）后邻是 A 柱（windshield#wheel_*，
  WINDOW ✓ 无顶 ✓）→ 风挡排 4 格全部盖上。
- 反例排除：消防车 fire_truck 风挡排每格 windshield+roof 同格（真·"风挡+车顶盖
  同格"布局）→ 行有顶 → 盒顶 1.35 不延伸，机盖保持 1×1。
- 警用 SUV/警车/测试车结构相同（x=2 机盖、x=1 风挡无顶、x=0 座舱有顶）→ 全部
  自动命中跨两排。

### 无顶普通车体格的盒顶贴图（TP-24）

- 规则（用户定义）：一块车体**不属于**侧立板/尾板/前盖板/挡风玻璃四角色，
  **且没有车顶** → 把那格的 2D 贴图平铺到该格体素盒顶。覆盖：皮卡货斗、敞篷
  座舱座椅排、自行车架、无顶设备格等——此前盒顶是纯 gray153。
- 实现：尾板块之后新增"盒顶贴图块"，门控 = `vdrew && !near_hide &&
  !roof_covered && !got_side_panel && !is_windshield && !hood_tile &&
  !rear_tile`（hood_tile/rear_tile = has_elevation + 对应方向 exterior，即
  四类角色的现成判定）。贴图直接用蒙皮同一个 lookup `vl`（真实朝向帧、
  开门/破损 variant 与 2D 一致），crop_spill 裁溢出后 1×1 平放盒顶 +5mm
  （与车盖平放同规则），rot4 同蒙皮（bg=0、fg=fg_rot4）。glyph 回退不上盒顶。
- 边角语义：无溢出的车头格（自行车头管）不立车盖板 → 落到本块画贴图 ✓；
  无溢出的尾排格（皮卡货斗尾排）不立尾板 → 画货斗贴图 ✓；风挡格盒顶由
  TP-23 车盖延伸覆盖、后玻璃排盒顶保持无贴图（同 TP-23 决议）；整车近距
  隐藏时同步消失。**后视镜格除外（TP-26 接管）；侧板格本就排除，TP-25
  后侧板格连盒都没有。**

### 侧板内收 + 后视镜贴侧板 + 远距隐藏蒙皮（TP-25/26/27）

- **TP-25 侧板内收**：门板列格的空白盒顶是"体素与两侧之间的白条"。行宽
  ≥3（新增 `row_width` lambda，±10 列扫描，1/2 格宽的车不内缩）时，侧板从
  门板格**外缘移到内缘**（push_panel 传 `-d` + `proud=-1`，5mm 仍朝外贴住
  内邻车舱盒面）；该格**不再放体素盒**（`flank_tightened` 门控）——侧面看
  可透过车底见地面（用户选定的取舍），车顶随之收窄到车舱列。
- **拐角格同收 + 角件贴图内移一格**：车头/车尾角件格（halfboard#nw/ne、
  door_trunk#horizontal_2 等）同样内收去盒；其机盖平铺贴图 / 尾板立板
  **横向内移一格**落到相邻中间列上（decal 与竖板都不写深度，画家序/
  stable_sort 保序，不闪）。前盖/后盖视觉宽度 = 中间列宽，不探出收窄后
  的侧面线。push_panel 新增可选 `shift` 参数（尾板内移用）。
  **TP-28 修正：整幅叠放会与中间列自己的贴图整面重合（实测"两块贴图
  重合"），收紧拐角格的机盖/尾板 art 最终直接不画**，详见下节。已知近似：拐角机盖贴图内移后用本格 box_top 定高（UC 机盖排
  角件与中间列同为 32×48 → 同 0.80；若有高机盖角件会略悬）。
- **TP-26 后视镜**：`VISION`+`PROTRUSION` 旗标组合全数据唯一命中
  `wing_mirror`。后视镜格不放体素盒、不上盒顶贴图块；贴图**朝天平放**在
  内侧车身格（门板格）上方 `VEH_MIRROR_Z`(0.80)+5mm 处，内缘贴侧板、
  向车外伸出（找不到内侧邻格退回本格）。
- **TP-27 远距隐藏蒙皮**：2D 地面蒙皮（bg/fg 平铺 + glyph 回退）只在
  近距（near_hide，<5 格，外壳隐藏时）绘制；远距只留 3D 外壳。`vdrew`
  判定与实际 push 解耦（否则远距整车不画）。货舱高亮/随车家具 decal 不动。

### 角件 art 重合修复（TP-28：拐角格的机盖/尾板 art 直接去掉）

TP-25 的"角件贴图内移一格整幅叠放"实测出问题：拐角格尾板与中列尾板 span
精确重合、拐角格机盖（含 TP-23 两排拉伸）与中列机盖整片重合——角件贴图的
不透明构图（大灯/尾灯/拐角描边）与中列不同，灰叠灰假设不成立，看上去就是
"两块贴图重合"。曾实现过"内移保留 + 只留靠外半幅灯条"（VEH_CORNER_KEEP
几何裁剪），用户实测后拍板：**灯条/灯角直接去掉，不再渲染**。

- 收紧拐角格（`flank_tightened`）的机盖平铺贴图与尾板立板**整块不画**——
  机盖块与尾板块的门控各加 `!flank_tightened`；前盖/后盖宽度 = 中间列自身
  宽度，与收紧车身一致，零重合、不探出。
- 中间列的机盖（含 TP-23 两排拉伸）/尾板、风挡玻璃竖板全部不动；TP-28 的
  裁剪机制（VEH_CORNER_KEEP、push_panel keep/outboard、corner_u_crop）随之
  移除，push_panel 签名回到 TP-19 形态（末尾只有 proud）。
- 行宽门不变：行宽 <3 不收紧 → 角件照常画，窄车行为不变。

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

- **载具后续**：载具进入 3D 地图记忆（对齐 2D 的 decoration 记忆）、载具灯光、
  行驶动画/连续转向角（现为 4 朝向量化，与贴图帧一致）、风挡斜面、旅行车后排
  中段尾门缺口（door_trunk 无立面贴图）、车顶观感改进（现为纯色平顶）。
- **稳定性**：GPU 探针失败自动回退 2D（已实现）；关注实例缓冲上限与 gather 成本
  （±60 约 2.9 万格/帧）。
- 已知未覆盖：粒子/动画帧、多 tileset 叠加、非当前 z 的记忆。
- field 后续：tileset layering 的 field_variants（火盆/油桶专用覆盖贴图）未实现。

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
- TP-10：field 渲染——血迹/胆汁/酸液/蛛网等液固体画贴地薄片（带邻接连接子图与强度贴图），
  烟雾/毒气/火焰/电等气体等离子画面向相机的 billboard（高 1.4 m、软 alpha 抖动）；
  连接形状经 3D 专用包装复用 2D 的 `get_tile_values`。
- TP-11：载具平铺——每格显示件（`get_display_of_tile` 的 z_order 分层、乘客隐藏
  on_roof、fake/hidden 规则原样复用）的 2D 贴图以贴地薄片绘制：variant 解析、
  open/broken 子瓦片、朝向帧/单帧四分之一转、贴图偏移足迹、破损双层、货舱高亮与
  携带家具逐层错开；无邻接连接（与 2D 相同）。载具暂不进入地图记忆。
- TP-12：载具双侧立板——带北向溢出的立面贴图在车体左右外侧缘竖板；贴图用固定
  朝向帧（左板=朝西帧、右板=朝东帧，脱离实际朝向），沿轴锚定车头方向；面板进
  相机排序的画家子流（远→近），近侧板盖远侧板、远侧板背面镜像即内侧视图。
  全量三纵层（蒙皮抬升等）实测不佳已回退。
- TP-13：载具车头迎风面——前排外格贴图按固定 vrota=2 帧（车正对相机的正视图）
  在前缘立车盖板（≈0.83 m 高，格栅在下）；风挡件（WINDOW 且非门）在后排格前缘
  立挡风玻璃板（0.55–1.35 m，黑色玻璃带露出车盖之上）；u 方向按正视镜像规则
  逐朝向校准；两板进相机排序子流，前角件同时成侧板拐角。
- TP-14：载具车尾——车尾外格贴图按固定 vrota=0 帧（车尾正视图）在后缘立尾门/
  后盖板（与侧板同高同式，角部带尾灯）；风挡按离车头/车尾的距离分流前后
  （后风挡 sedan 类在后缘立后玻璃板）；尾角格侧板+尾板成拐角。已知缺口：旅行车
  后排中段尾门无立面贴图不立。
- TP-15：车顶层——有 ROOF flag 部件的格子在 1.35 m（与侧板顶齐平）铺无贴图
  纯色平顶（0.72 灰 × 光照），走 FLATQUAD 桶（深度写开、软遮罩挖洞看车内
  玩家）；拆顶破洞；风挡/车盖/尾排不盖。
- TP-16：车顶全宽拓展 + 车顶设备——覆盖改为行区间（行内 ROOF 件的 y 区间内
  全盖，两翼门板列纳入）；on_roof 显示件（警灯/太阳能板/炮塔等）的贴图画在
  顶盖上（decal 流，+5 mm），乘客时随 2D 规则隐藏。
- TP-17：体素车身——车顶从薄片改为每格 MODE_BOX 实心盒（wz+0.02→1.35，0.72 灰），
  车体成实心整体；覆盖修正为行内任一 ROOF 件即全行有顶（修复两翼漏盖）；竖板
  沿外法向前移 5mm 避免与盒面共面消失；车顶设备贴图改本格 1×1 居中不偏置
  （TP-21 已还原为原生足迹+偏移）。
- TP-18：全车体素 + 近距隐藏——体素盒拓展到每个有显示件的车体格（不再限于有顶
  行），高度按部位分层（有顶行 1.35；无顶按贴图北向溢出 0.35+0.9×spill：车架
  0.35 / 车门车盖 0.80 / 高车身 1.25）；玩家同层且距离 < 2.2 格时该格的竖板/
  体素盒/车顶设备全部隐藏，只留 2D 平铺贴图（贴近修车、看货舱不被外壳挡）。
- TP-19：车盖平放 + 玻璃贴座舱面——车盖从车头竖板改为平铺在机盖盒顶面（1×1、
  格栅朝车头，rot4=(vrota+2)&3）；挡风玻璃从风挡格前缘（悬空且下段埋入机盖盒）
  改贴座舱体素盒暴露垂直面（本格盒顶→车顶 1.35，恰好覆盖；push_panel 外移方向
  取反 proud=−1）；后玻璃对称；无顶车保持旧位置。
- TP-20：近距隐藏改整车判定——玩家到该车任一部件格 < 5 格（原为逐格 2.2 格，
  长车会只消失半截）→ 整辆车的竖板/体素盒/车顶设备同时隐藏，走远同时恢复；
  判定结果按 vehicle* 缓存避免逐格重算。
- TP-21：贴图核对——32×48 部件贴图的北溢区（sheet 偏移 (0,−16) 对应行）全透明，
  画面恰好填满 32×32 足迹区；整贴图 UV 压进 1×1/暴露面 → 1/3 浪费在透明区
  （车盖只剩一截、风挡玻璃带成细缝）。修复：crop_spill 按偏移裁 UV（车盖铺满
  盒顶、玻璃带恢复"上玻璃+下灰台"构图）；车顶设备撤销居中压缩、还原 2D 原生
  足迹+偏移（红蓝警灯重新拼成完整一根）；体素盒灰色 0.72→0.6（=贴图 gray153）。
- TP-22：风挡格拆分——2D 风挡格 = 玻璃带 + 一块前车盖（足迹底部 20 行灰 cowl）；
  flush 竖板改为只留玻璃带铺满暴露面（`glass_band`，保留）；风挡排盒顶平放块
  两案皆被实测否决（只放灰部 → 与 gray153 盒顶同色隐身；整块足迹 → 黑玻璃带
  平放误读为玻璃缝）→ 平放语义废止，由 TP-23 取代；敞篷保持整块足迹。
- TP-23：车前挡风盖跨两排——警用 SUV 实测缺风挡排 4 格的车盖面；cowl 为纯平
  gray153 无细节，改为机盖平放 decal 在后邻格是"非开门风挡且该行无顶"时拉伸
  覆盖本格 + 风挡排盒顶（条纹横跨两排、格栅在前缘，2D 连续车盖观感）；fire_truck
  类风挡+车顶同格车（风挡排有顶）自动排除。
- TP-24：无顶普通车体格（非侧板/尾板/车盖/风挡）的 2D 贴图平铺盒顶——皮卡货斗、
  敞篷座椅排、自行车架等盒顶不再是纯灰；贴图复用蒙皮 lookup（朝向/variant 与
  2D 一致），crop_spill + 1×1 + 盒顶+5mm。
- TP-25：侧板内收——行宽 ≥3 时侧板从门板格外缘移到内缘（贴住车舱盒侧面），
  门板格不再放体素盒（侧面可透过车底见地面，车顶收窄）；拐角格同收，其机盖
  平铺/尾板立板横向内移一格到中间列上（前盖/后盖宽度随之收窄）；1/2 格宽
  车辆不内缩。（角件贴图叠放方式后被 TP-28 修正。）
- TP-26：后视镜（VISION+PROTRUSION = wing_mirror）不放体素盒，贴图朝天平放在
  内侧门板格上方 0.80 处、内缘贴侧板。
- TP-27：远距隐藏 2D 蒙皮——超过 5 格后地面车辆贴图隐藏只留 3D 外壳；5 格内
  照旧只有 2D（与 TP-20 互补，vdrew 判定与 push 解耦）。
- TP-28：角件 art 重合修复——TP-25 整幅内移叠放与中间列贴图整面重合（实测
  "两块贴图重合"）；先改为只留靠外半幅灯条叠在新角落，实测后用户拍板
  **拐角格的机盖平铺/尾板立板直接不画**（机盖块/尾板块门控加
  !flank_tightened），前盖/后盖宽度 = 中间列宽，裁剪机制随之移除。
- TP-29：车顶设备东西朝向偏移修复——sheet 溢出恒向世界北，车朝东/西时溢出
  转为侧向，东西帧设备 art 伸入溢出区（警灯条 art 0–33 行）→ TP-25 去盒后
  悬空探出车顶半格；东西朝向时丢弃 oy（art 居中回本格），南北朝向不变。
- 2D 隔离 + 忠实移植：恢复 `get_texture_draw_data` 为基点实现；新增 3D 专用解析器
  完整复刻 2D 选取语义。

### 上游 `bf50a850944`（2026-04-18，master）

该提交把 `rota` 改为顺时针并同步交换了 `get_rotation_and_subtile` 的下标 1↔3，
但 tileset 按 `doc/TILESET.md` 的文档顺序（转角 `[nw,sw,se,ne]`、T/端头
`[n,w,s,e]`，逆时针）编写，导致 2D 多 sprite 的东北/西南、宽路东西侧 T、
东西端头互换；同提交把大地图道路改为 `(4-rotation)%4`。**本分支不修 2D**；
3D 与 2D 保持完全一致的下标语义，不做补偿性交换（用户决定）。
