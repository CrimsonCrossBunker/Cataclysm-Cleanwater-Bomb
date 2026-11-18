local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "radio_mod",
        category = "spare_parts",
        name = ccb.content.plural_text("radio activation mod", "radio activation mods"),
        description = ccb.content.text("A small electronic device that can be attached to certain items to activate them with a radio signal from an RC car controller."),
        mass_milligrams = 142000,
        volume_ml = 250,
        price_cents = 5000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("RADIO_MOD")
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "radiocontrol",
        name = ccb.content.plural_text("RC control", "RC controls"),
        description = ccb.content.text("A remote control for an RC car, with a joystick to steer the car and colorful buttons that don't seem to do anything.  Perhaps they were for the deluxe model?"),
        symbol = "#",
        color = "yellow",
        mass_milligrams = 670000,
        volume_ml = 500,
        price_cents = 6000,
        price_postapoc_cents = 250,
        replace_pockets = true,
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("RADIOCONTROL")
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, turns_per_charge = 20, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:clear_tick_actions()
    item:native_on_tick("RADIOCONTROL_TICK")
    content.add(item)
end

do
    local item = content.Item {
        id = "radio_car",
        name = ccb.content.plural_text("RC car", "RC cars"),
        description = ccb.content.text("A remote-controlled car.  Fun for all ages."),
        symbol = "#",
        mass_milligrams = 2340000,
        volume_ml = 1500,
        price_cents = 24000,
        price_postapoc_cents = 250,
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("RADIOCAR")
    item:clear_flags()
    item:flag("RADIO_CONTAINER")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:container_pocket {
        max_volume_ml = 1250,
        max_weight_milligrams = 2000000,
        rigid = true,
        allowed_flags = { "RADIOCARITEM" },
    }
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
        id = "radio_car_on",
        copy_from = "radio_car",
        looks_like = "radio_car",
        name = ccb.content.plural_text("RC car (on)", "RC cars (on)"),
        description = ccb.content.text("A remote-controlled toy car.  It is turned on and draining its batteries just like a real electric car!  Use a remote control to drive it around."),
        light = 15,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "radio_car" },
        message = ccb.content.text("You turn off the %s."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:clear_flags()
    item:flag("RADIO_CONTAINER")
    item:flag("TRADER_AVOID")
    item:flag("RADIOCAR")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "radio_car" }
    item:tool { turns_per_charge = 12 }
    item:clear_tick_actions()
    item:sound_on_tick { message = ccb.content.text("buzzz…"), volume = 0, sound_id = "misc", sound_variant = "rc_car_drives" }
    content.add(item)
end

do
    local item = content.Item {
        id = "radio",
        name = ccb.content.plural_text("radio (off)", "radios (off)"),
        description = ccb.content.text("A portable radio.  Using this radio turns it on.  It will pick up any nearby signals being broadcasted and play them audibly."),
        mass_milligrams = 295000,
        volume_ml = 1000,
        price_cents = 1000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:link_cable { cable_length = 3, charge_milliwatts = 5000 }
    item:transform_on_use {
        result = { target = "radio_on" },
        menu_text = ccb.content.text("Turn on"),
        message = ccb.content.text("You turn on the %s."),
        ammo_scale = 0,
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "radio_on",
        copy_from = "radio",
        looks_like = "radio",
        name = ccb.content.plural_text("radio (on)", "radios (on)"),
        description = ccb.content.text("A portable radio that is turned on and continually draining its batteries.  It is playing the broadcast being sent from any nearby radio towers."),
    }
    item:clear_use_actions()
    item:native_use("RADIO_ON")
    item:link_cable {
        cable_length = 3,
        ammo_scale = 0,
        charge_milliwatts = 5000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:transform_on_use { result = { target = "radio" }, menu_text = ccb.content.text("Turn off"), ammo_scale = 0 }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "radio" }
    item:tool { power_milliwatts = 500 }
    item:clear_tick_actions()
    item:native_on_tick("RADIO_TICK")
    content.add(item)
end

do
    local item = content.Item {
        id = "two_way_radio",
        name = ccb.content.plural_text("two-way radio", "two-way radios"),
        description = ccb.content.text("A radio with a transmitting unit.  You could use it to contact someone who also has one."),
        mass_milligrams = 431000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 750,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TWO_WAY_RADIO")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:link_cable { cable_length = 3, charge_milliwatts = 5000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "remotevehcontrol",
        name = ccb.content.plural_text("remote vehicle controller", "remote vehicle controllers"),
        description = ccb.content.text("A remote controller for a real car.  Can turn onboard devices on and off.  Some cars can be driven remotely."),
        mass_milligrams = 907000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 250,
        symbol = "#",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("REMOTEVEH")
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 1, turns_per_charge = 10, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:clear_tick_actions()
    item:native_on_tick("REMOTEVEH_TICK")
    content.add(item)
end
