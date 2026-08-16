# 纯 Lua 内置范例 MOD 与开发者教程 (Lua-First Showcase & Tutorial)

**作者**: `g1ytx`  
**版本**: `0.1.0`  
**架构**: 基于 **CCB Lua Platform v1** (纯 Lua 架构，零 JSON、零 EOC、零旧式 manifest)

本 MOD 既是 CCB 纯 Lua 架构的官方验收测试夹具，也是面向 Mod 开发者的**全系统实战范例与教程**。

---

## 目录结构

```text
data/mods/Lua_First_Example/
├── mod.lua                         -- Mod 原生元数据声明 (ccb.ModDefinition)
├── main.lua                        -- 模组总装配与注册入口
├── README.md                       -- 模组说明与开发文档
├── content/                        -- 原生游戏内容注册 (纯 Lua DSL)
│   ├── cleanwater_charm.lua        -- 核心净化护符与基础配方
│   ├── items_and_tools.lua         -- 全息开发手册、多功能振波刃与纳米注射剂
│   ├── recipes_and_crafting.lua    -- 制作配方、可逆解体与熟练度系统
│   ├── monsters_and_ai.lua         -- 教程训练无人机、专属采收表与行为树 AI
│   ├── mutations_and_traits.lua    -- 突变分类、特质与动态角色修正器
│   ├── magic_and_spells.lua        -- 赛博魔法系统、经验曲线与失败反噬策略
│   └── environment_and_emissions.lua -- 动态环境字段排放与扩散策略
└── runtime/                        -- 运行时逻辑、界面与事件钩子
    ├── behaviour.lua               -- 回调总线与生命周期调度
    ├── tutorial_ui.lua             -- 游戏内交互式开发手册与沙盒调试终端
    ├── tasks_and_state.lua         -- 跨存档延迟任务、动态计算策略与自检诊断
    └── combat_and_hooks.lua        -- 原生游戏事件钩子与实时统计
```

---

## 核心系统与实战范例

### 1. 零配置发现与 `mod.lua`
- 无需 `modinfo.json` 或 `manifest.json`，目录即模组。
- `mod.lua` 声明原生元数据与依赖关系。

### 2. 原生物品与多功能工具 (`content/items_and_tools.lua`)
- 使用 `ccb.content.Item` 注册物品，配置质量、体积、价格、材质、工具等级（切割/屠宰/撬锁/敲击）与耐久标签。
- 绑定命名 Lua 回调处理函数 `:on_use(handler_id, label)`。
- 支持在游戏内使用时实时切换高频振动、纳米精细等不同工作模式。

### 3. 配方、解体与熟练度 (`content/recipes_and_crafting.lua`)
- 声明制造配方与所需技能难度。
- 支持可逆解体（`uncraft = true`），将装备 100% 还原为原始材料。
- 自定义工具质量（`ToolQuality`）与制作熟练度（`Proficiency`）。

### 4. 怪物、攻击与行为树 AI (`content/monsters_and_ai.lua`)
- 注册自主巡逻无人机及其种族、掉落组和采收解剖表。
- 搭载基于效用（Utility）评分的纯 Lua 行为树（`Behavior Tree`），支持自主巡逻与战斗策略切换。
- 绑定自定义声学脉冲攻击策略。

### 5. 突变特质与角色修正器 (`content/mutations_and_traits.lua`)
- 注册专属突变谱系。
- 挂载动态角色修正器（`CharacterModifier`），由 Lua 函数实时计算角色制作与学习速度加成。

### 6. 魔法系统与动态策略 (`content/magic_and_spells.lua`)
- 注册赛博法术流派，由 Lua 动态接管升级经验公式、施法成功率判定与施法失败反噬效果。

### 7. 环境字段排放 (`content/environment_and_emissions.lua`)
- 定义烟雾/粒子动态排放源，支持由 Lua 策略函数根据周围环境实时微调排放浓度。

### 8. 游戏内交互式开发终端 (`runtime/tutorial_ui.lua`)
- 激活开发手册物品即可在游戏内打开终端菜单。
- 包含 8 大核心章节教程、开发者沙盒调试箱、运行时状态检视器与诊断报告。

### 9. 状态持久化、延迟任务与事件钩子 (`runtime/tasks_and_state.lua` / `combat_and_hooks.lua`)
- **持久化存储**：`ccb.state.character` 与 `ccb.state.world` 自动与角色及世界存档同步。
- **跨存档延迟任务**：`ccb.tasks.after` 调度经过指定回合后触发的倒计时任务。
- **原生事件钩子**：实时监听近战命中、物品制作等游戏底层事件。
