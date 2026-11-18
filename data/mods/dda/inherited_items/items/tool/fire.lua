local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tinderbox",
        name = ccb.content.plural_text("ember carrier", "ember carriers"),
        description = ccb.content.text("A small container for holding tinder, with holes punched in it to provide a controlled airflow.  It can nurture a smoldering ember for a long time, to start fires without modern tools."),
        mass_milligrams = 40000,
        volume_ml = 263,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tinderbox_on" },
        menu_text = ccb.content.text("Light", "verb"),
        message = ccb.content.text("You light the tinder."),
        need_charges = 1,
        need_fire = 1,
        need_charges_message = ccb.content.text("The ember carrier is out of tinder."),
    }
    item:tool { ammo_types = { "tinder" } }
    item:magazine_pocket { ammo_capacities = { tinder = 50 }, rigid = true }
    content.add(item)
end

do
    -- ultra light battery seems to not have enough power to generate this amount of heat
    local item = content.Item {
        id = "crude_firestarter",
        name = ccb.content.plural_text("electric firestarter", "electric firestarters"),
        description = ccb.content.text("A crudely-made electric firestarter, which can function as an inefficient lighter."),
        mass_milligrams = 14000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:firestarter { moves = 1000, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fire_drill",
        name = ccb.content.plural_text("bow fire drill", "bow fire drills"),
        description = ccb.content.text("A simple item for starting fires with friction between a notched plank and wooden shaft.  The shaft is spun rapidly with a sawing motion by a bowstring wrapped around it.  Very slow to acquire a usable ember."),
        mass_milligrams = 240000,
        volume_ml = 400,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "brown",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:firestarter { moves = 30000, moves_slow = 60000 }
    item:quality("DRILL_ROCK", 1)
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("REQUIRES_TINDER")
    item:tool { charges_per_use = 1, ammo_types = { "notch" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        allowed_items = { "notched_plank", "notched_stick" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fire_drill_large",
        name = ccb.content.plural_text("pump fire drill", "pump fire drills"),
        description = ccb.content.text("A simple item for starting fires by friction between a notched plank and wooden shaft, with a flywheel attached.  The shaft is spun rapidly with a pumping motion by a cord wrapped around it.  Slow to acquire a usable ember."),
        mass_milligrams = 900000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "brown",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:clear_use_actions()
    item:firestarter { moves = 6000, moves_slow = 15000 }
    item:quality("DRILL_ROCK", 1)
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("REQUIRES_TINDER")
    item:tool { charges_per_use = 1, ammo_types = { "notch" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        allowed_items = { "notched_plank", "notched_stick" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "flint_steel",
        name = ccb.content.plural_text("flint and steel", "sets of flint and steel"),
        description = ccb.content.text("A piece of flint paired with a hardened high carbon steel striker.  Use it to spark a flame."),
        mass_milligrams = 400000,
        volume_ml = 250,
        price_cents = 300,
        price_postapoc_cents = 250,
        symbol = ",",
        color = "dark_gray",
    }
    item:material("stone", 1)
    item:material("hc_steel", 1)
    item:clear_use_actions()
    item:firestarter { moves = 3000, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("REQUIRES_TINDER")
    item:tool { charges_per_use = 1, initial_charges = 2000, max_charges = 2000 }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "lighter",
        ascii_picture = "lighter",
        name = ccb.content.plural_text("lighter", "lighters"),
        description = ccb.content.text("A disposable plastic lighter, capable of creating a small flame with the flick of a finger.  Allows you to use various drugs like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire."),
        mass_milligrams = 14000,
        volume_ml = 14,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "blue",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { butane = 100 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "magnifying_glass",
        name = ccb.content.plural_text("magnifying glass", "magnifying glasses"),
        description = ccb.content.text("A magnifying glass, for closely examining fine details.  It can also be used for starting fires if direct sunlight is available."),
        mass_milligrams = 400000,
        volume_ml = 250,
        price_cents = 600,
        price_postapoc_cents = 50,
        symbol = "o",
        color = "green",
    }
    item:material("glass", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:firestarter { moves = 1000, moves_slow = 25000, need_sunlight = true }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lens_crude",
        symbol = ".",
        color = "light_cyan",
        name = ccb.content.plural_text("crude glass lens", "crude glass lenses"),
        category = "spare_parts",
        description = ccb.content.text("A very low-quality focusing lens, made from non-optical-grade glass.  Useless for building most optical devices, but you can start a fire with it if sunlight is available."),
        price_cents = 300,
        price_postapoc_cents = 80,
        mass_milligrams = 50000,
        volume_ml = 20,
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:firestarter { moves = 1100, moves_slow = 33000, need_sunlight = true }
    item:clear_flags()
    item:flag("FIRESTARTER")
    content.add(item)
end

do
    -- Insert tinder, pump (possibly repeatedly), take ember out.
    local item = content.Item {
        id = "fire_piston",
        name = ccb.content.plural_text("fire piston", "fire pistons"),
        description = ccb.content.text("A firestarting tool of Southeast Asian origin, consisting of a thin, hollow wooden cylinder sealed at one end and open at the other, and a wooden piston forming an airtight circular seal with it, making use of rapid and adiabatic air compression to ignite a piece of tinder.  It also comes with a tinder container to keep tinder dry.  Use it to start a fire."),
        mass_milligrams = 668000,
        volume_ml = 750,
        longest_side_mm = 200,
        price_cents = 300,
        price_postapoc_cents = 250,
        symbol = ",",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:firestarter { moves = 6000, moves_slow = 30000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("REQUIRES_TINDER")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { tinder = 50 }, rigid = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "matches",
        name = ccb.content.plural_text("matchbook", "matchbooks"),
        description = ccb.content.text("A small book of matches with a coarse strike surface on the outside flap for lighting them.  Allows you to use various drugs like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire.  Due to the matches being lightly glued to the matchbook, they can be removed, but not replaced on the book."),
        category = "container",
        mass_milligrams = 10000,
        volume_ml = 10,
        price_cents = 10,
        price_postapoc_cents = 5,
        symbol = ",",
        color = "blue",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:quality("STRIKING_SURFACE", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { match = 20 }, rigid = true, holster = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "survival_match",
        name = ccb.content.plural_text("survival match", "survival matches"),
        description = ccb.content.text("A solid strike anywhere match.  One and done."),
        looks_like = "matches",
        mass_milligrams = 2000,
        volume_ml = 1,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = "|",
        color = "red",
    }
    item:material("cardboard", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("BURNOUT")
    item:tool { charges_per_use = 1, initial_charges = 1, max_charges = 1 }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "ref_matches",
        name = ccb.content.plural_text("matchbox", "matchboxes"),
        description = ccb.content.text("A small box of matches with a coarse strike surface on the side for lighting them.  Allows you to use various drugs like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire."),
        looks_like = "matches",
        category = "container",
        mass_milligrams = 10000,
        volume_ml = 25,
        price_postapoc_cents = 50,
        price_cents = 7,
        symbol = ",",
        color = "blue",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:quality("STRIKING_SURFACE", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("WATER_BREAK")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { match = 32 }, rigid = true, holster = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "ref_lighter",
        name = ccb.content.plural_text("refillable lighter", "refillable lighters"),
        description = ccb.content.text("A stylish lighter featuring a flip-top cover and a refuelable tank, capable of creating a small flame with the flick of a finger.  Allows you to use various drugs like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire."),
        mass_milligrams = 20000,
        volume_ml = 31,
        price_cents = 3000,
        price_postapoc_cents = 150,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "ref_lighter_on" },
        message = ccb.content.text("You flick the lighter."),
        menu_text = ccb.content.text("Light up"),
        need_charges = 1,
        need_charges_message = ccb.content.text("Nothing happens."),
    }
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:tool { charges_per_use = 1, ammo_types = { "lamp_oil" } }
    item:magazine_pocket { ammo_capacities = { lamp_oil = 50 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "ref_lighter_on",
        name = ccb.content.plural_text("refillable lighter", "refillable lighters"),
        description = ccb.content.text("A stylish lighter featuring a flip-top cover and a refuelable tank.  It is lit."),
        mass_milligrams = 20000,
        volume_ml = 31,
        price_cents = 3000,
        price_postapoc_cents = 150,
        symbol = ",",
        color = "light_gray",
        light = 8,
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:transform_on_use {
        result = { target = "ref_lighter" },
        message = ccb.content.text("You extinguish the lighter."),
        menu_text = ccb.content.text("Extinguish"),
    }
    item:clear_flags()
    item:flag("FIRE")
    item:flag("FIRESTARTER")
    item:flag("FLAMING")
    item:flag("TRADER_AVOID")
    item:flag("WATER_EXTINGUISH")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "ref_lighter" }
    item:tool { charges_per_use = 1, turns_per_charge = 20, ammo_types = { "lamp_oil" } }
    item:magazine_pocket { ammo_capacities = { lamp_oil = 50 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "ref_lighter_butane",
        name = ccb.content.plural_text("refillable butane lighter", "refillable butane lighters"),
        description = ccb.content.text("A large lighter with a trigger and a safety, reloaded by fitting a can of butane inside the base.  Allows you to use various drugs like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire."),
        mass_milligrams = 200000,
        volume_ml = 176,
        longest_side_mm = 150,
        price_cents = 3000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "white",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:tool { charges_per_use = 1, ammo_types = { "butane" } }
    item:magazine_well { max_volume_ml = 200000000, max_weight_milligrams = 2000000000000, allowed_items = { "butane_can" } }
    content.add(item)
end

do
    -- ~30 seconds to get the tinder out and spreading under optimal conditions.
    local item = content.Item {
        id = "tinderbox_on",
        name = ccb.content.plural_text("ember carrier (lit)", "ember carriers (lit)"),
        description = ccb.content.text("A small container for holding tinder, with holes punched in it to provide a controlled airflow.  An ember is smoldering inside it, and can be used to start a campfire."),
        mass_milligrams = 40000,
        volume_ml = 263,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:firestarter { moves = 3000, moves_slow = 30000 }
    item:transform_on_use {
        result = { target = "tinderbox" },
        message = ccb.content.text("The ember is extinguished."),
        menu_text = ccb.content.text("Extinguish"),
    }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tinderbox" }
    item:tool { turns_per_charge = 600, ammo_types = { "tinder" } }
    item:magazine_pocket { ammo_capacities = { tinder = 50 }, rigid = true }
    content.add(item)
end

do
    -- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
    local item = content.Item {
        id = "small_lighter",
        ascii_picture = "small_lighter",
        name = ccb.content.plural_text("mini lighter", "mini lighters"),
        description = ccb.content.text("A miniature disposable plastic lighter, capable of creating a small flame with the flick of a finger.  Allows you to use various drugs, like cigarettes, light explosives like Molotov cocktails, or light nearby items on fire."),
        mass_milligrams = 8000,
        volume_ml = 8,
        price_cents = 6,
        price_postapoc_cents = 6,
        symbol = ",",
        color = "blue",
        looks_like = "lighter",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:firestarter { moves = 500, moves_slow = 6000 }
    item:clear_flags()
    item:flag("FIRESTARTER")
    item:flag("NO_UNLOAD")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { butane = 50 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end
