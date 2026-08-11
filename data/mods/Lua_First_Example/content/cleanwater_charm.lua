local content = {}

function content.register(ccb)
    local charm = ccb.content.Item {
        id = "lua_first_cleanwater_charm",
        name = "clean-water charm",
        description = "A tiny proof that bundled content can be authored as native Lua.",
        symbol = "*",
    }
    charm:mass_grams(20)
    charm:volume_ml(10)
    charm:price_cents(250)
    charm:material("steel", 1)
    charm:on_use("use_cleanwater_charm", "Listen to the charm")
    ccb.content.add(charm)

    local recipe = ccb.content.Recipe {
        id = "lua_first_cleanwater_charm",
        result = "lua_first_cleanwater_charm",
        category = "CC_OTHER",
        subcategory = "CSC_OTHER_OTHER",
        skill = "fabrication",
        difficulty = 1,
        duration_moves = 500,
        autolearn = true,
    }
    recipe:component_any {
        { id = "scrap", count = 1 },
        { id = "steel_chunk", count = 1 },
    }
    recipe:tool_any {
        { id = "hammer", count = 1 },
        { id = "rock", count = 1 },
    }
    ccb.content.add(recipe)
end

return content
