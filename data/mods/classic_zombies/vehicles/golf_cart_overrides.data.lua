local ccb = require("ccb")

-- 2
-- 2
ccb.content.define_vehicle {
    id = "golf_cart",
    name = ccb.content.text("Golf Cart"),
    blueprint = { { "o|o" }, { "o|o" } },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_T_left", "seat_back#left", "roof", "engine_electric" } },
        { x = 0, y = 0, parts = { "controls", "battery_car" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat_back#right", "roof" } },
        { x = 0, y = 1, parts = { "battery_car" } },
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
        { x = 0, y = 0, parts = { "controls", "battery_car" } },
        { x = 0, y = 1, parts = { "frame#vertical_T_right", "seat_back#right", "roof" } },
        { x = 0, y = 1, parts = { "battery_car" } },
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
