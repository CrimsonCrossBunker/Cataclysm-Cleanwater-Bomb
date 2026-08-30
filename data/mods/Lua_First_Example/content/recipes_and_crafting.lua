local content = {}

function content.register(ccb)
    local quality = ccb.content.ToolQuality {
        id = "lua_first_purification_tech",
        name = "Purification Tuning",
    }
    quality:usage(1, "Basic electrolyte filtering")
    quality:usage(2, "Advanced nanofiltration resonance")
    ccb.content.add(quality)

    local prof_cat = ccb.content.ProficiencyCategory {
        id = "prof_cat_lua_first",
        name = "Lua Platform Modding",
        description = "Crafting proficiencies relating to pure Lua engineering.",
    }
    ccb.content.add(prof_cat)

    local prof = ccb.content.Proficiency {
        id = "prof_lua_first_engineering",
        name = "Lua Modding Principles",
        description = "Practical understanding of CCB Platform v1 content and runtime architectures.",
        category = "prof_cat_lua_first",
    }
    ccb.content.add(prof)

    local req = ccb.content.Requirement {
        id = "req_lua_first_circuitry",
        name = "basic circuitry",
    }
    req:component_any {
        { id = "scrap", count = 2 },
    }
    req:tool_any {
        { id = "hammer", count = 1 },
        { id = "rock", count = 1 },
    }
    ccb.content.add(req)

    local recipe_codex = ccb.content.Recipe {
        id = "lua_first_dev_codex",
        result = "lua_first_dev_codex",
        category = "CC_OTHER",
        subcategory = "CSC_OTHER_OTHER",
        skill = "fabrication",
        difficulty = 0,
        duration_moves = 100,
        autolearn = true,
    }
    recipe_codex:component_any {
        { id = "paper", count = 5 },
        { id = "plastic_chunk", count = 1 },
    }
    ccb.content.add(recipe_codex)

    local recipe_omnitool = ccb.content.Recipe {
        id = "lua_first_omnitool",
        result = "lua_first_omnitool",
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_CUTTING",
        skill = "fabrication",
        difficulty = 2,
        duration_moves = 1200,
        autolearn = true,
    }
    recipe_omnitool:component_any {
        { id = "steel_chunk", count = 2 },
        { id = "scrap", count = 2 },
    }
    recipe_omnitool:tool_any {
        { id = "hammer", count = 1 },
        { id = "rock", count = 1 },
    }
    ccb.content.add(recipe_omnitool)

    local recipe_tonic = ccb.content.Recipe {
        id = "lua_first_nano_tonic",
        result = "lua_first_nano_tonic",
        category = "CC_CHEM",
        subcategory = "CSC_CHEM_DRUGS",
        skill = "firstaid",
        difficulty = 1,
        duration_moves = 800,
        autolearn = true,
    }
    recipe_tonic:component_any {
        { id = "water_clean", count = 1 },
        { id = "aspirin", count = 2 },
    }
    recipe_tonic:tool_any {
        { id = "chemistry_set", count = 1 },
        { id = "pot", count = 1 },
    }
    ccb.content.add(recipe_tonic)

    local recipe_uncraft = ccb.content.Recipe {
        id = "lua_first_omnitool_uncraft",
        result = "lua_first_omnitool",
        uncraft = true,
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_CUTTING",
        skill = "fabrication",
        difficulty = 1,
        duration_moves = 300,
        autolearn = true,
    }
    recipe_uncraft:component_any {
        { id = "steel_chunk", count = 1 },
        { id = "scrap", count = 2 },
    }
    ccb.content.add(recipe_uncraft)
end

return content
