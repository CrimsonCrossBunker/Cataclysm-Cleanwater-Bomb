local ccb = require("ccb")
local tasks_mod = require("runtime.tasks_and_state")

local ui = {}

local function show_chapter_dialog(title, text)
    ccb.presentation.notice("[" .. title .. "]\n\n" .. text)
end

function ui.open_codex_menu(context)
    while true do
        local choice = ccb.presentation.choose("=== CCB Lua 原生 MOD 开发教程与调试终端 ===", {
            {
                id = "chapter_1",
                label = "1. 零配置发现与 mod.lua 架构",
                description = "了解目录即 Mod、main.lua 入口与 ccb.ModDefinition 原生元数据",
            },
            {
                id = "chapter_2",
                label = "2. 原生物品与工具系统 (Items & Tools)",
                description = "学习 ItemDefinition、质量/材质/耐久与命名 on_use 行为回调",
            },
            {
                id = "chapter_3",
                label = "3. 配方、解体与熟练度 (Crafting & Uncrafting)",
                description = "学习 RecipeDefinition、工具质量、复用需求与可逆解体机制",
            },
            {
                id = "chapter_4",
                label = "4. 怪物与行为树 AI (Monsters & Behavior Trees)",
                description = "学习 MonsterDefinition、物种、自定义攻击、采收与行为树",
            },
            {
                id = "chapter_5",
                label = "5. 突变特质与角色修正器 (Mutations & Modifiers)",
                description = "学习 MutationCategory、特质与命名 Lua 角色修正器",
            },
            {
                id = "chapter_6",
                label = "6. 魔法系统与动态策略 (Magic & Policies)",
                description = "学习 MagicType、能量源、升级经验与施法失败策略",
            },
            {
                id = "chapter_7",
                label = "7. 字段排放与动态环境 (Emissions & Environment)",
                description = "学习 EmissionDefinition、静态 fallback 与动态 profile 策略",
            },
            {
                id = "chapter_8",
                label = "8. 延迟任务与持久化状态 (Tasks, Hooks & State)",
                description = "学习 ccb.tasks、ccb.state.character/world 与生命周期钩子",
            },
            {
                id = "sandbox",
                label = "🛠️ 开发者沙盒调试箱 (Interactive Sandbox)",
                description = "生成示例物品、召唤教程怪物、测试延迟任务与状态更新",
            },
            {
                id = "inspector",
                label = "📊 运行时状态检视器 (Live State Inspector)",
                description = "查看当前角色与世界在 savefile 中的持久化变量与环境数据",
            },
            {
                id = "diagnostics",
                label = "🧪 执行 Mod 原生自检诊断 (Self-Diagnostics)",
                description = "运行本地 API 完整性断言测试并查看诊断报告",
            },
            {
                id = "exit",
                label = "🚪 退出开发手册 (Close Menu)",
                description = "关闭终端并返回游戏世界",
            },
        })

        if not choice or choice == "exit" then
            break
        elseif choice == "chapter_1" then
            show_chapter_dialog(
                "第 1 章：零配置发现与 mod.lua 架构",
                "• 零配置发现：只需在 Mod 根目录放置 main.lua，无需 modinfo.json。\n" ..
                "• mod.lua：可选的高级元数据文件，返回 ccb.ModDefinition { id, name, version, dependencies }。\n" ..
                "• 模块组织：建议将数据定义放入 content/，行为逻辑放入 runtime/，通过 local require 载入。\n" ..
                "• 事务与安全：Platform v1 提供加载时事务暂存与冲突回滚，Lua 接收代际安全句柄。"
            )
        elseif choice == "chapter_2" then
            show_chapter_dialog(
                "第 2 章：原生物品与工具系统",
                "• 物品定义：使用 ccb.content.Item { id, name, description, symbol }。\n" ..
                "• 属性配置：:mass_grams()、:volume_ml()、:price_cents()、:material()、:quality()。\n" ..
                "• 使用行为：:on_use(handler_id, label) 将物品与命名 Lua 处理函数绑定。\n" ..
                "• 示例物品：lua_first_omnitool（多功能振波刃）、lua_first_nano_tonic（纳米注射剂）。"
            )
        elseif choice == "chapter_3" then
            show_chapter_dialog(
                "第 3 章：配方、解体与熟练度",
                "• 基础配方：ccb.content.Recipe { id, result, skill, difficulty, duration_moves, autolearn }。\n" ..
                "• 材料与工具：:component_any({ choices })、:tool_any({ choices })。\n" ..
                "• 解体配方：设置 uncraft = true 即可将物品拆解回基础零件。\n" ..
                "• 工具质量与熟练度：支持自定义 ccb.content.ToolQuality 与 ccb.content.Proficiency。"
            )
        elseif choice == "chapter_4" then
            show_chapter_dialog(
                "第 4 章：怪物与行为树 AI",
                "• 怪物定义：ccb.content.Monster { id, name, symbol, color, hp, speed, default_faction }。\n" ..
                "• 攻击与采收：:attack() 绑定 MonsterAttack，:harvest() 绑定 HarvestDefinition 采收表。\n" ..
                "• 行为树 (Behavior Trees)：由 ccb.content.Behavior 节点组成树状图。\n" ..
                "• 策略回调：:when() 判定执行条件，:score() 评估 utility 效用评分。"
            )
        elseif choice == "chapter_5" then
            show_chapter_dialog(
                "第 5 章：突变特质与角色修正器",
                "• 突变分类：ccb.content.MutationCategory { id, name, threshold_mutation, mutagen_message }。\n" ..
                "• 突变特质：ccb.content.MutationType { id } 声明稳定特质 ID。\n" ..
                "• 角色修正器：ccb.content.CharacterModifier { id, description, operation }。\n" ..
                "• 动态计算：:evaluate_with(handler_id) 绑定命名 Lua 函数计算数值倍率或加成。"
            )
        elseif choice == "chapter_6" then
            show_chapter_dialog(
                "第 6 章：魔法系统与动态策略",
                "• 魔法类型：ccb.content.MagicType { id, energy, cannot_cast_message, failure_cost_fraction }。\n" ..
                "• 经验与等级：:progression() 绑定等级与所需经验计算策略。\n" ..
                "• 施法与失败：:casting_experience() 计算施法经验，:on_failure() 触发失败反噬效果。"
            )
        elseif choice == "chapter_7" then
            show_chapter_dialog(
                "第 7 章：字段排放与动态环境",
                "• 字段排放：ccb.content.Emission { id, field, intensity, quantity, chance }。\n" ..
                "• 静态 Fallback：提供默认的气体/粒子排放参数。\n" ..
                "• 动态 Profile：:profile(handler_id) 绑定命名策略，根据位置和环境动态微调烟雾与浓度。"
            )
        elseif choice == "chapter_8" then
            show_chapter_dialog(
                "第 8 章：延迟任务、钩子与持久化状态",
                "• 持久化状态：ccb.state.character.get/set 与 ccb.state.world.get/set 会自动写入存档。\n" ..
                "• 延迟任务：ccb.tasks.after(turns, handler_id, payload, version, owner) 调度单次倒计时任务。\n" ..
                "• 周期任务：支持世界级/角色级持久化任务，跨存档自动恢复。\n" ..
                "• 原生钩子：ccb.runtime.hook(hook_name, handler_id) 监听游戏内战斗、制作等实时事件。"
            )
        elseif choice == "sandbox" then
            while true do
                local sb_choice = ccb.presentation.choose("=== 开发者沙盒调试箱 ===", {
                    { id = "task_demo", label = "⏳ 调度 5 回合延迟任务", description = "使用 ccb.tasks.after 设置一个世界级提醒任务" },
                    { id = "tonic_demo", label = "💊 激活纳米再生注射剂效果", description = "测试角色状态计数与任务循环" },
                    { id = "inc_state", label = "📈 手动递增角色持久化计数器", description = "增加 ccb.state.character['dev_sandbox_counter']" },
                    { id = "back", label = "⬅️ 返回主目录", description = "返回开发手册主菜单" },
                })
                if not sb_choice or sb_choice == "back" then
                    break
                elseif sb_choice == "task_demo" then
                    ccb.tasks.after(5, "lua_first_example_reminder", {
                        text = "[沙盒任务提醒] 5 回合延迟任务已成功按时触发！",
                    }, 1, "world")
                    ccb.presentation.notice("已调度 5 回合延迟任务！请在游戏中等待 5 回合查看效果。")
                elseif sb_choice == "tonic_demo" then
                    local ticks = ccb.state.character.get("lua_first_tonic_ticks", 0) + 1
                    ccb.state.character.set("lua_first_tonic_ticks", ticks)
                    ccb.tasks.after(2, "lua_first_task_tonic_tick", {}, 1, "character")
                    ccb.presentation.notice("已激活纳米再生循环，已记录当前脉冲次数: " .. ticks)
                elseif sb_choice == "inc_state" then
                    local cur = ccb.state.character.get("dev_sandbox_counter", 0) + 1
                    ccb.state.character.set("dev_sandbox_counter", cur)
                    ccb.presentation.notice("角色持久化计数器已更新为: " .. cur)
                end
            end
        elseif choice == "inspector" then
            local charm_uses = ccb.state.character.get("cleanwater_charm_uses", 0)
            local crafts = ccb.state.character.get("lua_first_crafts_total", 0)
            local melees = ccb.state.character.get("lua_first_melee_encounters", 0)
            local tonic_ticks = ccb.state.character.get("lua_first_tonic_ticks", 0)
            local custom_counter = ccb.state.character.get("dev_sandbox_counter", 0)
            local world_init = ccb.state.world.get("cleanwater_example_initialized", false)
            local world_reminders = ccb.state.world.get("cleanwater_example_reminders", 0)
            local dim = ccb.services.gameplay.environment.dimension()

            local info = "【角色持久化状态 (Character State)】\n" ..
                "• 净化护符使用次数 (cleanwater_charm_uses): " .. tostring(charm_uses) .. "\n" ..
                "• 制作事件总计 (lua_first_crafts_total): " .. tostring(crafts) .. "\n" ..
                "• 近战遭遇总计 (lua_first_melee_encounters): " .. tostring(melees) .. "\n" ..
                "• 纳米再生脉冲 (lua_first_tonic_ticks): " .. tostring(tonic_ticks) .. "\n" ..
                "• 沙盒调试计数 (dev_sandbox_counter): " .. tostring(custom_counter) .. "\n\n" ..
                "【世界持久化状态 (World State)】\n" ..
                "• 世界就绪已初始化 (initialized): " .. tostring(world_init) .. "\n" ..
                "• 世界提醒已触发次数 (reminders): " .. tostring(world_reminders) .. "\n" ..
                "• 当前所处维度 (dimension): " .. tostring(dim)

            ccb.presentation.notice(info)
        elseif choice == "diagnostics" then
            local report = tasks_mod.run_diagnostics()
            ccb.presentation.notice(report)
        end
    end

    return 0
end

return ui
