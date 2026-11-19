local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "ap_veh_tools_kitchen",
    copy_from = "veh_tools_kitchen",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_veh_tools_workshop",
    copy_from = "veh_tools_workshop",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_workbench_with_recharger",
    copy_from = "workbench_with_recharger",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_oven",
    name = ccb.content.text("oven"),
    categories = { "utility" },
    description = ccb.content.text("A standard electric convection-based oven, commonly used for heating and cooking food.  It's plugged in and ready to go."),
    color = "dark_gray",
    broken_color = "dark_gray_white",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "CARGO", "OBSTACLE", "COVERED", "FLAT_SURF", "APPLIANCE" },
    pseudo_tools = { { id = "oven_tool" }, { id = "hotplate", hotkey = "h" } },
    item = "oven",
    looks_like = "f_oven",
    breaks_into = {
        { item = "sheet_metal", count = { 1, 4 } },
        { item = "sheet_metal_small", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 0, 3 } },
        { item = "scrap", count = { 0, 6 } },
        { item = "element", count = { 1, 3 } },
        { item = "cable", count = { 1, 2 } },
    },
    size = "50 L",
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_water_purifier",
    name = ccb.content.text("stationary water purifier"),
    categories = { "utility" },
    description = ccb.content.text("This device effectively sterilizes water.  Activate it to clean all water in a connected tank, at the cost of some electricity."),
    color = "white",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 60,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "water_purifier", hotkey = "p" } },
    item = "stationary_water_purifier",
    looks_like = "f_water_purifier",
    breaks_into = {
        { item = "scrap", count = { 2, 7 } },
        { item = "mc_steel_chunk", count = { 0, 3 } },
        { item = "sheet_metal", count = { 2, 6 } },
        { item = "cable", count = { 1, 5 } },
        { item = "hose", count = { 0, 2 } },
        { item = "cu_pipe", count = { 1, 4 } },
        { item = "scrap_copper", count = { 0, 2 } },
        { item = "water_faucet", count = { 0, 1 } },
    },
    variants = { { symbols = "W", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_arcade_machine",
    name = ccb.content.text("arcade machine"),
    categories = { "utility" },
    description = ccb.content.text("A bulky upright arcade cabinet, brightly painted and slightly worn with age.  Ready to be played."),
    color = "red",
    broken_color = "red",
    light_color = { 120, 200, 255 },
    damage_modifier = 10,
    damage_reduction = { all = 10 },
    durability = 80,
    flags = {
        "OBSTACLE",
        "COVERED",
        "HALF_CIRCLE_LIGHT",
        "APPLIANCE",
        "ENABLED_DRAINS_EPOWER",
        "ARCADE",
        "CTRL_ELECTRONIC",
    },
    epower = "-150 W",
    bonus = 10,
    item = "arcade_machine",
    looks_like = "f_arcade_machine",
    breaks_into = {
        { item = "splinter", count = { 0, 6 } },
        { item = "television", probability = 50 },
        { item = "2x4", count = { 2, 6 } },
        { item = "nail", charges = { 4, 10 } },
        { item = "cable", count = { 2, 4 } },
        { item = "circuit", count = { 0, 4 } },
        { item = "power_supply", probability = 50 },
        { item = "RAM", count = { 0, 2 } },
    },
    variants = { { symbols = "6", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_arc_furnace",
    name = ccb.content.text("arc furnace"),
    looks_like = "f_arcfurnace_empty",
    color = "blue",
    categories = { "utility" },
    description = ccb.content.text("An arc furnace designed to burn a powdery mix of coke and limestone to create calcium carbide.  Plugged in and ready to go."),
    broken_color = "yellow_red",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "fake_arc_furnace" } },
    item = "arc_furnace",
    breaks_into = {
        { item = "scrap", count = { 2, 4 } },
        { item = "mc_steel_chunk", count = { 0, 3 } },
        { item = "pipe", count = { 0, 4 } },
    },
    variants = { { symbols = "U", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_forge",
    copy_from = "veh_forge",
    name = ccb.content.text("electric forge"),
    description = ccb.content.text("An electric forge, plugged in and ready to be used for metalworking.  If you attempt to craft an item that needs a forge, you will be given the option of selecting it as a tool."),
    item = "forge",
    flags = { "CARGO", "OBSTACLE", "APPLIANCE" },
}

ccb.content.define_vehicle_part {
    id = "ap_stereo",
    flags = { "STEREO", "APPLIANCE", "ENABLED_DRAINS_EPOWER" },
    copy_from = "stereo",
}

ccb.content.define_vehicle_part {
    id = "ap_kiln",
    description = ccb.content.text("An electric kiln for baking brick or clay.  When plugged in and powered you could use this to harden bricks or clay.  If you attempt to craft an item that needs a kiln, you will be given the option of selecting it as a tool."),
    flags = { "CARGO", "OBSTACLE", "APPLIANCE" },
    item = "kiln",
    copy_from = "veh_kiln",
    pseudo_tools = { { id = "kiln" } },
}

ccb.content.define_vehicle_part {
    id = "ap_drill_press",
    name = ccb.content.text("drill press"),
    looks_like = "f_machinery_light",
    color = "yellow_red",
    categories = { "utility" },
    description = ccb.content.text("A powerful drill mounted on a slide that lets it drop precisely down.  Useful in all kinds of projects, from industrial fabrication to home woodworking.  Plugged in and ready to go."),
    broken_color = "yellow_red",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "drill_press_tool" } },
    item = "drill_press",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_power_hammer",
    name = ccb.content.text("power hammer"),
    looks_like = "f_drophammer",
    color = "light_blue",
    categories = { "utility" },
    description = ccb.content.text("A self-contained pneumatic power hammer using compressed air from an integrated compressor to strike repeatedly with great force.  Used for efficiently shaping and working metal.  Plugged in and ready to smash!"),
    broken_color = "light_blue",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "power_hammer_tool" } },
    item = "power_hammer",
    breaks_into = {
        { item = "scrap", count = { 8, 12 } },
        { item = "hc_steel_chunk", count = { 8, 12 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "e_scrap", count = { 2, 4 } },
        { item = "steel_plate", count = { 10, 12 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "f_steel_kiln",
    name = ccb.content.text("tempering kiln"),
    looks_like = "f_kiln_empty",
    color = "light_blue",
    categories = { "utility" },
    description = ccb.content.text("A very long electric kiln made for heat treating metal.  Unlike a forge, it can't get extremely hot, but its temperature is completely programmable."),
    broken_color = "light_blue",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "APPLIANCE" },
    pseudo_tools = { { id = "steel_kiln_tool" } },
    item = "steel_kiln",
    variants = { { symbols = "8", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_tablesaw",
    name = ccb.content.text("table saw"),
    looks_like = "f_machinery_light",
    color = "yellow_red",
    categories = { "utility" },
    description = ccb.content.text("A rotating sawblade set into a large, flat table.  Used for making straight, measured cuts, it's a key tool in any carpenter's arsenal.  Plugged in and ready to go."),
    broken_color = "yellow_red",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "tablesaw_tool" } },
    item = "tablesaw",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_mitresaw",
    name = ccb.content.text("mitre saw"),
    looks_like = "f_machinery_light",
    color = "yellow_cyan",
    categories = { "utility" },
    description = ccb.content.text("A circular sawblade on an arm that can slide and rotate in several directions, this is a staple tool for nearly any carpentry.  Plugged in and ready to go."),
    broken_color = "yellow_cyan",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "mitresaw_tool" } },
    item = "mitresaw",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_bandsaw",
    name = ccb.content.text("band saw"),
    looks_like = "f_machinery_light",
    color = "yellow_cyan",
    categories = { "utility" },
    description = ccb.content.text("A ribbonlike sawblade runs in a single direction in this tool, allowing precise cuts at almost any angle.  Plugged in and ready to go."),
    broken_color = "yellow_cyan",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "bandsaw_tool" } },
    item = "bandsaw",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_router",
    name = ccb.content.text("router table"),
    looks_like = "f_machinery_light",
    color = "yellow_green",
    categories = { "utility" },
    description = ccb.content.text("This table has an inset router, a rotating motor with an exchangeable blade head for cutting specific profiles and grooves.  Plugged in and ready to go."),
    broken_color = "yellow_green",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "router_tool" } },
    item = "router",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_planer",
    name = ccb.content.text("planer"),
    looks_like = "f_machinery_light",
    color = "yellow_white",
    categories = { "utility" },
    description = ccb.content.text("A hefty tool that will take in a board and cut it smooth and flat to a specific width, particularly great if working with raw lumber stock, but also good just for shaving wood down to size.  Plugged in and ready to go."),
    broken_color = "yellow_white",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "planer_tool" } },
    item = "planer",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_jointer",
    name = ccb.content.text("jointer"),
    looks_like = "f_machinery_light",
    color = "yellow_magenta",
    categories = { "utility" },
    description = ccb.content.text("A table-shaped tool with a rotating blade that will cut down, smooth out, and square off a board to make it nice and smooth.  Plugged in and ready to go."),
    broken_color = "yellow_magenta",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "jointer_tool" } },
    item = "jointer",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_catalytic_cracking_reactor",
    name = ccb.content.text("catalytic cracking reactor"),
    looks_like = "f_catalytic_cracking_reactor",
    variants = { { symbols = "Y", broken_symbols = "x" } },
    color = "light_cyan",
    categories = { "utility" },
    description = ccb.content.text("A makeshift extraction system, or as makeshift as you can consider something that was purpose-built in a laboratory by a group of experts."),
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "catalytic_cracking_reactor_tool" } },
    item = "catalytic_cracking_reactor",
    breaks_into = {
        { item = "element", count = { 4, 8 } },
        { item = "55gal_drum", count = { 3, 5 } },
        { item = "pipe", count = { 2, 5 } },
        { item = "thermometer", count = { 1, 4 } },
        { item = "well_pump", count = { 0, 1 } },
        { item = "laptop", count = { 0, 1 } },
        { item = "pump_complex", count = { 0, 3 } },
        { item = "cable", count = { 1, 3 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_hydraulic_press",
    name = ccb.content.text("hydraulic press"),
    looks_like = "f_hydraulic_press",
    color = "black_red",
    categories = { "utility" },
    description = ccb.content.text("If you really want to squash something a lot, this is exactly the right industrial tool for you.  Plugged in and ready to go."),
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "hydraulic_press_tool" } },
    item = "hydraulic_press",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "mc_steel_lump", count = { 1, 2 } },
        { item = "steel_plate", count = { 1, 2 } },
    },
    variants = { { symbols = "7", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_air_compressor",
    name = ccb.content.text("air compressor"),
    looks_like = "f_standing_tank",
    color = "black_yellow",
    categories = { "utility" },
    description = ccb.content.text("This durable tank is topped with a motor that will cram as much air into the tank as possible.  Plugged in and ready to go."),
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "air_compressor_tool" } },
    item = "air_compressor",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "steel_plate", count = { 2, 4 } },
    },
    variants = { { symbols = "7", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_heater_large",
    name = ccb.content.text("large heater"),
    item = "large_space_heater",
    flags = { "CTRL_ELECTRONIC", "ENABLED_DRAINS_EPOWER", "SPACE_HEATER", "APPLIANCE" },
    copy_from = "mountable_heater",
    requirements = { removal = { duration = "6 m" } },
}

ccb.content.define_vehicle_part {
    id = "ap_heater_small",
    name = ccb.content.text("small heater"),
    item = "small_space_heater",
    flags = { "CTRL_ELECTRONIC", "ENABLED_DRAINS_EPOWER", "SPACE_HEATER", "APPLIANCE" },
    copy_from = "mountable_heater_small",
    requirements = { removal = { duration = "6 m" } },
}

ccb.content.define_vehicle_part {
    id = "ap_electrolyzer_makeshift",
    name = ccb.content.text("makeshift water electrolyzer"),
    item = "electrolyzer_makeshift",
    description = ccb.content.text("A makeshift appliance which decomposes water into oxygen and hydrogen via electrolysis of sodium hydroxide solution, with a power cord to connect it to an electric grid."),
    categories = { "utility" },
    color = "green",
    broken_color = "green",
    damage_modifier = 10,
    damage_reduction = { all = 20 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "electrolyzer_makeshift" } },
    breaks_into = {
        { item = "mc_steel_chunk", count = { 2, 6 } },
        { item = "scrap", count = { 8, 13 } },
        { item = "glass_shard", count = { 16, 24 } },
        { item = "sheet_metal_small", count = { 4, 8 } },
        { item = "pipe", count = { 0, 1 } },
        { item = "cable", count = { 50, 100 } },
    },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_ammonia_machine_reactor",
    name = ccb.content.text("makeshift ammonia machine reactor"),
    item = "ammonia_machine_reactor",
    description = ccb.content.text("A huge appliance built from salvaged industrial equipment, which produces ammonia via the Haber-Bosch process from hydrogen and nitrogen.  It has a power cord to connect it to an electric grid."),
    categories = { "utility" },
    color = "green",
    broken_color = "green",
    damage_modifier = 10,
    damage_reduction = { all = 40 },
    durability = 400,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "ammonia_machine_reactor" } },
    breaks_into = {
        { item = "mc_steel_lump", count = { 15, 25 } },
        { item = "mc_steel_chunk", count = { 15, 25 } },
        { item = "scrap", count = { 15, 25 } },
        { item = "pyrometer", probability = 25 },
        { item = "hd_valve", count = { 0, 2 } },
        { item = "pressure_gauge", count = { 0, 1 } },
        { item = "steel_grille", count = { 6, 10 } },
        { item = "element", count = { 6, 10 } },
        { item = "cable", count = { 5, 10 } },
    },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_ammonia_machine_pipework",
    name = ccb.content.text("makeshift ammonia machine pipework"),
    item = "ammonia_machine_pipework",
    description = ccb.content.text("A rather complicated system of thick-walled pipes, powerful compressors, and wiring, meant to interface with a reactor producing ammonia from nitrogen and hydrogen via the Haber-Bosch process, with a power cord to connect it to an electric grid."),
    categories = { "utility" },
    color = "green",
    broken_color = "green",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 12,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "ammonia_machine_pipework" } },
    breaks_into = {
        { item = "mc_steel_lump", count = { 4, 8 } },
        { item = "mc_steel_chunk", count = { 4, 8 } },
        { item = "scrap", count = { 4, 8 } },
        { item = "hd_pipe", count = { 6, 10 } },
        { item = "pipe", count = { 1, 2 } },
        { item = "pipe_fittings", count = { 0, 1 } },
        { item = "hd_pipe_fittings", count = { 2, 4 } },
        { item = "hd_valve", probability = 25 },
        { item = "pressure_gauge", probability = 25 },
        { item = "power_supply", probability = 25 },
        { item = "hd_compressor", count = { 0, 2 } },
        { item = "sheet_metal_small", count = { 1, 3 } },
        { item = "pressure_gauge", count = { 0, 1 } },
        { item = "cable", count = { 34, 67 } },
    },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_nitrogen_generator",
    name = ccb.content.text("makeshift nitrogen generator"),
    item = "nitrogen_generator",
    description = ccb.content.text("A large makeshift appliance which captures nitrogen from the air for use in chemistry projects, with a power cord to connect it to an electric grid."),
    categories = { "utility" },
    color = "green",
    broken_color = "green",
    damage_modifier = 10,
    damage_reduction = { all = 20 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "nitrogen_generator" } },
    breaks_into = {
        { item = "mc_steel_lump", count = { 8, 13 } },
        { item = "mc_steel_chunk", count = { 8, 13 } },
        { item = "scrap", count = { 8, 13 } },
        { item = "sheet_cotton", count = { 5, 10 } },
        { item = "pipe", count = { 0, 1 } },
        { item = "hd_pipe", count = { 1, 2 } },
        { item = "sheet_metal_small", count = { 1, 2 } },
        { item = "hd_compressor", probability = 25 },
        { item = "nitrogen_membrane_filter", probability = 25 },
        { item = "cable", count = { 2, 3 } },
        { item = "salt", count = { 2000, 3000 }, container_item = "null" },
    },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "power_cord",
    name = ccb.content.text("power cord"),
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 120,
    description = ccb.content.text("A power cord sticking out of an appliance.  You need to plug it into a powered grid for the appliance to work properly."),
    item = "power_cord",
    flags = { "NO_INSTALL_HIDDEN", "NO_UNINSTALL", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    variants = { { symbols = "{", broken_symbols = "s" } },
}

ccb.content.define_vehicle_part {
    id = "ap_wall_light",
    name = ccb.content.text("wall light"),
    item = "wall_light",
    categories = { "lighting" },
    color = "white",
    broken_color = "blue",
    light_color = { 255, 230, 210 },
    durability = 20,
    description = ccb.content.text("A wall-mounted lamp that provides illumination when turned on."),
    epower = "-10 W",
    bonus = 200,
    damage_modifier = 10,
    looks_like = "ap_standing_directed_floodlight",
    breaks_into = {
        { item = "cable", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    flags = {
        "WALL_MOUNTED",
        "HALF_CIRCLE_LIGHT",
        "APPLIANCE",
        "ENABLED_DRAINS_EPOWER",
        "CTRL_ELECTRONIC",
        "OBSTACLE",
    },
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "*", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "ap_standing_lamp",
    name = ccb.content.text("standing lamp"),
    item = "standing_lamp",
    categories = { "lighting" },
    color = "white",
    broken_color = "blue",
    light_color = { 255, 230, 210 },
    durability = 20,
    description = ccb.content.text("A tall floor lamp that provides illumination when turned on."),
    epower = "-10 W",
    bonus = 200,
    damage_modifier = 10,
    looks_like = "f_floor_lamp",
    breaks_into = {
        { item = "cable", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    flags = { "CIRCLE_LIGHT", "APPLIANCE", "ENABLED_DRAINS_EPOWER", "CTRL_ELECTRONIC" },
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "*", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "ap_exodii_lamp",
    name = ccb.content.text("scavenged utility light"),
    item = "exodii_lamp",
    categories = { "lighting" },
    color = "light_gray",
    broken_color = "red",
    light_color = { 220, 255, 200 },
    durability = 20,
    description = ccb.content.text("The bulbs emit an eerie greenish glow, and some parts of it have a curved appearance as though the metal were grown in a lab, but by and large this isn't a particularly unusual looking area light."),
    epower = "-100 W",
    bonus = 200,
    damage_modifier = 10,
    looks_like = "f_exodii_lamp",
    breaks_into = {
        { item = "scrap", count = { 8, 12 } },
        { item = "pipe", count = { 0, 3 } },
        { item = "sheet_metal_small", count = { 2, 10 } },
        { item = "scrap_copper", count = { 2, 12 } },
        { item = "amplifier", count = { 0, 5 } },
        { item = "power_supply", count = { 0, 1 } },
        { item = "cable", count = { 0, 2 } },
    },
    flags = { "CIRCLE_LIGHT", "APPLIANCE", "ENABLED_DRAINS_EPOWER", "CTRL_ELECTRONIC" },
    requirements = { removal = { duration = "5 s" } },
    variants = { { symbols = "T", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "ap_nl_exodii_lamp",
    name = ccb.content.text("strange utility light"),
    item = "nl_exodii_lamp",
    looks_like = "f_nl_exodii_lamp",
    description = ccb.content.text("Parts of this utility light have a curved appearance, as though the metal were grown in a lab.  The round bulb emits an eerie greenish glow."),
    copy_from = "ap_exodii_lamp",
}

ccb.content.define_vehicle_part {
    id = "ap_standing_floodlight",
    name = ccb.content.text("standing floodlight"),
    item = "standing_floodlight",
    description = ccb.content.text("A large, heavy light that illuminates a wide area around it when switched on."),
    flags = { "CIRCLE_LIGHT", "ENABLED_DRAINS_EPOWER", "APPLIANCE", "CTRL_ELECTRONIC" },
    copy_from = "floodlight",
    requirements = { removal = { duration = "5 s" } },
}

ccb.content.define_vehicle_part {
    id = "ap_standing_directed_floodlight",
    name = ccb.content.text("standing directed floodlight"),
    item = "standing_directed_floodlight",
    description = ccb.content.text("A large, heavy light that illuminates a wide semicircle around it when switched on."),
    copy_from = "directed_floodlight",
    flags = { "HALF_CIRCLE_LIGHT", "ENABLED_DRAINS_EPOWER", "APPLIANCE", "CTRL_ELECTRONIC" },
    requirements = { removal = { duration = "5 s" } },
}

ccb.content.define_vehicle_part {
    id = "ap_wall_wiring",
    name = ccb.content.text("wall wirings"),
    item = "wall_wiring",
    categories = { "other" },
    color = "white",
    broken_color = "red",
    durability = 20,
    description = ccb.content.text("Electric wires embedded in the wall."),
    flags = { "APPLIANCE", "OBSTACLE", "WALL_MOUNTED", "WIRING" },
    variants = { { symbols = "_", broken_symbols = "/" } },
}

ccb.content.define_vehicle_part {
    id = "ap_folding_solar_panel",
    name = ccb.content.text("deployed folding solar panel"),
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("This folding solar panel has been unfolded, and it is ready to charge connected devices, if the sun is out."),
    copy_from = "solar_panel",
    color = "light_blue",
    broken_color = "light_gray",
    proportional = { durability = 0.5 },
    epower = "120 W",
    requirements = { install = {}, removal = { duration = "5 s" } },
    breaks_into = { { item = "folding_solar_panel", damage = { 5, 5 } } },
    remove_as = "folding_solar_panel",
    item = "folding_solar_panel_deployed",
}

ccb.content.define_vehicle_part {
    id = "ap_folding_solar_panel_v2",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    name = ccb.content.text("deployed solar suitcase"),
    description = ccb.content.text("This solar suitcase has been unpacked and is ready to supply power."),
    copy_from = "ap_folding_solar_panel",
    epower = "200 W",
    breaks_into = { { item = "folding_solar_panel_v2", damage = { 5, 5 } } },
    requirements = { removal = { duration = "1 m" } },
    remove_as = "folding_solar_panel_v2",
    item = "folding_solar_panel_v2_deployed",
}

ccb.content.define_vehicle_part {
    id = "ap_solar_panel",
    name = ccb.content.text("small solar panel"),
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A small solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "solar_panel",
    proportional = { epower = 1.2 },
    requirements = {
        install = {},
        removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

-- 4 times the panels, 1.2x matching the above appliance
ccb.content.define_vehicle_part {
    id = "ap_ground_solar_panel",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A solar panel, mounted on a frame and ready to power other appliances."),
    item = "ground_solar_panel",
    copy_from = "solar_panel",
    proportional = { epower = 4.8 },
    requirements = {
        install = {},
        removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } },
        repair = {
            skills = { { "electronics", 6 } },
            duration = "120 m",
            using_requirements = { { "vehicle_screw", 1 }, { "solar_panel", 4 }, { "soldering_standard", 8 } },
        },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 8, 32 } },
        { item = "mc_steel_chunk", count = { 8, 32 } },
        { item = "scrap", count = { 8, 32 } },
        { item = "solar_cell", count = { 4, 16 } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_reinforced_solar_panel",
    color = "yellow",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A reinforced solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "reinforced_solar_panel",
    proportional = { epower = 1.2 },
    requirements = { removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } } },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_solar_panel_v2",
    name = ccb.content.text("small advanced solar panel"),
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A  small, high-performance solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "solar_panel_v2",
    proportional = { epower = 1.2 },
    requirements = { removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } } },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

-- 4 times from 4 more panels, 1.2 times as is done above
ccb.content.define_vehicle_part {
    id = "ap_ground_solar_panel_v2",
    copy_from = "solar_panel_v2",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    item = "ground_solar_panel_v2",
    proportional = { epower = 4.8 },
    requirements = {
        install = {},
        removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } },
        repair = {
            skills = { { "electronics", 8 } },
            duration = "150 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v2", 4 },
                { "soldering_standard", 64 },
            },
        },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 8, 16 } },
        { item = "mc_steel_chunk", count = { 8, 16 } },
        { item = "scrap", count = { 8, 16 } },
        { item = "solar_cell_v2", count = { 4, 24 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_reinforced_solar_panel_v2",
    color = "yellow",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A high-performance reinforced solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "reinforced_solar_panel_v2",
    proportional = { epower = 1.2 },
    requirements = { removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_1", 1 } } } },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_wind_turbine",
    location = "structure",
    flags = { "WIND_TURBINE", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A mounted wind turbine, ready to power other appliances."),
    copy_from = "wind_turbine",
    requirements = { removal = { duration = "15 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "T", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "ap_xl_wind_turbine",
    location = "structure",
    flags = { "WIND_TURBINE", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A large mounted wind turbine, ready to power other appliances."),
    copy_from = "xl_wind_turbine",
    requirements = { removal = { duration = "15 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "Y", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "ap_water_wheel",
    location = "structure",
    flags = { "WATER_WHEEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A mounted water wheel, ready to power other appliances."),
    copy_from = "water_wheel",
    requirements = { removal = { duration = "15 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "x", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_xl_water_wheel",
    location = "structure",
    flags = { "WATER_WHEEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A mounted large water wheel, ready to power other appliances."),
    copy_from = "xl_water_wheel",
    requirements = { removal = { duration = "15 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "x", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_small",
    name = ccb.content.text("small grid battery"),
    color = "white",
    flags = { "APPLIANCE" },
    description = ccb.content.text("A small battery to store electrical power in a static power grid."),
    copy_from = "small_storage_battery",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "b", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_medium",
    name = ccb.content.text("medium grid battery"),
    flags = { "APPLIANCE" },
    description = ccb.content.text("A medium battery to store electrical power in a static power grid."),
    copy_from = "medium_storage_battery",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery",
    name = ccb.content.text("large grid battery"),
    color = "light_red",
    flags = { "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A large battery to store electrical power in a static power grid."),
    copy_from = "storage_battery",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_large",
    name = ccb.content.text("very large grid battery"),
    color = "red",
    flags = { "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A very large battery to store electrical power in a static power grid."),
    copy_from = "large_storage_battery",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_car",
    name = ccb.content.text("car grid battery"),
    categories = { "energy" },
    looks_like = "battery_car",
    color = "red",
    flags = { "APPLIANCE" },
    description = ccb.content.text("A car battery wired into a static power grid."),
    item = "battery_car",
    breaks_into = {
        { item = "lead", count = { 1680, 2380 } },
        { item = "chem_sulphuric_acid", count = { 5, 8 }, container_item = "null" },
        { item = "plastic_chunk", count = { 14, 20 } },
        { item = "scrap", count = { 2, 3 } },
        { item = "shredded_rubber", count = { 10, 14 } },
    },
    durability = 120,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_motorbike",
    name = ccb.content.text("motorbike grid battery"),
    categories = { "energy" },
    looks_like = "battery_motorbike",
    color = "red",
    flags = { "APPLIANCE" },
    description = ccb.content.text("A motorbike battery wired into a static power grid."),
    item = "battery_motorbike",
    breaks_into = {
        { item = "lead", count = { 252, 357 } },
        { item = "chem_sulphuric_acid", count = { 0, 1 }, container_item = "null" },
        { item = "plastic_chunk", count = { 2, 3 } },
        { item = "scrap", count = { 0, 1 } },
        { item = "shredded_rubber", count = { 1, 2 } },
    },
    durability = 100,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_motorbike_small",
    name = ccb.content.text("small motorbike grid battery"),
    categories = { "energy" },
    looks_like = "battery_motorbike_small",
    color = "red",
    flags = { "APPLIANCE" },
    description = ccb.content.text("A small motorbike battery wired into a static power grid."),
    item = "battery_motorbike_small",
    breaks_into = {
        { item = "lead", count = { 126, 178 } },
        { item = "chem_sulphuric_acid", count = { 0, 1 }, container_item = "null" },
        { item = "plastic_chunk" },
        { item = "scrap", count = { 0, 1 } },
        { item = "shredded_rubber", count = { 0, 1 } },
    },
    durability = 30,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_washing_machine",
    looks_like = "f_washer",
    flags = { "OBSTACLE", "APPLIANCE", "WASHING_MACHINE", "CARGO", "COVERED", "ENABLED_DRAINS_EPOWER" },
    description = ccb.content.text("An appliance used to clean laundry, plugged into a power supply and using internal water tanks."),
    size = "135 L",
    copy_from = "washing_machine",
    item = "household_washing_machine",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "W", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_dishwasher",
    name = ccb.content.text("dishwasher"),
    looks_like = "f_dishwasher",
    flags = { "OBSTACLE", "APPLIANCE", "DISHWASHER", "CARGO", "COVERED", "ENABLED_DRAINS_EPOWER" },
    description = ccb.content.text("An appliance used to clean dishes, plugged into a power supply and using internal tanks."),
    size = "120 L",
    copy_from = "dishwasher",
    item = "household_dishwasher",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "D", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_autoclave",
    name = ccb.content.text("small autoclave"),
    looks_like = "f_autoclave",
    color = "light_blue",
    flags = { "OBSTACLE", "APPLIANCE", "AUTOCLAVE", "CARGO", "COVERED", "ENABLED_DRAINS_EPOWER" },
    description = ccb.content.text("An autoclave that can steam its contents at high enough temperatures to completely sterilize them, killing any possible contaminants.  This one is plugged into a power grid and running off internal water tanks."),
    copy_from = "autoclave",
    item = "autoclave",
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "D", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_foot_locker_recharge_station",
    name = ccb.content.text("foot locker recharging station"),
    categories = { "cargo" },
    color = "light_green",
    broken_color = "blue",
    damage_modifier = 10,
    durability = 40,
    description = ccb.content.text("A universal recharging station integrated into a steel storage compartment.  When turned on, it will steadily charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space."),
    bonus = 600,
    size = "200 L",
    item = "foot_locker_recharge_station",
    flags = { "CARGO", "OBSTACLE", "RECHARGE", "COVERED", "APPLIANCE", "CTRL_ELECTRONIC" },
    breaks_into = {
        { item = "cable", count = { 1, 2 } },
        { item = "mc_steel_lump", count = { 4, 6 } },
        { item = "mc_steel_chunk", count = { 4, 8 } },
        { item = "scrap", count = { 5, 7 } },
    },
    damage_reduction = { all = 10 },
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_box_battery_charger",
    name = ccb.content.text("box battery charger"),
    categories = { "cargo" },
    color = "light_green",
    broken_color = "blue",
    damage_modifier = 10,
    durability = 20,
    description = ccb.content.text("A small device for recharging batteries integrated into a small wooden storage compartment.  When turned on, it will slowly charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space."),
    bonus = 15,
    size = "50 L",
    item = "box_battery_charger",
    flags = { "CARGO", "OBSTACLE", "RECHARGE", "COVERED", "APPLIANCE", "CTRL_ELECTRONIC" },
    breaks_into = {
        { item = "splinter", count = { 3, 5 } },
        { item = "nail", charges = { 10, 15 } },
        { item = "plastic_chunk", probability = 50 },
        { item = "cable", count = { 1, 2 } },
        { item = "e_scrap", count = { 0, 2 } },
        { item = "scrap", count = { 1, 3 } },
    },
    damage_reduction = { all = 5 },
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_compact_ASRG_containment",
    name = ccb.content.text("advanced Stirling radioisotope generator"),
    looks_like = "f_compact_ASRG_containment",
    categories = { "energy" },
    color = "green_white",
    broken_color = "blue",
    location = "structure",
    damage_modifier = 80,
    durability = 400,
    description = ccb.content.text("A rather heavy brick of metal housing an ASRG, formerly designed by NASA and repurposed for terrestrial use.  Will provide about 130 W, basically forever as far as you're concerned.  Even though the alpha radiation these run off of isn't very dangerous in case of a breach, this unit appears to be armored to take a beating and is a good deal heavier owing to its composite plating."),
    epower = "130 W",
    item = "compact_ASRG_containment",
    requirements = {
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 5 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "OBSTACLE", "RADIOACTIVE", "COVERED", "APPLIANCE", "PERPETUAL", "REACTOR" },
    breaks_into = {
        { item = "scrap", count = { 4, 16 } },
        { item = "mc_steel_chunk", count = { 1, 6 } },
        { item = "plutonium", count = { 0, 2 } },
        { item = "lead", count = { 12, 18 } },
    },
    damage_reduction = { all = 60 },
    variants = { { symbols = "0", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "app_microwave",
    name = ccb.content.text("grid microwave"),
    looks_like = "microwave",
    item = "microwave",
    description = ccb.content.text("A microwave connected to a power grid, ready to cook some food."),
    categories = { "utility" },
    location = "center",
    color = "green",
    broken_color = "blue",
    damage_modifier = 10,
    damage_reduction = { all = 5 },
    durability = 25,
    flags = { "APPLIANCE", "CARGO" },
    requirements = {
        repair = {
            skills = { { "mechanics", 3 }, { "electronics", 2 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
        removal = { duration = "1 m" },
    },
    pseudo_tools = { { id = "microwave" } },
    size = "5 L",
    breaks_into = {
        { item = "plastic_chunk", count = { 4, 7 } },
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "sheet_metal_small", count = { 4, 8 } },
        { item = "scrap", count = { 4, 7 } },
        { item = "element", count = { 0, 2 } },
        { item = "glass_shard", probability = 50 },
        { item = "motor_micro", probability = 25 },
    },
    variants = { { symbols = "Y", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_oxygen_concentrator",
    name = ccb.content.text("oxygen concentrator"),
    categories = { "utility" },
    broken_color = "dark_gray",
    damage_modifier = 35,
    durability = 100,
    description = ccb.content.text("A machine capable of generating pure oxygen from the air.  It has been plugged into a power grid."),
    item = "oxygen_concentrator",
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "pseudo_app_oxygen_concentrator", hotkey = "h" } },
    breaks_into = {
        { item = "plastic_chunk", count = { 4, 8 } },
        { item = "scrap", count = { 4, 8 } },
        { item = "mc_steel_chunk", count = { 5, 10 } },
    },
    damage_reduction = { all = 40 },
    variants = { { symbols = "&", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_hd_compressor_unit",
    name = ccb.content.text("high pressure compressor unit"),
    categories = { "utility" },
    broken_color = "dark_gray",
    damage_modifier = 45,
    durability = 150,
    description = ccb.content.text("A machine designed to compress an input gas to a very high pressure.  It has been plugged into a power grid."),
    item = "hd_compressor_unit",
    flags = { "OBSTACLE", "COVERED", "APPLIANCE" },
    pseudo_tools = { { id = "pseudo_app_hd_compressor_unit", hotkey = "h" } },
    breaks_into = {
        { item = "plastic_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 6, 12 } },
        { item = "mc_steel_chunk", count = { 8, 16 } },
        { item = "sheet_metal_small", count = { 1, 4 } },
    },
    damage_reduction = { all = 50 },
    variants = { { symbols = "&", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_glassblowers_crucible",
    name = ccb.content.text("glassblower's crucible"),
    color = "brown",
    categories = { "utility" },
    description = ccb.content.text("An electric crucible, powered by your electric grid.  Designed for melting large quantities of glass for batch crafting and production of large items, it needs to be placed and plugged into a power source."),
    broken_color = "yellow_red",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "glassblowers_crucible_tool" } },
    item = "glassblowers_crucible",
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 8, 12 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "ceramic_shard", count = { 21, 42 } },
        { item = "rock", count = { 6, 12 } },
    },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_lathe",
    categories = { "utility" },
    name = ccb.content.text("lathe"),
    description = ccb.content.text("An industrial-grade lathe, for turning chunks of metal and other hard things into round chunks of metal and other hard things."),
    looks_like = "f_heavy_lathe",
    variants = { { symbols = "4", broken_symbols = "#" } },
    color = "cyan_red",
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "fake_lathe" } },
    item = "lathe",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 12, 20 } },
        { item = "chunk_cast_iron", count = { 2, 4 } },
        { item = "lump_cast_iron", count = { 1, 2 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_mill",
    categories = { "utility" },
    name = ccb.content.text("vertical mill"),
    description = ccb.content.text("A machinist's one knee vertical mill, commonly known as a Bridgeport.  Used to shape blocks of metal into various parts."),
    looks_like = "f_machinery_light",
    variants = { { symbols = "M", broken_symbols = "#" } },
    color = "cyan_red",
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "fake_mill_vertical" } },
    item = "mill_vertical",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "scrap", count = { 12, 20 } },
        { item = "chunk_cast_iron", count = { 2, 4 } },
        { item = "lump_cast_iron", count = { 1, 2 } },
        { item = "motor_small", count = { 0, 1 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_deep_fryer",
    categories = { "utility" },
    name = ccb.content.text("deep fryer"),
    description = ccb.content.text("An industrial deep fryer, for frying huge batches of food at once."),
    looks_like = "f_oven",
    variants = { { symbols = "h", broken_symbols = "#" } },
    broken_color = "dark_gray_white",
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "fake_deep_fryer" } },
    item = "deep_fryer",
    damage_modifier = 10,
    damage_reduction = { all = 20 },
    durability = 60,
    breaks_into = {
        { item = "sheet_metal", count = { 1, 2 } },
        { item = "sheet_metal_small", count = { 4, 6 } },
        { item = "lc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 0, 3 } },
        { item = "element", count = { 1, 2 } },
        { item = "cable", count = { 1, 2 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_oil_press_industrial",
    categories = { "utility" },
    name = ccb.content.text("industrial oil press"),
    description = ccb.content.text("A heavy-duty press used to create vegetable oil from nuts or seeds."),
    looks_like = "f_machinery_light",
    variants = { { symbols = "Y", broken_symbols = "#" } },
    color = "green",
    flags = { "OBSTACLE", "APPLIANCE" },
    pseudo_tools = { { id = "fake_oil_press_industrial" } },
    item = "oil_press_electric",
    damage_modifier = 10,
    damage_reduction = { all = 30 },
    durability = 80,
    breaks_into = {
        { item = "funnel", count = { 0, 1 } },
        { item = "frame", count = { 0, 1 } },
        { item = "sheet_metal", count = { 0, 2 } },
        { item = "element", count = { 0, 2 } },
        { item = "crude_heating_element", count = { 0, 3 } },
        { item = "motor_tiny", count = { 0, 1 } },
        { item = "cable", count = { 0, 4 } },
        { item = "power_supply", count = { 0, 1 } },
        { item = "pipe_fittings", count = { 0, 2 } },
        { item = "pipe", count = { 0, 2 } },
        { item = "wire_mesh", count = { 0, 1 } },
        { item = "metal_tank_little", count = { 0, 1 } },
    },
}

ccb.content.define_vehicle_part {
    id = "ap_mobile_weather_station",
    copy_from = "veh_mobile_weather_station",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_xedra_mobile_weather_station",
    copy_from = "veh_xedra_mobile_weather_station",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_robofac_mobile_weather_station",
    copy_from = "veh_robofac_mobile_weather_station",
    extend = { flags = { "APPLIANCE" } },
}

ccb.content.define_vehicle_part {
    id = "ap_nl_safehouse_boiler",
    categories = { "energy" },
    name = ccb.content.text("otherworldly boiler"),
    item = "nl_safehouse_boiler",
    color = "red",
    broken_color = "light_gray",
    durability = 60,
    description = ccb.content.text("A huge, pot-bellied device that resembles something between a coal-burning stove and a boiler, with a wide, hinged cage covering the combustion chamber.  Three unmarked gauges sit like alien eyes upon its face.  A side-mounted crank is its only visible control.  In defiance of its apparent function, it has no exhaust vent; in its place is a hose twisted on itself several times, coiled in copper, and terminating in a bulbous back-mounted battery pack."),
    breaks_into = {
        { item = "scrap", count = { 8, 12 } },
        { item = "pipe", count = { 0, 3 } },
        { item = "sheet_metal_small", count = { 2, 10 } },
        { item = "scrap_copper", count = { 2, 12 } },
        { item = "amplifier", count = { 0, 5 } },
        { item = "power_supply", count = { 0, 1 } },
        { item = "cable", count = { 0, 2 } },
    },
    flags = { "APPLIANCE", "NL_BOILER", "CTRL_ELECTRONIC", "CARGO", "OBSTACLE" },
    size = "200 L",
    requirements = { removal = { duration = "5 s" } },
    variants = { { symbols = "&", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "app_electric_cooker",
    name = ccb.content.text("electric cooker"),
    item = "electric_cooker",
    categories = { "utility" },
    location = "center",
    description = ccb.content.text("An electric cooker connected to a power grid.  Place raw food inside and activate it to automatically cook meals."),
    color = "dark_gray",
    broken_color = "light_gray",
    durability = 40,
    damage_modifier = 10,
    damage_reduction = { all = 5 },
    flags = { "APPLIANCE", "CARGO", "COVERED", "OBSTACLE", "AUTO_COOKER", "ENABLED_DRAINS_EPOWER" },
    size = "20 L",
    epower = "-750 W",
    requirements = {
        repair = {
            skills = { { "mechanics", 2 }, { "electronics", 1 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 2 }, { "soldering_standard", 3 } },
        },
        removal = { duration = "1 m" },
    },
    breaks_into = {
        { item = "plastic_chunk", count = { 2, 5 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "sheet_metal_small", count = { 2, 6 } },
        { item = "scrap", count = { 2, 5 } },
        { item = "element", count = { 0, 1 } },
        { item = "cable", count = { 1, 2 } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_bulk_liquid_tank",
    name = ccb.content.text("bulk liquid tank"),
    looks_like = "f_storage_tank",
    categories = { "utility" },
    color = "light_gray",
    broken_color = "dark_gray",
    location = "structure",
    damage_modifier = 80,
    durability = 400,
    description = ccb.content.text("A stationary bank of interconnected steel tanks holding up to 600 liters of liquid.  Its electric heater can be switched on to keep the contents from freezing, while attached plumbing equipment can provide convenient access or purification."),
    item = "bulk_liquid_tank",
    epower = "-200 W",
    flags = { "APPLIANCE", "FLUIDTANK", "HEATED_TANK", "ENABLED_DRAINS_EPOWER", "OBSTACLE", "VEH_TOOLS" },
    allowed_tools = { "water_faucet", "water_purifier" },
    requirements = {
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "repair_welding_standard", 10 } },
        },
    },
    breaks_into = {
        { item = "metal_tank", count = { 4, 8 }, damage = 4 },
        { item = "nuts_bolts", count = { 5, 15 } },
    },
    damage_reduction = { all = 30, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}
