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

do
    local item = content.Item {
        id = "mtorch_everburning",
        name = ccb.content.plural_text("everburning torch", "everburning torches"),
        description = ccb.content.text("This is a high quality engraved wooden torch.  On command, the tip bursts into flame and produces a fair amount of light.  It will burn forever."),
        mass_milligrams = 831000,
        volume_ml = 750,
        price_cents = 125000,
        price_postapoc_cents = 125000,
        melee_to_hit = 1,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "mtorch_everburning_lit" },
        message = ccb.content.text("You light the torch."),
        menu_text = ccb.content.text("Light", "verb"),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mtorch_everburning_lit",
        name = ccb.content.plural_text("everburning torch", "everburning torches"),
        copy_from = "mtorch_everburning",
        looks_like = "mtorch_everburning",
        techniques = { "WBLOCK_1" },
        light = 60,
    }
    item:clear_use_actions()
    item:firestarter { moves = 30 }
    item:transform_on_use {
        result = { target = "mtorch_everburning" },
        message = ccb.content.text("The torch is extinguished."),
        menu_text = ccb.content.text("Extinguish"),
    }
    item:flag("FIRE")
    item:flag("FLAMING")
    item:flag("TRADER_AVOID")
    item:flag("WATER_EXTINGUISH")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "mtorch_everburning" }
    item:tool { crafting_subtype = "fire" }
    content.add(item)
end

do
    local item = content.Item {
        id = "mcandle_everburning",
        name = ccb.content.plural_text("everburning candle", "everburning candles"),
        description = ccb.content.text("A high quality thick wax candle.  On command, the wick ignites and provides a small amount of light.  It will burn forever."),
        mass_milligrams = 400000,
        volume_ml = 466,
        longest_side_mm = 102,
        price_cents = 100000,
        price_postapoc_cents = 100000,
        symbol = ",",
        color = "white",
    }
    item:material("paraffin_wax", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "mcandle_everburning_lit" },
        message = ccb.content.text("You light the candle."),
        menu_text = ccb.content.text("Light"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mcandle_everburning_lit",
        name = ccb.content.plural_text("everburning candle", "everburning candles"),
        copy_from = "mcandle_everburning",
        looks_like = "mcandle_everburning",
        light = 8,
    }
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:transform_on_use {
        result = { target = "mcandle_everburning" },
        message = ccb.content.text("The candle winks out."),
        menu_text = ccb.content.text("Extinguish"),
    }
    item:flag("FIRE")
    item:flag("FLAMING")
    item:flag("TRADER_AVOID")
    item:flag("WATER_EXTINGUISH")
    item:flag("WIND_EXTINGUISH")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "mcandle_everburning" }
    item:tool { crafting_subtype = "fire" }
    content.add(item)
end
