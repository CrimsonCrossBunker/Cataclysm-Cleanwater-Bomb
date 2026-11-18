local ccb = require("ccb")
local content = ccb.content

do
    -- The coins would be worthless but the PrepNet Phyle still retains some manufacturing capacity
    local item = content.Item {
        id = "crypto_coin",
        name = ccb.content.plural_text("Crypto coin", "Crypto coins"),
        description = ccb.content.text("PrepNet had been heavily involved in avoiding taxes by using untraceable internet currencies.  These however are physical coins with random numbers sequences embossed on them and RFID chips inside."),
        price_cents = 12000,
        price_postapoc_cents = 15000,
        mass_milligrams = 1000,
        volume_ml = 1,
        melee_to_hit = -3,
        color = "cyan",
        symbol = "$",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_radiobeacon",
        name = ccb.content.plural_text("broken distress beacon", "broken distress beacons"),
        description = ccb.content.text("Truly putting the 'distress' in 'distress beacon,' this one has a huge hole in the front.  It will not be alerting anyone today.  Perhaps you could disassemble it for scrap."),
        mass_milligrams = 340000,
        volume_ml = 1000,
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_tattered_garment",
        name = ccb.content.plural_text("tattered garments", "tattered garments"),
        category = "other",
        description = ccb.content.text("Time and the elements have reduced them to a mound of filthy ribbons."),
        mass_milligrams = 1175000,
        volume_ml = 30000,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -1,
        symbol = "[",
        replace_pockets = true,
        looks_like = "cotton_patchwork",
        color = "brown",
    }
    item:material("cotton", 1)
    item:container_pocket {
        max_volume_ml = 10000,
        max_weight_milligrams = 20000000,
        rigid = true,
        open_container = true,
        moves = 400,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_scrap_titanium",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("scrap titanium", "scrap titanium"),
        category = "spare_parts",
        description = ccb.content.text("A piece of light titanium, usable for crafting or repairs."),
        price_cents = 1000,
        looks_like = "scrap",
        mass_milligrams = 450000,
        volume_ml = 100,
    }
    item:material("titanium", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nuclear_waste",
        name = ccb.content.plural_text("nuclear waste", "nuclear waste"),
        description = ccb.content.text("A small pellet of silvery metal, still warm to the touch."),
        looks_like = "medium_atomic_battery_cell",
        mass_milligrams = 30000,
        volume_ml = 250,
        price_cents = 0,
        symbol = "*",
        color = "light_green",
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("RADIOACTIVE")
    item:flag("LEAK_ALWAYS")
    content.add(item)
end

do
    local item = content.Item {
        id = "nuclear_fuel",
        copy_from = "nuclear_waste",
        looks_like = "nuclear_waste",
        name = ccb.content.plural_text("nuclear fuel pellet", "nuclear fuel pellets"),
        description = ccb.content.text("A small pellet of fissile material.  Useful for powering up things, or for blowing them up."),
        price_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "hazardous_waste_drum",
        copy_from = "55gal_drum",
        looks_like = "55gal_drum",
        name = ccb.content.plural_text("hazardous waste drum", "hazardous waste drums"),
        description = ccb.content.text("A yellow drum meant for the storage of hazardous substances."),
        symbol = "0",
        replace_pockets = true,
        color = "yellow",
    }
    item:material("steel", 1)
    item:material("lead", 1)
    item:container_pocket {
        max_volume_ml = 200000,
        max_weight_milligrams = 500000000,
        watertight = true,
        rigid = true,
        moves = 400,
    }
    content.add(item)
end

do
    -- I figured bionic preppers would have a sci-fi solution to some low tech problems.
    local item = content.Item {
        id = "atomic_butterchurn",
        category = "tools",
        name = ccb.content.plural_text("folded atomic butter churn", "folded atomic butter churns"),
        description = ccb.content.text("The Rivtech Churninator 4000, the only churn to be banned by 13 religious sects.  The legs are currently folded up for travel.  Unlike a standard churn that requires cream separated from raw milk this churn requires only raw milk, salt and a healthy respect for glowing objects."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 5000,
        price_postapoc_cents = 45000,
        looks_like = "still",
        symbol = "u",
        color = "light_green",
    }
    item:clear_use_actions()
    item:deploy_furniture("f_atomic_butter_churn")
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_titanium_implant",
        name = ccb.content.plural_text("titanium implant", "titanium implants"),
        description = ccb.content.text("An internal implant to correct a musculoskeletal problem such as a bad hip or back.  It is made of titanium due to its biocompatibility."),
        price_cents = 9500,
        price_postapoc_cents = 1500,
        mass_milligrams = 2250000,
        volume_ml = 500,
        melee_to_hit = -3,
        symbol = "*",
        color = "light_gray",
    }
    item:material("titanium", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_titanium_tooth",
        name = ccb.content.plural_text("titanium tooth", "titanium teeth"),
        description = ccb.content.text("A dental implant made of pure titanium, used to replace teeth due to its biocompatibility and durability."),
        price_cents = 5000,
        price_postapoc_cents = 50,
        mass_milligrams = 10000,
        volume_ml = 2,
        melee_to_hit = -3,
        symbol = "$",
        color = "light_gray",
    }
    item:material("titanium", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_enzime_replicator",
        name = ccb.content.plural_text("enzyme biofactory", "enzyme biofactory"),
        description = ccb.content.text("A complex Mercurial manufactured bacterial biome that partially replicates human biochemistry.  Output volume is small, so this device is mostly used for medical research and tailor-made medical solutions.  Rarely seen in the frontier."),
        symbol = "o",
        color = "yellow",
        mass_milligrams = 14000000,
        volume_ml = 1000,
        price_cents = 300000,
        category = "spare_parts",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_fusion_engine_core",
        name = ccb.content.plural_text("fusion drive powerplant", "fusion drive powerplant"),
        description = ccb.content.text("A very heavy sphere of radiation shielding completely obscures the inner workings of this hyperspace-age device.  Any experienced salvor knows that opening it would completely ruin it."),
        symbol = "o",
        color = "yellow",
        mass_milligrams = 14000000,
        volume_ml = 1000,
        price_cents = 1000000,
        category = "spare_parts",
    }
    item:material("copper", 1)
    item:material("lead", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_catalytic_core",
        name = ccb.content.plural_text("catalytic rod", "catalytic rod"),
        description = ccb.content.text("A gleaming rod of hyperspace-age alloy, manufactured through arts lost to the Discontinuity.  A critical and near irreplaceable component of interstellar industry, it would fetch a high price anywhere."),
        symbol = "o",
        color = "yellow",
        mass_milligrams = 40000000,
        volume_ml = 10000,
        price_cents = 4500000,
        category = "spare_parts",
    }
    item:material("copper", 1)
    item:material("lead", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_ruined_laser_pistol",
        name = ccb.content.plural_text("ruined energy pistol", "ruined energy pistols"),
        description = ccb.content.text("A mass of corroded metal and plastic, identifiable as a pistol only due to its general shape.  Some of its components might still be salvageable."),
        mass_milligrams = 380000,
        volume_ml = 750,
        price_cents = 700,
        price_postapoc_cents = 700,
        symbol = "(",
        color = "light_gray",
        category = "spare_parts",
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_ruined_laser_rifle",
        name = ccb.content.plural_text("ruined energy rifle", "ruined energy rifles"),
        description = ccb.content.text("Pitted and corroded, this weapon is barely recognizable as a rifle.  Some of its components might still be salvageable."),
        mass_milligrams = 2640000,
        volume_ml = 3817,
        longest_side_mm = 511,
        price_cents = 700,
        price_postapoc_cents = 700,
        symbol = "(",
        color = "light_gray",
        category = "spare_parts",
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_ruined_rifle",
        name = ccb.content.plural_text("ruined long gun", "ruined long guns"),
        description = ccb.content.text("Not much of this weapon remains, at most it could be used to bar a door."),
        mass_milligrams = 2640000,
        volume_ml = 3817,
        longest_side_mm = 511,
        price_cents = 700,
        price_postapoc_cents = 700,
        symbol = "(",
        color = "light_gray",
        category = "spare_parts",
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_ruined_magazine",
        name = ccb.content.plural_text("ruined magazine", "ruined magazines"),
        description = ccb.content.text("A small box of heavily corroded metal.  Its more fragile internal components wasted away long ago."),
        mass_milligrams = 2640000,
        volume_ml = 3817,
        longest_side_mm = 511,
        price_cents = 700,
        price_postapoc_cents = 700,
        symbol = "(",
        color = "light_gray",
        category = "spare_parts",
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_glass_device",
        name = ccb.content.plural_text("glass device", "glass devices"),
        description = ccb.content.text("This transparent slate of computation glass was once an incredibly versatile hypercloud access point.  It continues to display \"No Connection\" in ancient English script."),
        mass_milligrams = 80000,
        volume_ml = 80,
        price_cents = 700,
        price_postapoc_cents = 500,
        symbol = "[",
        color = "light_gray",
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("STURDY")
    content.add(item)
end
