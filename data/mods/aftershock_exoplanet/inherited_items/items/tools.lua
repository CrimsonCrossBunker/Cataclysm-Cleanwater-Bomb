local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_welding_paste",
        name = ccb.content.plural_text("self-welding paste", "self-welding paste"),
        description = ccb.content.text("A pyrotechnic metal suspension that can be applied to metal surfaces and ignited to create 'temporary' welds.  Intended for use in emergency situations."),
        mass_milligrams = 2,
        volume_ml = 1,
        price_cents = 100,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "red",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("powder", 1)
    item:quality("WELD", 2)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("UNRECOVERABLE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atompot",
        name = ccb.content.plural_text("atompot", "atompots"),
        copy_from = "pressure_cooker",
        description = ccb.content.text("Rivtech's premiere self-heating kitchen appliance, complete with lid, hand-crafted with the power of the atom to reach any temperature in thirty seconds.  As bulky as it is, its plutonium power source means that it can be used to cook an absurd amount of meals without ever worrying about running low on power.  Unsurprisingly, sales weren't particularly good because of the prospect of irradiating your food, but internal shielding ensures that only trace amounts find their way into the center."),
        price_cents = 30000,
        price_postapoc_cents = 5000,
        looks_like = "pot",
        symbol = ")",
        color = "light_green",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("CHEM", 1)
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HOTPLATE_ATOMIC")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bionic_maintenance_toolkit",
        copy_from = "screwdriver_set",
        looks_like = "screwdriver_set",
        name = ccb.content.plural_text("bionic maintenance toolkit", "bionic maintenance toolkits"),
        description = ccb.content.text("A set of very small tools and encrypted digital keys normally used to repair bionic modules in clinical settings.  They will allow you to disassemble simple bionics, but anything more complex would require even more specialized tools."),
        replace_qualities = true,
    }
    item:quality("BIONIC_ASSEMBLY", 1)
    item:quality("SCREW_FINE", 1)
    item:quality("WRENCH_FINE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_complete_bionic_toolkit",
        copy_from = "screwdriver_set",
        looks_like = "screwdriver_set",
        name = ccb.content.plural_text("complete bionic toolkit", "complete bionic toolkits"),
        description = ccb.content.text("A set of very small robotic tools and encrypted digital keys originally designed to disassemble and test the quality of industrially produced bionics.  A highly skilled and patient engineer could use them to manually assemble new cybernetics."),
        replace_qualities = true,
    }
    item:quality("BIONIC_ASSEMBLY", 2)
    item:quality("SCREW_FINE", 1)
    item:quality("WRENCH_FINE", 1)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "nano_pseudo_forge",
        name = content.plural_text("pseudo nano forge", "pseudo nano forges"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 20000,
        replace_qualities = true,
        symbol = "H",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:quality("NANO_FORGE", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_bio_deck_jack",
        category = "tools",
        name = ccb.content.plural_text("Infolink jack", "Infolink jacks"),
        description = ccb.content.text("The interface jack of an implanted Infolink, coiled within your forearm and accessible through a small port in your wrist.  It can be used to interface and hack into electronic devices."),
        mass_milligrams = 20000,
        volume_ml = 2,
        price_cents = 100,
        symbol = ",",
        color = "green",
        replace_qualities = true,
    }
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("WATER_FRIENDLY")
    item:flag("SOFT")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_NATURAL_ATTACKS")
    item:flag("TRADER_AVOID")
    item:flag("USES_BIONIC_POWER")
    item:quality("HACK", 4)
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "pseudo_diamond_press",
        name = content.plural_text("pseudo diamond press", "pseudo diamond presses"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 20000,
        replace_qualities = true,
        symbol = "H",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:quality("DIAMONDPRESS", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "military_mess_kit",
        name = ccb.content.plural_text("military mess kit", "military mess kits"),
        description = ccb.content.text("A military mess kit designed for long-range reconnaissance patrols deployed behind enemy lines.  All of its parts are made from thin sheets of aluminum-superalloy composite and are insulated with ceramic coating.  Relies on a battery-operated hotplate, rather than the smoke-producing chemical-fueled hexamine stove.  Compact, durable and lightweight."),
        mass_milligrams = 900000,
        volume_ml = 1000,
        longest_side_mm = 100,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -1,
        symbol = ";",
        color = "green",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("superalloy", 1)
    item:material("ceramic", 1)
    item:quality("COOK", 2)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HOTPLATE")
    item:native_use("HEAT_FOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 25, ammo_types = { "battery" }, crafting_subtype = "hotplate_induction" }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_battery_charger",
        category = "other",
        name = ccb.content.plural_text("portable battery charger", "portable battery chargers"),
        looks_like = "box_battery_charger",
        description = ccb.content.text("This small device easily deploys anywhere you need it and will slowly charge all rechargeable batteries placed within it's storage space."),
        mass_milligrams = 3050000,
        color = "cyan",
        symbol = "]",
        volume_ml = 10000,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_appliance("afs_battery_charger")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:ammo_pocket("battery", 100)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_imager",
        name = ccb.content.plural_text("structural imager", "structural imagers"),
        description = ccb.content.text("A compact imaging tool, capable of scanning and visualizing objects hiding behind walls, maintenance panels and all other sort of visual barriers.  While normally used to diagnostic potential faults within the internal systems of spaceships, the ability to peer between obstacles grant it obvious surveillance applications.  It can be activated to reveal a small conical area around you."),
        mass_milligrams = 500000,
        volume_ml = 850,
        longest_side_mm = 200,
        price_cents = 1000000,
        symbol = "(",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "afs_clairvoyance_cone", no_fail = true, level = 5 }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 50, ammo_types = { "battery" } }
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
        id = "afs_motion_sensor_on",
        copy_from = "afs_motion_sensor",
        looks_like = "afs_motion_sensor",
        name = ccb.content.plural_text("motion scanner (on)", "motion scanners (on)"),
        description = ccb.content.text("This active motion scanner will survey your surroundings every ten seconds and audibly alert you when movement is detected.  Wielding it will accurately reveal the location of motion sources."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_motion_sensor" },
        menu_text = ccb.content.text("Deactivate"),
        message = ccb.content.text("The %s screen flashes briefly before fading out."),
    }
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "afs_motion_sensor" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_plasma_torch",
        name = ccb.content.plural_text("377-UASTA plasma torch", "377-UASTA plasma torches"),
        description = ccb.content.text("One of the many versions of UASTA certified plasma torches, essentially a civilian plasma railgun used to deliver focused waves of plasma for precision welding or metal cutting.  It is an indispensable tool for construction or demolition work, and is sometimes transformed into a weapon by mining & salvage outfits of questionable repute."),
        mass_milligrams = 4200000,
        volume_ml = 4500,
        longest_side_mm = 600,
        price_cents = 35000,
        price_postapoc_cents = 35000,
        symbol = ";",
        color = "red",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("OXYTORCH")
    item:quality("WELD", 2)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("BELT_CLIP")
    item:tool { charges_per_use = 1, ammo_types = { "afs_shydrogen" } }
    item:magazine_well {
        max_volume_ml = 20000,
        max_weight_milligrams = 20000000,
        holster = true,
        magazine_well_ml = 120,
        allowed_items = { "afs_40g_plasma_civ" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atomic_smartphone_flashlight",
        copy_from = "afs_atomic_smartphone",
        looks_like = "afs_atomic_smartphone",
        name = ccb.content.plural_text("atomic smartphone - Flashlight", "atomic smartphones - Flashlight"),
        light = 25,
    }
    item:clear_use_actions()
    item:native_use("PORTABLE_GAME")
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:transform_on_use {
        result = { target = "afs_atomic_smartphone" },
        message = ccb.content.text("You deactivate the flashlight app."),
        menu_text = ccb.content.text("Turn off flashlight"),
    }
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "afs_atomic_smartphone" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atomic_wraitheon_flashlight",
        copy_from = "afs_atomic_smartphone_flashlight",
        looks_like = "afs_atomic_smartphone_flashlight",
        name = ccb.content.plural_text("Wraitheon executive's smartphone - Flashlight", "Wraitheon executive's smartphones - Flashlight"),
    }
    item:clear_use_actions()
    item:native_use("PORTABLE_GAME")
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:transform_on_use {
        result = { target = "afs_wraitheon_smartphone" },
        message = ccb.content.text("You deactivate the flashlight app."),
        menu_text = ccb.content.text("Turn off flashlight"),
    }
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "afs_atomic_smartphone" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_power_cutter",
        name = ccb.content.plural_text("power cutter (off)", "power cutters (off)"),
        description = ccb.content.text("A huge, gas-powered saw with a diamond blade.  If it has gasoline, it can be turned on to turn it into a powerful metal cutting tool."),
        mass_milligrams = 9979000,
        volume_ml = 3000,
        price_cents = 100000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = "/",
        looks_like = "circsaw_off",
        color = "light_red",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:material("diamond", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_power_cutter_on" },
        message = ccb.content.text("You rev up the power cutter!"),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("cut", 3)
    item:tool { charges_per_use = 1, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 500 }, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_power_cutter_on",
        copy_from = "afs_power_cutter",
        looks_like = "afs_power_cutter",
        name = ccb.content.plural_text("power cutter (on)", "power cutters (on)"),
        description = ccb.content.text("A huge, gas-powered saw with a diamond blade, currently a whirling blur.  It's consuming gasoline, but can be used as a fantastic tool for cutting metal.  You can also use it as a terrifying weapon, if you're into that sort of thing."),
        replace_qualities = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_power_cutter" },
        message = ccb.content.text("Your power cutter falls quiet."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:quality("CUT", 2)
    item:quality("SAW_M", 20)
    item:quality("SAW_M_FINE", 1)
    item:quality("BUTCHER", -70)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("cut", 80)
    item:transform_into { target = "afs_power_cutter" }
    item:tool { turns_per_charge = 3 }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_murdersaw",
        name = ccb.content.plural_text("murdersaw (off)", "murdersaws (off)"),
        description = ccb.content.text("This former power cutter has been lightened and stripped of all those unnecessary safety measures, turning it into a gas-powered killing machine.  Use it to turn it on."),
        mass_milligrams = 4301000,
        volume_ml = 2000,
        price_cents = 100000,
        price_postapoc_cents = 30000,
        melee_to_hit = -3,
        symbol = "/",
        looks_like = "circsaw_off",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:material("diamond", 1)
    item:clear_use_actions()
    item:transform_on_use { result = { target = "afs_murdersaw_on" }, message = ccb.content.text("You rev up the murdersaw!") }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 3)
    item:tool { charges_per_use = 1, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 500 }, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_murdersaw_on",
        copy_from = "afs_murdersaw",
        looks_like = "afs_murdersaw",
        name = ccb.content.plural_text("murdersaw (on)", "murdersaws (on)"),
        description = ccb.content.text("This fearsome weapon is currently whirring loudly and shaking with the force of its own power.  Use it to turn it off."),
        replace_qualities = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_murdersaw" },
        message = ccb.content.text("Your murdersaw falls quiet."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:quality("CUT", 2)
    item:quality("SAW_M", 10)
    item:quality("BUTCHER", -50)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 80)
    item:transform_into { target = "afs_murdersaw" }
    item:tool { turns_per_charge = 5 }
    content.add(item)
end

do
    local item = content.Item {
        id = "control_laptop",
        name = ccb.content.plural_text("control laptop", "control laptops"),
        description = ccb.content.text("A modified laptop, now additionally capable of transmitting in the ultra-high frequencies utilized by robots.  Activate it to command robots from afar."),
        mass_milligrams = 2721000,
        volume_ml = 1000,
        price_cents = 10000,
        price_postapoc_cents = 8000,
        symbol = ",",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:native_use("ROBOTCONTROL")
    item:native_use("E_FILE_DEVICE")
    item:native_use("EBOOKSAVE")
    item:native_use("PORTABLE_GAME")
    item:transform_on_use {
        result = { target = "control_laptop_screen_lit" },
        message = ccb.content.text("You light up the screen."),
        menu_text = ccb.content.text("Light up the screen"),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:clear_flags()
    item:flag("WATCH")
    item:tool { charges_per_use = 2, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    item:file_storage_pocket {
        max_volume_ml = 1,
        max_weight_milligrams = 1000,
        rigid = true,
        weight_multiplier = 0.0,
        memory_kb = 1000000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "control_laptop_screen_lit",
        copy_from = "control_laptop",
        looks_like = "control_laptop",
        name = ccb.content.plural_text("control laptop - lit screen", "control laptops - lit screen"),
        light = 10,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "control_laptop" },
        message = ccb.content.text("You turn off the screen."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("WATCH")
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "control_laptop" }
    item:tool { power_milliwatts = 1000 }
    content.add(item)
end
