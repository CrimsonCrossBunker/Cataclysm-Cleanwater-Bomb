# Lua 目标与进度 / Lua goal and progress

更新于 2026-09-26。此页只记录下一步开发方向；实际接口以源码、LuaLS 声明和测试为准。
Updated 2026-09-26. Source, LuaLS declarations, and tests define current behavior.

## 目标 / Goal

- 让核心内容和 Mod 用 `require("ccb")` 编写行为；静态 JSON 可以保留。
- 优先做能加载、游玩、保存、重进的完整 Lua Mod，再按真实需求补原生接口。
- 迁移仍在使用的 EOC 内容；确认引用归零后再移除旧执行器。
- 不恢复 v5、`game.*` 或 EOC 风格的新创作入口。

## 进度 / Progress

- Platform v1 核心已在路线图中标为完成；这不等于旧内容已迁移完成。
- 当前主线账本有 586 个 EOC 条目：1 项有完整验收记录、572 项仅覆盖部分形状且未完整验收、13 项经审查不适用。这些计数不代表 Lua 整体完成率。
- [#923](https://github.com/CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb/pull/923) 是变量与迁移差异修复的草稿，尚未合并；其新增测试不能代替完整玩法验证。
- 下一步：完成 #923 的相关检查，然后用一个真实 Lua Mod 验证加载、持续行为和存档恢复；后续缺口从这个流程和实际迁移中选。

## 开发与验证 / Development and checks

开发者在游戏里实测改动涉及的 Lua 玩法，记录测试版本、操作和结果。已有自动测试按需用于定位回归，日常改动不要求另编译 Lua 测试程序。公开接口变更仍同步声明和生成文件，仓库现有 CI 照常运行。无需逐条核对 EOC 或反复扫描全量语料；只有声明全面替代或准备删除旧路径时，才核对涉及的合法输入和实际引用。

Developers verify changed Lua gameplay in the game and record the build, steps, and outcome. Use existing automated tests as needed to diagnose regressions; routine changes do not require a separate Lua test build. Keep public declarations and generated references in sync when interfaces change. Existing CI still runs. Audit the relevant legacy inputs and references only when claiming broad parity or preparing to remove an old path.

稳定版的 Lua 玩法由开发者用候选发行包手动验收：实玩示例补剂和致命丧尸病毒，再载入一份受支持旧版本的存档副本，保存退出并重进，确认还能继续玩。发版前无需额外运行一套 Lua 自动测试。

For stable releases, developers verify Lua gameplay manually with the release candidate: play through the tonic example and Deadly Zombie Virus, load a copy of a save from a supported older version, then save, quit, and reopen it to confirm play can continue. There is no separate automated Lua gameplay gate for the release.
