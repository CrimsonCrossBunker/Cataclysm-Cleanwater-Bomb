local content = {}

function content.register(ccb)
    local quality = ccb.content.ToolQuality {
        id = "lua_first_purification_tech",
        name = "纯化调校",
    }
    quality:usage(1, "基础电解质过滤")
    quality:usage(2, "高级纳米共振微滤")
    ccb.content.add(quality)

    local prof_cat = ccb.content.ProficiencyCategory {
        id = "prof_cat_lua_first",
        name = "Lua 平台模组开发",
        description = "与纯 Lua 原生工程相关的制作与设计专精。",
    }
    ccb.content.add(prof_cat)

    local prof = ccb.content.Proficiency {
        id = "prof_lua_first_engineering",
        name = "Lua 架构设计原理",
        description = "深入理解 CCB Platform v1 原生内容构建与运行时架构。",
        category = "prof_cat_lua_first",
    }
    ccb.content.add(prof)

    local req = ccb.content.Requirement {
        id = "req_lua_first_circuitry",
        name = "基础电路",
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
        { id = "chem_set", count = 1 },
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
