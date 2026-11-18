local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "directional_antenna",
        name = ccb.content.plural_text("directional antenna", "directional antennas"),
        description = ccb.content.text("An antenna designed to pick up signals better when pointed at the source.  You could use this with a radio to receive faint signals."),
        mass_milligrams = 454000,
        volume_ml = 500,
        longest_side_mm = 600,
        price_cents = 800,
        price_postapoc_cents = 250,
        symbol = ",",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("wood", 1)
    item:clear_use_actions()
    item:native_use("DIRECTIONAL_ANTENNA")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_usb_stick",
        name = ccb.content.plural_text("Exodii digital storage device", "Exodii digital storage devices"),
        melee_to_hit = -5,
        symbol = ",",
        color = "light_green",
        description = ccb.content.text("A bundle of electronics shielded in scrap metal.  It has an otherworldly connection for Exodii computers."),
        price_cents = 100,
        price_postapoc_cents = 1,
        mass_milligrams = 190000,
        volume_ml = 138,
        longest_side_mm = 120,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_usb_stick_full",
        name = ccb.content.plural_text("Exodii digital storage device (data)", "Exodii digital storage devices (data)"),
        melee_to_hit = -5,
        symbol = ",",
        color = "light_green",
        description = ccb.content.text("A bundle of electronics shielded in scrap metal.  It has an otherworldly connection for Exodii computers.  This one is filled with data downloaded from an Exodii computer."),
        price_cents = 100,
        price_postapoc_cents = 1,
        mass_milligrams = 190000,
        volume_ml = 138,
        longest_side_mm = 120,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    -- Based on Panasonic Ranger 505
    local item = content.Item {
        id = "exodii_portable_tv",
        name = ccb.content.plural_text("Exodii TV-radio", "Exodii TV-radios"),
        melee_to_hit = -5,
        symbol = ",",
        color = "light_green",
        description = ccb.content.text("This looks like a travel TV from the 1970s, styled to resemble military field equipment.  The bulbous CRT is encased in a drab plastic shell with an oversized carrying handle.  The switches and chunky tuning controls look like they were salvaged from an abandoned Cold War command center.  A single camera lens is visible above the screen, slightly off center."),
        price_cents = 100,
        price_postapoc_cents = 1,
        mass_milligrams = 3600000,
        volume_ml = 15360,
        longest_side_mm = 320,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    -- hackrf one, + 300 ml for cables and antenna + slot for battery because real hackrf works from usb, not something we can emulate here
    local item = content.Item {
        id = "electrohack",
        category = "tools",
        name = ccb.content.plural_text("electrohack", "electrohacks"),
        description = ccb.content.text("This device has many ports attached, allowing it to connect to almost any control panel or other electronic machine (but not computers).  With a little skill, it can be used to crack passwords and more."),
        mass_milligrams = 114000,
        volume_ml = 478,
        price_cents = 34000,
        price_postapoc_cents = 200,
        ascii_picture = "electrohack",
        symbol = ",",
        color = "green",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:quality("HACK", 2)
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_crank_charger",
        category = "tools",
        name = ccb.content.plural_text("hand-crank charger", "hand-crank chargers"),
        description = ccb.content.text("A hand-powered battery charger.  It has an adjustable receptacle designed to accept a wide variety of rechargeable battery cells."),
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 1000,
        price_postapoc_cents = 250,
        symbol = ":",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:native_use("HAND_CRANK")
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_MEDIUM", "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "UPS_off",
        name = ccb.content.plural_text("UPS", "UPSes"),
        description = ccb.content.text("A unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power tools, smartphones, armor, and some guns, but drains batteries quickly."),
        mass_milligrams = 680000,
        volume_ml = 2500,
        price_cents = 280000,
        price_postapoc_cents = 1500,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("IS_UPS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:magazine_well { flags = { "BATTERY_HEAVY" }, default_magazine = "heavy_plus_battery_cell" }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "methanol_fuel_cell",
        name = ccb.content.plural_text("methanol fuel cell UPS", "methanol fuel cell UPSes"),
        description = ccb.content.text("A direct methanol fuel cell which can provide power to UPS-compatible electronic devices by oxidizing methanol supplied from a specialized fuel tank to produce electricity."),
        mass_milligrams = 7800000,
        volume_ml = 24390,
        longest_side_mm = 448,
        price_cents = 280000,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("IS_UPS")
    item:magazine_well { flags = { "METHANOL_TANK" }, default_magazine = "5l_methanol_tank" }
    item:tool { ammo_types = { "methanol_fuelcell" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "usb_drive_older",
        copy_from = "usb_drive",
        looks_like = "usb_drive",
        name = ccb.content.plural_text("older USB drive", "older USB drives"),
        description = ccb.content.text("A USB thumb drive.  Maybe a decade out of date, but still useful for holding electronic data."),
        replace_pockets = true,
    }
    item:tool()
    item:file_storage_pocket {
        max_volume_ml = 1,
        max_weight_milligrams = 1000,
        rigid = true,
        weight_multiplier = 0.0,
        memory_kb = 32000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "memory_card",
        copy_from = "abstract_memory_card",
        name = ccb.content.plural_text("memory card", "memory cards"),
        description = ccb.content.text("A memory card, can be used to store data."),
        symbol = ",",
        color = "white",
        price_cents = 1000,
        price_postapoc_cents = 10,
        replace_pockets = true,
    }
    item:tool()
    item:file_storage_pocket {
        max_volume_ml = 1,
        max_weight_milligrams = 1000,
        rigid = true,
        weight_multiplier = 0.0,
        memory_kb = 64000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "memory_card_older",
        copy_from = "memory_card",
        looks_like = "memory_card",
        name = ccb.content.plural_text("older memory card", "older memory cards"),
        description = ccb.content.text("A memory card.  Maybe a decade out of date, but can still be used to store data."),
        replace_pockets = true,
    }
    item:tool()
    item:file_storage_pocket {
        max_volume_ml = 1,
        max_weight_milligrams = 1000,
        rigid = true,
        weight_multiplier = 0.0,
        memory_kb = 16000000,
    }
    content.add(item)
end

do
    -- Battery only, intentionally. Meant for field expeditions to other dimensions where grid power is unavailable. Too advanced for the player to make grid-useable.
    local item = content.Item {
        id = "resonance_measurement_device",
        name = ccb.content.plural_text("Otherworldly measuring device", "Otherworldly measuring devices"),
        description = ccb.content.text("This strange contraption appears to be little more than a laminated box built around a battery, a poorly backlit screen, and a wound spool of cloth netting.  The letters \"X E D R A\" are emblazoned on the side.  To operate the device, unfurl the netting and place it around the object to analyze.  Despite not appearing to do anything, it consumes an enormous amount of electricity and provides a brief numerical readout."),
        mass_milligrams = 600000,
        volume_ml = 900,
        price_cents = 150000000,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:native_use("MEASURE_RESONANCE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 2400, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_items = { "heavy_atomic_battery_cell" },
    }
    content.add(item)
end
