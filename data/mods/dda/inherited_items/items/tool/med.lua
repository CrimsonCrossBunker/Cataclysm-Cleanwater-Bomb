local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "scalpel",
        name = ccb.content.plural_text("scalpel", "scalpels"),
        description = ccb.content.text("A very sharp knife designed for surgical cutting.  Its small, sharp blade allows for precision strikes in the hands of the skilled."),
        ascii_picture = "scalpel",
        mass_milligrams = 23000,
        volume_ml = 15,
        longest_side_mm = 130,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 3)
    item:quality("BUTCHER", 8)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "thermometer",
        category = "tools",
        name = ccb.content.plural_text("thermometer", "thermometers"),
        description = ccb.content.text("A plastic thermometer that can read the air temperature."),
        mass_milligrams = 10000,
        volume_ml = 25,
        price_cents = 100,
        price_postapoc_cents = 10,
        ascii_picture = "thermometer",
        symbol = ";",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("THERMOMETER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scissors_medical",
        name = ccb.content.plural_text("medical scissors", "medical scissors"),
        description = ccb.content.text("A pair of medical scissors, typically used by nurses or paramedics to cut bandages or fabric."),
        ascii_picture = "scissors",
        mass_milligrams = 50000,
        volume_ml = 95,
        longest_side_mm = 140,
        price_cents = 700,
        price_postapoc_cents = 20,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 2)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("stab", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dental_tools",
        name = ccb.content.plural_text("dental tool set", "dental tool sets"),
        description = ccb.content.text("A set of picks, hooks, and scrapers designed for cleaning teeth."),
        mass_milligrams = 160000,
        volume_ml = 370,
        longest_side_mm = 200,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "?",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("LOCKPICK", 1)
    item:quality("LEATHER_AWL", 1)
    item:quality("PUNCH", 1)
    item:clear_melee_damage()
    item:melee_damage("stab", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "anesthetic_kit",
        name = ccb.content.plural_text("anesthesia kit", "anesthesia kits"),
        description = ccb.content.text("A kit for inducing anesthesia for surgery, containing specialized canisters with a variety of powerful hypnotic, analgesic, and stimulative drugs.  It's intended for use in specialized medical equipment, and can't be administered manually."),
        category = "drugs",
        mass_milligrams = 100000,
        volume_ml = 3250,
        price_cents = 1000,
        price_postapoc_cents = 1500,
        symbol = "!",
        color = "cyan",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:quality("ANESTHESIA", 1)
    item:tool { ammo_types = { "anesthetic" } }
    item:magazine_pocket { ammo_capacities = { anesthetic = 6000 }, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "inhaler",
        category = "drugs",
        name = ccb.content.plural_text("inhaler", "inhalers"),
        description = ccb.content.text("An albuterol inhaler.  Used in the treatment of bronchospasm, it is a lifeline for people with asthma.  A mild stimulant, it may cause anxiety or tremors."),
        mass_milligrams = 85000,
        volume_ml = 100,
        price_cents = 5000,
        price_postapoc_cents = 750,
        symbol = "!",
        color = "light_blue",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_use_actions()
    item:native_use("INHALER")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { albuterol = 100 }, airtight = true, rigid = true, watertight = true }
    content.add(item)
end

do
    -- stats *exclude* contents
    -- potentially revert_to an empty container e.g. bottle_30ml_atomizer
    local item = content.Item {
        id = "liq_bandage_spray",
        category = "drugs",
        name = ccb.content.plural_text("spray bottle of liquid bandage", "spray bottles of liquid bandage"),
        description = ccb.content.text("Liquid bandage for minor cuts and scrapes, packaged in a tiny bottle with an atomizer spray for convenient application."),
        mass_milligrams = 5000,
        volume_ml = 50,
        price_cents = 25,
        price_postapoc_cents = 5,
        symbol = "!",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:heal { bandages_power = 1, bleed = 4, disinfectant_power = 2, bite = 0.3, move_cost = 250 }
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { liq_bandage = 90 }, airtight = true, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "rx12_injector",
        name = ccb.content.plural_text("RX12 jet injector", "RX12 jet injectors"),
        description = ccb.content.text("A Rivtech RX12 jet injector, a small pistol-shaped device used to inject advanced fast-healing chemicals through the skin without using a needle.  A label on the side warns against using more than two doses per hour."),
        category = "drugs",
        mass_milligrams = 316000,
        volume_ml = 500,
        price_cents = 100000,
        price_postapoc_cents = 1500,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("ceramic", 1)
    item:material("superalloy", 1)
    item:clear_use_actions()
    item:native_use("JET_INJECTOR")
    item:tool { charges_per_use = 1, ammo_types = { "ampoule" } }
    item:magazine_pocket { ammo_capacities = { ampoule = 2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "smoxygen_tank",
        name = ccb.content.plural_text("small oxygen delivery kit", "small oxygen delivery kits"),
        description = ccb.content.text("A small tank of compressed medical oxygen with a folding regulator and mask.  Commonly used in emergency situations, it provides immediate relief for asthma attacks or smoke inhalation, and can provide a brief burst of energy."),
        mass_milligrams = 800000,
        volume_ml = 1100,
        longest_side_mm = 220,
        price_cents = 4000,
        price_postapoc_cents = 250,
        melee_to_hit = -5,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_use_actions()
    item:native_use("OXYGEN_BOTTLE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { oxygen = 12 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "oxygen_tank",
        name = ccb.content.plural_text("oxygen delivery kit", "oxygen delivery kits"),
        description = ccb.content.text("A tank of compressed medical oxygen with a regulator and mask.  Commonly used in emergency situations, it provides immediate relief for asthma attacks or smoke inhalation, and can provide a brief burst of energy."),
        mass_milligrams = 2721000,
        volume_ml = 3750,
        longest_side_mm = 420,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_use_actions()
    item:native_use("OXYGEN_BOTTLE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { oxygen = 24 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "wrapped_rad_badge",
        name = ccb.content.plural_text("wrapped radiation badge", "wrapped radiation badges"),
        description = ccb.content.text("A badge that detects radiation dosage, sealed in a radiation-blocking bag.  Use it to remove it from the bag."),
        mass_milligrams = 25000,
        volume_ml = 25,
        price_cents = 8000,
        price_postapoc_cents = 500,
        symbol = ",",
        color = "light_blue",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "rad_badge" },
        message = ccb.content.text("You remove the badge from its wrapper, exposing it to ambient radiation."),
        menu_text = ccb.content.text("Unwrap badge"),
    }
    item:tool()
    content.add(item)
end
