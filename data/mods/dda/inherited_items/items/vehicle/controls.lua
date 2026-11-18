local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "camera_control",
        name = ccb.content.plural_text("security camera display", "security camera displays"),
        description = ccb.content.text("A set of small monitors.  Required to view cameras' output."),
        mass_milligrams = 11234000,
        melee_to_hit = -3,
        color = "light_blue",
        symbol = "#",
        volume_ml = 4000,
        category = "veh_parts",
        price_cents = 10000,
        price_postapoc_cents = 1250,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "omnicamera",
        name = ccb.content.plural_text("security camera", "security cameras"),
        description = ccb.content.text("A security camera you could connect to a display.  Image quality is quite low, but the field of vision is great."),
        mass_milligrams = 1100000,
        melee_to_hit = -3,
        color = "light_blue",
        symbol = "+",
        volume_ml = 2000,
        category = "veh_parts",
        price_cents = 10000,
        price_postapoc_cents = 750,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "vehicle_controls",
        name = ccb.content.plural_text("vehicle controls", "sets of vehicle controls"),
        description = ccb.content.text("A steering wheel, accelerator, and brake pedals."),
        mass_milligrams = 6000000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "$",
        volume_ml = 3000,
        category = "veh_parts",
        price_cents = 40000,
        price_postapoc_cents = 500,
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "vehicle_dashboard",
        name = ccb.content.plural_text("dashboard", "dashboards"),
        description = ccb.content.text("A vehicle instrument panel with various gauges and switches."),
        mass_milligrams = 2821000,
        color = "cyan",
        symbol = "$",
        volume_ml = 10000,
        category = "veh_parts",
        price_cents = 8000,
        price_postapoc_cents = 250,
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "electronics_controls",
        copy_from = "vehicle_dashboard",
        looks_like = "vehicle_dashboard",
        name = ccb.content.plural_text("electronics control unit", "electronics control units"),
        description = ccb.content.text("A vehicle instrument panel with various gauges and switches.  Useful for crafting."),
        mass_milligrams = 1311000,
        melee_to_hit = -3,
        volume_ml = 1500,
        price_cents = 4000,
        price_postapoc_cents = 250,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    content.add(item)
end
