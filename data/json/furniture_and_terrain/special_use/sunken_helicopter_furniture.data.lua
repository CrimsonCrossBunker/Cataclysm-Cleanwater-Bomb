local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_floor",
    copy_from = "t_scrap_floor",
    extend = { flags = { "LIQUID", "SWIMMABLE", "DEEP_WATER", "WATER_CUBE" } },
    name = ccb.content.text("waterlogged aisle"),
    description = ccb.content.text("A waterlogged aisle.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
    connect_groups = { "INDOORFLOOR", "MULCHFLOOR" },
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_floor_rotator",
    copy_from = "t_sunkenhelicopter_floor",
    connect_groups = { "INDOORFLOOR", "MULCHFLOOR" },
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_nw",
    copy_from = "t_scrap_wall",
    name = ccb.content.text("waterlogged board"),
    description = ccb.content.text("A waterlogged metal wall.  Keeps zombies outside the vehicle and prevents people from seeing through it.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_ne",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_w",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_e",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_s",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_sw",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_wall_se",
    copy_from = "t_sunkenhelicopter_wall_nw",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_quarterpanel_n_middle",
    copy_from = "t_drystone_wall_half",
    name = ccb.content.text("waterlogged quarterpanel"),
    description = ccb.content.text("A waterlogged half-height metal wall.  Keeps zombies outside the vehicle but allows people to see over it.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
    flags = { "TRANSPARENT", "NOITEM", "THIN_OBSTACLE", "LIQUID", "SWIMMABLE", "DEEP_WATER", "WATER_CUBE" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_pit_shallow",
        drops = { { item = "lc_steel_chunk", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_quarterpanel_n_left",
    copy_from = "t_sunkenhelicopter_quarterpanel_n_middle",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_quarterpanel_n_right",
    copy_from = "t_sunkenhelicopter_quarterpanel_n_middle",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_windshield_n",
    copy_from = "t_window",
    name = ccb.content.text("waterlogged windshield"),
    description = ccb.content.text("A waterlogged sheet of glass that lets you see outside the vehicle.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
    roof = "t_flat_roof",
    flags = { "TRANSPARENT", "NOITEM" },
    shoot = {
        reduce_damage = { 1, 4 },
        reduce_damage_laser = { 0, 4 },
        destroy_damage = { 1, 4 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_frame",
    copy_from = "t_junk_floor",
    extend = { flags = { "LIQUID", "SWIMMABLE", "DEEP_WATER", "WATER_CUBE" } },
    name = ccb.content.text("waterlogged frame"),
    description = ccb.content.text("A waterlogged metal framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
    flags = { "TRANSPARENT", "NOITEM" },
}

ccb.content.define_furniture {
    id = "f_sunkenhelicopter_seat_rotating",
    name = ccb.content.text("waterlogged bucket seat"),
    description = ccb.content.text("A waterlogged soft upholstered car seat, contoured to hold one person.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
    copy_from = "f_armchair",
    rotates_to = "MULCHFLOOR",
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_roof",
    copy_from = "t_sunkenhelicopter_floor",
    extend = { flags = { "LIQUID", "SWIMMABLE", "DEEP_WATER", "WATER_CUBE" } },
    name = ccb.content.text("waterlogged roof"),
    description = ccb.content.text("A waterlogged metal roof.  Absolutely unrecoverable."),
}

ccb.content.define_terrain {
    id = "t_sunkenhelicopter_rotor",
    copy_from = "t_sunkenhelicopter_floor",
    name = ccb.content.text("waterlogged heavy-duty military Blackhawk rotors"),
    description = ccb.content.text("A set of four military-grade helicopter rotor blades, used to provide lift by rotation.  It has started to degrade after some time spent underwater.  Absolutely unrecoverable."),
}
