local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mkey_opening",
        name = ccb.content.plural_text("skeleton key of opening", "skeleton keys of opening"),
        description = ccb.content.text("A small gold skeleton key.  You can activate it to unlock locked things."),
        mass_milligrams = 20000,
        volume_ml = 1,
        price_cents = 500000,
        symbol = "[",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("gold", 1)
    item:quality("LOCKPICK", 50)
    item:clear_flags()
    item:flag("PERFECT_LOCKPICK")
    item:tool { charges_per_use = 1, initial_charges = 5, max_charges = 5 }
    content.add(item)
end

do
    local item = content.Item {
        id = "heat_cube_torch_on",
        copy_from = "heat_cube",
        looks_like = "heat_cube",
        name = ccb.content.plural_text("heat cube (torch on)", "heat cubes (torch on)"),
        description = ccb.content.text("The heat cube in the torch configuration, where it emits warmth and a bright flame that does not burn."),
        light = 15,
        field_emissions = { "emit_hot_air2_stream" },
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "heat_cube" },
        message = ccb.content.text("The torch flame is extinguished."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "heat_cube" }
    item:tool { turns_per_charge = 360 }
    content.add(item)
end
