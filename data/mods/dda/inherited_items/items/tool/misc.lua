local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "alarmclock",
        name = ccb.content.plural_text("alarm clock", "alarm clocks"),
        description = ccb.content.text("A wind-up alarm clock.  Though the noise it makes is unpleasant to wake up to, it's always good to get an early start to your day.  Can also be disassembled into some useful parts."),
        mass_milligrams = 562000,
        volume_ml = 250,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = ",",
        color = "yellow",
    }
    item:material("aluminum", 1)
    item:material("glass", 1)
    item:clear_flags()
    item:flag("WATCH")
    item:flag("ALARMCLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_urn",
        name = ccb.content.plural_text("clay urn", "clay urns"),
        category = "container",
        description = ccb.content.text("A clay container for storing cremated ashes."),
        mass_milligrams = 1600000,
        volume_ml = 4280,
        price_cents = 5000,
        price_postapoc_cents = 50,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 4100, max_weight_milligrams = 4000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:tool()
    content.add(item)
end

do
    -- Based on: https://www.amazon.com/dp/B0B1DJL6XR
    local item = content.Item {
        id = "cow_bell",
        name = ccb.content.plural_text("cow bell", "cow bells"),
        description = ccb.content.text("A cow bell.  You feel like you need more of it."),
        mass_milligrams = 330000,
        volume_ml = 300,
        longest_side_mm = 200,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
    }
    item:material("steel", 19)
    item:material("rubber", 1)
    item:clear_use_actions()
    item:native_use("BELL")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crystal_urn",
        name = ccb.content.plural_text("crystal urn", "crystal urns"),
        description = ccb.content.text("An exquisite, translucent container for cremated ashes, decorated with floral patterns."),
        mass_milligrams = 1400000,
        volume_ml = 4280,
        price_cents = 125000,
        price_postapoc_cents = 500,
        symbol = ")",
        color = "magenta",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("crystal", 1)
    item:container_pocket { max_volume_ml = 4100, max_weight_milligrams = 4000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "e_tool",
        name = ccb.content.plural_text("entrenching tool", "entrenching tools"),
        description = ccb.content.text("A stout, collapsible spade.  It's commonly used by military forces and favored by hikers for digging."),
        mass_milligrams = 453000,
        volume_ml = 1000,
        longest_side_mm = 230,
        price_cents = 4000,
        price_postapoc_cents = 500,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        melee_to_hit = -2,
    }
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("DIG", 3)
    item:quality("BUTCHER", -8)
    item:quality("COOK", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NEEDS_UNFOLD")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "etched_skull",
        name = ccb.content.plural_text("etched human skull", "etched human skulls"),
        description = ccb.content.text("A human skull covered with strange etchings."),
        mass_milligrams = 311000,
        volume_ml = 750,
        price_cents = 300000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "white",
    }
    item:material("bone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hose_garden",
        looks_like = "hose",
        name = ccb.content.plural_text("garden hose", "garden hoses"),
        description = ccb.content.text("A flexible garden hose.  If you cut it into smaller pieces, it could be used for crafting or siphoning fuel from a vehicle."),
        mass_milligrams = 1632000,
        volume_ml = 1500,
        longest_side_mm = 300,
        price_cents = 600,
        price_postapoc_cents = 300,
        symbol = ",",
        color = "green",
        replace_qualities = true,
    }
    item:material("rubber", 1)
    item:quality("HOSE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "grip_hook",
        category = "weapons",
        name = ccb.content.plural_text("grip hook", "grip hooks"),
        description = ccb.content.text("A simple steel meat hook with a circular steel handle."),
        mass_milligrams = 900000,
        color = "light_gray",
        symbol = "?",
        techniques = { "DEF_DISARM", "SWEEP" },
        volume_ml = 750,
        melee_to_hit = -4,
        price_cents = 2000,
        price_postapoc_cents = 250,
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_BODY_BLOCK")
    item:quality("HAMMER", 1)
    item:quality("BUTCHER", -5)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_pump",
        symbol = "/",
        color = "blue",
        name = ccb.content.plural_text("hand pump", "hand pumps"),
        description = ccb.content.text("A hand-powered pump suitable for pumping air into inflatable objects."),
        price_cents = 400,
        price_postapoc_cents = 250,
        mass_milligrams = 113000,
        volume_ml = 500,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:quality("PRESSURIZATION", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "leather_bellow",
        name = ccb.content.plural_text("leather bellow", "leather bellows"),
        description = ccb.content.text("A bellow is a device constructed to furnish a strong blast of air."),
        mass_milligrams = 450000,
        volume_ml = 2500,
        price_cents = 0,
        price_postapoc_cents = 100,
        replace_qualities = true,
        symbol = ";",
        color = "brown",
    }
    item:quality("WINNOW", 1)
    item:material("leather", 1)
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "horn_big",
        category = "veh_parts",
        name = ccb.content.plural_text("truck horn", "truck horns"),
        description = ccb.content.text("A very loud horn, usually found on large trucks like semis."),
        mass_milligrams = 310000,
        volume_ml = 1500,
        price_cents = 12000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "horn_car",
        category = "veh_parts",
        name = ccb.content.plural_text("car horn", "car horns"),
        description = ccb.content.text("A car horn meant to be attached to a car's electrical system."),
        mass_milligrams = 270000,
        volume_ml = 500,
        price_cents = 9000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lifestraw",
        name = ccb.content.plural_text("lifestraw", "lifestraws"),
        description = ccb.content.text("A small personal water filter.  The instructions say to set the lifestraw in suspect water, let sit for one minute then drink.  The two-part filtration system will purify the water you drink up to a certain amount.  Water taken from uncertain sources like a river may be dirty."),
        mass_milligrams = 104000,
        volume_ml = 592,
        price_cents = 4000,
        price_postapoc_cents = 1000,
        symbol = "i",
        looks_like = "advanced_ecig",
        color = "light_cyan",
    }
    item:material("cotton", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WATER_PURIFIER")
    item:tool { charges_per_use = 1, initial_charges = 4000, max_charges = 4000 }
    content.add(item)
end

do
    -- gasket sizes range from 1in diameter to 6in.
    local item = content.Item {
        id = "gasket_plastic",
        name = ccb.content.plural_text("plastic gasket", "plastic gaskets"),
        description = ccb.content.text("A single-use plastic gasket."),
        symbol = "(",
        color = "dark_gray",
        looks_like = "plastic_chunk",
        mass_milligrams = 5000,
        volume_ml = 30,
        price_cents = 150,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "porcelain_urn",
        name = ccb.content.plural_text("porcelain urn", "porcelain urns"),
        description = ccb.content.text("A container for holding the remains of a loved one.  Its prior owners must have taken good care of it, as you can see your face reflected clearly upon its surface."),
        mass_milligrams = 1600000,
        volume_ml = 4280,
        price_cents = 35000,
        price_postapoc_cents = 250,
        symbol = ")",
        color = "white",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("porcelain", 1)
    item:container_pocket { max_volume_ml = 4100, max_weight_milligrams = 4000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "safe_box",
        category = "other",
        name = ccb.content.plural_text("safe deposit box", "safe deposit boxes"),
        description = ccb.content.text("A secure combination-lock box.  Sadly, you don't know the combination.  Breaking into it would destroy anything of value."),
        mass_milligrams = 2267000,
        volume_ml = 3750,
        price_cents = 8000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sarcophagus_access_code",
        name = ccb.content.plural_text("sarcophagus access code", "sarcophagus access codes"),
        description = ccb.content.text("A printout displaying a string of numbers, the passcode to access the elevator in the hazardous waste sarcophagus."),
        mass_milligrams = 5000,
        volume_ml = 4,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "white",
    }
    item:material("paper", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "stepladder",
        name = ccb.content.plural_text("wooden stepladder", "wooden stepladders"),
        description = ccb.content.text("A ten-foot wooden stepladder.  Activate it to set it down."),
        mass_milligrams = 20000000,
        volume_ml = 50000,
        longest_side_mm = 1500,
        price_cents = 2000,
        price_postapoc_cents = 100,
        melee_to_hit = -2,
        symbol = "H",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_ladder")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "testflames",
        name = ccb.content.plural_text("Flaming Chunk of Steel +2", "Flaming Chunks of Steel +2"),
        description = ccb.content.text("HOLY SHIT THIS THING IS ON FIRE!"),
        mass_milligrams = 64000,
        volume_ml = 250,
        price_cents = 98000,
        price_postapoc_cents = 100,
        melee_to_hit = 100,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_3", "WIDE" },
        light = 240,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("FIRE")
    item:flag("FLAMING")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tindalos_whistle",
        name = ccb.content.plural_text("Whistle of Tindalos", "Whistles of Tindalos"),
        description = ccb.content.text("Who is this Tindalos guy?"),
        mass_milligrams = 22000,
        volume_ml = 1,
        price_cents = 10000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "yellow",
    }
    item:material("superalloy", 1)
    item:clear_use_actions()
    item:native_use("CALL_OF_TINDALOS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "vortex_stone",
        name = ccb.content.plural_text("vortex stone", "vortex stones"),
        description = ccb.content.text("A stone with spirals all over it and holes around its perimeter.  Though it is fairly large, it weighs next to nothing.  Air seems to gather around it."),
        mass_milligrams = 1000,
        volume_ml = 250,
        price_cents = 300000,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "light_gray",
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:native_use("VORTEX")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 1, initial_charges = 1, max_charges = 1 }
    content.add(item)
end

do
    local item = content.Item {
        id = "sandbox_kit",
        name = ccb.content.plural_text("sandbox kit", "sandbox kits"),
        description = ccb.content.text("A plastic bucket holding a small spade and rake, perfect for building sand castles!"),
        mass_milligrams = 250000,
        volume_ml = 1050,
        price_cents = 300,
        price_postapoc_cents = 3,
        symbol = "u",
        color = "red",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 2000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "aluminum_stepladder",
        name = ccb.content.plural_text("aluminum stepladder", "aluminum stepladders"),
        description = ccb.content.text("A ten-foot aluminum stepladder.  Activate it to set it down."),
        looks_like = "stepladder",
        mass_milligrams = 15750000,
        volume_ml = 50000,
        longest_side_mm = 1500,
        price_cents = 2000,
        price_postapoc_cents = 100,
        melee_to_hit = -2,
        symbol = "H",
        color = "light_gray",
    }
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_aluminum_stepladder")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_cutter",
        name = ccb.content.plural_text("handheld glass cutter", "handheld glass cutters"),
        description = ccb.content.text("A handheld tool used for controlled breaking of glass.  A necessity for any glass cutting projects."),
        mass_milligrams = 700000,
        volume_ml = 500,
        price_cents = 1200,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT_GLASS", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "air_launcher",
        name = ccb.content.plural_text("novelty pneumatic launcher", "novelty pneumatic launchers"),
        description = ccb.content.text("A toy that uses compressed air to launch small objects for the amusement of children.  It is very tiring to reload, and completely ineffective as a weapon.  Pump sold separately."),
        looks_like = "m79",
        mass_milligrams = 1850000,
        volume_ml = 3850,
        price_cents = 1500,
        price_postapoc_cents = 100,
        melee_to_hit = -1,
        symbol = "P",
        color = "blue",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "handcuffs_leather",
        name = ccb.content.plural_text("pair of leather cuffs", "pairs of leather cuffs"),
        description = ccb.content.text("A pair of sturdy leather cuffs connected by a chain.  Perfect to hold prisoners in your dungeon."),
        mass_milligrams = 200000,
        volume_ml = 300,
        price_postapoc_cents = 1,
        symbol = "8",
        color = "red",
    }
    item:material("leather", 9)
    item:material("steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gag_ball",
        name = ccb.content.plural_text("ball gag", "ball gags"),
        description = ccb.content.text("A ball gag, make sure you're not keeping a katana nearby before using it."),
        mass_milligrams = 150000,
        volume_ml = 150,
        price_postapoc_cents = 1,
        symbol = "§",
        color = "red",
    }
    item:material("leather", 9)
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "paddle_plastic",
        name = ccb.content.plural_text("small plastic paddle", "small plastic paddles"),
        description = ccb.content.text("Using it against unfriendly cheeks would be ill advised."),
        mass_milligrams = 50000,
        volume_ml = 50,
        longest_side_mm = 300,
        price_postapoc_cents = 1,
        symbol = "p",
        color = "dark_gray",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tape_measure",
        symbol = ";",
        color = "yellow",
        name = ccb.content.plural_text("tape measure", "tape measures"),
        description = ccb.content.text("A 25' tape measure, with a bright yellow, plastic exterior."),
        mass_milligrams = 250000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 100,
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "notched_plank",
        category = "spare_parts",
        name = ccb.content.plural_text("notched plank", "notched planks"),
        description = ccb.content.text("A quarter of a wooden plank with notches cut into it, used with a fire drill to create embers."),
        symbol = "/",
        color = "brown",
        looks_like = "2x4",
        mass_milligrams = 610000,
        volume_ml = 1035,
        longest_side_mm = 300,
        price_cents = 500,
        price_postapoc_cents = 5,
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:tool()
    item:magazine_pocket { ammo_capacities = { notch = 24 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "notched_stick",
        category = "spare_parts",
        name = ccb.content.plural_text("notched stick", "notched sticks"),
        description = ccb.content.text("A wooden stick with notches cut into it, used with a fire drill to create embers."),
        symbol = "/",
        color = "brown",
        looks_like = "stick",
        mass_milligrams = 375000,
        volume_ml = 625,
        longest_side_mm = 320,
        price_cents = 500,
        price_postapoc_cents = 5,
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:tool()
    item:magazine_pocket { ammo_capacities = { notch = 10 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "teargas_sprayer",
        name = ccb.content.plural_text("tear gas sprayer", "tear gas sprayers"),
        description = ccb.content.text("A pocket sized plastic canister filled with a pressurized tear gas spray, a step above oleoresin capsicum pepper spray in terms of potency.  Most commonly used by law enforcement and bear-wary hikers, but it became more common in recent months due to anxiety over the riots.  Probably won't do much against a zombie, but should give anything still breathing a rather nasty surprise and give you time to get away.  It contains enough spray for about twenty seconds of continuous application."),
        mass_milligrams = 96000,
        volume_ml = 100,
        longest_side_mm = 90,
        price_cents = 1000,
        price_postapoc_cents = 150,
        symbol = ";",
        color = "red",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:native_use("MACE")
    item:tool { charges_per_use = 1, ammo_types = { "teargas_spray" } }
    item:magazine_pocket { ammo_capacities = { teargas_spray = 10 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "c4_payload",
        category = "weapons",
        name = content.plural_text("C-4 payload", "C-4 payloads"),
        description = content.text("This is a dummy item used by c4 hacks.  You should never see it outside of debug."),
        symbol = "*",
        color = "dark_gray",
    }
    item:clear_use_actions()
    item:transform_on_use { result = { target = "c4armed", timer_turns = 10 } }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:flag("ZERO_WEIGHT")
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "tear_gas_payload",
        category = "weapons",
        name = content.plural_text("tear gas payload", "tear gas payloads"),
        description = content.text("This is a dummy item used by tear gas hacks.  You should never see it outside of debug."),
        symbol = "*",
        color = "dark_gray",
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tear_gas_payload_act", timer_turns = 5 },
        message = ccb.content.text("You pull the pin on the %s."),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:flag("ZERO_WEIGHT")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "toilet_travel",
        name = ccb.content.plural_text("travel toilet", "travel toilets"),
        description = ccb.content.text("A portable plastic toilet, designed to use plastic bags for waste instead of plumbing."),
        mass_milligrams = 1587000,
        volume_ml = 27651,
        longest_side_mm = 330,
        price_cents = 2500,
        price_postapoc_cents = 400,
        symbol = ";",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "toilet_travel_folded" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You collapse the toilet for transport."),
    }
    item:container_pocket {
        max_volume_ml = 22712,
        max_weight_milligrams = 6000000,
        watertight = false,
        rigid = true,
        open_container = true,
        max_item_length_mm = 280,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "toilet_travel_folded",
        name = ccb.content.plural_text("folded travel toilet", "folded travel toilets"),
        description = ccb.content.text("A portable plastic toilet.  It has been collapsed for easy transport."),
        mass_milligrams = 1587000,
        volume_ml = 2000,
        longest_side_mm = 280,
        price_cents = 2500,
        price_postapoc_cents = 400,
        symbol = ";",
        color = "white",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "toilet_travel" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You unfold the travel toilet."),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "large_space_heater",
        name = ccb.content.plural_text("large space heater", "large space heaters"),
        description = ccb.content.text("A portable electric heater that steadily emits warm air.  Raises temperature about 10 degrees Celsius, and fills a larger volume of air than the smaller version."),
        mass_milligrams = 12000000,
        volume_ml = 7500,
        price_cents = 20000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "large_space_heater_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 1000000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:fault_group("electronic_general", {  })
    item:tool { ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_HEAVY" },
        default_magazine = "heavy_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "large_space_heater_on",
        copy_from = "large_space_heater",
        looks_like = "large_space_heater",
        name = ccb.content.plural_text("large space heater (on)", "large space heaters (on)"),
        description = ccb.content.text("A portable electric heater that steadily emits warm air.  Raises temperature about 10 degrees Celsius, and fills a larger volume of air than the smaller version."),
        light = 2,
        field_emissions = { "emit_hot_air2_blast" },
    }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "large_space_heater" },
        message = ccb.content.text("You turn off the %s."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 1000000 }
    item:transform_into { target = "large_space_heater" }
    item:tool { power_milliwatts = 1000000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "small_space_heater",
        name = ccb.content.plural_text("small space heater", "small space heaters"),
        description = ccb.content.text("A portable electric heater that steadily emits warm air.  Raises temperature about 10 degrees Celsius."),
        mass_milligrams = 6000000,
        volume_ml = 3750,
        price_cents = 5000,
        price_postapoc_cents = 1500,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "small_space_heater_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 500000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
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
    local item = content.Item {
        id = "small_space_heater_on",
        copy_from = "small_space_heater",
        looks_like = "small_space_heater",
        name = ccb.content.plural_text("small space heater (on)", "small space heaters (on)"),
        description = ccb.content.text("A portable electric heater that steadily emits warm air.  Raises temperature about 10 degrees Celsius."),
        light = 2,
        field_emissions = { "emit_hot_air2_stream" },
    }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "small_space_heater" },
        message = ccb.content.text("You turn off the %s."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 2, charge_milliwatts = 500000 }
    item:transform_into { target = "small_space_heater" }
    item:tool { power_milliwatts = 500000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "sextoy",
        name = ccb.content.plural_text("sex toy", "sex toys"),
        description = ccb.content.text("A sex toy."),
        mass_milligrams = 500000,
        volume_ml = 500,
        longest_side_mm = 200,
        price_postapoc_cents = 20,
        symbol = "ï",
        color = "pink",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("VIBE")
    item:variants {
        { id = "dildo", name = ccb.content.plural_text("dildo", "dildoes"), description = ccb.content.text("You know what this is.  Use it to take a break and unwind.") },
        { id = "beads", name = ccb.content.plural_text("anal beads", "anal beads"), description = ccb.content.text("Very inappropriate for prayer.  Use it to take a break and unwind.") },
        { id = "plug", name = ccb.content.plural_text("anal plug", "anal plugs"), description = ccb.content.text("Will produce sparks but won't start your car.  Use it to take a break and unwind.") },
    }
    item:tool()
    content.add(item)
end
