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

do
    local item = content.Item {
        id = "electric_lantern",
        name = ccb.content.plural_text("electric lantern (off)", "electric lanterns (off)"),
        description = ccb.content.text("A battery-powered lamp.  It does not provide much light, but it lasts a long time."),
        mass_milligrams = 550000,
        volume_ml = 1527,
        price_cents = 6800,
        price_postapoc_cents = 20,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "electric_lantern_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 20000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 58 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "electric_lantern_on",
        copy_from = "electric_lantern",
        looks_like = "electric_lantern",
        name = ccb.content.plural_text("electric lantern (on)", "electric lanterns (on)"),
        light = 15,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "electric_lantern" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn off the %s."),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 20000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("TRADER_AVOID")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "electric_lantern" }
    item:tool { power_milliwatts = 1000 }
    content.add(item)
end

do
    -- Based on this: https://www.amazon.com/dp/B00DI5GMOM
    local item = content.Item {
        id = "diving_flashlight_variable",
        name = ccb.content.plural_text("variable power diving flashlight (off)", "variable power diving flashlights (off)"),
        description = ccb.content.text("A waterproof variable power flashlight with a plastic handle, powered by batteries.  Can be attached to some diving masks and hoods and onto a proprietary wrist mount."),
        looks_like = "flashlight",
        symbol = ";",
        color = "blue",
        mass_milligrams = 182000,
        volume_ml = 185,
        longest_side_mm = 130,
        price_cents = 500,
        price_postapoc_cents = 100,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("WRIST_MOUNT_ATTACHMENT")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_variable_on_hi" },
        message = ccb.content.text("You turn the flashlight on."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable {
        cable_length = 2,
        ammo_scale = 0,
        charge_milliwatts = 20000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 35 }, rigid = true }
    content.add(item)
end

do
    -- Uses a 3.7 V battery at ~1.73 A at full power = 6.413 W draw.
    local item = content.Item {
        id = "diving_flashlight_variable_on_hi",
        copy_from = "diving_flashlight_variable",
        name = ccb.content.plural_text("variable power diving flashlight (on, high)", "variable power mini diving flashlights (on, high)"),
        looks_like = "flashlight_on",
        light = 500,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_variable_on_med" },
        menu_text = ccb.content.text("Lower power"),
        message = ccb.content.text("You decrease power of the flashlight."),
        ammo_scale = 0,
    }
    item:link_cable {
        cable_length = 2,
        ammo_scale = 0,
        charge_milliwatts = 20000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "diving_flashlight_variable" }
    item:tool { power_milliwatts = 6420 }
    content.add(item)
end

do
    -- Uses a 3.7 V battery at ~0.46 A at medium power = ~1.7 W draw.
    local item = content.Item {
        id = "diving_flashlight_variable_on_med",
        copy_from = "diving_flashlight_variable",
        name = ccb.content.plural_text("variable power diving flashlight (on, medium)", "variable power mini diving flashlights (on, medium)"),
        looks_like = "flashlight_on",
        light = 200,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_variable_on_low" },
        menu_text = ccb.content.text("Lower power"),
        message = ccb.content.text("You decrease power of the flashlight."),
        ammo_scale = 0,
    }
    item:link_cable {
        cable_length = 2,
        ammo_scale = 0,
        charge_milliwatts = 20000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "diving_flashlight_variable" }
    item:tool { power_milliwatts = 1700 }
    content.add(item)
end

do
    -- Uses a 3.7 V battery at ~0.289 A at low power = ~1.07 W draw.
    local item = content.Item {
        id = "diving_flashlight_variable_on_low",
        copy_from = "diving_flashlight_variable",
        name = ccb.content.plural_text("variable power diving flashlight (on, low)", "variable power mini diving flashlights (on, low)"),
        looks_like = "flashlight_on",
        light = 80,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "diving_flashlight_variable" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the flashlight off."),
        ammo_scale = 0,
    }
    item:link_cable {
        cable_length = 2,
        ammo_scale = 0,
        charge_milliwatts = 20000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("HELMET_HEAD_ATTACHMENT")
    item:flag("HEAD_STRAP_MOUNT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "diving_flashlight_variable" }
    item:tool { power_milliwatts = 1070 }
    content.add(item)
end

do
    local item = content.Item {
        id = "heavy_flashlight_on",
        copy_from = "heavy_flashlight",
        looks_like = "heavy_flashlight",
        name = ccb.content.plural_text("heavy-duty flashlight (on)", "heavy-duty flashlights (on)"),
        light = 650,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "heavy_flashlight" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the heavy-duty flashlight off."),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 20000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("CHARGEDIM")
    item:flag("BELT_CLIP")
    item:flag("BELTED")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "heavy_flashlight" }
    item:tool { power_milliwatts = 4000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "lightstrip",
        name = ccb.content.plural_text("LED strip", "LED strips"),
        copy_from = "lightstrip_inactive",
        looks_like = "lightstrip_inactive",
        color = "green",
        symbol = ";",
        light = 200,
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "lightstrip_inactive" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn off the %s."),
    }
    item:link_cable { cable_length = 10, charge_milliwatts = 5000 }
    item:transform_into { target = "lightstrip_inactive" }
    item:tool { power_milliwatts = 5000, revert_message = ccb.content.text("The LED strip fades away.") }
    content.add(item)
end

do
    -- 25 feet (7.5 m) + 1.5 meters for plug
    local item = content.Item {
        id = "lightstrip_inactive",
        name = ccb.content.plural_text("LED strip (inactive)", "LED strips (inactive)"),
        description = ccb.content.text("25 feet of colorful LED strip, that are often used as house lights or on some holidays."),
        mass_milligrams = 158000,
        volume_ml = 70,
        price_cents = 1000,
        price_postapoc_cents = 2,
        symbol = ";",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("aluminum", 9)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "lightstrip" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
    }
    item:link_cable { cable_length = 9, charge_milliwatts = 5000 }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    -- https://www.amazon.com/dp/B08GG42WXY
    local item = content.Item {
        id = "reading_light",
        name = ccb.content.plural_text("reading light (off)", "reading lights (off)"),
        description = ccb.content.text("A little clip-on LED light, meant for reading books in the dark."),
        mass_milligrams = 64000,
        volume_ml = 150,
        price_cents = 2400,
        price_postapoc_cents = 1,
        symbol = ";",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "reading_light_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 2000 }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 13 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "reading_light_on",
        copy_from = "reading_light",
        looks_like = "reading_light",
        name = ccb.content.plural_text("reading light (on)", "reading lights (on)"),
        description = ccb.content.text("A little clip-on LED light, meant for reading books in the dark.  This one is turned on."),
        light = 15,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "reading_light" },
        message = ccb.content.text("You turn off the %s."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 2000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:flag("CHARGEDIM")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "reading_light" }
    item:tool { power_milliwatts = 46 }
    content.add(item)
end

do
    -- https://www.amazon.com/dp/B0CM3RKR5Z
    local item = content.Item {
        id = "smart_lamp",
        name = ccb.content.plural_text("smart lamp (off)", "smart lamps (off)"),
        description = ccb.content.text("A smart lamp that can be activated remotely."),
        mass_milligrams = 297000,
        volume_ml = 1851,
        price_cents = 3000,
        price_postapoc_cents = 1,
        melee_to_hit = -4,
        symbol = "&",
        color = "blue",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "smart_lamp_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 6000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("RADIO_ACTIVATION")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("RADIOSIGNAL_2")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 33 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "smart_lamp_on",
        copy_from = "smart_lamp",
        looks_like = "smart_lamp",
        name = ccb.content.plural_text("smart lamp (on)", "smart lamps (on)"),
        description = ccb.content.text("A smart lamp which can be deactivated remotely.  Currently it is turned on."),
        light = 240,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "smart_lamp" },
        message = ccb.content.text("You turn off the %s."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 6000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("RADIO_ACTIVATION")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("RADIOSIGNAL_2")
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "smart_lamp" }
    item:tool { power_milliwatts = 1321 }
    content.add(item)
end
