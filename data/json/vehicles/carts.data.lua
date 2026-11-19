local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "engine_crane",
    name = ccb.content.text("Engine Crane"),
    blueprint = { "#" },
    mounts = { { x = 0, y = 0, parts = { "folding_frame", "wheel_10", "crane_small" } } },
}

ccb.content.define_vehicle {
    id = "food_cart",
    name = ccb.content.text("Food Vendor Cart"),
    blueprint = { { "&" }, { "H" } },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#cross", "wheel_10", "big_portable_fridge" } },
        { x = 0, y = 0, parts = { "controls_electronic" } },
        { x = -1, y = 0, parts = { "xlframe#cross", "wheel_10" } },
        { x = -1, y = 0, parts = { "small_storage_battery" } },
        { x = -1, y = 0, parts = { { part = "veh_tools_kitchen", tools = { "hotplate", "pan", "pot" } } } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 100, item_groups = { "food_vendor_cart_kitchen" } },
        { x = 0, y = 0, chance = 100, item_groups = { "food_vendor_cart_fridge" } },
    },
}

-- 2
-- 2
ccb.content.define_vehicle {
    id = "golf_cart",
    name = ccb.content.text("Golf Cart"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_T_left", "seat_back#left", "roof", "engine_electric" } },
        { x = 0, y = 0, parts = { "controls" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat_back#right", "roof" } },
        { x = 0, y = 1, parts = { "storage_battery" } },
        { x = 1, y = 0, parts = { "frame#nw", "halfboard#nw", "wheel_mount_light_steerable" } },
        { x = 1, y = 0, parts = { "wheel_small" } },
        { x = 1, y = 1, parts = { "frame#ne", "halfboard#ne", "wheel_mount_light_steerable" } },
        { x = 1, y = 1, parts = { "wheel_small" } },
        { x = -1, y = 0, parts = { "frame#sw", "box", "wheel_mount_light", "wheel_small" } },
        { x = -1, y = 1, parts = { "frame#se", "box", "wheel_mount_light", "wheel_small" } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 25, item_groups = { "golf_cart" } },
        { x = -1, y = 1, chance = 25, item_groups = { "golf_cart" } },
    },
}

-- 2
-- 2
ccb.content.define_vehicle {
    id = "golf_cart_4seat",
    name = ccb.content.text("Golf Cart"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_T_left", "seat_back#left", "roof", "engine_electric" } },
        { x = 0, y = 0, parts = { "controls" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat_back#right", "roof" } },
        { x = 0, y = 1, parts = { "storage_battery" } },
        { x = 1, y = 0, parts = { "frame#nw", "halfboard#nw", "wheel_mount_light_steerable" } },
        { x = 1, y = 0, parts = { "wheel_small" } },
        { x = 1, y = 1, parts = { "frame#ne", "halfboard#ne", "wheel_mount_light_steerable" } },
        { x = 1, y = 1, parts = { "wheel_small" } },
        { x = -1, y = 0, parts = { "frame#sw", "roof", "seat_back#left", "wheel_mount_light" } },
        { x = -1, y = 0, parts = { "wheel_small" } },
        { x = -1, y = 1, parts = { "frame#se", "roof", "seat_back#right", "wheel_mount_light" } },
        { x = -1, y = 1, parts = { "wheel_small" } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 20, item_groups = { "golf_cart" } },
        { x = -1, y = 1, chance = 20, item_groups = { "golf_cart" } },
        { x = 0, y = 0, chance = 20, item_groups = { "golf_cart" } },
        { x = 0, y = 1, chance = 20, item_groups = { "golf_cart" } },
    },
}

ccb.content.define_vehicle {
    id = "handjack",
    name = ccb.content.text("Handjack"),
    blueprint = { "=" },
    mounts = { { x = 0, y = 0, parts = { "frame_handle", "wheel_10", "crane_small" } } },
}

ccb.content.define_vehicle {
    id = "hand_truck",
    name = ccb.content.text("Hand Truck"),
    blueprint = { "L" },
    mounts = { { x = 0, y = 0, parts = { "foldxlframe", "wheel_10", "nose_plate" } } },
}

ccb.content.define_vehicle {
    id = "ice_cream_cart",
    name = ccb.content.text("Ice Cream Cart"),
    blueprint = { "#" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_10", "small_storage_battery" } },
        { x = 0, y = 0, parts = { "chest_minifreezer", "controls_electronic" } },
    },
}

ccb.content.define_vehicle {
    id = "luggage_cart",
    name = ccb.content.text("Luggage Cart"),
    blueprint = { "H" },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster", "trunk" } } },
    item_spawns = {
        {
            x = 0,
            y = 0,
            chance = 6,
            item_groups = { "bags_trip", "jackets", "shirts", "male_underwear_bottom", "male_underwear" },
        },
        {
            x = 0,
            y = 0,
            chance = 6,
            item_groups = {
                "bags_trip",
                "beauty",
                "dresses",
                "dresses",
                "female_underwear_bottom",
                "female_underwear_top",
                "female_underwear",
            },
        },
        {
            x = 0,
            y = 0,
            chance = 3,
            item_groups = { "bags_trip", "jackets", "shirts", "child_items", "underwear" },
        },
        {
            x = 0,
            y = 0,
            chance = 2,
            item_groups = { "bags_trip", "traveler", "dresser", "glasses", "shoes", "underwear" },
        },
    },
}

ccb.content.define_vehicle {
    id = "shopping_cart",
    name = ccb.content.text("Shopping Cart"),
    blueprint = { "o" },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster_large", "basketlg#cart" } } },
    item_spawns = { { x = 0, y = 0, chance = 35, item_groups = { "SUS_trash_floor_light" } } },
}

ccb.content.define_vehicle {
    id = "rolling_trash_can",
    name = ccb.content.text("Rolling Trash Can"),
    blueprint = { { "o" } },
    mounts = { { x = 0, y = 0, parts = { "xlframe", "wheel_caster_large", "integrated_trashcan" } } },
    item_spawns = { { x = 0, y = 0, chance = 100, item_groups = { "SUS_trash_rolling_trashcan" } } },
}

ccb.content.define_vehicle {
    id = "grocery_cart",
    name = ccb.content.text("Grocery Cart"),
    blueprint = { { "o" }, { "-" } },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster_large", "basketlg#cart" } },
        { x = -1, y = 0, parts = { "cart_handle" } },
    },
    item_spawns = { { x = 0, y = 0, chance = 35, item_groups = { "SUS_trash_floor_light" } } },
}

ccb.content.define_vehicle {
    id = "swivel_chair",
    name = ccb.content.text("Swivel Chair"),
    blueprint = { "#" },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster", "seat#swivel_chair_front" } } },
}

ccb.content.define_vehicle {
    id = "water_cart",
    name = ccb.content.text("Water Cart"),
    blueprint = { "o" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster" } },
        { x = 0, y = 0, parts = { { part = "tank_small", fuel = "water_clean" } } },
        { x = 0, y = 0, parts = { "water_faucet", "basketsm" } },
    },
    item_spawns = {
        { x = 0, y = 0, chance = 15, items = { "whistle" } },
        { x = 0, y = 0, chance = 25, items = { "sports_drink" } },
        { x = 0, y = 0, chance = 25, items = { "sports_drink" } },
        { x = 0, y = 0, chance = 25, items = { "sports_drink" } },
        { x = 0, y = 0, chance = 25, items = { "towel" } },
        { x = 0, y = 0, chance = 25, items = { "towel" } },
        { x = 0, y = 0, chance = 25, items = { "towel" } },
        { x = 0, y = 0, chance = 15, items = { "heatpack" } },
        { x = 0, y = 0, chance = 15, items = { "heatpack" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, items = { "bandages" } },
        { x = 0, y = 0, chance = 15, item_groups = { "used_1st_aid" } },
        { x = 0, y = 0, chance = 15, item_groups = { "used_1st_aid" } },
        { x = 0, y = 0, chance = 15, items = { "mouthpiece" } },
        { x = 0, y = 0, chance = 15, items = { "mouthpiece" } },
        { x = 0, y = 0, chance = 15, items = { "arm_splint" } },
        { x = 0, y = 0, chance = 15, items = { "leg_splint" } },
        { x = 0, y = 0, chance = 15, items = { "football" } },
        { x = 0, y = 0, chance = 15, items = { "football" } },
        { x = 0, y = 0, chance = 15, items = { "football" } },
        { x = 0, y = 0, chance = 15, items = { "football_armor" } },
        { x = 0, y = 0, chance = 15, items = { "helmet_football" } },
    },
}

ccb.content.define_vehicle {
    id = "welding_cart",
    name = ccb.content.text("Welding Cart"),
    blueprint = { "&" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster_large", "small_storage_battery" } },
        { x = 0, y = 0, parts = { { part = "veh_tools_workshop", tools = { "welder", "soldering_iron" } } } },
    },
    item_spawns = { { x = 0, y = 0, chance = 30, items = { "goggles_welding" } } },
}

ccb.content.define_vehicle {
    id = "wheelbarrow",
    name = ccb.content.text("Wheelbarrow"),
    blueprint = { "o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame_handle", "wheel_mount_light", "wheel_barrow" } },
        { x = 0, y = 0, parts = { "box#wheelbarrow" } },
    },
}

ccb.content.define_vehicle {
    id = "wheelchair",
    name = ccb.content.text("Foldable wheelchair"),
    blueprint = { "#" },
    mounts = {
        { x = 0, y = 0, parts = { "folding_frame", "folding_seat", "wheel_mount_light" } },
        { x = 0, y = 0, parts = { "wheel_wheelchair", "hand_rims", "basketsm#wheelchair" } },
    },
}

ccb.content.define_vehicle {
    id = "hospital_bed",
    name = ccb.content.text("hospital bed"),
    blueprint = { { "x" }, { "o" } },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_10", "bed" } },
        { x = -1, y = 0, parts = { "xlframe#vertical_2", "wheel_10", "bed" } },
    },
    item_spawns = {
        { x = 0, y = 0, chance = 70, item_groups = { "hospital_bed" } },
        { x = -1, y = 0, chance = 70, item_groups = { "hospital_bed" } },
    },
}

ccb.content.define_vehicle {
    id = "laundry_cart",
    name = ccb.content.text("Laundry Cart"),
    blueprint = { "o" },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster", "basketlg#cart" } } },
    item_spawns = {
        { x = 0, y = 0, chance = 40, item_groups = { "shirts" } },
        { x = 0, y = 0, chance = 40, item_groups = { "pants" } },
        { x = 0, y = 0, chance = 20, item_groups = { "underwear" } },
    },
}

-- 2
-- 2
ccb.content.define_vehicle {
    id = "cart_livestock_stall",
    name = ccb.content.text("Large Animal Transport Cart"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_T_left", "seat", "roof", "engine_electric" } },
        { x = 0, y = 0, parts = { "controls" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat", "roof" } },
        { x = 0, y = 1, parts = { "storage_battery" } },
        { x = 1, y = 0, parts = { "frame#nw", "halfboard#nw", "wheel_mount_light_steerable" } },
        { x = 1, y = 0, parts = { "wheel_small" } },
        { x = 1, y = 1, parts = { "frame#ne", "halfboard#ne", "wheel_mount_light_steerable" } },
        { x = 1, y = 1, parts = { "wheel_small" } },
        { x = -1, y = 0, parts = { "frame#sw", "livestock_stall", "wheel_mount_light", "wheel_small" } },
        { x = -1, y = 1, parts = { "frame#se", "livestock_stall", "wheel_mount_light", "wheel_small" } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 25, item_groups = { "snacks" } },
        { x = -1, y = 1, chance = 25, item_groups = { "snacks" } },
    },
}

-- 2
-- 2
ccb.content.define_vehicle {
    id = "cart_animal_compartment",
    name = ccb.content.text("Animal Transport Cart"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_T_left", "seat", "roof", "engine_electric" } },
        { x = 0, y = 0, parts = { "controls" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat", "roof" } },
        { x = 0, y = 1, parts = { "storage_battery" } },
        { x = 1, y = 0, parts = { "frame#nw", "halfboard#nw", "wheel_mount_light_steerable" } },
        { x = 1, y = 0, parts = { "wheel_small" } },
        { x = 1, y = 1, parts = { "frame#ne", "halfboard#ne", "wheel_mount_light_steerable" } },
        { x = 1, y = 1, parts = { "wheel_small" } },
        { x = -1, y = 0, parts = { "frame#sw", "animal_compartment", "wheel_mount_light", "wheel_small" } },
        { x = -1, y = 1, parts = { "frame#se", "animal_compartment", "wheel_mount_light", "wheel_small" } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 25, item_groups = { "snacks" } },
        { x = -1, y = 1, chance = 25, item_groups = { "snacks" } },
    },
}

ccb.content.define_vehicle {
    id = "cart_chassis",
    name = ccb.content.text("Cart Chassis"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_left" } },
        { x = 0, y = 1, parts = { "frame#vertical_right" } },
        { x = 1, y = 0, parts = { "frame#nw", "wheel_mount_light_steerable" } },
        { x = 1, y = 0, parts = { "wheel_small" } },
        { x = 1, y = 1, parts = { "frame#ne", "wheel_mount_light_steerable" } },
        { x = 1, y = 1, parts = { "wheel_small" } },
        { x = -1, y = 0, parts = { "frame#sw", "wheel_mount_light", "wheel_small" } },
        { x = -1, y = 1, parts = { "frame#se", "wheel_mount_light", "wheel_small" } },
    },
}

ccb.content.define_vehicle {
    id = "cart_chassis_2",
    name = ccb.content.text("Cart Chassis"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_left" } },
        { x = 0, y = 1, parts = { "frame#vertical_right" } },
        { x = 1, y = 0, parts = { "frame#nw" } },
        { x = 1, y = 1, parts = { "frame#ne" } },
        { x = -1, y = 0, parts = { "frame#sw" } },
        { x = -1, y = 1, parts = { "frame#se" } },
    },
}

ccb.content.define_vehicle {
    id = "hospital_bed_small",
    name = ccb.content.text("small hospital bed"),
    blueprint = { { "x" } },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_10", "bed" } } },
}

ccb.content.define_vehicle {
    id = "medical_cart",
    name = ccb.content.text("Medical Cart"),
    blueprint = { "#" },
    mounts = { { x = 0, y = 0, parts = { "xlframe#vertical_2", "wheel_caster", "metal_tray" } } },
}
