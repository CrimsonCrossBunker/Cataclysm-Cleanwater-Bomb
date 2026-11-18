local ccb = require("ccb")
local content = ccb.content

do
    -- cheap and reusable, but doesn't last very long
    local item = content.Item {
        id = "magus_booster_1",
        looks_like = "fire_drill",
        name = ccb.content.plural_text("magus's elastic potential energy contraption (off)", "magus's elastic potential energy contraptions (off)"),
        description = ccb.content.text("This elaborate contraption of wooden sticks under tension and tightly wound strings has a pebble with a magus rune on in its center.  Once activated, this device will transform the stored elastic potential energy into arcane energy, boosting your caster level of magus spells by 1 for as long as the stored energy lasts."),
        mass_milligrams = 150000,
        volume_ml = 250,
        price_cents = 200,
        melee_to_hit = -1,
        symbol = "&",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "magus_booster_1_active", charges = 100, ammo_type = "elastic_potential_energy" },
        message = ccb.content.text("You squeeze the machine and its interior starts spinning."),
        menu_text = ccb.content.text("Activate"),
        moves = 500,
        ammo_scale = 0,
    }
    item:tool()
    item:magazine_pocket { ammo_capacities = { elastic_potential_energy = 100 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "magus_booster_1_active",
        looks_like = "fire_drill",
        name = ccb.content.plural_text("magus's elastic potential energy contraption", "magus's elastic potential energy contraptions"),
        description = ccb.content.text("This elaborate contraption of wooden sticks and strings contains a rapidly spinning pebble with magus rune on.  You feel slightly empowered, as your caster level of magus spells is boosted by 1."),
        mass_milligrams = 150000,
        volume_ml = 250,
        price_cents = 200,
        melee_to_hit = -1,
        symbol = "&",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "magus_booster_1" },
        message = ccb.content.text("The device slows down and stops."),
        menu_text = ccb.content.text("Stop"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "magus_booster_1" }
    item:tool { turns_per_charge = 5 }
    item:magazine_pocket { ammo_capacities = { elastic_potential_energy = 100 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "magus_booster_2",
        looks_like = "alarmclock",
        name = ccb.content.plural_text("magus's clockwork contraption (off)", "magus's clockwork contraptions (off)"),
        description = ccb.content.text("This intricate contraption consists of fine gears, screw drivers, belts, pulleys, springs and other clockwork.  The gearwork is contained in a casing of magically treated glass.  An elegantly drawn magus rune is caged in the center, and a wind-up key extends out of the casing, allowing the device to be powered.  Once wound up, it will boost your magus caster level by 2 for as long as the energy lasts."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 200,
        melee_to_hit = -1,
        symbol = "&",
        color = "white",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:material("iron", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "magus_booster_2_active", charges = 400, ammo_type = "elastic_potential_energy" },
        message = ccb.content.text("You wind up the device and it starts making a ticking noise."),
        menu_text = ccb.content.text("Activate"),
        moves = 500,
    }
    item:tool()
    item:magazine_pocket { ammo_capacities = { elastic_potential_energy = 400 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magus_booster_2_active",
        looks_like = "alarmclock",
        name = ccb.content.plural_text("magus's clockwork contraption", "magus's clockwork contraptions"),
        description = ccb.content.text("This intricate contraption consists of fine gears, screw drivers, belts, pulleys, springs and other clockwork parts moving in a mesmerizing dance.  The gearwork is contained in a casing of magically treated glass and gives off a soft ticking noise.  An elegantly drawn magus rune in the center is being spun and rotated in a neverending complex dance of arcane energy.  The wind-up key extending from the casing slowly spins back into its original position.  You feel empowered, as your caster level of magus spells is boosted by 2."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 200,
        melee_to_hit = -1,
        symbol = "&",
        color = "white",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:material("iron", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "magus_booster_2" },
        message = ccb.content.text("The device slows down and stops."),
        menu_text = ccb.content.text("Stop"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "magus_booster_2" }
    item:tool { turns_per_charge = 5 }
    item:magazine_pocket { ammo_capacities = { elastic_potential_energy = 400 } }
    content.add(item)
end

do
    -- Stats are based off of a food_processor.
    local item = content.Item {
        id = "technomancer_booster_2",
        category = "tools",
        name = ccb.content.plural_text("technomancer's doodad (off)", "technomancer's doodads (off)"),
        description = ccb.content.text("A jumble of cables, gears, electromagnets, and metal encased in a steel casing inscribed with arcane runes.  A pebble with a technomancer rune is found at the core.  The machine can adjust the electric charge, magnetic field, and angular velocity of said rune.  When active and in your inventory, the machine will automatically detect when you are trying to cast a technomancer spell.  Once that happens, it will use a moderate amount of battery charge to boost your caster level as far as it can.  A larger boost will draw more energy."),
        mass_milligrams = 3500000,
        volume_ml = 20000,
        longest_side_mm = 400,
        price_cents = 12000,
        price_postapoc_cents = 700,
        melee_to_hit = -1,
        symbol = "%",
        color = "white",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "technomancer_booster_2_active" },
        message = ccb.content.text("You turn on the doodad and it starts to hum."),
        menu_text = ccb.content.text("Activate"),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:fault_group("electronic_general", {  })
    item:tool { ammo_types = { "battery" } }
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
    -- Stats are based off of a food_processor.
    local item = content.Item {
        id = "technomancer_booster_2_active",
        category = "tools",
        name = ccb.content.plural_text("technomancer's doodad", "technomancer's doodads"),
        description = ccb.content.text("A jumble of cables, gears, electromagnets, and metal encased in a steel casing inscribed with arcane runes.  A pebble with a technomancer rune is found at the core.  The machine can adjust the electric charge, magnetic field, and angular velocity of said rune.  While active and in your inventory, the machine will automatically detect when you are trying to cast a technomancer spell.  Once that happens, it will use a moderate amount of battery charge to boost your caster level as far as it can.  A larger boost will draw more energy.  A faint humming is heard from inside."),
        mass_milligrams = 3500000,
        volume_ml = 20000,
        longest_side_mm = 400,
        price_cents = 12000,
        price_postapoc_cents = 700,
        melee_to_hit = -1,
        symbol = "%",
        color = "white",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "technomancer_booster_2" },
        message = ccb.content.text("The doodad shuts down."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:fault_group("electronic_general", {  })
    item:tool { turns_per_charge = 2000, ammo_types = { "battery" } }
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
    -- Based off of the candle, but twice the burn rate, and doesn't go out in the wind.
    local item = content.Item {
        id = "kelvinist_booster_1",
        looks_like = "candle",
        name = ccb.content.plural_text("kelvinist's candle (off)", "kelvinist's candles (off)"),
        description = ccb.content.text("A thick candle of magically treated tallow with a kelvinist rune artfully inscribed on the side.  It doesn't burn for quite as long as a regular candle, but it will boost your caster level of kelvinist spells by 1 while burning.  You'll need a lighter or matches to light it."),
        mass_milligrams = 225000,
        volume_ml = 250,
        price_cents = 100,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "white",
        replace_pockets = true,
    }
    item:material("beeswax", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "kelvinist_booster_1_active" },
        message = ccb.content.text("You light the candle."),
        menu_text = ccb.content.text("Light", "verb"),
        need_fire = 1,
    }
    item:clear_flags()
    item:flag("BURNOUT")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { candle_wax = 100 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "kelvinist_booster_1_active",
        looks_like = "candle_lit",
        copy_from = "kelvinist_booster_1",
        name = ccb.content.plural_text("kelvinist's candle", "kelvinist's candles"),
        description = ccb.content.text("A thick candle of magically treated tallow with a kelvinist rune artfully inscribed on the side.  It doesn't burn for quite as long as a regular candle, but it will boost your caster level of kelvinist spells by 1 while burning.  The magic of the candle protects it from the wind and from setting your backpack aflame.  This candle is lit."),
        light = 8,
    }
    item:clear_use_actions()
    item:firestarter { moves = 100 }
    item:transform_on_use {
        result = { target = "kelvinist_booster_1" },
        message = ccb.content.text("The candle winks out."),
        menu_text = ccb.content.text("Extinguish"),
        ammo_scale = 0,
    }
    item:flag("WATER_EXTINGUISH")
    item:flag("TRADER_AVOID")
    item:flag("FIRESTARTER")
    item:flag("SPAWN_ACTIVE")
    item:tool { turns_per_charge = 630 }
    content.add(item)
end

do
    -- Based off of the clay oil lamp, but twice the burn rate, doesn't go out in the wind, and made of metal.
    local item = content.Item {
        id = "kelvinist_booster_2",
        looks_like = "oil_lamp",
        name = ccb.content.plural_text("kelvinist's oil lamp (off)", "kelvinist's oil lamps (off)"),
        description = ccb.content.text("An masterfully crafted metal oil lamp with two elongated nozzles, each containing a wick.  The surface is carved with intricate arcane symbols, including a prominent kelvinist rune.  The magic of the lamp protects it from the wind and from setting your backpack aflame.  It does not provide much light, but will boost your kelvinist caster level by 2 while burning.  Use it to light it."),
        mass_milligrams = 820000,
        volume_ml = 300,
        price_cents = 800,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "brown",
        replace_pockets = true,
    }
    item:material("iron", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "kelvinist_booster_2_active" },
        menu_text = ccb.content.text("Light", "verb"),
        message = ccb.content.text("You light the lamp."),
        need_charges = 1,
        need_fire = 1,
        need_charges_message = ccb.content.text("The lamp is empty."),
    }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 1, ammo_types = { "crude_lamp_oil", "lamp_oil" } }
    item:magazine_pocket { ammo_capacities = { crude_lamp_oil = 250, lamp_oil = 250 }, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "kelvinist_booster_2_active",
        copy_from = "kelvinist_booster_2",
        looks_like = "oil_lamp_on",
        name = ccb.content.plural_text("kelvinist's oil lamp", "kelvinist's oil lamps"),
        description = ccb.content.text("An masterfully crafted metal oil lamp with two elongated nozzles, each containing a burning wick.  The surface is carved with intricate arcane symbols, including a prominent kelvinist rune.  The reflections from the flames makes it look like the inscriptions are moving.  The magic of the lamp protects it from the wind and from setting your backpack aflame.  It is lit, consuming oil, boosting your kelvinist caster level by 2, and providing light.  Use it to extinguish the flame."),
        light = 10,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "kelvinist_booster_2" },
        message = ccb.content.text("The lamp is extinguished."),
        menu_text = ccb.content.text("Extinguish"),
        ammo_scale = 0,
    }
    item:firestarter { moves = 100 }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIRE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_EXTINGUISH")
    item:flag("FIRESTARTER")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "kelvinist_booster_2" }
    item:tool { turns_per_charge = 120 }
    content.add(item)
end
