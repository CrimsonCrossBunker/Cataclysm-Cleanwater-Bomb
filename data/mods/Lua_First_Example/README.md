# Lua-First Bundled Example & Mod Developer Tutorial
# 纯 Lua 内置示例 MOD 与开发者教程

This bundled Mod is both an executable acceptance fixture and a comprehensive
developer tutorial for the **CCB Lua Platform v1**. It contains 100% pure Lua code:
no JSON definitions, no EOC scripts, no legacy manifests, and no required `lua/`
folder hierarchy.

本 MOD 既是仓库的纯 Lua 验收测试用例，也是面向 Mod 开发者的**全系统实战教程**。
完全基于 **CCB Lua Platform v1** 编写，零 JSON、零 EOC、零旧式 manifest 配置文件。

---

## Directory Structure / 目录结构

```text
data/mods/Lua_First_Example/
├── mod.lua                         -- Mod metadata definition / 原生元数据声明
├── main.lua                        -- Main entry point & wiring / 总装配与注册入口
├── README.md                       -- Developer guide & documentation / 开发教程文档
├── content/                        -- Pure Lua content registrations / 原生内容系统
│   ├── cleanwater_charm.lua        -- Charm item & recipe fixture / 核心净化护符与配方
│   ├── items_and_tools.lua         -- Developer codex, multitool & tonic / 物品与多功能工具
│   ├── recipes_and_crafting.lua    -- Recipes, uncrafting & proficiencies / 配方、解体与熟练度
│   ├── monsters_and_ai.lua         -- Monster, species, attacks & behavior trees / 怪物与行为树 AI
│   ├── mutations_and_traits.lua    -- Categories, traits & modifiers / 突变特质与角色修正器
│   ├── magic_and_spells.lua        -- Magic types, progression & failures / 魔法系统与失败策略
│   └── environment_and_emissions.lua -- Field emissions & profiles / 环境字段排放与动态策略
└── runtime/                        -- Runtime behaviour, UI & hooks / 运行时逻辑与界面
    ├── behaviour.lua               -- Handler bridge & event routing / 回调总线与生命周期
    ├── tutorial_ui.lua             -- In-game interactive codex UI & sandbox / 游戏内教程与沙盒终端
    ├── tasks_and_state.lua         -- Delayed tasks, policies & diagnostics / 延迟任务与策略计算
    └── combat_and_hooks.lua        -- Native game hooks & telemetry / 原生游戏钩子与事件统计
```

---

## Core Features Demonstrated / 核心系统示范

### 1. Zero-Configuration & `mod.lua` (零配置发现与元数据)
- A minimal mod only needs `main.lua` at the root.
- Optional `mod.lua` returns a native `ccb.ModDefinition`:
  ```lua
  local ccb = require("ccb")
  return ccb.ModDefinition {
      id = "my_mod",
      name = "My Mod",
      version = "1.0.0",
      dependencies = { "dda" },
  }
  ```

### 2. Items, Tools & Consumables (原生物品与工具)
- Staged via `ccb.content.Item { id, name, description, symbol }`.
- Configures mass, volume, price, materials, qualities (`CUT`, `PRY`, etc.), and durability flags (`DURABLE_MELEE`).
- Binds named Lua callbacks via `:on_use(handler_id, label)`.

### 3. Recipes, Uncrafting & Requirements (配方、解体与熟练度)
- Staged via `ccb.content.Recipe { id, result, skill, difficulty, duration_moves, autolearn }`.
- Defines component choices (`:component_any`), tool requirements (`:tool_any`), and reusable requirement definitions (`ccb.content.Requirement`).
- Supports reversible disassembly with `uncraft = true`.
- Custom tool qualities (`ccb.content.ToolQuality`) and proficiencies (`ccb.content.Proficiency`).

### 4. Monsters & Behavior Trees (怪物、攻击与行为树 AI)
- Staged via `ccb.content.Monster { id, name, symbol, color, hp, speed, default_faction, harvest }`.
- Custom species (`ccb.content.Species`) with fear/anger triggers.
- Custom monster attacks (`ccb.content.MonsterAttack`) bound to named Lua policies.
- Full utility-based AI Behavior Trees (`ccb.content.Behavior`) with conditional execution (`:when`) and dynamic utility scoring (`:score`).

### 5. Mutations, Traits & Modifiers (突变特质与角色修正器)
- Staged via `ccb.content.MutationCategory` and `ccb.content.MutationType`.
- Dynamic character modifiers (`ccb.content.CharacterModifier`) using named Lua evaluators (`:evaluate_with`).

### 6. Magic & Spells (魔法系统与动态策略)
- Staged via `ccb.content.MagicType { id, energy, ... }`.
- Policies for leveling curves (`:progression`), casting exp (`:casting_experience`), failure chance (`:failure_chance`), and failure backlash (`:on_failure`).

### 7. Emissions & Dynamic World (字段排放与动态环境)
- Staged via `ccb.content.Emission { id, field, intensity, quantity, chance }`.
- Supports dynamic Lua profile calculation per emission event (`:profile`).

### 8. Interactive In-Game Codex UI (游戏内交互式开发手册与沙盒)
- Activate the **Lua Modding Codex (`lua_first_dev_codex`)** in-game to open a native menu powered by `ccb.presentation.choose` and `notice`.
- **Tutorial Chapters**: Read structured guides on all Lua subsystems directly in-game.
- **Sandbox Toolbox**: Test item usage, trigger delayed tasks, and modify persistent variables.
- **Live State Inspector**: Inspect `ccb.state.character` and `ccb.state.world` savefile values in real time.
- **Self-Diagnostics**: Run integrated unit tests and assertion checks.

### 9. State Persistence, Tasks & Hooks (状态持久化、任务与钩子)
- **Character & World State**: Durable storage via `ccb.state.character.get/set` and `ccb.state.world.get/set`, automatically saved into player/world sidecars.
- **Delayed & Periodic Tasks**: Scheduled via `ccb.tasks.after(turns, handler_id, payload, version, owner)`. Survives save/reload cycles.
- **Synchronous Hooks**: Subscribed via `ccb.runtime.hook(hook_name, handler_id)` for combat, crafting, and creature events.
