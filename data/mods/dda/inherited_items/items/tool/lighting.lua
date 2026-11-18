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

do
    -- https://www.amazon.com/dp/B0CFLGMKQM
    local item = content.Item {
        id = "flashlight",
        name = ccb.content.plural_text("flashlight (off)", "flashlights (off)"),
        description = ccb.content.text("A typical household flashlight with a plastic handle, powered by batteries."),
        ascii_picture = "flashlight",
        symbol = ";",
        color = "blue",
        mass_milligrams = 140000,
        volume_ml = 121,
        longest_side_mm = 136,
        price_cents = 900,
        price_postapoc_cents = 15,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("WATER_BREAK_ACTIVE")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "flashlight_on" },
        message = ccb.content.text("You turn the flashlight on."),
        need_charges = 1,
        damage_failure_message = ccb.content.text("You press the button on your %s, but nothing happens."),
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "flashlight_on",
        copy_from = "flashlight",
        looks_like = "flashlight",
        ascii_picture = "flashlight",
        name = ccb.content.plural_text("flashlight (on)", "flashlights (on)"),
        light = 300,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "flashlight" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the flashlight off."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("WATER_BREAK")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "flashlight" }
    item:tool { power_milliwatts = 1560 }
    content.add(item)
end

do
    -- Based on this: https://www.amazon.com/dp/B07BDKRFJG; Sinlge 18650 instead of two AAs
    local item = content.Item {
        id = "diving_flashlight_small",
        name = ccb.content.plural_text("mini diving flashlight (off)", "mini diving flashlights (off)"),
        description = ccb.content.text("A small waterproof flashlight with an aluminum handle, powered by batteries.  Can be attached to some diving masks and hoods."),
        looks_like = "flashlight",
        symbol = ";",
        color = "blue",
        mass_milligrams = 48000,
        volume_ml = 45,
        longest_side_mm = 100,
        price_cents = 500,
        price_postapoc_cents = 100,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_small_on" },
        message = ccb.content.text("You turn the flashlight on."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "diving_flashlight_small_on",
        copy_from = "diving_flashlight_small",
        name = ccb.content.plural_text("mini diving flashlight (on)", "mini diving flashlights (on)"),
        looks_like = "flashlight_on",
        light = 170,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_small" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the flashlight off."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "diving_flashlight_small" }
    item:tool { power_milliwatts = 1200 }
    content.add(item)
end

do
    -- Based on this: https://www.amazon.com/dp/B0BD6GVJH2
    local item = content.Item {
        id = "diving_flashlight_small_hipower",
        name = ccb.content.plural_text("high-power mini diving flashlight (off)", "high-power mini diving flashlights (off)"),
        description = ccb.content.text("A small waterproof high-power flashlight with an aluminum handle, powered by batteries.  Can be attached to some diving masks and hoods."),
        looks_like = "flashlight",
        symbol = ";",
        color = "blue",
        mass_milligrams = 40000,
        volume_ml = 38,
        longest_side_mm = 100,
        price_cents = 500,
        price_postapoc_cents = 100,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_small_hipower_on" },
        message = ccb.content.text("You turn the flashlight on."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "diving_flashlight_small_hipower_on",
        copy_from = "diving_flashlight_small_hipower",
        name = ccb.content.plural_text("high-power mini diving flashlight (on)", "high-power mini diving flashlights (on)"),
        looks_like = "flashlight_on",
        light = 450,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_small_hipower" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the flashlight off."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "diving_flashlight_small_hipower" }
    item:tool { power_milliwatts = 3000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "glowstick",
        name = ccb.content.plural_text("glowstick", "glowsticks"),
        description = ccb.content.text("A small blue-light glowstick.  Use it to bend the plastic and break the glass cylinder inside to start the reaction.  It will produce a small amount of light."),
        mass_milligrams = 25000,
        volume_ml = 25,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_blue",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "glowstick_lit" },
        message = ccb.content.text("You activate the glowstick."),
        menu_text = ccb.content.text("Activate"),
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:tool { ammo_types = { "glowstick_juice" } }
    item:magazine_pocket { ammo_capacities = { glowstick_juice = 1400 }, rigid = true }
    content.add(item)
end
