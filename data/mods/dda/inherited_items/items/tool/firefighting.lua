local ccb = require("ccb")
local content = ccb.content

do
    -- Same stats as a hatchet (as a tool and weapon), except it has prying instead of hammering.
    local item = content.Item {
        id = "crash_axe",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("crash axe", "crash axes"),
        looks_like = "hatchet",
        description = ccb.content.text("A short, lightweight emergency tool with a quarter-circular blade, a short pick opposite the blade, and an insulated handle.  Used on airplanes to chop down or pry walls or cabinets to gain access in case of a fire."),
        price_cents = 2500,
        price_postapoc_cents = 750,
        techniques = { "WBLOCK_1" },
        mass_milligrams = 907000,
        volume_ml = 1000,
        longest_side_mm = 400,
        melee_to_hit = 0,
        weapon_categories = { "HAND_AXES" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:quality("AXE", 2)
    item:quality("CUT", 1)
    item:quality("PRY", 2)
    item:quality("BUTCHER", 16)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 20)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fire_ax",
        name = ccb.content.plural_text("fire axe", "fire axes"),
        description = ccb.content.text("A large, two-handed pickhead axe normally used by firefighters.  It makes a powerful melee weapon, but is a bit slow to recover between swings.  The pickhead is for spiking into doors and glass and is not effective at hooking limbs of opponents."),
        mass_milligrams = 3448000,
        volume_ml = 2000,
        price_cents = 20000,
        longest_side_mm = 900,
        price_postapoc_cents = 1500,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        weapon_categories = { "GREAT_AXES" },
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("AXE", 3)
    item:quality("PRY", 3)
    item:quality("BUTCHER", -30)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:container_pocket {
        max_volume_ml = 550,
        max_weight_milligrams = 5500000,
        max_item_length_mm = 760,
        moves = 150,
        allowed_items = { "halligan" },
        holster = true,
        description = ccb.content.text("Marrying strap for a Halligan bar."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 37)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "halligan",
        name = ccb.content.plural_text("Halligan bar", "Halligan bars"),
        description = ccb.content.text("A heavy, multiple-use tool commonly carried by firefighters, law enforcement, and military rescue units.  Use it to open locked doors without destroying them or to lift manhole covers.  You could also wield it to bash some heads in."),
        mass_milligrams = 4772000,
        volume_ml = 550,
        longest_side_mm = 760,
        price_cents = 7500,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "dark_gray",
        melee_to_hit = -1,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("PRY", 4)
    item:quality("HAMMER", 2)
    item:quality("DIG", 1)
    item:quality("PRYING_NAIL", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 42)
    item:melee_damage("stab", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "throw_extinguisher_act",
        category = "tools",
        name = ccb.content.plural_text("active throwable fire extinguisher", "active throwable fire extinguishers"),
        description = ccb.content.text("An active extinguisher grenade, likely to burst any second now.  Better throw it!"),
        mass_milligrams = 630000,
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        symbol = "*",
        color = "light_red",
        field_emissions = { "emit_extinguisher_burst" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:transform_into { target = "canister_empty" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ny_hook",
        symbol = "/",
        color = "yellow",
        looks_like = "iceaxe",
        name = ccb.content.plural_text("New York hook", "New York hooks"),
        description = ccb.content.text("A shaft with a pair of hooks on one end and a pry bar on the other, forged from a single piece of steel."),
        price_cents = 5500,
        techniques = { "WBLOCK_1" },
        mass_milligrams = 2900000,
        volume_ml = 400,
        longest_side_mm = 900,
        melee_to_hit = -1,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_AXE")
    item:quality("PRY", 3)
    item:quality("HAMMER", 1)
    item:quality("DIG", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    item:melee_damage("stab", 13)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "extinguisher",
        name = ccb.content.plural_text("large fire extinguisher", "large fire extinguishers"),
        description = ccb.content.text("An emergency fire extinguisher containing five gallons of fire-retardant foam.  Useful for putting out adjacent fires."),
        mass_milligrams = 7030000,
        volume_ml = 20000,
        longest_side_mm = 500,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = ";",
        color = "red",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_use_actions()
    item:native_use("EXTINGUISHER")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { extinguishing_agent = 100 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "sm_extinguisher",
        name = ccb.content.plural_text("small fire extinguisher", "small fire extinguishers"),
        description = ccb.content.text("A handheld fire extinguisher containing a liter of highly compressed CO2 gas.  Useful for putting out adjacent fires."),
        mass_milligrams = 1133000,
        volume_ml = 2000,
        longest_side_mm = 400,
        price_cents = 4000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ";",
        color = "red",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_use_actions()
    item:native_use("EXTINGUISHER")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 1, ammo_types = { "extinguishing_agent" } }
    item:magazine_pocket { ammo_capacities = { extinguishing_agent = 10 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "throw_extinguisher",
        category = "tools",
        name = ccb.content.plural_text("throwable fire extinguisher", "throwable fire extinguishers"),
        description = ccb.content.text("A fire extinguisher in grenade form.  While not as effective as a regular fire extinguisher, you can use it from a farther distance.  It has a plastic plug that can be pulled, but is primarily activated by heat, so just throw it into the flames."),
        mass_milligrams = 630000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = "*",
        color = "blue",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "throw_extinguisher_act", timer_turns = 3 },
        need_wielding = true,
        menu_text = ccb.content.text("Pull plug"),
        message = ccb.content.text("You pull the plug on the extinguisher grenade."),
    }
    item:clear_flags()
    item:flag("ACT_IN_FIRE")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end
