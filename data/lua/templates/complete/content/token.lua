local token_content = {}
local MOD_ID = __CCB_LUA_FIRST_MOD_ID__
local TOKEN_ID = MOD_ID .. "_cleanwater_token"

function token_content.register(ccb)
    local token = ccb.content.Item {
        id = TOKEN_ID,
        name = "Lua clean-water token",
        description = "A native item defined entirely by Lua-first Platform code.",
        symbol = "*",
    }
    token:mass_grams(25)
    token:volume_ml(10)
    token:price_cents(500)
    token:material("steel", 1)
    token:on_use("activate_cleanwater_token", "Activate Lua token")
    ccb.content.add(token)

    local recipe = ccb.content.Recipe {
        id = TOKEN_ID,
        result = TOKEN_ID,
        category = "CC_OTHER",
        subcategory = "CSC_OTHER_OTHER",
        skill = "fabrication",
        difficulty = 1,
        duration_moves = 500,
        autolearn = true,
    }
    recipe:component("scrap", 1)
    ccb.content.add(recipe)
end

return token_content
