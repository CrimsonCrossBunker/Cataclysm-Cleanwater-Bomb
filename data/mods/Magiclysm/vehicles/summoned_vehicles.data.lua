local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "floating_disk",
    name = ccb.content.text("Floating disk"),
    blueprint = { "o" },
    mounts = { { x = 0, y = 0, parts = { "mana_frame" } } },
}

ccb.content.define_item {
    id = "mana_wheel",
    category = "veh_parts",
    name = ccb.content.plural_text("mana wheel", "mana wheels"),
    description = ccb.content.text("A column of mana energy that enables a floating disk to move."),
    mass = "500 g",
    volume = "500 ml",
    price = "1 cent",
    accuracy = -4,
    materials = { "steel" },
    symbol = "]",
    color = "light_gray",
    melee_damage = { bash = 8 },
    wheel = { diameter = 20, width = 10 },
}

ccb.content.define_vehicle {
    id = "magic_motorcycle",
    name = ccb.content.text("Mojocycle"),
    blueprint = { "o#>o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor", "motorcycle_kickstand" } },
        { x = 1, y = 0, parts = { "frame_handle" } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_light", "wheel_motorbike" } },
        { x = 2, y = 0, parts = { "frame#vertical", "wheel_mount_light_steerable", "wheel_motorbike" } },
        { x = 0, y = 0, parts = { "controls_technomancer", "controls_electronic", "vehicle_alarm" } },
        { x = 0, y = 0, parts = { "horn_car", "engine_vtwin_magic", "alternator_motorbike" } },
        { x = 1, y = 0, parts = { "headlight", "battery_motorbike" } },
        { x = -1, y = 0, parts = { "muffler", "box" } },
    },
}

ccb.content.define_vehicle {
    id = "magic_comcycle",
    copy_from = "magic_motorcycle",
    name = ccb.content.text("Co-op cycle"),
    blueprint = { { "o#>o" }, { " #> " } },
    mounts = {
        { x = 0, y = 1, parts = { "frame#cross", "wheel_mount_light", "wheel_motorbike", "seat" } },
        { x = 1, y = 1, parts = { "frame_handle", "box" } },
    },
}

ccb.content.define_vehicle_part {
    id = "mana_frame",
    copy_from = "frame_abstract",
    name = ccb.content.text("mana frame"),
    breaks_into = "EMPTY_GROUP",
    color = "magenta",
    damage_modifier = 10,
    noise_factor = 1,
    fuel_type = "mana",
    durability = 20,
    item = "mana_wheel",
    m2c = 90,
    rolling_resistance = 0.45,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 20,
    description = ccb.content.text("A shape of pure mana that can float and carry items."),
    size = "37500 ml",
    power = "200 W",
    flags = {
        "NO_INSTALL_HIDDEN",
        "ENGINE",
        "STABLE",
        "E_STARTS_INSTANTLY",
        "STEERABLE",
        "WHEEL",
        "OBSTACLE",
        "CARGO",
        "MAGIC_FOLLOW",
        "FLOATS",
    },
    damage_reduction = { all = 12 },
}

-- NO_I18N
ccb.content.define_item {
    id = "mana",
    category = "chems",
    name = ccb.content.plural_text("mana core power", "mana core power"),
    description = ccb.content.text_without_extraction("Seeing this is a bug."),
    mass = "10 g",
    volume = "10 ml",
    phase = "solid",
    materials = { "mana" },
    flags = { "PSEUDO", "PERPETUAL" },
    symbol = "?",
    color = "magenta",
    melee_damage = { bash = 1 },
    ammunition = { count = 1, type = "mana" },
}
