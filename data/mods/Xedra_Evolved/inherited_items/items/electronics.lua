local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "laptop_xedra",
        copy_from = "laptop",
        looks_like = "laptop",
        category = "tools",
        name = ccb.content.plural_text("XEDRA laptop", "XEDRA laptops"),
        description = ccb.content.text("A heavy, dark laptop with a swappable battery slot.  The back panel is labeled \"PROPERTY OF XEDRA\".  It uses a non-standard OS, so there's not much you can use it for without reinstalling it."),
        symbol = ",",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "laptop_xedra_lit" },
        message = ccb.content.text("You light up the screen."),
        menu_text = ccb.content.text("Light up the screen"),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:link_cable {
        cable_length = 5,
        ammo_scale = 0,
        charge_milliwatts = 140000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("WATCH")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:fault_group("electronic_general", {  })
    item:tool()
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    item:on_use("read_xedra_locked_folders", ccb.content.text("Try to open locked folders"), ccb.content.text("You can guess a password and check some classified information, if it has any."), { id = "inspect_locked_folders" })
    content.add(item)
end

do
    local item = content.Item {
        id = "laptop_xedra_lit",
        copy_from = "laptop_xedra",
        looks_like = "laptop_xedra",
        name = ccb.content.plural_text("XEDRA laptop - lit screen", "XEDRA laptops - lit screen"),
        light = 10,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "laptop_xedra" },
        message = ccb.content.text("You turn off the screen."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:link_cable {
        cable_length = 5,
        ammo_scale = 0,
        charge_milliwatts = 140000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_flags()
    item:flag("WATCH")
    item:flag("TRADER_AVOID")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("SPAWN_ACTIVE")
    item:fault_group("electronic_general", {  })
    item:transform_into { target = "laptop_xedra" }
    item:tool { power_milliwatts = 1000 }
    item:on_use("read_xedra_locked_folders", ccb.content.text("Try to open locked folders"), ccb.content.text("You can guess a password and check some classified information, if it has any."), { id = "inspect_locked_folders" })
    content.add(item)
end
