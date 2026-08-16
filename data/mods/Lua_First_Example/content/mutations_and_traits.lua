local content = {}

function content.register(ccb)
    local cat = ccb.content.MutationCategory {
        id = "LUA_TUTORIAL_CAT",
        name = "Lua Adept",
        mutagen_message = "A sensation of logical clarity flows through your mind.",
        memorial_message = "Mastered the paradigms of pure Lua architecture.",
        skip_consistency_test = true,
    }
    ccb.content.add(cat)

    local mod = ccb.content.CharacterModifier {
        id = "mod_lua_first_crafting_efficiency",
        description = "Increases crafting and learning speed through methodical Lua scripting understanding.",
        operation = "multiply",
    }
    mod:evaluate_with("lua_first_eval_craft_speed")
    ccb.content.add(mod)
end

return content
