local content = {}

function content.register(ccb)
    local codex = ccb.content.Item {
        id = "lua_first_dev_codex",
        name = "Lua Modding Codex",
        description = "An interactive field terminal and tutorial codex for CCB Lua Platform v1. Use it to access mod developer tutorials, interactive sandboxes, and runtime state inspectors.",
        symbol = "?",
    }
    codex:mass_grams(150)
    codex:volume_ml(250)
    codex:price_cents(500)
    codex:material("plastic", 1)
    codex:on_use("lua_first_open_dev_codex", "Read developer tutorials and open toolbox")
    ccb.content.add(codex)

    local omnitool = ccb.content.Item {
        id = "lua_first_omnitool",
        name = "vibro-salvage multitool",
        description = "A high-frequency oscillating cutting and maintenance tool created with Lua Platform v1. Combines high cutting, prying, and butchery qualities.",
        symbol = "/",
    }
    omnitool:mass_grams(450)
    omnitool:volume_ml(350)
    omnitool:price_cents(3500)
    omnitool:material("steel", 2)
    omnitool:quality("CUT", 3)
    omnitool:quality("BUTCHER", 20)
    omnitool:quality("HAMMER", 2)
    omnitool:quality("PRY", 2)
    omnitool:flag("DURABLE_MELEE")
    omnitool:on_use("lua_first_use_omnitool", "Toggle power modes")
    ccb.content.add(omnitool)

    local tonic = ccb.content.Item {
        id = "lua_first_nano_tonic",
        name = "purifying nano-tonic",
        description = "A medical stimulant vial synthesized via Lua chemistry recipes. Grants sustained cellular regeneration and scheduled state tracking.",
        symbol = "!",
    }
    tonic:mass_grams(60)
    tonic:volume_ml(50)
    tonic:price_cents(1200)
    tonic:material("glass", 1)
    tonic:on_use("lua_first_use_nano_tonic", "Inject nano-tonic")
    ccb.content.add(tonic)

    local cell = ccb.content.Item {
        id = "lua_first_cleanwater_cell",
        name = "purification capacitor cell",
        description = "A compact high-density power cell used by clean-water experimental devices.",
        symbol = "=",
    }
    cell:mass_grams(80)
    cell:volume_ml(40)
    cell:price_cents(300)
    cell:material("steel", 1)
    ccb.content.add(cell)
end

return content
