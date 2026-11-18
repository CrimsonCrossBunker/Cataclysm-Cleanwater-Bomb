local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "glowstick_dead",
        category = "other",
        name = ccb.content.plural_text("dead glowstick", "dead glowsticks"),
        description = ccb.content.text("A spent glowstick.  It is essentially trash."),
        mass_milligrams = 25000,
        volume_ml = 25,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glowstick_lit",
        name = ccb.content.plural_text("active glowstick", "active glowsticks"),
        description = ccb.content.text("An active glowstick, currently producing light.  It will last for a few hours before burning out."),
        mass_milligrams = 25000,
        volume_ml = 25,
        symbol = ";",
        color = "light_blue",
        light = 8,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SLEEP_IGNORE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "glowstick_dead" }
    item:ammo_pocket("glowstick_juice", 1400)
    item:tool { turns_per_charge = 30, revert_message = ccb.content.text("The glowstick fades out.") }
    content.add(item)
end

do
    -- It's specifically not rigid because volume of candlestick and candle should be additive.
    local item = content.Item {
        id = "menorah",
        name = ccb.content.plural_text("menorah", "menorahs"),
        description = ccb.content.text("An eight-branched candelabra more properly called a 'hanukkiah', the menorah is used to celebrate the Jewish festival of Hanukkah."),
        mass_milligrams = 229000,
        volume_ml = 1931,
        longest_side_mm = 184,
        price_cents = 1500,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:container_pocket {
        max_volume_ml = 350,
        max_weight_milligrams = 4000,
        holster = true,
        max_item_length_mm = 151,
        allowed_items = { "candle_small", "candle_small_lit" },
        transparent = true,
    }
    item:tool()
    content.add(item)
end
