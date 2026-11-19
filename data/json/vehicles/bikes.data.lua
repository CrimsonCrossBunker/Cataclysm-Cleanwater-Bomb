local ccb = require("ccb")

ccb.content.define_vehicle {
    abstract = "bicycle_abstract",
    name = ccb.content.text("Bicycle"),
    blueprint = { "o#o" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "saddle#pedal", "horn_bicycle", "foot_pedals" } },
        { x = 1, y = 0, parts = { "xlframe#vertical", "wheel_mount_light_steerable" } },
        { x = -1, y = 0, parts = { "xlframe#vertical", "wheel_mount_light" } },
    },
}

ccb.content.define_vehicle {
    id = "bicycle",
    copy_from = "bicycle_abstract",
    mounts = {
        { x = 1, y = 0, parts = { "wheel_bicycle" } },
        { x = -1, y = 0, parts = { "wheel_bicycle#rear", "basketsm#bike_rear" } },
    },
}

ccb.content.define_vehicle {
    id = "bicycle_dirt",
    copy_from = "bicycle_abstract",
    name = ccb.content.text("Mountain bike"),
    mounts = {
        { x = 1, y = 0, parts = { "wheel_bicycle_or" } },
        { x = -1, y = 0, parts = { "wheel_bicycle_or#rear" } },
    },
}

ccb.content.define_vehicle {
    id = "bicycle_electric",
    copy_from = "bicycle",
    name = ccb.content.text("Electric Bicycle"),
    mounts = {
        { x = 0, y = 0, parts = { "controls", "controls_electronic" } },
        { x = -1, y = 0, parts = { "small_storage_battery", "engine_electric_tiny" } },
    },
}

ccb.content.define_vehicle {
    id = "motorcycle_cross",
    name = ccb.content.text("Motocross Bike"),
    blueprint = { "o#o" },
    mounts = {
        { x = 1, y = 0, parts = { "frame#vertical_2", "wheel_mount_light_steerable", "wheel_motorbike_or" } },
        { x = 0, y = 0, parts = { "frame#vertical", "saddle#motor", "controls", "battery_motorbike_small" } },
        { x = 0, y = 0, parts = { "engine_1cyl_large", { part = "tank_small", fuel = "gasoline" } } },
        { x = 0, y = 0, parts = { "alternator_motorbike" } },
        {
            x = -1,
            y = 0,
            parts = { "xlframe#vertical", "muffler", "wheel_mount_light", "wheel_motorbike_or#rear" },
        },
    },
}

ccb.content.define_vehicle {
    id = "motorcycle_enduro",
    copy_from = "motorcycle_cross",
    name = ccb.content.text("Street-Legal Dirt Bike"),
    mounts = {
        { x = 1, y = 0, parts = { "motorcycle_headlight" } },
        { x = 0, y = 0, parts = { "controls_electronic", "horn_car" } },
    },
}

ccb.content.define_vehicle {
    abstract = "motorcycle_abstract",
    name = ccb.content.text("Motorcycle"),
    blueprint = { "o#>o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor" } },
        { x = 1, y = 0, parts = { "frame_handle", { part = "tank_small", fuel = "gasoline" } } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_light", "wheel_motorbike#rear" } },
        { x = 2, y = 0, parts = { "frame#vertical", "wheel_mount_light_steerable", "wheel_motorbike" } },
        { x = 0, y = 0, parts = { "controls", "controls_electronic", "vehicle_alarm" } },
        { x = 0, y = 0, parts = { "horn_car", "engine_vtwin", "alternator_motorbike" } },
        { x = 1, y = 0, parts = { "motorcycle_headlight", "battery_motorbike" } },
        { x = -1, y = 0, parts = { "muffler", "box" } },
    },
}

ccb.content.define_vehicle {
    id = "motorcycle",
    copy_from = "motorcycle_abstract",
    mounts = { { x = 0, y = 0, parts = { "motorcycle_kickstand" } } },
}

ccb.content.define_vehicle {
    id = "motorcycle_chassis",
    name = ccb.content.text("Motorcycle Chassis"),
    blueprint = { "o#>" },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor" } },
        { x = 1, y = 0, parts = { "frame_handle", { part = "tank_small", fuel = "gasoline" } } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_light", "wheel_motorbike#rear" } },
    },
}

ccb.content.define_vehicle {
    id = "motorcycle_sidecart",
    copy_from = "motorcycle_abstract",
    name = ccb.content.text("Motorcycle"),
    blueprint = { { "o#>o" }, { " #> " } },
    mounts = {
        { x = 0, y = 1, parts = { "frame#cross", "wheel_mount_light", "wheel_motorbike", "seat" } },
        { x = 1, y = 1, parts = { "frame_handle", "box" } },
    },
    item_spawns = {
        { x = -1, y = 0, chance = 2, items = { "joint" } },
        { x = -1, y = 0, chance = 8, items = { "helmet_motor" } },
        { x = 0, y = 1, chance = 33, items = { "helmet_motor" } },
    },
}

-- Based on CanAm three-wheelers
ccb.content.define_vehicle {
    abstract = "motorcycle_3wheel_abstract",
    name = ccb.content.text("Three-Wheel Motorcycle"),
    blueprint = { { "   O" }, { "o#>o" }, { "   O" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor" } },
        { x = 0, y = 0, parts = { "controls", "controls_electronic", "vehicle_alarm" } },
        { x = 1, y = 0, parts = { "frame_handle", { part = "tank_medium", fuel = "gasoline" } } },
        { x = 1, y = 0, parts = { "motorcycle_headlight", "battery_motorbike" } },
        { x = 2, y = 0, parts = { "frame#cover", "box" } },
        { x = 2, y = 0, parts = { "horn_car" } },
        { x = 2, y = -1, parts = { "frame#horizontal", "wheel_mount_medium_steerable", "wheel" } },
        { x = 2, y = 1, parts = { "frame#horizontal", "wheel_mount_medium_steerable", "wheel" } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_medium", "wheel" } },
        { x = -1, y = 0, parts = { "muffler", "box" } },
    },
}

ccb.content.define_vehicle {
    id = "motorcycle_3wheel",
    copy_from = "motorcycle_3wheel_abstract",
    mounts = { { x = 2, y = 0, parts = { "engine_vtwin", "alternator_motorbike" } } },
}

ccb.content.define_vehicle {
    id = "motorcycle_3wheel_super",
    copy_from = "motorcycle_3wheel_abstract",
    mounts = { { x = 2, y = 0, parts = { "engine_inline4", "alternator_motorbike" } } },
}

ccb.content.define_vehicle {
    id = "quad_bike",
    name = ccb.content.text("Quad Bike"),
    blueprint = { { "O O" }, { "=#>" }, { "O O" } },
    mounts = {
        {
            x = 0,
            y = 0,
            parts = { "frame#vertical_2", "saddle#motor", "controls", "controls_electronic", "horn_car" },
        },
        {
            x = 1,
            y = 0,
            parts = { "frame#cover", "engine_vtwin", "alternator_motorbike", "battery_motorbike" },
        },
        {
            x = 1,
            y = 0,
            parts = { "motorcycle_headlight", { part = "tank_small", fuel = "gasoline" }, "plating_steel" },
        },
        { x = -1, y = 0, parts = { "frame#horizontal", "muffler", "box" } },
        { x = 1, y = 1, parts = { "frame#horizontal", "wheel_mount_light_steerable", "wheel_motorbike_or" } },
        { x = 1, y = -1, parts = { "frame#horizontal", "wheel_mount_light_steerable", "wheel_motorbike_or" } },
        { x = -1, y = -1, parts = { "frame#horizontal", "wheel_mount_light", "wheel_motorbike_or#rear" } },
        { x = -1, y = 1, parts = { "frame#horizontal", "wheel_mount_light", "wheel_motorbike_or#rear" } },
    },
    item_spawns = { { x = -1, y = 0, chance = 10, items = { "helmet_motor" } } },
}

ccb.content.define_vehicle {
    id = "quad_bike_chassis",
    name = ccb.content.text("Quad Bike Chassis"),
    blueprint = { { "O O" }, { "|#>" }, { "O  " } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor" } },
        { x = 1, y = 0, parts = { "frame#cover" } },
        { x = -1, y = 0, parts = { "frame#horizontal" } },
        { x = 1, y = -1, parts = { "frame#horizontal", "wheel_mount_light_steerable", "wheel_motorbike_or" } },
        { x = -1, y = -1, parts = { "frame#horizontal", "wheel_mount_light", "wheel_motorbike_or#rear" } },
        { x = -1, y = 1, parts = { "frame#horizontal", "wheel_mount_light", "wheel_motorbike_or#rear" } },
    },
}

ccb.content.define_vehicle {
    abstract = "scooter_abstract",
    name = ccb.content.text("Scooter"),
    blueprint = { "o>o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame_handle", "saddle#scooter" } },
        { x = 0, y = 0, parts = { "controls", "controls_electronic", "horn_car", "motorcycle_kickstand" } },
        {
            x = 1,
            y = 0,
            parts = { "xlframe#vertical", "wheel_mount_light_steerable", "wheel_small#scooter_front" },
        },
        { x = 1, y = 0, parts = { "motorcycle_headlight" } },
        { x = -1, y = 0, parts = { "xlframe#vertical", "wheel_mount_light", "wheel_small#scooter_rear" } },
    },
}

ccb.content.define_vehicle {
    id = "skateboard",
    name = ccb.content.text("Skateboard"),
    blueprint = { "$" },
    mounts = { { x = 0, y = 0, parts = { "frame_wood_deck", "wheel_mount_skateboard", "wheel_skateboard" } } },
}

ccb.content.define_vehicle {
    id = "scooter",
    copy_from = "scooter_abstract",
    mounts = {
        { x = 0, y = 0, parts = { "engine_1cyl", "alternator_motorbike", "battery_motorbike" } },
        { x = 0, y = 0, parts = { { part = "tank_small", fuel = "gasoline" } } },
        { x = -1, y = 0, parts = { "muffler" } },
    },
}

ccb.content.define_vehicle {
    id = "scooter_electric",
    copy_from = "scooter_abstract",
    name = ccb.content.text("Electric Scooter"),
    blueprint = { "o>o" },
    mounts = { { x = 0, y = 0, parts = { "medium_storage_battery", "engine_electric_small" } } },
}

ccb.content.define_vehicle {
    id = "superbike",
    name = ccb.content.text("Superbike"),
    blueprint = { "o#>o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor", "motorcycle_kickstand" } },
        { x = 1, y = 0, parts = { "frame_handle", { part = "tank_small", fuel = "gasoline" } } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_light", "wheel_motorbike#rear" } },
        { x = 2, y = 0, parts = { "frame#vertical", "wheel_mount_light_steerable", "wheel_motorbike" } },
        { x = 0, y = 0, parts = { "controls", "controls_electronic", "vehicle_alarm" } },
        { x = 0, y = 0, parts = { "horn_car", "engine_inline4", "alternator_motorbike" } },
        { x = 1, y = 0, parts = { "motorcycle_headlight", "battery_car" } },
        { x = -1, y = 0, parts = { "muffler" } },
    },
}

ccb.content.define_vehicle {
    id = "tandem",
    name = ccb.content.text("Tandem"),
    blueprint = { "o##o" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2", "saddle#motor", "horn_bicycle", "foot_pedals" } },
        { x = 1, y = 0, parts = { "xlframe#vertical", "wheel_mount_light_steerable", "wheel_bicycle" } },
        { x = -1, y = 0, parts = { "xlframe#vertical_2", "saddle#pedal" } },
        {
            x = -2,
            y = 0,
            parts = { "xlframe#vertical", "wheel_mount_light", "wheel_bicycle#rear", "basketsm#bike_rear" },
        },
    },
}

ccb.content.define_vehicle {
    id = "tricycle",
    name = ccb.content.text("Children's Tricycle"),
    blueprint = { "#" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical", "saddle#pedal", "foot_pedals", "wheel_tricycle" } },
    },
}

ccb.content.define_vehicle {
    id = "unicycle",
    name = ccb.content.text("Unicycle"),
    blueprint = { "#" },
    mounts = {
        {
            x = 0,
            y = 0,
            parts = { "frame_handle", "saddle#pedal", "foot_pedals", "wheel_mount_light", "wheel_unicycle" },
        },
    },
}
