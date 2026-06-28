# Stage 4 — RenderBackend 接口 / 渲染模块化

> 父计划：`sim-render-decoupling-plan.md` §阶段 4
> 前置：阶段 2（ViewSnapshot）+ 阶段 3（present 分离）+ 3.5（L3/L1-L2 拆分）✅
> 目标：present 侧收口到 `render_backend` 接口，SDL 降格为可替换实现，独立编译单元
> C++ 标准：C++17
> 构建：MSVC Release|x64

## 0. 测绘结论：present 侧当前调用拓扑

```
present_turn()                          // do_turn.cpp:850
  ├─ ui_manager::redraw()              // 触发所有 ui_adaptor 回调
  │    └─ game::draw(ui_adaptor&)      // game.cpp:3394 — 主 terrain ui_adaptor
  │         ├─ game::draw_ter()        // game.cpp:3584
  │         │    └─ map::draw(w, c)    // map.cpp:8351
  │         │         ├─ [TILES] cata_tiles::draw()   // 全局单例 tilecontext
  │         │         └─ [!TILES] ASCII 绘制
  │         ├─ game::draw_panels()     // 侧边栏
  │         └─ draw_callbacks / async_anim
  └─ refresh_display()                 // sdltiles.cpp:1142 — SDL_RenderPresent
```

**SDL 类型泄漏清单**（cata_tiles.h 公开 API）：

| 类型 | 用途 | 出现次数 |
|---|---|---|
| `SDL_Renderer_Ptr` | 渲染器句柄 | 构造函数 + 4 方法 |
| `GeometryRenderer_Ptr` | 几何辅助 | 构造函数 |
| `SDL_Texture*` | 纹理输出 | `render_character_preview` |
| `SDL_Rect` / `SDL_Point` / `SDL_Color` | 矩形/颜色 | 纹理类 + color_block |
| `std::shared_ptr<cata_tiles> tilecontext` | 全局单例 (sdltiles.h:39) | game.cpp ~40 处 |
| `bool use_tiles` | 全局标志 | ~20 处 |

**关键发现**：`cata_tiles::draw()` 不直接读 `get_map()` 的 live 数据（静态层已捕获到 cache，field/item/vpart 每帧刷新），但它的**接口签名全是 SDL 类型**（`SDL_Renderer_Ptr`, `GeometryRenderer_Ptr`），并且产物是 SDL 纹理。

## 1. 设计：`render_backend` 接口

### 1.1 接口定义（草图）

```cpp
// src/render_backend.h — 独立编译单元，不 #include 任何 SDL 头
class render_backend {
public:
    virtual ~render_backend() = default;

    // 每帧主入口：吃 ViewSnapshot，画到后端自己的输出面上。
    // 后端负责 L1（精灵选择/上色）和 L2（合成/排序），服务端不参与。
    // 返回 false 表示后端内部错误（如设备丢失），调用方可尝试重建。
    virtual bool present( const view_snapshot &snap ) = 0;

    // 通知后端视口尺寸变化（窗口 resize）。
    virtual void resize( int pixel_width, int pixel_height ) = 0;

    // 帧结束——刷新到屏幕。与 present() 分开以支持批量提交。
    virtual void flush() = 0;

    // 返回后端可读名称，用于调试/选项切换。
    virtual const char *name() const = 0;
};
```

### 1.2 接口设计原则

1. **零 SDL 类型**：`render_backend.h` 不引用 SDL/OpenGL/D3D 任何头文件。
2. **只吃 ViewSnapshot**：所有 L3 数据从快照来；L1（tileset 查表、tint 上色）和 L2（11 层合成、camera）是各后端自己的事。
3. **编译期切换**：`#if defined(TILES)` 选 SDL 后端，`#elif defined(HEADLESS)` 选 null 后端。不引入虚函数开销的担忧——present() 每帧只调一次，虚函数开销可忽略。
4. **运行期切换**：后端实例是裸指针/unique_ptr，可在窗口重建时替换（例如 SDL GPU 设备丢失 → 切 D3D11）。

### 1.3 现有代码如何映射到接口

| 现有调用 | 映射到接口 |
|---|---|
| `cata_tiles::draw(renderer, geometry, ...)` | `sdl_backend::present(snapshot)` 内部调用 |
| `refresh_display()` | `backend->flush()` |
| `tilecontext->set_draw_cache_dirty()` | 移到 `view_snapshot` 生产者侧（sim），不归 backend 管 |
| `tilecontext->get_tile_width()` 等查询 | 不暴露——这些是 L1 内部细节 |
| `game::draw()` 中的 `werase`/`wnoutrefresh` | curses 路径单独处理，暂不纳入第一阶段 |

## 2. 实施：四阶段 PR 切分

### 4A — 创建 `render_backend` 接口 + null 实现（纯加法，零行为变更）

**改动**：
- 新增 `src/render_backend.h`：接口定义（~25 行）
- 新增 `src/null_render_backend.cpp`：null 实现（~15 行，`present()` 空函数，`flush()` 空函数）
- 新增 `src/sdl_render_backend.h/.cpp`：SDL 实现的**壳**（构造函数接收 `SDL_Renderer_Ptr` + `GeometryRenderer_Ptr`，内部持有 `cata_tiles` 实例，`present()` 转发给 `cata_tiles::draw()`）
- 在 `game` 类中新增 `std::unique_ptr<render_backend> backend` 成员
- 初始化路径：TILES → `sdl_render_backend`，HEADLESS → `null_render_backend`
- **不改变任何现有调用路径**——新代码是旁路，与旧路径并存

**验证**：完整构建 0 错误；`--jsonverify` exit 0；游戏正常运行（旧路径未动）。

### 4B — 将 `present_turn()` 切换到 backend 调用

**改动**：
- `present_turn()` 中 `ui_manager::redraw()` + `refresh_display()` → `backend->present(snapshot)` + `backend->flush()`
- `render_mid_step()` 中的 `ui_manager::redraw()` 同理
- `game::draw()` 内的 `map::draw()` 调用改为取 snapshot 后交给 backend
- 此时 SDL 后端内部仍走 `cata_tiles::draw()`，只是调用点变了

**风险**：do_turn 高频区。但改动集中在 2 个函数（`present_turn` + `render_mid_step`），且回放台可 A/B diff 验证。

**验证**：回放台 A/B diff `serialize_json` 逐字节一致（世界态不受影响）；肉眼比对画面无差异。

### 4C — 渲染代码独立目录

**改动**：
- 创建 `src/render/` 目录
- 移入：`cata_tiles.{h,cpp}`, `sdltiles.{h,cpp}`, `sdl_render_backend.{h,cpp}`, `null_render_backend.cpp`, `render_backend.h`
- 移入：tileset 相关（`tileset_loader.{h,cpp}`, `cached_options.h` 中 tiles 配置）
- 移入：`cursesdef.h`, `catacurses.cpp` 等 curses 抽象层
- 创建 `src/render/CMakeLists.txt`（独立库 `librender`）
- MSVC vcxproj 对应调整

**目标**：`src/render/` 成为独立编译单元，`librender` 的符号边界与 `render_backend` 接口一致。

**验证**：完整构建 0 错误；`dumpbin /symbols librender.lib` 确认不导出 SDL 类型到外部。

### 4D — D3D12 崩溃根治验证

**改动**：无需代码改动。使用 4B 完成后的代码验证崩溃已根治。

**测试方法**：
- 强制启用 SDL3-GPU + D3D12 路径
- 走路、开车、上下楼梯：不再 SIGSEGV
- 切到 D3D11 backend：运行正常（证明 backend 可替换）
- ASCII 低倍率不再崩溃（如果 null backend 作为 fallback）

**这是验收标准 #4 的验证，不是新代码。**

## 3. 不在此阶段做的事

| 排期 | 原因 |
|---|---|
| UI 面板（侧边栏、菜单）抽象到 backend | 面板走 ImGui/curses，与 terrain tiles 是不同的渲染路径；先做完 terrain 再推面板 |
| 音频 sfx 纳入 backend | 音频是独立子系统，不要捆绑进渲染接口 |
| input 纳入 backend | 输入已通过 `input_context` 与后端解耦（见 §0.6 命令通道），不需要动 |
| Async sim/render 线程分离 | 需要线程安全的 snapshot + SDL 线程亲和——这是 4E+ 的工作，不在 4A-4D 范围内 |
| 新引擎 backend（Godot 等） | 接口设计预留插槽，但实现等轴 B 成熟后再说 |

## 4. 验证

| PR | 验证手段 |
|---|---|
| 4A | 构建 0 错误；headless `--jsonverify` exit 0 |
| 4B | 回放台 A/B diff `serialize_json` 逐字节一致；肉眼比对画面无差异（tint/height_3d/z-order） |
| 4C | 构建 0 错误；`dumpbin /symbols` 确认无 SDL 类型泄漏 |
| 4D | SDL3-GPU/D3D12 路径不再崩溃；切 backend 运行正常 |

## 5. 与长期计划的关系

- 4A-4D 完成后，**轴 A（渲染解耦）交付物全部到位**：无头 / 异步 / 换引擎 / 模块化图形 四个目标均获基建支撑
- 剩余 gap（#4 creature/#5 generation/#6 序列化/#7 ownership）是轴 B 和 client-server 的前提，不阻 stage 4
- 轴 B（模拟经营）可独立规划，不被 stage 4 阻塞
