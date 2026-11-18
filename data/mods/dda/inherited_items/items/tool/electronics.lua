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

do
    -- Nokia 105 4G, 26g Li-Ion battery
    local item = content.Item {
        id = "cell_phone",
        name = ccb.content.plural_text("cellphone", "cellphones"),
        description = ccb.content.text("A cellphone, an older cousin of the smartphone that is still popular in certain circles due to its reliability and sturdiness.  Using the phone will turn it on and provide light, assuming it is sufficiently charged.  It also tells the time and has an alarm feature."),
        mass_milligrams = 95000,
        volume_ml = 88,
        price_cents = 9000,
        price_postapoc_cents = 15,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 75)
    item:material("plastic", 25)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "cell_phone_flashlight" },
        menu_text = ccb.content.text("Light up the screen"),
        message = ccb.content.text("You light up the screen."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 20000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATCH")
    item:flag("ALARMCLOCK")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 17 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "cell_phone_flashlight",
        copy_from = "cell_phone",
        looks_like = "cell_phone",
        name = ccb.content.plural_text("cellphone - Flashlight", "cellphones - Flashlight"),
        light = 8,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "cell_phone" },
        message = ccb.content.text("You turn off the screen."),
        menu_text = ccb.content.text("Turn off the screen"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 20000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATCH")
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "cell_phone" }
    item:tool { power_milliwatts = 500 }
    content.add(item)
end

do
    -- Don't add ELECTRONIC flag here, since these handcuffs have their own behavior when affected by EMP blast
    local item = content.Item {
        id = "e_handcuffs",
        name = ccb.content.plural_text("electronic handcuffs", "electronic handcuffs"),
        description = ccb.content.text("A pair of electronic handcuffs, used by police and riot bots to detain captives.  Their continuous siren clearly identifies the wearer as an arrested criminal and alerts human police.  Wait for their arrival, don't try to escape or to remove the cuffs - they will administer an electric shock.\nHowever, since the only police likely to respond are undead, you may have a long wait ahead, unless you get creative…"),
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "white",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("EHANDCUFFS")
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:tool { max_charges = 3000, turns_per_charge = 1 }
    item:clear_tick_actions()
    item:native_on_tick("EHANDCUFFS_TICK")
    content.add(item)
end

do
    -- amazon kindle, LIONX 6300mAh battery 42 ml
    local item = content.Item {
        id = "eink_tablet_pc",
        copy_from = "abstract_tablet",
        name = ccb.content.plural_text("e-ink tablet PC", "e-ink tablet PCs"),
        description = ccb.content.text("A tablet PC using an efficient color e-ink display.  Before the Cataclysm, these were nifty gadgets; now, they are extremely useful tools.  Runs on conventional batteries."),
        mass_milligrams = 158000,
        volume_ml = 137,
        longest_side_mm = 158,
        price_cents = 8500,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "blue",
        replace_pockets = true,
    }
    item:material("aluminum", 3)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:transform_on_use {
        result = { target = "eink_tablet_pc_on" },
        menu_text = ccb.content.text("Light up the screen"),
        message = ccb.content.text("You light up the screen."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable { cable_length = 4, charge_milliwatts = 10000 }
    item:tool()
    item:magazine_pocket { ammo_capacities = { battery = 85 }, rigid = true }
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
    -- light 10 is the bare minimum for reading without penalties
    local item = content.Item {
        id = "eink_tablet_pc_on",
        copy_from = "eink_tablet_pc",
        looks_like = "eink_tablet_pc",
        name = ccb.content.plural_text("e-ink tablet PC (on)", "e-ink tablet PCs (on)"),
        light = 10,
    }
    item:clear_use_actions()
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:transform_on_use {
        result = { target = "eink_tablet_pc" },
        menu_text = ccb.content.text("Turn off the screen"),
        message = ccb.content.text("You turn off the screen."),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 4, charge_milliwatts = 10000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATCH")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "eink_tablet_pc" }
    item:tool { power_milliwatts = 2000 }
    content.add(item)
end

do
    -- https://www.amazon.com/dp/B0B541D433 but AA instead of 14500
    local item = content.Item {
        id = "geiger_off",
        name = ccb.content.plural_text("Geiger counter (off)", "Geiger counters (off)"),
        description = ccb.content.text("A tool for measuring radiation.  Using it will prompt you to choose whether to scan yourself or the terrain, or to turn on continuous scan, which will provide continuous feedback on ambient radiation.  It is currently off."),
        mass_milligrams = 231000,
        volume_ml = 161,
        price_cents = 6800,
        price_postapoc_cents = 20,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:native_use("GEIGER")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
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
        id = "geiger_on",
        copy_from = "geiger_off",
        looks_like = "geiger_off",
        name = ccb.content.plural_text("Geiger counter (on)", "Geiger counters (on)"),
        description = ccb.content.text("A tool for measuring radiation.  It is in continuous scan mode, and will produce quiet clicking sounds in the presence of ambient radiation.  Using it allows you to turn it off, or scan yourself or the ground."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "geiger_off" },
        message = ccb.content.text("The Geiger counter's SCANNING LED turns off."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "geiger_off" }
    item:tool { power_milliwatts = 200 }
    item:clear_tick_actions()
    item:native_on_tick("GEIGER_ACTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "laptop_screen_lit",
        copy_from = "laptop",
        looks_like = "laptop",
        name = ccb.content.plural_text("laptop computer - lit screen", "laptop computers - lit screen"),
        light = 10,
    }
    item:clear_use_actions()
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:native_use("PORTABLE_GAME")
    item:transform_on_use {
        result = { target = "laptop" },
        message = ccb.content.text("You turn off the screen."),
        menu_text = ccb.content.text("Turn off the screen"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 5, charge_milliwatts = 140000 }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATCH")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "laptop" }
    item:tool { power_milliwatts = 1000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "noise_emitter",
        name = ccb.content.plural_text("noise emitter (off)", "noise emitters (off)"),
        description = ccb.content.text("A device constructed by 'enhancing' a speaker with some amplifier circuits.  It has no other use besides emitting loud crackling static noise that could distract zombies."),
        mass_milligrams = 340000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "noise_emitter_on" },
        message = ccb.content.text("You turn on the %s."),
        menu_text = ccb.content.text("Turn on"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("WATER_BREAK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_HEAVY", "BATTERY_MEDIUM", "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "noise_emitter_on",
        copy_from = "noise_emitter",
        looks_like = "noise_emitter",
        name = ccb.content.plural_text("noise emitter (on)", "noise emitters (on)"),
        description = ccb.content.text("A homemade device that is emitting horrible crackles, pops, and other loud static sounds.  Quick, get away from it before it draws zombies to you!"),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "noise_emitter" },
        message = ccb.content.text("The infernal racket dies as the noise emitter turns off."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "noise_emitter" }
    item:tool { power_milliwatts = 10000 }
    item:clear_tick_actions()
    item:native_on_tick("NOISE_EMITTER_ON")
    content.add(item)
end

do
    -- Based off the TRIFIELD EMF Meter Model TF2.  Supposed to use 9volt, but uses medium battery instead
    local item = content.Item {
        id = "emf_detector",
        name = ccb.content.plural_text("EMF detector (off)", "EMF detectors (off)"),
        description = ccb.content.text("This device detects and reads out different electromagnetic wave lengths.  It beeps with proximity and is sensitive enough you could use it to get a sense of direction."),
        mass_milligrams = 240000,
        volume_ml = 355,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "emf_detector_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:fault_group("electronic_general", {  })
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
    -- lasts 12 hours with backlight off
    local item = content.Item {
        id = "emf_detector_on",
        copy_from = "emf_detector",
        looks_like = "emf_detector",
        name = ccb.content.plural_text("EMF detector (on)", "EMF detectors (on)"),
        description = ccb.content.text("This device detects and reads out different wave lengths.  It is currently on, humming and beeping with proximity.  It is sensitive enough you could use it to get a sense of direction."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "emf_detector" },
        message = ccb.content.text("The noise of your EMF detector slows to a halt."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "emf_detector" }
    item:tool { power_milliwatts = 1000 }
    item:clear_tick_actions()
    item:native_on_tick("EMF_PASSIVE_ON")
    content.add(item)
end

do
    -- Nintendo Switch
    local item = content.Item {
        id = "portable_game",
        name = ccb.content.plural_text("handheld game system", "handheld game systems"),
        description = ccb.content.text("A portable video game console, with a backlit screen allowing you to play in the dark.  You can use it to play a game, but this requires batteries.  Multiple game systems can be linked together for multiplayer games."),
        mass_milligrams = 362000,
        volume_ml = 341,
        price_cents = 29200,
        price_postapoc_cents = 3,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("aluminum", 75)
    item:material("plastic", 25)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("PORTABLE_GAME")
    item:link_cable { cable_length = 4, charge_milliwatts = 39000 }
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 48 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "smart_phone_flashlight",
        copy_from = "smart_phone",
        looks_like = "smart_phone",
        name = ccb.content.plural_text("smartphone - Flashlight", "smartphones - Flashlight"),
        light = 20,
    }
    item:clear_use_actions()
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:native_use("PORTABLE_GAME")
    item:transform_on_use {
        result = { target = "smart_phone" },
        message = ccb.content.text("You deactivate the flashlight app."),
        menu_text = ccb.content.text("Turn off flashlight"),
        ammo_scale = 0,
    }
    item:link_cable { cable_length = 3, charge_milliwatts = 20000 }
    item:flag("CHARGEDIM")
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "smart_phone" }
    item:tool { power_milliwatts = 1500 }
    content.add(item)
end

do
    local item = content.Item {
        id = "vibrator",
        copy_from = "sextoy",
        looks_like = "sextoy",
        name = ccb.content.plural_text("vibrator", "vibrators"),
        description = ccb.content.text("A vibrator."),
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 9)
    item:clear_use_actions()
    item:native_use("VIBE")
    item:link_cable { cable_length = 3, charge_milliwatts = 10000 }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("ELECTRONIC")
    item:variants {
        { id = "wand", name = ccb.content.plural_text("vibrating wand", "vibrating wands"), description = ccb.content.text("This truly multipurpose massage tool is just the thing you need to relax.  Use it to take a break and unwind.") },
        { id = "egg", name = ccb.content.plural_text("vibrating egg", "vibrating eggs"), description = ccb.content.text("This bulbous, u-shaped alien looking device will help you see the stars.  Use it to take a break and unwind.") },
        { id = "dildo", name = ccb.content.plural_text("vibrating dildo", "vibrating dildos"), description = ccb.content.text("You know what this is.  There's a switch at the bottom, you know what it's for.  Use it to take a break and unwind.") },
    }
    item:adjust_measurements { mass_milligrams = { offset = 50000 } }
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_pocket { ammo_capacities = { battery = 58 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "noise_emitter_super_on",
        copy_from = "noise_emitter_super",
        looks_like = "noise_emitter_super",
        name = ccb.content.plural_text("super noise emitter (on)", "super noise emitters (on)"),
        description = ccb.content.text("This is a noisemaker that has been further enhanced with a series of amplifiers.  It's currently making an extraordinary amount of noise - hopefully you have hearing protection."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "noise_emitter_super" },
        message = ccb.content.text("The infernal racket dies as the noise emitter turns off."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("POWERED")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "noise_emitter_super" }
    item:tool { power_milliwatts = 250000 }
    item:clear_tick_actions()
    item:on_tick("tick_noise_emitter_super_on")
    content.add(item)
end
