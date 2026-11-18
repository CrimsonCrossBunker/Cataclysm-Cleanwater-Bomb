local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "masonrysaw_on",
        copy_from = "masonrysaw_off",
        looks_like = "masonrysaw_off",
        name = ccb.content.plural_text("masonry saw (on)", "masonry saws (on)"),
        description = ccb.content.text("This masonry saw is on and making a lot of noise.  Use it to turn it off."),
        melee_to_hit = -2,
        techniques = { "SWEEP" },
        replace_qualities = true,
    }
    item:quality("AXE", 3)
    item:quality("BUTCHER", -100)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "masonrysaw_off" },
        message = ccb.content.text("Your %s goes quiet."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:clear_flags()
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("POWERED")
    item:flag("FRAGILE_MELEE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 10)
    item:transform_into { target = "masonrysaw_off" }
    item:tool { charges_per_use = 0, turns_per_charge = 4 }
    item:clear_tick_actions()
    item:on_tick("tick_masonrysaw_on")
    content.add(item)
end

do
    -- I don't know whether we are allowed to have less than 1 turn per charge. Based on 13.2 to 1 conversion rate between
    -- epower and gasoline (according to jackhammer tools) it would be 0.3 turns per charge.
    local item = content.Item {
        id = "electric_masonrysaw_on",
        copy_from = "electric_masonrysaw_off",
        looks_like = "electric_masonrysaw_off",
        name = ccb.content.plural_text("electric masonry saw (on)", "electric masonry saws (on)"),
        description = ccb.content.text("This electric masonry saw is on and making a lot of noise.  Use it to turn it off."),
        melee_to_hit = -2,
        techniques = { "SWEEP" },
        replace_qualities = true,
    }
    item:quality("AXE", 3)
    item:quality("BUTCHER", -100)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "electric_masonrysaw_off" },
        message = ccb.content.text("Your %s goes quiet."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:link_cable {
        cable_length = 33,
        ammo_scale = 0,
        charge_milliwatts = 2200000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("POWERED")
    item:flag("FRAGILE_MELEE")
    item:flag("USE_UPS")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 10)
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "electric_masonrysaw_off" }
    item:tool { charges_per_use = 0, turns_per_charge = 1 }
    item:clear_tick_actions()
    item:on_tick("tick_electric_masonrysaw_on")
    content.add(item)
end

do
    local item = content.Item {
        id = "heavy_masonrysaw_on",
        copy_from = "heavy_masonrysaw_off",
        looks_like = "heavy_masonrysaw_off",
        name = ccb.content.plural_text("heavy masonry saw (on)", "heavy masonry saws (on)"),
        description = ccb.content.text("This masonry saw is on and making a lot of noise.  Use it to turn it off."),
        melee_to_hit = -2,
        techniques = { "SWEEP" },
        replace_qualities = true,
    }
    item:quality("AXE", 3)
    item:quality("BUTCHER", -100)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "heavy_masonrysaw_off" },
        message = ccb.content.text("Your %s goes quiet."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:clear_flags()
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("POWERED")
    item:flag("FRAGILE_MELEE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 10)
    item:transform_into { target = "heavy_masonrysaw_off" }
    item:tool { charges_per_use = 0, turns_per_charge = 4 }
    item:clear_tick_actions()
    item:on_tick("tick_heavy_masonrysaw_on")
    content.add(item)
end

do
    local item = content.Item {
        id = "masonrysaw_off",
        name = ccb.content.plural_text("masonry saw (off)", "masonry saws (off)"),
        description = ccb.content.text("A construction tool for cutting through concrete or other surfaces.  It runs on gasoline.  Using this item will cause it to turn on, turning it into a very powerful but unwieldy melee weapon or a terrible chainsaw."),
        mass_milligrams = 4500000,
        volume_ml = 2500,
        longest_side_mm = 250,
        price_cents = 8000,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = "/",
        color = "blue",
        techniques = { "SWEEP" },
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 5, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 450 }, watertight = true, rigid = true }
    item:clear_use_actions()
    item:on_use("start_masonrysaw_off", ccb.content.text("Turn on"), nil, { id = "activate_power" })
    content.add(item)
end

do
    -- based on Hilti DSH 900-X 16 inch Gas cut-off saw
    local item = content.Item {
        id = "heavy_masonrysaw_off",
        name = ccb.content.plural_text("heavy masonry saw (off)", "heavy masonry saws (off)"),
        description = ccb.content.text("A heavy construction tool for cutting demolishing concrete.  It runs on gasoline.  Using this item will cause it to turn on, turning it into a formidable demolition tool, a terrible chainsaw, and an unwieldy melee weapon."),
        mass_milligrams = 12400000,
        volume_ml = 20000,
        longest_side_mm = 860,
        price_cents = 200000,
        price_postapoc_cents = 1000,
        melee_to_hit = -2,
        symbol = "/",
        color = "blue",
        looks_like = "masonrysaw_off",
        techniques = { "SWEEP" },
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 5, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 450 }, watertight = true, rigid = true }
    item:clear_use_actions()
    item:on_use("start_heavy_masonrysaw_off", ccb.content.text("Turn on"), nil, { id = "activate_power" })
    content.add(item)
end
