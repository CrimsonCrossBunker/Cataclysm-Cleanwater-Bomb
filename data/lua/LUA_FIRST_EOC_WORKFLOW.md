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

围绕实际功能写代码。对改变的行为保留一个能发现回归的聚焦测试，并运行受影响的检查；公共接口变化同步声明和生成文件。CI 继续自动执行仓库现有检查。无需为每次改动逐条核对 586 项、反复运行全量语料审计或维护额外的验收表。只有声明某项已全面替代或准备删除旧路径时，才核对该声明涉及的全部合法输入与实际引用；未执行的测试如实标明。

Implement the needed behavior first. Add a focused regression for changed behavior, run relevant checks, and update declarations/generated references when the public API changes. Per-item audits are not a routine development gate. Broad parity or EOC removal claims need evidence for their exact scope; report checks that were not run.
