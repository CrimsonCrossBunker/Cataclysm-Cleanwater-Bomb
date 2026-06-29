# CDDA 模拟↔渲染解耦 — 长期计划

> 背景:放弃激进的 Godot 整体迁移(见记忆 godot-render-backend-refactor),改走逐模块解耦。
> 长期目标(用户定):①解耦渲染、模块化图形(可像 CBN 那样把图形分离成独立模块);
> ②允许未来接入新引擎;③客户端/服务端分离;④支持无头测试。
> 主约束:持续同步上游(cdda-upstream-pr-sync),`do_turn.cpp`/`cata_tiles.cpp` 是上游高频改动文件,
> 改动要小、自包含、可单独成 PR,尽量不与上游打架。
> 主构建:Windows / MSVC(VS18 msbuild Release|x64)。CMake/Makefile 为辅。
> 节奏:本文件是**长期路线图,不急着实现**。

---

## 0. 北极星与设计原则

**一条缝贯穿四目标**:把"推进世界(simulate)"与"呈现世界(present)"分成两侧,中间只隔一个
**显式的、可序列化的 view-model 快照**。一旦这条缝干净:
- 无头 = present 侧换成 null;
- 换引擎 = present 侧换实现;
- 模块化图形 = present 侧独立成模块/库;
- 客户端/服务端 = 把缝拉成进程/网络边界(快照过去、输入回来)。

**设计原则(贯穿所有阶段)**:
1. **缝切在 I/O 边界(渲染 + 输入),不切在全局访问模式上**——但 `g->u`(avatar 单例)是例外,见原则 5。
   `get_map()` 1556 处、`g->` 1683 处——把它们做依赖注入是死路,也非目标所需。
   sim 侧继续用全局无妨;只要 sim 的**产物**是快照、不直接喂给某个具体渲染器即可。
2. **每步可编译、可对现有 SDL 渲染逐像素验证、可单独成 PR**。绝不"大爆炸重写"——那正是上一条 Godot 路线翻车的原因。
3. **旁路镜像优先于劫持**(Godot 切片的血泪教训):新路径先与旧路径并存验证,确认无回归再切换。
4. **玩法中立**:解耦 PR 不夹带玩法/数值改动,降低上游冲突与 review 成本。
5. **快照按「显式视图区域 + 观察者」参数化,不默认绕 avatar**(由本 fork 未来设计倒逼,见 §0.5)。
   现状 cata_tiles 隐式以 `you.pos_bub()` 为视口中心(cata_tiles.cpp:647)。自由视角/自由 bubble/联机
   都要求快照能渲染「任意区域 + 任意观察者的 FOV」。此事**阶段 2 设计时定对几乎免费,事后返工很贵**。
6. **区分两条轴,别混为一谈**(见 §0.5):轴 A=渲染/present 解耦(本计划主体);
   轴 B=SIM 模型泛化(自由 bubble、`g->u` 去单例)。avatar 单例属轴 B,不要塞进渲染缝。
7. **渲染层不上 ECS**(2026-06-22 决策,用户已确认)。ECS 是 sim 层模式(几万实体批处理、cache 友好),
   不治渲染的任何病灶(即时模式、全局耦合、写回、RTTI 分发)——治这些的是**语义快照缝**(§3),不是 component 数组。
   ECS/组件化属轴 B(模拟经营实体管理)且因 `Creature→Character/monster`、`item` 是庞大继承体系,
   只做**局部组件注入**(给现有对象挂 component),绝不推倒重建。渲染层(present 侧)永不上 ECS。

---

## 0.5 两条轴 与 本 fork 未来设计(自由空间泡 / 自由视角·模拟经营 / 联机)

用户为本 fork 预定的未来设计**不与本计划冲突**,反而验证了"语义层快照缝"的选择。但它们暴露:
本计划只画了**轴 A**,而这些设计大部分活在**轴 B** 上。两轴大体并行,在「联机」处汇合。

| | **轴 A:渲染/present 解耦**(本计划阶段 0-4) | **轴 B:SIM 模型泛化**(未来设计,需独立工作量) |
|---|---|---|
| 内容 | ViewSnapshot、present 分离、RenderBackend、无头、异步 | 自由 bubble(CBN #3152)、`g->u` 去单例 / Game Objects(CBN #2250)、多实体指令/回合模型 |
| 交付 | 无头 / 异步 / 换引擎 / 模块化图形 | 自由空间泡 / 自由视角 / 模拟经营 |
| `g->u` 540+、`do_turn` 单 avatar 动作循环 `while(u.get_moves()>0)` | 不碰 | **攻坚目标** |

**逐条对照**:
- **自由空间泡** = CBN #3152。纯 SIM 侧、与渲染缝正交、不冲突。是「模拟经营」(看别处时基地继续运转)的前提。属轴 B。
- **自由视角 / 模拟经营** = 与渲染解耦**高度协同**:自由视角本质就是「present 渲染 sim 有数据的任意区域」,
  ViewSnapshot(若按原则 5 参数化)直接提供。但模拟经营要控制**多个实体** → 顶到 `g->u` 单例与单 avatar 回合模型(轴 B)。
- **联机** = client/server 终局(阶段 5+),**两轴汇合点**:每客户端各有视口+FOV → 快照「每客户端每帧一份、各带区域与可见性」(轴 A 原则 5);
  多 avatar → `g->u` 去单例(轴 B)。

**诚实结论**:渲染解耦是这三个未来设计的**必要前提与加速器,但单靠它一个都交付不了**——
每个还需各自的轴 B 工作量。做完阶段 0-4 ≠ 自动拥有模拟经营。轴 B 可跟踪/移植 CBN #2250、#3152 的成果。

---

## 0.6 客户端/服务端边界细化(2026-06-22 调研新增)

> 阶段 5+ 把缝"拉成进程/网络边界"时,边界**划在哪一层**决定成败。本节给判据 + 分层 + 跨缝清单,
> 是原则 5(区域参数化)的具体化。核心要避免的反模式:**服务端把图画好、客户端只贴图**(瘦客户端笑话)。

**判据(一句话)**:**同一服务端必须能同时挂一个 ASCII 客户端 + 一个图块客户端,都正常工作。**
只要服务端算 sprite 索引/颜色/tint/dimming,ASCII 与 tiles 立刻分家,判据破 → 逼边界落到**语义状态**上。
**CDDA 现状已隐式通过**(curses 与 cata_tiles 读同一份 `g` 产出两种画面)→ 本工程是把隐式缝**形式化**,非造新缝。

**分层(边界落 L3/L4 之间)**:
| 层 | 内容 | 归属 |
|---|---|---|
| L0 栅格化(像素/字形上屏) | | 客户端 |
| L1 精灵/字形选择:tileset 查表、ASCII 字符、旋转、变体、**光照上色、记忆/可见性 dimming** | | 客户端 |
| L2 绘制列表/场景合成:11 层、z 层合成、**动画插值、相机/自由视角/缩放** | | 客户端 |
| L3 **可见语义快照**(= ViewSnapshot,§3 阶段2):type id、光**强度**、可见/记忆**标志** | | **边界** |
| L4 权威世界模型:完整 map、生物、物理、FOV、行为结算 | | 服务端 |
| L5 意图/命令处理:校验并应用客户端命令 | | 服务端 |
"笑话" = 边界落 L0/L1(发像素)。正确位置 = L3/L4。D3D12/tint 崩溃**全属客户端层**,服务端不碰(印证阶段4根治崩溃)。

**跨缝实体四类(穷举)**:
- **A 快照**(每帧状态,全语义无 sprite/颜色):格 type id+旋转语义、光强数值、可见+记忆标志、
  实体记录(类别+type id+朝向+状态/特效语义 id+overlay 语义 id)、载具 part type+涂装**语义颜色名**(如 red 非 RGB)。
- **B 事件**(离散):战斗→add_msg;**语义声音**(双重身份:产生在服务端**参与 sim**怪物循声、播放在客户端);
  动画触发器(服务端发"A→B",**插值曲线属客户端**)。
- **C 命令**(客户端→服务端,语义意图):move/fire_at/wield… type id+目标坐标级别,**绝无按键、绝无光标中间态**。
- **D 易漏项**(评审重点):①RNG/种子必服务端(否则 MP 各端不同步,客户端不得自掷骰)②时间/turn 服务端权威 tick,客户端只本地时钟插值
  ③**overlay_ordering.cpp + tileset + 地形定义 = JSON 静态数据,两端预共享不过缝**,只**实例状态**过缝
  ④存档 = 服务端权威(印证阶段1)⑤debug/作弊 MP 须服务端校验。
  **D③/D④划定「预共享静态内容 vs 过缝实例状态」界线,划错会让缝重新渗漏。**

**⚠️ 通用归属判据(2026-06-22,防一类误判)**:**per-player ≠ 客户端侧。归属看「谁消费」,不看「是否每人一份」。**
sim 消费的 per-player 状态(血量、物品栏、**地图记忆**)仍是**服务端权威分片**——每玩家一份、进权威存档、联机下反作弊需它在服务端。
证据:地图记忆**被模拟逻辑消费**,非纯显示——autodrive 读 driver 自己的记忆规划路线(vehicle_autodrive.cpp:759-772「必须看见或曾看见过才能规划经过」)、map.cpp:2316-2406 读 `get_memorized_tile` 判 ter/dec 是否已知、iuse_actor.cpp:1679 用 `has_memory_at` 门控物品。
故"记忆该归客户端"的直觉里:**per-player 对、客户端侧错**——它是服务端的 per-player 分片。

**地图记忆三层模型(经营玩法逼出第 2 层)**:
| 层 | 是什么 | 哪侧 | 为什么 |
|---|---|---|---|
| 1 角色感知记忆 | 单角色见过什么,`ter_id`/`dec_id` 语义 | **服务端** per-character | sim 读它(autodrive/NPC 各一份) |
| 2 阵营/玩家知识 | 玩家(调度者)被允许看到什么 = 旗下角色记忆并集 + 阵营情报(战争迷雾) | **服务端** 派生层 | **反作弊**:gate 服务端发什么;客户端持有=可透图 |
| 3 客户端呈现缓存 | 收到的记忆 tile + subtile/rotation/symbol | **客户端** | 带宽副本,非权威 |
单 avatar 的 CDDA 里第 1、2 层重合(角色见到=玩家知道),只有一层;**经营玩法(多殖民者+上帝视角)把两者劈开,第 2 层是新增的服务端派生层**。
⚠️ 第 2 层**绝不能放客户端**:否则客户端能伪造"我知道这片地图"骗 autodrive、透战争迷雾。

**记忆带宽(存储≠传输)**:整份记忆待服务端(权威、进存档)**无问题**;风险只在**怎么传**。被三件事卡死,到不了"全量"量级——
①只发**视口区域**的记忆 tile(被屏幕大小 bound,**非探索总面积**)②`ter_id` 走预共享静态字典(D③)→ 跨缝是**小整数索引非字符串**,一屏个位数 KB 且只进视口时发一次 ③客户端缓存+delta(阶段 2 diff 友好),记忆几乎不变。
稳态带宽≈0。唯一要认真对待的是**自由视角/经营镜头远距离平移**→ 按需拉新区域记忆 = **区域流式**问题,与现有从磁盘流式加载 submap 同类,复用 async-submap-prefetch 预取。**结论:别 naive 发全量即可,带宽不是反对服务端存储的理由。**

**命令通道:不传按键,传语义命令(顺既有结构非发明)**:
`input_context` 已把输入解析成 **action_id 字符串**(`handle_input()` 返回 action,input_context.h:364);主循环本就 `action=ctxt.handle_input();if(action=="...")`
分发(game.cpp:2490/6245+)→ **裸键到不了游戏逻辑**;键位/CJK/手柄全在 action 层之下 → **输入整层属客户端**。
但 action_id 仍太低级不直接当跨缝命令(`"fire"` 需接瞄准→选目标→confirm;action 是 UI 模态相关)。
**正解**:回合内交互(瞄准/菜单/确认)整个留客户端走完,只把结论作一条语义命令发服务端(`fire_at{target_tile}`)——
顺带解决 MP "每次移光标卡一个 RTT"。与 action 系统**叠加非替换**:上面加一层 action 序列→语义命令归约,单机直通、拆进程才序列化。
**落点**:此细化主要服务阶段 5+(网络),但**命令归约层可在阶段 3(do_turn 拆分)时顺势确立**,因 handle_action 正是那时要处理的"玩家意图↔世界态硬耦合点"。

---

## 1. 承重事实(已核实)

- **无头已 ~95% 就绪**:251 个 Catch2 测试今天就无渲染跑完整模拟,靠 `test_mode` 全局标志;
  `ui_manager::redraw()` 在 test_mode 下 early return(ui_manager.cpp:380),输入被 stub。
  真正缺口是**构建配置**(测试二进制仍链 SDL/curses)而非代码耦合。
- **tilecontext 在非 TILES 下根本不编译**:sdltiles.h 整个被 `#if defined(TILES)` 包住;tile 绘制集中在 `use_tiles`/`tilecontext` 路径里,非 TILES 不链接 tile 符号。
  ⚠️**(2026-06-23 loop 校正)**:先前"animation.cpp 158 处 `if(tilecontext)` 守卫"系误计——实际 animation.cpp 仅 ~43 处 `tilecontext` **引用**、其中显式 `if(tilecontext)` 守卫**仅 1 处**(其余靠外层 `use_tiles`/函数本身只在 TILES 下有意义)。结构结论(非 TILES 干净编译、无强制 TILES 符号)不变,但"逐调用空指针守卫"的描述被夸大,勿据此假设每个 tile 调用都各自守卫。
- **catacurses 是干净抽象**:cursesdef.h 声明 ~26 个 `void` 函数(先前写 ~31,2026-06-23 校正) + ~4 个平台入口(refresh_display 等)
  + 3 个 input_manager 方法。ncurses_def.cpp(646 行)是接近完美的 null 后端模板。
- **渲染写回游戏态(唯一侵入点)**:draw 路径在 cata_tiles.cpp:3492 memorize_terrain、
  3583/3676/3740/4061 memorize_decoration、1549 memorize_clear、1509/1555/3486 cache set_dirty
  写回 avatar 地图记忆。渲染**不是纯读**。
- **do_turn 单体**:模拟+渲染+输入交织(do_turn.cpp:522-805);输入阻塞在渲染调用链内部。
- **深尾**:~620 处 mid-turn 阻塞式模态输入循环(look_around/veh_interact/advanced_inv/
  construction/iexamine),全部 inline 改游戏态,共用 ui_adaptor+input_context 模式但各自手写。

### 已校正的两处乐观假设
1. MSVC 的 `NoTiles` 配置走 **IMTUI(ImGui 文本 UI)**,不是真无头——仍有渲染后端依赖。
   真无头要 `TILES`/curses/`IMTUI` 全不定义。NoTiles 不能直接当模板。
2. 后端靠**文件顶部 `#if` 守卫**(非 glob 排除)。加 `null_backend.cpp` 不是纯加法:
   headless 不定义 TILES → ncurses_def.cpp 会与 null 后端撞车(符号重复)。
   ncurses 守卫须改 `#if !defined(TILES) && !defined(HEADLESS)`。

---

## 2. 上游同行参照(CBN,已核实)

Cataclysm: Bright Nights(DDA 的活跃分支)官方把**正是我们要做的方向**列为引擎议题
(Issue #3143「Game engine and infrastructure」),这给路线提供了同行验证 + 潜在移植源:

- **#3145 Rendering**:"SDL tiles renderer 古老、早已超出原始设计,**可能需要彻底重写**" — 与本计划同向。
- **#3144 Interface**:"界面代码与世界态紧密交织,导致难以测试" — 与我们测绘结论一字不差(印证阶段 1/3 的必要性)。
- **#3152 Reality bubble**:"只有一个 reality bubble,底层类一次做太多事" — client/server 的**深层障碍**
  (server 端需要多 bubble / 区域化模拟)。本计划近期不碰,但列为长期前置。
- **#2250 Game Objects**:统一实体管理(items/NPC/monster/vehicle/avatar 各用不同系统、有的离不开 `map`、
  有的硬连 `g->u`)— 是世界态**可干净序列化**的前提,与阶段 2 快照、未来网络复制强相关。CBN 在做,可跟踪。
- **#3146 Testing / #3113 Build**:测试受困于单体性、多套构建系统不同步 — 印证阶段 0 的价值。

**关于 CBN 的 Lua Tile Rendering(PR #8048)——反面教材 + 一处可偷的好设计**:
- ⚠️ 反面:`gapi.add_lua_tile(...)` 让脚本**直接读 `get_map()`/`get_avatar()` 再往渲染器塞 tile**,
  是又一条"逻辑直连渲染"的耦合路径,**不是**抽象层。"分离出类似 CBN 的图形"若指它,是要避开的样子。
- ✅ 可偷:`lua_tiles.{h,cpp}` 的**临时渲染对象模型 = handle + 双层生命周期清理(时间到期 + 离开 reality bubble)**。
  这正是异步渲染里"特效/瞬态视觉(爆炸/弹道/高亮)"该有的管理方式——快照之上的**瞬态视觉层**可借鉴此设计。

---

## 3. 目标态架构(草图)

```
            ┌─────────────────────────── SIM 侧(权威世界态)───────────────────────────┐
            │  game / map / creatures / weather ...   (继续用全局 get_map()/g->,无妨)   │
            │                                                                          │
            │   simulate_turn()  ──产出──►  ViewSnapshot(每帧 view-model,纯数据)        │
            │                                + TransientVisualLayer(瞬态特效,handle 模型)│
            └──────────────────────────────────┬───────────────────────────────────────┘
                                                │  (同进程引用 → 序列化 → 网络)
            ┌───────────────────────────────────▼──────────────────────────────────────┐
            │  PRESENT 侧(渲染模块,独立编译单元/库)                                      │
            │   RenderBackend 接口  ──┬── SDLBackend(现状,吃上游)                         │
            │                         ├── NullBackend(无头/测试/server)                  │
            │                         └── 新引擎 Backend(Godot/自研,复用 TCP 传输)       │
            │   present(snapshot) → 后端绘制;输入事件 ──回传──► SIM 侧                     │
            └───────────────────────────────────────────────────────────────────────────┘
```

关键:**RenderBackend 接口吃的是 ViewSnapshot,不是 SDL_Texture/SDL_Renderer**。
(对比上一条 Godot 路线:那是在图元层切缝,接口收 blit/fill,状态泄漏——本计划在语义层切缝。)

---

## 4. 分阶段路线

### 阶段 0 — `BUILD_HEADLESS` 构建目标(先做,最便宜)— ✅ 已完成并双构建验证
**目标**:不链 SDL/curses/ImTui 的二进制,能跑模拟与测试。交付"无头",强制出 server 链接边界。
**状态(2026-06-22)**:MinGW 与 MSVC 两条构建均已验证。`cataclysm-headless.exe` 链接表面 dumpbin 确认**只有 Windows 系统 DLL**(bcrypt/IMM32/KERNEL32/USER32/ADVAPI32/SHELL32),无 SDL/pdcurses;`--help`/`--jsonverify` 均 exit 0(全 JSON 数据加载、零渲染、不崩)。详见记忆 headless-phase0-probe-result。
**实际改动**(与原估基本一致):
- 新增 `src/platform_headless.cpp`(`#if defined(HEADLESS)`):catacurses 后端 + ImTui_ImplText 平台层 shim + input stub,~40 符号。
- 守卫:`ncurses_def.cpp:1` → `#if !(defined(TILES))` 保持(headless 不定义 TILES 但靠 HEADLESS 分流);`cursesport.h:5`/`cata_imgui.h:16` TUI 宏加 `defined(HEADLESS)`;`crash.cpp` curses include 守卫。
- `input_context.{h,cpp}`:`input_context_stack` 静态存储 guard 从 `__ANDROID__||TILES` 扩为含 `IMTUI||HEADLESS`(顺带修好 plain Release-NoTiles 整 sln 的预存链接错)。
- CMake:顶层 `option(HEADLESS)` + src/CMakeLists.txt headless 库块 + third-party imtui headless 变体。
- MSVC:**属性开关方案**(非新增命名配置,零 .sln 改动)——`/p:CDDA_HEADLESS=true` 叠在 `-NoTiles` 配置上。common.props 定义 `_CDDA_HEADLESS`+换宏(`HEADLESS;IMTUI` 取代 `USE_PDCURSES;…`)+去 pdcurses;ImGui-lib 排除 imtui-impl-ncurses.cpp;主 vcxproj TargetName=`cataclysm-headless`。
**探针顺带挖出 3 个 NoTiles 预存 bug**(2 个 plain NoTiles 也中招,详见记忆):①SDL_SOUND/SDL3 头错配;②ImGui-lib 缺 NoTiles vcpkg static triplet 档→联网重建 libogg;③input_context_stack guard 太窄(JsonFormatter 工具 TILES↔NoTiles lib 符号错配)。
**构建命令**:`msbuild msvc-full-features/Cataclysm-vcpkg-static.sln /m /p:Configuration=Release-NoTiles /p:Platform=x64 /p:CDDA_HEADLESS=true`(VS18 dev shell)。
**风险**:低(冲突面=2-3 守卫行 + 构建配置,上游极少动)。**已验证为真**。

### 阶段 0.5 — 确定性回放测试台(整个多年计划的安全网)
**目标**:无头构建的杀手级应用——**录制输入事件流 + RNG 种子 → 无头回放 → 断言世界态逐字节一致**。
**为什么先做**:阶段 1-4 每次重构都能用「回放同一段录制、diff 世界态」**证明行为不变**。
没有它,"这次重构改没改游戏行为"只能靠肉眼——而我们要连续多年改最核心的循环代码。第一个受益者=阶段 1(唯一动 cata_tiles 的危险改动)。

**⚠️ 实施策略:实测优先(2026-06-22 决策,推翻子代理的容器大改预估)**:
子代理审计估 0.5 为 **10-15 人天**,四拦路虎=RNG 初始种子 + **horde_map**(双层 `unordered_map`,horde_map.h:41-42)+ **overmap** + mapgen 迭代顺序,主张先把 unordered 容器改成有序。
**此预估很可能被误导,不予采信为起点**,理由:
- **矛盾证据**:251 个 Catch2 测试今天就可重复跑(审计自己第 6 节确认)。若 horde_map/overmap 的 unordered 迭代真破坏确定性,这些测试**早该 flaky**——它们没有。
- **概念混淆**:`unordered_map<tripoint,...>` 在**同一二进制单次进程内**,key 集合+插入历史相同则迭代顺序**确定**(不掺墙上时钟/地址)。真正破跨运行确定性的是 **key 里混入非确定值(指针地址、未播种 RNG)**,不是 unordered 容器本身。审计把"理论非确定"标红、把真问题标黄了。
- **审计自己找到的真东西被低估**:`node_address_hasher` **按指针地址哈希**(vehicle_autodrive.cpp:229)——这才是真·跨运行非确定,却被标 MEDIUM/"可控"。
  ⚠️**(2026-06-23 loop 校正)**:此前把 `simple_pathfinding.cpp:209` 也算作"指针哈希"系**误判**——实读 simple_pathfinding.cpp:209-215,`node_address_hasher` 按**坐标 x/y/z** 哈希(`cata::hash64`),**不含指针**,跨运行确定。**真正含指针地址的只有 vehicle_autodrive.cpp:229 一处**(且仅在 autodrive 寻路期活,不写存档/不参与回合结算的核心态)。结论反而**更乐观**:确定性的真实风险面比审计所述还小,§0.5 的"廉价实证优先"判断进一步加强。

**故 0.5 起步 = 廉价实证,而非盲改容器**:
1. **搭台(~1 天,机械活)**:①修 RNG 初始种子——`rng_get_first_seed` 用 `high_resolution_clock`(rng.cpp:203,已核实),无头/回放下强制走显式 `rng_set_engine_seed`,缺种子即报错;②录制/回放钩子插在**后端无关的输入漏斗**,非 `get_input_event` 本身;③**新增 `replay_mode`**(与 test_mode 互斥)——因 headless 的 get_input_event 在 test_mode 下**直接抛异常**(platform_headless.cpp:238-242,已核实),回放不能复用 test_mode,需"喂输入而不抛异常"的新模式。

**⚠️ 钩子落点修正(2026-06-23 loop 核查)**:`input_manager::get_input_event` **不是单一汇聚点**——它有 **4 份按后端实现**(ncurses_def.cpp:426 / platform_headless.cpp:238 / sdltiles.cpp:6609 / wincurse.cpp:707),钩在"返回前"得改 4 处且漏不走它的路径。**正确录制缝 = 后端无关的调用方漏斗**:
   - 主漏斗 `input_context::handle_input`(input_context.cpp:486,`next_action = inp_mngr.get_input_event(...)`)——**所有游戏内动作输入都过这里**,且此处已能拿到解析前的 `input_event`(保鼠标坐标/文本)又紧邻 action 翻译(input_context.cpp:492 `input_to_action`)。录制 `input_event`、回放时在此注入即可,后端只剩一个 stub。
   - 次漏斗 `input_manager::wait_for_any_key`(input.cpp:1001)等少数直调 `get_input_event` 的特例,回放下一并改走注入源。
   - 落点优势:钩在 handle_input 层与 §0.6「输入整层属客户端、action 序列归约成语义命令」天然同一处——0.5 的录制缝**预演**了阶段 5 的命令通道缝,一份基建两用。
2. **A/B 实证**:同种子+同输入,无头跑两遍,diff 世界态(复用 `game::serialize_json`,savegame.cpp:94)。
3. **让实测指认拦路虎**:两遍一致 → 0.5 几乎免费,审计 10-15 天作废;不一致 → diff **精确指出**漂移的子系统,只修那个(优先查 node_address_hasher 这类 key 含指针的真源,而非全量改 horde_map)。

**世界态对比**:复用存档 JSON 序列化(savegame.cpp:94 `game::serialize_json`),非另写 dump。
**风险**:搭台低(~50 行核心逻辑 + 序列化辅助);确定性修复的真实规模**由 A/B 实测决定,不预设**。**玩法中立、纯测试基建**。
**审计原始清单(留作对照,优先级待实测校正)**:RNG 种子(微小,真要修)、horde_map(疑虚惊)、overmap(疑虚惊)、mapgen/item_group 迭代(疑虚惊)、node_address_hasher 指针哈希(**仅 vehicle_autodrive.cpp:229 一处真含指针**,simple_pathfinding.cpp:209 已校正为坐标哈希、不构成风险;且 autodrive 哈希不进存档,审计标 MEDIUM **疑被高估**)、do_turn 时钟(do_turn.cpp:136-139,仅影响游玩时长统计,低)。

### 阶段 1 — 记忆写回从 draw 抽出(渲染变纯读)
**目标**:把 avatar 地图记忆写回从 cata_tiles draw 移到独立 pass,使渲染成为纯读。快照化前提。
**改动**:新增 memory-update pass(do_turn 末尾或 map cache 重建时),迁出 cata_tiles.cpp:3486-3492/3583/3676/3740/4061/1509/1549/1555
的 memorize_*/set_dirty;draw 只读已记忆 tile。
**⚠️ 深挖修正(2026-06-22,先前判断有误,已纠)**:读 `memorized_tile`(map_memory.h:22-54)后纠正——
记忆**已存语义 id**:`ter_id` 是 `ter_str_id`(类型 id)、`dec_id` 是 decoration id;旁边**附带**
`ter_subtile`/`ter_rotation`/`dec_subtile`/`dec_rotation`(int8 渲染朝向)+ `symbol`(char32_t,curses 字符)。
**故"L1 渲染产物污染存档"是我先前的错判**:实为「语义 id + 多套表现缓存(图块朝向 + curses 符号)混存」,
且 `set_tile_symbol` 与 `set_tile_terrain` 分开(map_memory.h:148-162)——记忆**早已同时服务 curses 与图块两套表现**。
存档迁移因此是**次要**风险(`ter_id` 已语义化,迁移面小),先前"最大风险=存档迁移"作废。

**真正的难点(评审核心问题:朝向归谁算)**:`subtile`/`rotation` 由 `get_connect_values`/`get_terrain_orientation`
(cata_tiles.cpp:3484-3488)按**当时可见的邻居**算出。被记住 tile 的邻居**事后可能不可见**→ 朝向必须在「看见那一刻」冻存。
**这正是 memorize 当初被放进 draw 的原因**:朝向计算本是渲染管线一部分,memorize 顺势复用其结果,**不是疏忽**。
于是把 memorize 移出 draw 有两条路、各有代价:
- (a) **连朝向计算一起搬到 sim 侧**:得把 `get_connect_values`/`get_terrain_orientation` 从 cata_tiles 剥出(现深嵌渲染态)——工作量大,但记忆变纯语义、最干净。
- (b) **记忆只存语义 `ter_id`、丢 subtile/rotation,客户端读记忆后用记忆里的邻居重算**:轻,但记忆稀疏(submap 级、有空洞)→ 邻居不全 → 朝向可能与初见不一致 → **视觉回归**。
此抉择与原则 5/客户端边界(§0.6)挂钩:朝向算"客户端表现"(走 b,ASCII 判据成立但需解决稀疏重算)还是"服务端语义"(走 a)。**评审须先定这条,才能动阶段 1。**

**✅ 抉择已定:走 (a) 搬 sim 侧 —— 剥离难度【低】(2026-06-23 loop 代码核查定论)**。先前以为 (a) "工作量大"是高估,实测证据反转:
- **两个朝向函数零渲染依赖**:`get_connect_values`(static,cata_tiles.h:733 / cata_tiles.cpp:6196)与 `get_terrain_orientation`(cata_tiles.h:741 / cata_tiles.cpp:5919)函数体**不碰 tilecontext/tileset/SDL**,只调 `map::get_known_connections()`、`map::get_known_rotates_to()`(只读 map 数据)+ 纯计算 `get_rotation_and_subtile()`。`get_connect_values`/`get_furn_connect_values` 已是 `static`,无 cata_tiles 成员访问。
- **底层依赖已在 sim 侧**:`get_known_connections`/`get_known_rotates_to` 实现就在 map.cpp(~2300/2357),已被非渲染路径(map.cpp:10372 `get_line_of_sight` 寻路)调用——搬朝向计算到 sim 侧**不引入新的 map 遍历成本**,是复用而非从零剥离。
- **记忆结构已支持**:memorized_tile(map_memory.h:48-53)已存 `ter_str_id ter_id` + `int8_t ter_subtile/ter_rotation/dec_subtile/dec_rotation` + `char32_t symbol`——无需改数据格式,走 (a) 不丢任何字段,(b) 的"记忆稀疏致视觉回归"风险**直接消失**。
- **落点**:把 `get_connect_values`/`get_terrain_orientation`/`get_furn_connect_values`/`get_rotation_and_subtile` 提取为 `map::` 成员或 map 模块内独立函数(它们已经几乎只依赖 map),sim 侧 memory-update pass 调用后写记忆;cata_tiles 改为从记忆读已算好的 subtile/rotation。
- **唯一需复核的尾巴**:`get_tile_values_with_ter` 含 `here.has_flag()` 渲染标志检查(难度【中】),提取前确认其语义在 sim 侧等价。其余皆低。
此结论也使阶段 1 从"全程唯一贵的侵入点"下修——侵入面仍在 cata_tiles(上游高频),但**逻辑搬迁本身不难**,真成本回归为"小步、玩法中立、对上游冲突的管理"。
**风险**:中(侵入 cata_tiles.cpp 上游高频文件;真风险=朝向计算与渲染管线耦合,非存档迁移)。**朝向归属已定走 (a) 搬 sim 侧、剥离难度低(见上)**,故此阶段成本回归为"管理上游冲突",非逻辑难度。趁早做成**干净、玩法中立的单独 PR**,先于阶段 2。
肉眼验证记忆区显示无回归(参考记忆里光照切片暗场景验证教训)。

**🔧 可执行第一步(2026-06-23 loop 落地,既然走 (a))**:
1. **抽函数到 map 模块**:把 `get_connect_values`/`get_terrain_orientation`/`get_furn_connect_values`/`get_rotation_and_subtile` 从 cata_tiles 提到 map 侧(`map::` 成员或 `map_memory` 邻近的独立 helper)。注意三个**渲染期参数**的处置:
   - `ter_override`/`furn_override`(`std::map<tripoint_bub_ms, ter_id>`):仅渲染预览(建造/覆盖)用,memorize 路径**传空**即可——搬迁时设默认空参,不引入渲染态。
   - `invisible[5]`(`std::array<bool,5>`):**FOV 派生,sim 侧已有**(观察者可见性),非渲染独有。按观察者 Character 的 FOV 计算,正好契合原则 5 的"观察者参数化"。
   - `rotate_group`/`connect_group`(`std::bitset<NUM_TERCONN>`):来自 terrain 定义(JSON 静态),两侧皆可读。
2. **建 memory-update pass**:在 do_turn.cpp 的 **simulate 段末尾**(~751 `u.process_turn()` 之后、~753 present 之前;或挂 `m.invalidate_visibility_cache()` do_turn.cpp:764 附近的 cache 重建点)新增 `update_map_memory(observer)`:遍历观察者 FOV 内可见格,调上面抽出的朝向函数,写 `avatar::memorize_terrain/decoration`。
3. **draw 改纯读**:删 cata_tiles.cpp 的 9 处写回(3492/3583/3676/3740/4061 memorize_* + 3486/1509/1555 set_dirty + 1549 clear),draw 仅 `get_memorized_tile` 读。
4. **验证**:① headless `--jsonverify` 仍 exit 0(无回归编译);② 进游戏走一圈,肉眼比对探索过/已离开区域的记忆显示与改前一致(尤其墙体连接朝向——这是走 (a) 要守住的不变量);③ 若已有阶段 0.5 回放台,A/B diff 存档证记忆字段逐字节一致。
**⚠️ 顺序依赖**:第 1 步(抽函数)可独立先成一个**纯重构 PR**(行为零变化,只是把渲染私有函数变成 map 可调),上游冲突最小;第 2-3 步(改写回时机)再成第二个 PR。拆两 PR 比一个大 PR 更易 review、更易在上游冲突时定位。

**📋 PR2 细分可行性计划(2026-06-23 loop,代码全核实后定稿;PR1=#241 已合)**

> ⚠️ 关键发现:PR2 比 plan 原想的复杂——memorize **不是 9 处分散写回**,而是 cata_tiles.cpp:1524-1558 一个**统一的 FOV memorize 循环**,用 `memorize_only=true` 复用 `draw_terrain/furniture/trap/part_con/vpart` 同一批函数(它们也被绘制层指针表 1042-1049 以 `=false` 调用做正常绘制)。`memorize_only=true` 时只算朝向+写记忆、短路掉 `draw_from_id_string`。所以 PR2 本质 = **把 memorize_only 路径从这批双用函数里剥成 sim 侧独立逻辑**,而非"新写一个 pass"。

**5 条 memorize 路径可抽离性清单(逐个核实)**:
| 路径 | memorize 时算朝向用 | 障碍 | 难度 |
|---|---|---|---|
| `draw_terrain`(3477-3493) | `map::get_connect_values`/`get_terrain_orientation` | 无(PR1 已搬) | 低 |
| `draw_part_con`(3736-3741) | 无(写死 0,0) | 无(纯 sim `partial_con_at`) | 低 |
| `draw_vpart`(4050-4061) | `vd.is_open`/`veh.face.dir()`/`angle_to_dir4` | 无(全 sim 数据) | 低 |
| `draw_furniture`(3574-3583) | `map::get_furn_connect_values` 或 `get_tile_values_with_ter` | ⚠️依赖 `get_tile_values_with_ter` | 中→低* |
| `draw_trap`(3673-3676) | `get_tile_values` | ⚠️依赖 `get_tile_values` | 中→低* |

*已核实两个尾巴函数零渲染依赖,可干净搬(见 PR2a)。`draw_graffiti`(3753)/`draw_field_or_item`(3775) 在 `memorize_only=true` 时开头 `return false` 短路,**不参与 memorize、PR2 不碰**。

**共性依赖(已核实全部 sim 侧可用)**:`invisible[5]`(FOV 派生)、`would_apply_vision_effects`(cata_tiles.cpp:3340 **仅一行** `return visibility!=CLEAR`,可搬)、`apply_visible`(cata_tiles.cpp:733 局部 lambda,逻辑同上可搬)、`map::get_visibility`(已 map 成员)、`level_cache::visibility_cache[x][y]`(已 sim 数据)、`map::memory_cache_*_is_dirty/set_dirty`(已 map 成员)。

**两个尾巴函数已核实可搬(推翻 PR1 的"中难度"标注)**:
- `get_tile_values`(cata_tiles.cpp:5919-5931):纯计算,已调 `map::get_rotation_and_subtile`,零依赖。
- `get_tile_values_with_ter`(5933-6009):用 `map::has_flag`(sim 地形标志 JSON,**非渲染标志**,map.h:1225)、`map::has_furn/furn`、`map::get_known_rotates_to_f`(map.h:1096)、`four_adjacent_offsets`(point.h:438 全局常量)——**全 sim 侧,无 tilecontext/tileset/SDL**。PR1 标"中难度"系误判(`has_flag` 看着像渲染其实是 sim)。

**三段式拆分(每步可编译可验证、风险递增、与 PR1 同性质先纯重构再改行为)**:
- **PR2a(纯重构,低风险,与 PR1 同性质)**:把 `get_tile_values`/`get_tile_values_with_ter` 搬到 `map::` static 成员(同 PR1 手法)。调用点:cata_tiles.cpp 的 furniture/trap/field 路径 + 任何其它处加 `map::` 前缀。⚠️**教训记取**:`git grep` 须扫全 src(尤其 sdltiles.cpp),勿只扫 cata_tiles.cpp;完整 TILES 构建验证(非仅静态库)。做完后 5 条路径的朝向计算全部 sim 侧可调。
- **PR2b(建 sim 侧 memory pass,中风险,改行为)**:① 把可见性 helper(`would_apply_vision_effects`/`apply_visible`)搬成 sim 侧自由函数或 map 成员;② 在 do_turn.cpp 新增 `update_map_memory(observer)`,**插入点 = `u.process_turn()`(do_turn.cpp:766)之后、`m.invalidate_visibility_cache()`(:779)之前**;③ pass 内复刻 1524-1558 的 FOV 遍历 + 5 条 memorize 路径的"算朝向→memorize_*"逻辑(用 PR1+PR2a 搬好的 `map::` 函数),写 `avatar::memorize_terrain/decoration/clear_decoration`(avatar.h:162-167,签名:`(tripoint_abs_ms, string_view id, int subtile, int rotation)`)。
- **PR2c(draw 改纯读,中风险,删旧路径)**:删 cata_tiles.cpp:1524-1558 的 memorize 循环 + 5 个 `draw_*` 的 `memorize_only` 参数与写回分支(memorize_*/set_dirty 共约 6 处),draw 仅 `get_*_memory_at` 读。⚠️ 注意 `draw_terrain` 3486 的 `set_dirty(p,true)`(发现新连接时重记)语义要在新 pass 保留。
- **验证(每个 PR 都做)**:① 完整 TILES 构建链接 0 错误;② 进游戏肉眼比对墙连接/地形过渡/家具/陷阱/载具/overmap 朝向无回归;③ **PR2b/2c 起 0.5 回放台可用**——A/B diff 存档证记忆字段(ter_id/subtile/rotation/symbol)逐字节一致(这是 0.5 安全网第一个真正受益的行为改动 PR)。
- ⚠️**可考虑合并 PR2a 入 PR2b 还是独立**:PR2a 是纯重构、独立交冲突最小(同 PR1 论证),建议**独立先交**;2b/2c 因共改 do_turn+cata_tiles 同一区,可视改动量决定合并或拆。

**✅ 第 1 步落地状态(2026-06-23,PR1 = PR #241 已提交 OPEN,base master←feat/stage1-orient-extract,6 文件 +310/−335)**:
- **实际搬了 7 个函数,非 plan 点名的 4 个**:`get_rotation_and_subtile` 的三个下级 helper `get_rotation_unconnected`/`get_rotation_edge_ns`/`get_rotation_edge_ew` 必须随行(否则编译不过),整簇搬到 `map::` **static 成员**(选了「map:: 成员」而非独立 helper)。
- **`NEIGHBOUR` 枚举搬到 `enums.h`**(原在 cata_tiles.h、被旋转 helper 引用)——plan 漏列的必要子任务。
- **`get_tile_values`/`get_tile_values_with_ter` 未动**(留 cata_tiles):它们是 §1 标注的「中难度尾巴」(含 `here.has_flag()` 渲染标志),不属纯重构 PR 范围,留待 PR2 或之后复核。
- **3 个查图函数改用 `get_map()`**(static 无隐式 this),与原 cata_tiles 取全局地图同对象;`ter_override`/`furn_override` 设默认空参 `= {}`。
- **⚠️ 调用点不止 cata_tiles.cpp(关键教训)**:最终调用点 = cata_tiles.cpp **8 处** + sdltiles.cpp **2 处**(在 `cata_tiles::get_omt_id_rotation_and_subtile` 内、overmap 瓦片渲染)。首轮只 grep 了 cata_tiles.cpp、漏了 sdltiles.cpp,被**完整 TILES 构建**(非静态库)暴露 → 已补 `map::` 前缀。注意 sdltiles.cpp 另有 `oter_t::`/`terrain.get_rotation_and_subtile`(2 参成员方法)与搬的 4 参 static 同名但无关,勿动。
- **✅ 验证已完成**:完整 TILES 配置(Release|x64,target `Cataclysm-vcpkg-static`,exe 名 `cataclysm-tiles.exe`)编译链接通过 0 错误;进游戏肉眼比对墙体连接/地形过渡/家具/overmap 道路河流朝向**无回归**(§1 第 4 步 / §5.1 验收② 满足)。0.5 回放台测不到本 PR(全调用点 TILES-only、headless 不调 = 死代码路径),故用完整 TILES 构建 + 肉眼朝向作验证手段。
- **⚠️ 构建陷阱(记录备查)**:① Git Bash 把 `/m /p:` 吃成路径(`/m`→`M:/`),命令行 msbuild 须前置 `MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*'`;② VS IDE 会自动给 .sln 补 headless 的 `ARM64EC`/`x86` 幽灵配置(无对应 vcpkg triplet → 报错),非本工程改动,`git checkout` 丢弃,PR1 保持纯 6 文件 src。

### 阶段 2 — 插入 ViewSnapshot 中间层 + 瞬态视觉层
**目标**:sim 与 cata_tiles 间插显式 per-frame view-model;渲染器从快照画,不再直接读 get_map()/lm[][]。先同进程同线程,零行为改动。
**⚠️ 区域参数化(原则 5,必须一开始就定对)**:快照 schema **不内置 avatar 中心**,而是显式带
`{视图区域 (z + bbox)、观察者(决定 FOV/可见性/记忆的 Character&,可非 avatar)}` 两个参数。
现状渲染走 `you.pos_bub()`(cata_tiles.cpp:647)只是「观察者=avatar、区域=其周围」的一个特例。
此设计让自由视角/自由 bubble/联机(每客户端各自区域+FOV)免返工;事后补很贵。
**快照 schema(来自 cata_tiles 读集测绘)**:每 tile 含
terrain/furniture(+4邻)/trap/graffiti/field(type+intensity)/items(topmost)/vpart(display state);
lit_level + light color + light scalar;creature(id/type/facing/mount/summoner flags);memorized tile;radiation;overlay 调试态。
**⚠️ diff 友好(与区域参数化同性质:现在几乎免费、事后返工很贵)**:schema 从第一天起带
**稳定 tile key + 每 tile dirty/version 跟踪**。联机必须 delta 编码(只发变化 tile,非每帧 ~4000 条 blit);
为整帧 blit 设计的 schema 事后加 diff 是重写。顺着地图已有的 `memory_cache` dirty flag 模式做。

**📐 schema 落成 struct 草图(2026-06-23 loop,把散文变类型;遵 §0.6 L3 边界=纯语义,绝无 sprite 索引/RGB/tint)**:
```cpp
// 全部用 *_str_id / *_id(语义类型 id),不含任何渲染产物。客户端拿到后自行 tileset 查表上色。
struct TileView {
    // —— 地形/家具(连接朝向已在 sim 侧算好,见阶段1走(a))——
    ter_str_id   terrain;       furn_str_id  furniture;
    int8_t ter_subtile, ter_rotation, furn_subtile, furn_rotation;  // 语义朝向,非像素
    trap_str_id  trap;          // 陷阱(语义 id)
    // —— 覆盖物 ——
    field_view   field;         // { field_type_str_id type; int intensity; }(非颜色)
    int          graffiti_idx;  // -1=无;字符串走预共享字典
    item_view    topmost_item;  // { itype_id id; int8_t count_bucket; }(只 topmost 显示态)
    vpart_view   vpart;         // { vpart_id part; uint8_t display_state; std::string paint_color_name; } 涂装=语义色名(red),非 RGB
    // —— 光照(劈两半:强度数值进快照,上色 tint 纯客户端)——
    lit_level    lit;           // 可见/记忆/暗 等枚举
    float        light_scalar;  // 光强数值(客户端据此算 tint)
    // light *color* 不进快照——是客户端表现
    // —— 可见性/记忆标志(语义)——
    uint8_t      vis_flags;     // bit: visible / memorized / dark
    int          radiation;
    // memorized tile 用既有 memorized_tile(map_memory.h)语义结构,不另存
    // —— diff 友好 ——
    uint32_t     version;       // 每 tile 版本号;delta 编码只发 version 变化的 tile
};
struct view_snapshot {
    // 原则5:区域+观察者显式参数化,不内置 avatar 中心
    tripoint_abs_ms origin;       // 视口左上角世界绝对坐标;origin.z = 底部 z-level
    int    observer_z = 0;        // 观察者所在 z-level(≠ origin.z),用于 height_3d 计算
    point  size;                  // 视图区域行列数(cols × rows)
    character_id    observer;     // 决定 FOV/可见性/记忆(可非 avatar)
    std::vector<TileView> tiles;  // row-major,size.x*size.y
    std::vector<CreatureView> creatures;  // { creature_id; mtype/character 类别+type id; facing; mount/summoner flags }(无 sprite)
    // 瞬态视觉层独立(见下),不进每 tile
    uint64_t        generation = 0;  // 单调代次;每次快照重建(dirty gate)递增,客户端插值用
};
```
**草图取舍**:① 朝向字段在快照里(int8 语义),前提是阶段 1 已把朝向计算搬 sim 侧——两阶段在此咬合;② `paint_color_name`/`graffiti` 走语义而非 RGB/字面串,联机时配预共享字典变小整数(§0.6 D③);③ `version` 字段从第一天就在,delta 编码免事后重写;④ 此为**草图非最终**,字段名/类型待阶段 2 实做时对齐 cata_tiles 真实读集复核。

**📋 阶段 2 落地测绘(2026-06-25 loop,阶段 1 收口后全代码核实;PR2 记忆迁移 = #244 已合)**

> ⚠️ **关键发现(推翻"从零造快照层"的预设,与阶段 1 同一性质的好消息)**:cata_tiles **已有一个 per-tile 缓存** `draw_points_cache`(`map.h:410-466` `draw_points_cache_t`,存 `tile_render_info` 数组,`map.h:352-396`),是 movement-stutter-perf 修复时引入的(见记忆 [[movement-stutter-perf]])。它在 `cata_tiles::draw` 的重建 pass(**cata_tiles.cpp:748-1015**,`draw_points_cache_dirty` gated)里**逐 tile 算好并冻结**了:`lit_level ll`、`invisible[5]`(中心+4 邻可见性,经 `apply_visible` lambda @733)、tint 状态(`needs_tint`/`tint_color`/`bounds`/`tint_sprites`)、vision_effect(BOOMER 等)。**这正是 ViewSnapshot 的雏形——光照/可见性半边已经冻结了。**

> ⚠️ **但它只冻结了「光照+可见性+tint」,没冻结「语义内容」**——这是阶段 2 真正要补的另一半。11 个 `draw_*` 层函数(`drawing_layers` 表 cata_tiles.cpp:1042-1049)在**布局循环里(1153-1195)逐帧从 sim 现读** `here.ter(p)`(draw_terrain @3438)、`here.furn(p)`(@3515)、`here.tr_at(p)`(@3605)、`here.field_at(p)`/`maptile_at(p)`(@3701/3795)、`here.veh_at(p)`(@3967)、`here.partial_con_at(p)`(@3669)、`here.graffiti_at(p)`(@3689)。**故"重建 pass 那点已冻结全部数据、在 756 行 fork 即可"是错的**——语义读散在下游层函数里。
>
> **阶段 2 真正的缝 = 把这批 `here.*` 语义读从 11 个层函数上移进重建 pass、连同已冻结的光照一起进 `tile_render_info`,层函数改为从 struct 读。** 与阶段 1 同构:看着像"造新层",实为"扩一个已经做了 60% 的现成结构"。

**读集分类(子代理全 src 核实,cata_tiles.cpp 行号;按 §0.6 L3 边界判「该不该进快照」)**:
| 类别 | 现读点 | 返回 | 进快照?(L3 语义=进 / L0-2 渲染产物=客户端留) |
|---|---|---|---|
| 地形 | `here.ter(p)` @3438 + 朝向 `map::get_connect_values/orientation` @3451/3453 | `ter_id`+subtile/rotation | ✅ 语义 id+int8 朝向(朝向已阶段1搬 sim) |
| 家具 | `here.furn(p)` @3515 + 邻居 | `furn_id`+朝向 | ✅ 语义 |
| 陷阱 | `here.tr_at(p)` @3605,`tr.can_see(p,you)` @3606 | `trap_id` | ✅ 语义(can_see 是 FOV 判定,观察者参数化) |
| 场/物品 | `here.field_at(p)`/`displayed_field_type` @3701,`maptile_at(p).get_uppermost_item` @3795/3885,`sees_some_items` @3913 | `field_type_id`+intensity / `itype_id`(+corpse mtype/variant/count) | ✅ 语义(强度数值进、颜色不进) |
| 载具 | `here.veh_at(p)` @3967,`get_display_of_tile` @3970(id/is_open/is_broken/variant/has_cargo),`veh.face.dir()` @3973 | `vpart_id`+display state | ✅ 语义;⚠️`get_vpart_tint` @3978 返 RGB = **渲染产物,不进**(客户端据涂装语义色名自算) |
| 涂鸦 | `has_graffiti_at`/`passable`/`graffiti_at` @3683/87/89 | bool+string | ✅ 语义(串走预共享字典 §0.6 D③) |
| 半施工 | `here.partial_con_at(p)` @3669 | ptr/bool | ✅ 语义(写死 subtile 0,0) |
| 记忆 | `get_*_memory_at`/`get_memorized_tile` @3349-3494 等 | `memorized_tile`(已语义) | ✅ 已是语义结构(map_memory.h),invisible 路径读 |
| **光照** | `visibility_cache[x][y]` @817→`lit_level`,`get_visibility` @736→`visibility_type` | 枚举 | ✅ **已在 tile_render_info 冻结**(`ll`/`invisible`/vision_effect) |
| **光色 tint** | `light_color_cache[x][y]` @1107→RGB,`lm[x][y].max()` @1125→float | RGB / float | ⚠️ **劈两半**:强度 float **可进**快照(L3 数值);RGB tint **是客户端产物**(L1 上色)——现 `tile_render_info` 把算好的 tint_color 也冻了,阶段 2 schema 须把"强度数值"与"RGBA tint"分清(数值过缝、上色留客户端) |
| 生物 | `creature_at(p)` @4369 + monster/Character 类别/type id/facing/mount/summoner flags/attitude/overlay ids @4421-4799 | 语义 id+状态 | ✅ 全语义(独立 `CreatureView`,见草图);sprite 选择留客户端 |
| 调试 overlay | scent/radiation/temperature/snow/visibility/light @823-990 | 数值/bool | ✅ 全语义数值(debug-gated,可后置) |

**实施(已合并为 PR #272 `feat/stage2-snapshot-terrain-capture`,branch → master,5 文件 +560/−234)**:

PR #272 将原计划的 2A/2B/2C 三步**合并在一个 PR 中提交**,而非分开。具体包含:

| 原代号 | 实际 commit | 内容 |
|--------|------------|------|
| 2A step 1 | `5da747bf1a` | terrain 层捕获 (CATA_VERIFY_DRAW_CACHE 自检) |
| 2A step 2 | `7b24627385` | furniture/trap/part_con/graffiti 全静态层捕获 |
| 2A 配套 | `bdd23b9faa` | 装饰变化时 invalidate draw-points cache |
| **2B** | `9ce5ad2956` | draw terrain/furniture/trap/part_con/graffiti **从捕获 cache 读**，删 live `here.ter(p)` 现读 + 删 CATA_VERIFY_DRAW_CACHE 自检脚手架 |
| **2C** | `b71eb21919` | 提取 `view_snapshot` 类型(`src/view_snapshot.h`,321行)，`draw_points_cache_t`/`tile_render_info` 从 map.h 迁入；`view_snapshot::{origin,observer_z,size,observer,generation}` 区域参数化(原则5)；cache 从 `map::` 成员变为 snapshot 成员 |

**✅ 2A/2B/2C 交付物**:
- **静态层(terrain/furniture/trap/part_con/graffiti)**: 重建期捕获语义内容 → 布局期层函数从 cache 读，不再 live-read `here.*`
- **动态层(field/item/vpart/creature)**: 仍 live 路径（双节奏决策，待后续每帧 tier）
- **`view_snapshot` 类型**: `{origin(tripoint_abs_ms), observer_z, size(point), observer(character_id), tiles(draw_points_cache_t), generation(uint64_t)}`，显式带区域+观察者参数
- **`view_snapshot.h` 内显式记录 7 个已知 gap**（L253-293）：坐标分裂、消费期可变性、RGBA tint 混入 L3、缺 field/item/vpart/creature/light-scalar/memory-tile/per-tile-version 数据、序列化未实现、ownership 仍在 map

**⚠️ 实施偏差 vs 原计划**:
1. 2A/2B/2C **合并为一个 PR**（非 3 个独立 PR），5 个 commit 线性堆叠
2. 2C 的 `view_snapshot` 提取了区域参数化（origin/observer_z/size/observer/generation）但 **per-tile version 未实现**（留 gap #5）
3. ~~`tile_render_info` 内部仍混 L3 语义 + L1-L2 渲染产物（tint_color/sprite_screen_bounds/tint_sprite_records），**尚未做 L3 纯净拆分**（留 gap #2/#3）~~ → ✅ **已解决 (#294)**：`common` 拆为 `tile_view_data` + `tile_render_scratch`
4. 动态层（field/item/vpart/creature）+ CreatureView 独立快照 **全部留待后续 PR**

**剩余工作(阶段 2 未完项)** — 以 `view_snapshot.h:253-293` 的 7 个 gap 注释为权威清单：

| Gap | 内容 | 状态 |
|-----|------|------|
| #1 | 坐标分裂 | `origin` 是 abs 但 `tile_view_data::pos` 是 bub；服务端快照需全 abs |
| #2 | 消费期可变 | ✅ RESOLVED (#294)：`common` 拆为 `tile_view_data`(const L3) + `tile_render_scratch`(mutable L1-L2) |
| #3 | 假顶峰 | ✅ RESOLVED (#294)：RGBA tint/bounds/sprite recordings 限定在 `tile_render_scratch`，`tile_view_data` 仅含 pos |
| #4 | 缺失 L3 数据 | field(item+intensity) / item(topmost itype_id+count) / vpart(id+display state+paint color) / creature(CreatureView) / light scalar / memory tile / per-tile version |
| #5 | generation | 当前仅 bare uint64_t；client-server 需 game turn + sub-turn tick |
| #6 | 序列化 | draw_points_cache_t + tile_render_info 无 serialize() |
| #7 | ownership | 当前嵌在 `map` 内；未来由 `simulate_turn()` per observer 产出为独立值对象 |

剩余 #4 工作量最大（动态层 + CreatureView + per-tile version），#5–#7 是 client-server 硬前置。

**⚠️ 2026-06-27 状态更新**: 2D+2E 曾合并为一个 PR (#273) 提交但已被 revert (#275)。根因：提交管理混乱（2D 的 4 个子步骤 + 2E 全部捆绑）、代码注释命名混乱、PR 文本描述严重错误。**正确做法**：2D 拆为 4 个独立 PR（2D1 SCT → 2D2 handle → 2D3 advance+bubble → 2D4 highlight），2E 独立成 1 个 PR。详见本文件底部分步计划。

**瞬态视觉层(✅ 2026-06-27 已完成)**:爆炸/弹道/高亮/SCT 等特效独立成 handle + 双层生命周期(时间/bubble)对象层(借鉴 CBN lua_tiles 设计),叠在快照之上。
详见子计划 `stage2d-transient-visual-layer.md`。已交付:handle 系统(effect_handle+alloc_handle+cancel_effect 6路dispatch)、SCT 浮动文字、高亮异步化、bubble离开自动清理。MSBuild Release|x64 0错误。
**复用资产**:Godot 切片的 **TCP/帧序列化/atlas 桥**当传输层,内容从图元换成快照。
⚠️**(2026-06-23 loop 核查)**:`godot_bridge.cpp`/`godot_tile_backend.cpp` **不在 `feat/headless-build-target` 分支**(`git ls-files "*godot*"` 空、工作树无此文件),只存于历史提交——`0406b39e56`(共享内存镜像)、`98a54143bc`(localhost TCP 流式 tile)、`58684df9e4`+`3b5e3f2e3e`(逐 tile 光照变体,后者标 UNVERIFIED 半成品)。**"复用"=从这些提交 cherry-pick/参考其传输层代码,不是 src/ 现成可调**。动手前先 `git show 98a54143bc:src/godot_bridge.cpp` 取出。
**风险**:中高,工程量大。每步对现有 SDL 渲染逐像素验证。

### 阶段 3 — 拆 do_turn 成 simulate / present + tick/帧率解耦 ✅ 已完成

> ✅ **阶段 3 结构分离已收口**（3A #292 + 3B #291 + 3C #293）。
> **异步（sim 线程 / render 线程分离）不在阶段 3 交付范围内**。原标题里的"异步"是乐观预估；真异步需要线程安全的 view_snapshot（双缓冲/mutex）、SDL 线程亲和处理、输入命令回传重构、UI 模态循环去阻塞——这些是阶段 4（RenderBackend 接口化）和阶段 5+（网络）的工程，阶段 3 的词汇量级装不下。

**seam map(do_turn.cpp:522-805 逐行已分类)**:
- `simulate_turn_prefix()` ← 528-644(全 SIM)。
- `do_avatar_action_loop()` ← 647-744(玩家输入 + 动作,mid-step 渲染在 `render_mid_step()` 内)。
- `simulate_turn_suffix()` ← 746-813(全 SIM,含从 present_turn 迁入的 7 项世界态更新)。
- `present_turn()` ← 815-876(纯渲染 + 音频 + UI,不再含世界态突变)。
- **收益**:tick 率与帧率可独立调节(mid-step gate 跳帧不丢世界态 + 回合末世界态不受帧率影响)。`present_turn()` 已纯渲染,为阶段 4 RenderBackend 接口化清路。
- **风险**:中(do_turn 上游高频,已分 3 个独立 PR 小步交付,回放台可验证)。

### 阶段 4 — 渲染模块化为独立编译单元 / RenderBackend 接口
**目标**:把 present 侧收口到 `RenderBackend` 接口(吃 ViewSnapshot,不吃 SDL 类型),SDL 成为其一实现,
渲染代码独立成模块(独立库/目录),为换引擎与 client/server 留插口。
**前置**:阶段 2(快照)+ 阶段 3(present 分离)完成后才有意义。
**注**:这是"模块化图形 + 允许接入新引擎"两目标的落点。NullBackend(阶段0)与未来新引擎 Backend(复用阶段2传输层)都是此接口实现。
**🎯 这是 D3D12 崩溃的根治,不是为架构而架构**:整个旅程起点是走路崩溃 / ASCII 低倍率崩溃
(见记忆 walk-crash-gpu-tint-overlay、ascii-lowzoom-d3d12-crash,现靠强制 vulkan/d3d11 **对症绕过**)。
干净的 RenderBackend 边界让崩溃高发的 SDL3-GPU 路径**降格成众多可换实现之一**——这是治本。给阶段 4 一个具体杀-bug 理由。

### 阶段 5+(深尾,多年量级,非近期)
完整 client/server 真正卡点(**轴 A 与轴 B 汇合区**):
- **~620 处 mid-turn 阻塞式模态循环**(look_around game.cpp:6027、veh_interact、advanced_inv、construction、iexamine ~102 处)。
  每个需从"inline 改态"重写成"请求/响应 + 延迟变更",处理网络中断的取消/回滚。每个大循环 4-8 周量级。
- **自由空间泡 / 单一 reality bubble 重构**(轴 B,对齐 CBN #3152):server 需多区域/无 bubble 实体管理。也是模拟经营前提。
- **`g->u` 去单例 + 多 avatar 回合模型 + 实体管理统一**(轴 B,对齐 CBN #2250 Game Objects):
  `g->u` 540+ 处 + `do_turn` 单 avatar 动作循环。模拟经营(多实体控制)与联机(多玩家)都顶它。网络状态复制的前提。
- **每客户端独立快照 + 输入回传协议 + 反作弊校验层**(轴 A,落原则 5 的区域参数化)。
**结论**:无头(0)+ 异步渲染(3)+ 模块化/换引擎(2、4)能早达成,是 80/20。
模态尾巴、bubble 重构、avatar 去单例(轴 B)留到真正联机/模拟经营时再碰,可跟踪移植 CBN #2250/#3152。

---

## 5. 推荐顺序与 PR 切分

| 阶段 | 内容 | PR | 状态 |
|------|------|-----|------|
| 0 | BUILD_HEADLESS | — | ✅ 已完成 (MinGW+MSVC 双构建) |
| 0.5 | 确定性回放测试台 | #239 | ✅ 已完成 |
| 1 | 记忆写回抽离 | #241 (朝向提取) + #244 (sim 侧 memory pass) | ✅ 已完成 |
| 2 | ViewSnapshot + 瞬态层 + field/item/vpart | #272 (静态层) + 2D (瞬态) + #281 (field) + #285 (item) + #286 (vpart) | ✅ 2A-2G 已完成。creature 故意跳过（活体对象，不适合快照）。L3 拆分/gap 留待后续 |
| 3A | do_turn 四方法拆分 | #292 | ✅ 已合并 |
| 3B | mid-step render 提取 + 跳帧守卫 | #291 | ✅ 已合并 |
| 3C | SIM 突变回迁 + present 纯渲染化 | #293 | ✅ 已合并 |
| 3.5 | L3/L1-L2 纯净拆分 (gap #2/#3) | #294 | ✅ 已提交 |
| 4 | RenderBackend 接口 / 渲染模块化 (含异步) | — | ⏳ 未开始 |
| 5+ | 模态/bubble/实体/网络(轴 B) | — | ⏳ 未开始 |

每步可编译、可对现有 SDL 逐像素验证、可单独提交。

### 5.1 每阶段验收标准(2026-06-23 loop 新增 — 「怎么算这阶段做完了」)

| 阶段 | 验收标准(全满足才算完成) |
|------|--------------------------|
| 0 BUILD_HEADLESS | ✅ 已达成:`cataclysm-headless.exe` dumpbin 仅链 Windows 系统 DLL(无 SDL/curses);`--help`/`--jsonverify` exit 0;MinGW+MSVC 双构建过。 |
| 0.5 回放台 | ✅ 已完成 (PR #239)。① 同种子+同输入无头跑两遍,`serialize_json` 输出逐字节一致;② 录制/回放钩子在 input_context.cpp:486 后端无关漏斗;③ `replay_mode` 与 test_mode 互斥不冲突。 |
| 1 记忆写回抽离 | ✅ 已完成 (PR #241 + #244)。① 朝向函数已搬 `map::`;② memorize 已移 sim 侧 memory-update pass;③ cata_tiles draw 零 memorize_*/set_dirty;④ 探索记忆显示无回归;⑤ headless --jsonverify exit 0。 |
| 2 ViewSnapshot | 🟡 部分完成。**已交付**: ① 静态层(terrain/furniture/trap/part_con/graffiti)从 cache 读(#272);② `view_snapshot` 类型带区域+观察者参数(#272);③ 瞬态视觉层 2D ✅ 完成(handle+双层生命周期+bubble);④ L3/L1-L2 拆分(#294,gap #2/#3 RESOLVED):`tile_view_data`(const L3) + `tile_render_scratch`(mutable L1-L2)。**未交付**: 动态层(field/item/vpart/creature)仍 live 读;per-tile version 未实现;序列化未实现。 |
| 3 do_turn 拆分 | ✅ 已完成 (PR #292 + #291 + #293)。① do_turn 已拆为 `simulate_turn_prefix/do_avatar_action_loop/simulate_turn_suffix/present_turn` 四方法;② tick 与帧率可独立调(mid-step gate 跳帧不丢世界态 + 世界态不受帧率影响);③ 所有 early return / 条件 redraw 语义保留;④ `present_turn()` 已是纯渲染,为阶段 4 RenderBackend 接口清路。**异步不在阶段 3 验收范围内**(见 §阶段 3)。 |
| 4 RenderBackend | ① present 侧收口到 RenderBackend 接口、**接口签名不含任何 SDL 类型**(吃 ViewSnapshot);② SDLBackend + NullBackend 都是其实现,可编译期/运行期切换;③ 渲染代码独立成库/目录;④ 强制走 SDL3-GPU(D3D12)路径时,崩溃可通过切 backend 实现绕过而非改 sim——证明崩溃已降格为"一个可换实现的 bug"。 |
| 5+ 轴 B | (多年量级,不设单一验收;按 CBN #2250/#3152 移植进度分项跟踪) |



## 6. 意见(取舍与判断)

1. **阶段 0 ✅ 已完成** — 无头构建让 null 后端表面积确切可知,零上游冲突。
2. **阶段 1 ✅ 已完成** (PR #241 + #244) — 原"全程最贵侵入点"已解决;朝向函数搬 sim 侧、记忆写回抽离,为快照清路。
3. **别等"完整 client/server"才动手——那是多年工程且有 ~620 模态 + 单 bubble 两座大山**。
   阶段 3 结构分离已收口,`present_turn()` 已是纯渲染,为阶段 4 清路。真异步(sim/render 线程分离)是阶段 4 的工程,
   因为需要线程安全的 view_snapshot、SDL 线程亲和、输入命令回传、UI 模态去阻塞——阶段 3 的词汇量级装不下。
   建议把 client/server 当"缝做干净后自然长出来的能力",而非直接攻坚目标。
4. **快照在缝的语义层、不在图元层**——这是与翻车的 Godot 路线的根本区别。Godot 在图元层切(接口收 blit/fill),
   导致光照 tint/blendmode 状态泄漏、被迫旁路镜像。语义层快照让渲染器拥有"怎么画"的全部决策,状态不会跨缝泄漏。
5. **Godot 工作不白做**:TCP/帧序列化/atlas 桥是现成传输层,阶段 2/4 直接复用,只换内容(图元→快照)。
   把它从"渲染方案"重定位成"传输层资产"。⚠️**注意此资产在历史提交里、不在当前分支**(见 §阶段2 复用资产校注:`0406b39e56`/`98a54143bc`/`58684df9e4`/`3b5e3f2e3e`),复用 = 从这些提交取出参考,非 src/ 现成。
6. **跟踪 CBN 的 #2250(Game Objects)与 #3152(reality bubble)**:这两项若 CBN 先做出来,
   是你 client/server 阶段最值得移植/参考的上游成果,能省下大量自研。本计划近期不碰,但值得订阅其进展。
7. **风险登记**:① cata_tiles 上游高频 → 阶段 1 已过(✅),阶段 2 后续(动态层) + 3.5(✅ #294,L3拆分)已在此高风险区完成;② MSVC glob/wildcard-discard 陷阱(新 .cpp 易被 IDE 丢)→ 阶段 0/2 加文件后核对 tlog;
   ③ 快照每帧分配开销 → 用对象池/复用 buffer(参考 CBN #1932 "draw map 频繁 realloc" 教训);④ 验证靠肉眼(测试存档自动退出、自动截图抓不到窗口)→ 沿用记忆里的 PowerShell 置顶截图法。
8. **「存档快照」≠「view 快照」(命名巧合,别合流)**:本 fork 已有存档快照系统(PR#202,见记忆 save-snapshots-rebase-to-master),
   那是**持久全量态**;view 快照是**每帧呈现态**。schema/频率/用途都不同。网络复制可复用存档的序列化原语,但两个 "snapshot" 概念不要在脑中合并。
9. **现代化整洁度(2026-06-27 review,2A-2E 通过)**:整体合理。一项非阻塞微调:`tile_render_info::sprite` 平面字段待 item/vpart/creature 捕获完成后(2F-2H)按层分组为 sub-struct。其余 gap 已在 view_snapshot.h 注释中登记。

## 短期路线(2026-06-28 更新)

阶段 0–3.5 ✅ 全部完成。下一阶段：**阶段 4 — RenderBackend 接口 / 渲染模块化（含异步）**。

阶段 4 前置条件评估：
- `present_turn()` 已纯渲染 ✅
- `view_snapshot` 类型已存在（区域+观察者参数化）✅
- L3/L1-L2 拆分已完成（#294,gap #2/#3 RESOLVED）：`tile_view_data` 仅含 const pos，渲染暂存限定在 `tile_render_scratch` ✅
- 剩余未交付：动态层(field/item/vpart)仍 live 读、per-tile version 未实现、序列化未实现（gap #4/#5/#6/#7）
- SDL 线程亲和 + 输入命令回传 + UI 模态循环去阻塞是异步的硬前置
- **建议在阶段 4 前优先补 gap #4 的子集**（至少 field/item/vpart 捕获完成），否则 RenderBackend 接口的 ViewSnapshot 入参会不完整

---

## 7. 内容设计方向(模拟经营 = 对标 RimWorld,mod 中立)

模拟经营的发展方向**对标环世界(RimWorld)**,且**不与任何特定 mod(含修仙 mod)绑定**——
引擎能力做成**通用、中立的基建**,任何 mod 都能跑在上面。这符合本计划"分模块、保持中立"的一贯原则。

**RimWorld 对标让轴 B 的目标更具体(全是通用机制)**:
- **多殖民者 = 多 avatar 实体**:玩家同时管理多个角色,而非单一 `g->u`。这是轴 B `g->u` 去单例(540+处)+
  `do_turn` 单 avatar 动作循环改造的直接驱动力 = CBN #2250 Game Objects。
- **离屏区域持续模拟 = 自由空间泡**(轴 B,CBN #3152):你不看的殖民地区域继续运转。
- **上帝视角调度 = 自由视角 + 间接控制**:玩家是俯瞰调度者而非附身某角色。自由视角靠 ViewSnapshot 区域参数化(原则 5)直接支持;
  间接控制(下指令、AI 执行)是 SIM 侧的任务/工作队列系统(轴 B 内容工作)。
- **原则**:这些机制保持**通用**,不预设任何 mod 语义。修仙等 mod 是未来**可能跑在上面的内容之一**,
  不是设计前提——避免把通用经营框架特化成只服务一个 mod。

---

## 8. 日志 / 报错系统解耦(2026-06-22 调研新增,异步/联机的横切前提)

> 用户提的第二问:「DEBUG 报错会堵死游戏进程;游戏存在多套日志系统,不利于异步/联机」。
> 本节是对此的调研结论 + 改造策略。它**横切**阶段 0.5–3:报错/日志是异步与联机的隐性前提,
> 但本身**不阻塞**阶段 0/1,可与渲染缝并行推进。

### 8.1 承重事实(已核实)

- **debugmsg 模态阻塞只在交互构建发生**:`realDebugmsg`(debug.cpp:537-602)有两个降级岔口——
  `test_mode` 直接 return(:557)、`!catacurses::stdscr`(headless)走 `buffered_prompts` 缓冲(:577)。
  真正的 `for(;!stop;) inp_mngr.get_input_event()` 模态循环只在有终端时跑(:405-424)。
  **故"堵死进程"是 TUI/SDL 交互构建特有,headless 已不阻塞**——降级机制已存在,只是隐式散在 if 里。
- **四套并存日志系统,且零线程同步**(debug.cpp 内 mutex/lock/atomic 计数 = 0):
  | 系统 | 性质 | 客户端/服务端归属 |
  |---|---|---|
  | `DebugLog`(debug.h:143-180, debug.cpp:96-101) | 开发诊断,无锁单例 | 两侧共用 → **sink 抽象** |
  | `debugmsg`(debug.h:73, debug.cpp:537) | 模态报错 | 受 error policy 管 |
  | `add_msg`/`Messages`(messages.h:44-76, messages.cpp:424 单例) | **玩家可见表现** | **纯客户端** |
  | `event_bus`(event_bus.h:15-39; get:game.cpp:11708) | 同步分派,无锁 | **服务端→客户端天然通道** |
- **memorial_logger**(memorial_logger.h:43-74)已是 event_bus 订阅者,是"事件→持久记录"的现成范例。

### 8.2 策略(与渲染缝同构:语义层、不过早加锁)

1. **error policy 收敛**(对齐渲染缝的运行形态):把 `test_mode` early-return 与 `!stdscr` 缓冲两个**隐式岔口**,
   收敛成显式策略——`interactive`(模态,**保留**:开发期模态强迫正视 bug,是有意设计)/ `headless`/`server`(log-and-continue,复用现有缓冲)/(未来)`networked_client`(转发非模态 toast)。
   **不是去掉模态,是让模态成为可选的一种策略**。
2. **DebugLog → sink 接口**(file/stderr/OutputDebugString/未来网络),两侧共用;顺手处理 Windows `OutputDebugStreamA` 特例。
3. **add_msg/Messages 标记纯客户端表现层**:方向是 **sim 发 event、客户端把 event 翻译成玩家彩色消息**(对齐 §3 缝:语义事件过缝、表现留客户端)。
   现在**不动**海量调用点(玩法中立),只确立方向。
4. **event_bus 不急着异步化**(它已是同步单线程分派 = 未来"服务端→客户端事件流"现成管道),
   但要早让 `cata::event` 干净**可序列化**(memorial 序列化可作范例)。
5. **❌ 现在不加 mutex**:与渲染缝同理——线程归属未定(阶段 3 才拆线程),此刻加锁是给未定设计上枷锁。
   sink 抽象 + 线程归属约定先行,锁等真有第二线程触碰再加。

### 8.3 与阶段的关系

- 横切,**不阻塞阶段 0/0.5/1**。建议挂在**阶段 2 前后**做 error policy + sink(那时运行形态已清晰)。
- `cata::event` 可序列化是**阶段 5+ 网络复制的前提**,宜早做(低风险、纯加法)。
- 玩法中立,可独立成 PR。

---

## 9. 本计划文档的权威性与配套产物

- **本文件(`.claude/plans/sim-render-decoupling-plan.md`)是本工程长期计划的唯一权威源**。
- 2026-06-22 一次会话曾误在 `doc/fork-design/`(仓库内)另建 ROADMAP.md + render-log-decoupling.md,
  阶段编号(P0–P5)与本文(阶段 0/0.5/1/…)**冲突重复**。处理:仓库内文档应作废或改为指回本文,阶段定义以本文为准。
  教训:动手前先查 `.claude/plans/` 既有计划,勿另起炉灶。
- 配套记忆:`render-log-decoupling-decisions`(渲染不上ECS/日志不加锁/边界判据/跨缝实体/命令通道)。


