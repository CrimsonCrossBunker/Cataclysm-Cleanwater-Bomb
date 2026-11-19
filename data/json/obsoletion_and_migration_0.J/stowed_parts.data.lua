local ccb = require("ccb")

-- Everything in here is obsolete! You should not be adding anything! The only changes should be bare maintenance.
-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_fridge",
    name = ccb.content.text("tied-down household fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "apartment_fridge",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "apartment_fridge" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_minifridge",
    name = ccb.content.text("tied-down minifridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A minifridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "minifridge",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "minifridge" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_big_portable_fridge",
    name = ccb.content.text("tied-down food truck fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A food truck fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "big_portable_fridge",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "minifridge" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_glass_fridge",
    name = ccb.content.text("tied-down single glass door fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A single glass door fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands.  Careful with the glass!"),
    item = "glass_fridge",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "glass_fridge" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_glass_fridge_double",
    name = ccb.content.text("tied-down double glass door fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A double glass door fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands.  Careful with the glass!"),
    item = "glass_fridge_double",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "glass_fridge_double" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_heavy_duty_fridge",
    name = ccb.content.text("tied-down heavy duty fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A heavy duty fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "heavy_duty_fridge",
    location = "on_roof",
    requirements = {
        install = { duration = "15 m", using_requirements = { { "rope_natural", 2 } } },
        removal = { duration = "10 m" },
    },
    breaks_into = { { item = "heavy_duty_fridge" }, { item = "rope_30", count = { 2, 2 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_display_fridge",
    name = ccb.content.text("tied-down display fridge"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A display fridge, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "display_fridge",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "display_fridge" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_freezer",
    name = ccb.content.text("tied-down household freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A household freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "apartment_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "apartment_freezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_minifreezer",
    name = ccb.content.text("tied-down minifreezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A minifreezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "minifreezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "minifreezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_chest_minifreezer",
    name = ccb.content.text("tied-down chest minifreezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A chest minifreezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "chest_minifreezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "chest_minifreezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_big_portable_freezer",
    name = ccb.content.text("tied-down food truck freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A food truck freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "big_portable_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "big_portable_freezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_chest_freezer",
    name = ccb.content.text("tied-down chest freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A chest freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "chest_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "chest_freezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_heavy_duty_freezer",
    name = ccb.content.text("tied-down heavy-duty freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A heavy-duty freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "heavy_duty_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "15 m", using_requirements = { { "rope_natural", 2 } } },
        removal = { duration = "10 m" },
    },
    breaks_into = { { item = "heavy_duty_freezer" }, { item = "rope_30", count = { 2, 2 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_glass_freezer",
    name = ccb.content.text("tied-down glass freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A chest freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "glass_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "glass_freezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_display_freezer",
    name = ccb.content.text("tied-down display freezer"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A chest freezer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "display_freezer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "display_freezer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "F", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_oven",
    name = ccb.content.text("tied-down oven"),
    categories = { "other" },
    color = "dark_gray_white",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An oven, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "oven",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "oven" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "#", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_arcade_machine",
    name = ccb.content.text("tied-down arcade machine"),
    categories = { "other" },
    color = "red",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An arcade machine, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "arcade_machine",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "arcade_machine" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "6", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_drill_press",
    name = ccb.content.text("tied-down drill press"),
    categories = { "other" },
    color = "yellow_red",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A drill press, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "drill_press",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "drill_press" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_tablesaw",
    name = ccb.content.text("tied-down table saw"),
    categories = { "other" },
    color = "yellow_red",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A table saw, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "tablesaw",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "tablesaw" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_mitresaw",
    name = ccb.content.text("tied-down mitre saw"),
    categories = { "other" },
    color = "yellow_cyan",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A mitre, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "mitresaw",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "mitresaw" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_bandsaw",
    name = ccb.content.text("tied-down band saw"),
    categories = { "other" },
    color = "yellow_cyan",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A band saw, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "bandsaw",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "bandsaw" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_router",
    name = ccb.content.text("tied-down router"),
    categories = { "other" },
    color = "yellow_green",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A router, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "router",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "router" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_planer",
    name = ccb.content.text("tied-down planer"),
    categories = { "other" },
    color = "yellow_white",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A planer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "planer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "planer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_jointer",
    name = ccb.content.text("tied-down jointer"),
    categories = { "other" },
    color = "yellow_magenta",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A jointer, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "jointer",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "jointer" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_hydraulic_press",
    name = ccb.content.text("tied-down hydraulic press"),
    categories = { "other" },
    color = "black_red",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A hydraulic press, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "hydraulic_press",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "hydraulic_press" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_air_compressor",
    name = ccb.content.text("tied-down air compressor"),
    categories = { "other" },
    color = "black_yellow",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An air compressor, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "air_compressor",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "air_compressor" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "7", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_oxygen_concentrator",
    name = ccb.content.text("tied-down oxygen concentrator"),
    categories = { "other" },
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An oxygen concentrator, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "oxygen_concentrator",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "oxygen_concentrator" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "&", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_hd_compressor_unit",
    name = ccb.content.text("tied-down high pressure compressor unit"),
    categories = { "other" },
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An oxygen concentrator, secured to the roof for transportation.  Not functional, but easier than carrying it with your hands."),
    item = "hd_compressor_unit",
    location = "on_roof",
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural", 1 } } },
        removal = { duration = "5 m" },
    },
    breaks_into = { { item = "hd_compressor_unit" }, { item = "rope_30" } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "&", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_broken_yrax_quadraphract_leg",
    name = ccb.content.text("tied-down broken quadraphract leg"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A broken quadraphract leg, secured to the roof for transportation.  Not functional, and hopefully never be."),
    item = "broken_yrax_quadraphract_leg",
    location = "on_roof",
    requirements = {
        install = { duration = "35 m", using_requirements = { { "chain_material", 3 } } },
        removal = { duration = "15 m" },
    },
    breaks_into = { { item = "broken_yrax_quadraphract_leg" }, { item = "chain", count = { 3, 3 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "Y", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_broken_yrax_quadraphract",
    name = ccb.content.text("tied-down broken quadraphract"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("A broken quadraphract, secured to the roof for transportation.  Not functional, and hopefully never be."),
    item = "broken_yrax_quadraphract",
    location = "on_roof",
    requirements = {
        install = { duration = "35 m", using_requirements = { { "chain_material", 3 } } },
        removal = { duration = "15 m" },
    },
    breaks_into = { { item = "broken_yrax_quadraphract" }, { item = "chain", count = { 3, 3 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "Y", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_broken_golden_monolith",
    name = ccb.content.text("tied-down broken golden monolith"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("More than a ton of gold tied to roof for easier transportation.  Probably the only way to move this without breaking your back."),
    item = "broken_golden_monolith",
    location = "on_roof",
    requirements = {
        install = { duration = "2 h", using_requirements = { { "chain_material", 4 } } },
        removal = { duration = "20 m" },
    },
    breaks_into = { { item = "broken_golden_monolith" }, { item = "chain", count = { 4, 4 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "I", broken_symbols = "*" } },
}

-- This is used to simulate a rope being untied/broken and falling off
ccb.content.define_vehicle_part {
    id = "stowed_bot_golden_monolith",
    name = ccb.content.text("tied-down golden monolith"),
    categories = { "other" },
    color = "light_blue",
    damage_modifier = 5,
    durability = 20,
    description = ccb.content.text("An alien construct, secured to the roof for transportation.  Hopefully it won't reanimate on next road bump."),
    item = "bot_golden_monolith",
    location = "on_roof",
    requirements = {
        install = { duration = "2 h", using_requirements = { { "chain_material", 4 } } },
        removal = { duration = "20 m" },
    },
    breaks_into = { { item = "bot_golden_monolith" }, { item = "chain", count = { 4, 4 } } },
    flags = { "EXTRA_DRAG", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "I", broken_symbols = "*" } },
}
