local content = {}

function content.register(ccb)
    local cat = ccb.content.MutationCategory {
        id = "LUA_TUTORIAL_CAT",
        name = "Lua 架构大师",
        mutagen_message = "一种充满逻辑严谨与架构清晰的奇妙感觉流过你的脑海。",
        memorial_message = "彻底掌握了纯 Lua 原生架构的设计精髓。",
        skip_consistency_test = true,
    }
    ccb.content.add(cat)

    local mod = ccb.content.CharacterModifier {
        id = "mod_lua_first_crafting_efficiency",
        description = "通过对纯 Lua 脚本机制的深刻理解，全面提升物品制造与技能研读速度。",
        operation = "multiply",
    }
    mod:evaluate_with("lua_first_eval_craft_speed")
    ccb.content.add(mod)
end

return content
