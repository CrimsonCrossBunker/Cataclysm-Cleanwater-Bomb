local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "exo_lense_module",
        name = ccb.content.plural_text("exosuit multi-lens zoom module", "exosuit multi-lens zoom modules"),
        description = ccb.content.text("A series of strangely shaped hexagonal lenses that flutter about inside your helmet.  As the lenses shift things around you stay perfectly in focus no matter your eyesight or distance.  It can be mounted to an exosuit helmet."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 1000000,
        symbol = "(",
        color = "yellow",
    }
    item:material("lvl4ballisticglass", 1)
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("CANT_WEAR")
    item:flag("FIX_NEARSIGHT")
    item:flag("FIX_FARSIGHT")
    item:flag("ZOOM")
    item:flag("EXO_HELMET_GADGET")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_flashlight_low",
        copy_from = "exo_flashlight",
        looks_like = "exo_flashlight",
        name = ccb.content.plural_text("mounted lamp (low)", "mounted lamps (low)"),
        light = 250,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "exo_flashlight_high" },
        menu_text = ccb.content.text("Turn to high"),
        message = ccb.content.text("You turn the lamp on high."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("USE_UPS")
    item:flag("CANT_WEAR")
    item:flag("EXO_SMALL_GADGET")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "exo_flashlight" }
    item:tool { power_milliwatts = 1000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_flashlight_high",
        copy_from = "exo_flashlight",
        looks_like = "exo_flashlight",
        name = ccb.content.plural_text("mounted lamp (high)", "mounted lamps (high)"),
        light = 500,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "exo_flashlight" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn the lamp off."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("USE_UPS")
    item:flag("CANT_WEAR")
    item:flag("EXO_SMALL_GADGET")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "exo_flashlight" }
    item:tool { power_milliwatts = 2000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_recoil_on",
        copy_from = "exo_recoil",
        looks_like = "exo_recoil",
        name = ccb.content.plural_text("recoil mitigation system (on)", "recoil mitigation systems (on)"),
        max_worn = 1,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "exo_recoil" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn off the recoil mitigation system."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("USE_UPS")
    item:flag("CANT_WEAR")
    item:flag("EXO_SMALL_GADGET")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "exo_recoil" }
    item:tool { power_milliwatts = 2000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_imager",
        name = ccb.content.plural_text("exosuit structural imager module", "exosuit structural imager modules"),
        description = ccb.content.text("A compact imaging tool, capable of scanning and visualizing objects hiding behind walls, maintenance panels and all other sort of visual barriers.  While normally used to diagnostic potential faults within the internal systems of spaceships, the ability to peer between obstacles grant it obvious surveillance applications.  It can be mounted to an exosuit helmet.  It can be activated to reveal a small conical area around you."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 1000000,
        symbol = "(",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:material("qt_steel", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "afs_clairvoyance_cone", no_fail = true, level = 5 }
    item:clear_flags()
    item:flag("USE_UPS")
    item:flag("CANT_WEAR")
    item:flag("EXO_HELMET_GADGET")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 50 }
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_jetpack",
        name = ccb.content.plural_text("exosuit dynamic maneuvering unit", "exosuit dynamic maneuvering units"),
        description = ccb.content.text("A large collection of tanks and nozzles, this module converts hydrogen to plasma, propelling the user between spaceships or across rough terrain and gaps.  The thrust is insufficient for sustained flight in a gravity well, but can still launch you forward at extreme speed and deliver a powerful blow on landing."),
        mass_milligrams = 8750000,
        volume_ml = 10000,
        price_cents = 1000000,
        symbol = "(",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("vacuum_carbide", 1)
    item:material("qt_steel", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "spell_exosuit_jetpack", no_fail = true, level = 5 }
    item:clear_flags()
    item:flag("CANT_WEAR")
    item:flag("EXO_LARGE_GADGET")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { charges_per_use = 1, ammo_types = { "ammonia_liquid" } }
    item:magazine_pocket {
        ammo_capacities = { ammonia_liquid = 10 },
        rigid = true,
        watertight = true,
        description = ccb.content.text("This is the maneuvering unit's fuel tank.  Holds up to 10 liters of pressurized fuel."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "exosuit_med_injector",
        name = ccb.content.plural_text("exosuit medical injector", "exosuit medical injectors"),
        description = ccb.content.text("A combination medical monitor and drug injection system, this module is intended to keep the pilot in the field longer."),
        mass_milligrams = 475000,
        volume_ml = 500,
        symbol = "!",
        color = "white",
        max_worn = 1,
        replace_pockets = true,
    }
    item:material("ceramic", 1)
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("CANT_WEAR")
    item:flag("EXO_SMALL_GADGET")
    item:clear_use_actions()
    item:native_use("JET_INJECTOR")
    item:tool { charges_per_use = 1, ammo_types = { "ampoule" } }
    item:magazine_pocket { ammo_capacities = { ampoule = 4 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_AR_module_on",
        copy_from = "exo_AR_module",
        looks_like = "exo_AR_module",
        name = ccb.content.plural_text("exosuit AR research module (on)", "exosuit AR research modules (on)"),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "exo_AR_module" },
        message = ccb.content.text("You deactivate the module."),
        menu_text = ccb.content.text("Turn off module"),
        ammo_scale = 0,
    }
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "exo_AR_module" }
    item:tool { power_milliwatts = 250 }
    content.add(item)
end
