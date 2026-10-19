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
- 下层（dz<0）：仅 `seen_cache > 0` 的格绘制，未见不画黑块。
- 上层（dz>0）：屋顶模式——露天（`NO_FLOOR`/无地板）跳过；非露天格画地板与
  墙/门窗/栅栏轮廓；家具/物品/生物仅 seen 才画。
- dollhouse：玩家 12 格内的室内已见可走列，其上方各层只保留 50% ghost 地板
  （bit5），其余内容整列跳过；相机→玩家软遮罩仍会挖除视线内的部分。

### 相机与软遮罩

- 俯视轨道相机：中键拖拽旋转、滚轮缩放、俯角可到接近水平；失焦释放鼠标。
- 软遮罩（FS UBO set=3 binding=0）：以 eye→player 线段为轴的椭圆横截面，
  `smoothstep` + hash 抖动实现软边；`t` 向淡出让玩家面前的墙恢复；作用于
  BOX / LINEQUAD / FLATQUAD。

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

- **TP-4 记忆中的地形**：读取 avatar map memory（2D MEMORIZED 层的灰度/低亮数据），
  以低饱和实例渲染；只读接口，不改 2D 绘制。
- **TP-5 载具渲染**：`draw_vpart` 的部件贴图 + 朝向旋转接入 3D。
- **稳定性**：GPU 探针失败自动回退 2D（已实现）；关注实例缓冲上限与 gather 成本
  （±60 约 2.9 万格/帧）。
- 已知未覆盖：粒子/动画帧、多 tileset 叠加、载具、记忆地形。

## 历史

### 已完成

- FP-P0：方块世界最小验证；FP-P1/P2：贴图化。
- TP-1/1.1–1.3.6：相机（俯视+旋转/俯仰/缩放）、门薄板朝向、窗户三段式、
  栅栏轴对齐面片、水面两层合成、家具 90° 步进 billboard、multitile 朝向变体。
- TP-2.x：跨层渲染、门三段式、相机→玩家软遮罩、物品/家具 z-fighting、
  无贴图物品 ASCII 字形、ghost 屋顶取代娃娃屋挖除。
- TP-3.x：渲染距离 ±60、天空/太阳/云、dollhouse 半径、云增强与夜空压暗、
  全地形多瓦片连接、栅栏拐角、透明地板双层合成、FLATQUAD 消除黑缝、全 z 层。
- 2D 隔离 + 忠实移植：恢复 `get_texture_draw_data` 为基点实现；新增 3D 专用解析器
  完整复刻 2D 选取语义。

### 上游 `bf50a850944`（2026-04-18，master）

该提交把 `rota` 改为顺时针并同步交换了 `get_rotation_and_subtile` 的下标 1↔3，
但 tileset 按 `doc/TILESET.md` 的文档顺序（转角 `[nw,sw,se,ne]`、T/端头
`[n,w,s,e]`，逆时针）编写，导致 2D 多 sprite 的东北/西南、宽路东西侧 T、
东西端头互换；同提交把大地图道路改为 `(4-rotation)%4`。**本分支不修 2D**；
3D 与 2D 保持完全一致的下标语义，不做补偿性交换（用户决定）。
