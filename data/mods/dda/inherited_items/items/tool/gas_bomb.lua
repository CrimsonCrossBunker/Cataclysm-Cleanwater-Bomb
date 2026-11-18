local ccb = require("ccb")
local content = ccb.content

do
    -- intended fields: emits; countdown_interval; name
    local item = content.Item {
        id = "abstract_gas_bomb_active",
        abstract = true,
        copy_from = "abstract_gas_bomb_primed",
        description = ccb.content.text("This grenade has had its pin pulled and is now expelling highly toxic gas."),
        countdown_turns = 60,
    }
    item:transform_into { target = "canister_empty" }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("tear gas grenade", "tear gas grenades"),
        description = ccb.content.text("This tear gas grenade has had its pin removed and is expelling highly noxious gas."),
        field_emissions = { "emit_tear_gas_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "smokebomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("smoke grenade", "smoke grenades"),
        mass_milligrams = 680000,
        description = ccb.content.text("This smoke bomb has had its pin removed and is expelling thick smoke."),
        field_emissions = { "emit_smoke_stream" },
        countdown_turns = 100,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("insecticidal gas grenade", "insecticidal gas grenades"),
        field_emissions = { "emit_insecticidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift insecticidal gas grenade", "makeshift insecticidal gas grenades"),
        field_emissions = { "emit_small_insecticidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("fungicidal gas grenade", "fungicidal gas grenades"),
        field_emissions = { "emit_fungicidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift fungicidal gas grenade", "makeshift fungicidal gas grenades"),
        field_emissions = { "emit_small_fungicidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift toxic gas grenade", "makeshift toxic gas grenades"),
        countdown_turns = 30,
        field_emissions = { "emit_toxic_stream" },
    }
    content.add(item)
end
