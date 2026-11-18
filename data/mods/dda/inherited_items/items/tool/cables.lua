local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "jumper_cable_heavy",
        name = ccb.content.plural_text("heavy-duty jumper cable", "heavy-duty jumper cables"),
        description = ccb.content.text("A long, thick, heavy-duty jumper cable with power leads on either end.  Attach one end to one vehicle and the other to another, and you can transfer electrical power between the two, though you expect the power loss would be noticeable.  Can also link power grids."),
        volume_ml = 1500,
        mass_milligrams = 750000,
        copy_from = "jumper_cable",
        looks_like = "jumper_cable",
    }
    item:tool { initial_charges = 20, max_charges = 20 }
    content.add(item)
end

do
    local item = content.Item {
        id = "long_extension_cable",
        name = ccb.content.plural_text("outdoor extension cord", "outdoor extension cords"),
        description = ccb.content.text("An extra-long 100-foot (or about 30 m) orange extension cord for extending cables or connecting outdoor appliances.  Could be used on any appliance or other household electrical system."),
        copy_from = "extension_cable",
        looks_like = "extension_cable",
        volume_ml = 3750,
        mass_milligrams = 2500000,
    }
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("SINGLE_USE")
    item:tool { initial_charges = 30, max_charges = 30 }
    content.add(item)
end

do
    -- This cable is automatically handled by vehicles/appliances and is used for connecting them to each other.  See vehicle part in furniture_and_terrain > appliances.json
    local item = content.Item {
        id = "power_cord",
        name = ccb.content.plural_text("power cord", "power cords"),
        description = ccb.content.text("A power cord, like you've seen many times before: it's a short multi-stranded copper cord with a power outlet at the end."),
        color = "dark_gray",
        symbol = "&",
        volume_ml = 500,
        mass_milligrams = 75000,
        category = "tools",
        price_cents = 1,
        price_postapoc_cents = 100,
    }
    item:material("copper", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:link_cable { menu_text = ccb.content.text("Plug in / Manage connections"), targets = { "vehicle_port" } }
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("NO_DROP")
    item:flag("SINGLE_USE")
    item:tool { initial_charges = 2, max_charges = 2 }
    content.add(item)
end

do
    local item = content.Item {
        id = "jumper_cable",
        name = ccb.content.plural_text("jumper cable", "jumper cables"),
        description = ccb.content.text("A 3-foot (or about 1 m) jumper cable: a short multi-stranded copper cable with power leads on either end.  Attach one end to one vehicle and the other to another, and you can transfer electrical power between the two.  Can also link power grids."),
        melee_to_hit = -1,
        color = "light_blue",
        symbol = "&",
        volume_ml = 500,
        mass_milligrams = 75000,
        category = "tools",
        price_cents = 1,
        price_postapoc_cents = 100,
        replace_qualities = true,
    }
    item:material("copper", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:link_cable {
        menu_text = ccb.content.text("Attach / Manage connections"),
        targets = { "no_link", "bio_cable", "ups", "solarpack", "vehicle_battery" },
        can_extend = { "jumper_cable", "jumper_cable_heavy" },
    }
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:quality("JUMPSTART", 1)
    item:tool { initial_charges = 4, max_charges = 4 }
    content.add(item)
end

do
    local item = content.Item {
        id = "extension_cable",
        name = ccb.content.plural_text("extension cord", "extension cords"),
        description = ccb.content.text("A long 30-foot (or about 10 m) orange extension cord for extending cables or connecting appliances.  Could be used on any appliance or other household electrical system."),
        melee_to_hit = -1,
        color = "light_blue",
        symbol = "&",
        volume_ml = 1200,
        mass_milligrams = 800000,
        category = "tools",
        price_cents = 1,
        price_postapoc_cents = 100,
    }
    item:material("copper", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:link_cable {
        menu_text = ccb.content.text("Plug in / Manage connections"),
        targets = { "no_link", "vehicle_port" },
        can_extend = { "ELECTRICAL_DEVICES", "extension_cable", "long_extension_cable" },
    }
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { initial_charges = 10, max_charges = 10 }
    content.add(item)
end

do
    -- volume is cylinder with length 9m and diameter 5 mm, stats are calculated using <https://www.amazon.com/dp/B0C8V24Q27> as an example, and resized
    local item = content.Item {
        id = "hd_tow_cable",
        name = ccb.content.plural_text("heavy-duty tow cable", "heavy-duty tow cables"),
        description = ccb.content.text("An extremely heavy-duty 30-foot (or about 9 m) tow cable made from thick steel wire coated in plastic.  If attached to a vehicle, it could be used to pull another vehicle of any weight."),
        melee_to_hit = -1,
        color = "light_blue",
        symbol = "&",
        volume_ml = 749,
        mass_milligrams = 3252000,
        category = "tools",
        price_cents = 9999,
        price_postapoc_cents = 500,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:link_cable {
        efficiency = 0.0,
        menu_text = ccb.content.text("Attach / Manage connections"),
        targets = { "no_link", "vehicle_tow" },
    }
    item:quality("ROPE", 2)
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("TOW_CABLE")
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { initial_charges = 8, max_charges = 8 }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "jumper_cable_debug",
        name = content.plural_text("shiny debug cable", "shiny debug cables"),
        description = content.text("This is the cable of the gods: 100 meters long, no power loss, light as a feather, and fits in a matchbook.  You're sure this wasn't supposed to exist, and the way it shimmers makes you uneasy."),
        copy_from = "jumper_cable",
        looks_like = "jumper_cable",
        mass_milligrams = 1000,
        volume_ml = 1,
    }
    item:clear_use_actions()
    item:link_cable {
        efficiency = 1.0,
        menu_text = ccb.content.text("Attach / Manage connections"),
        targets = { "no_link", "bio_cable", "ups", "solarpack", "vehicle_port", "vehicle_battery", "vehicle_tow" },
        can_extend = { "ELECTRICAL_DEVICES", "jumper_cable_debug" },
    }
    item:tool { initial_charges = 100, max_charges = 100 }
    content.add(item)
end
