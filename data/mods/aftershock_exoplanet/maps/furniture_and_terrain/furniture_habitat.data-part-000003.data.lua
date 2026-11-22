local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_reinforced_displaycase",
    name = "reinforced display case",
    description = "A secure metal case at about waist-height, with reinforced glass paneling on top.  Useful for storing valuable things while still showing them off.  Secured with an electronic lock.",
    looks_like = "f_rack",
    symbol = "#",
    color = "light_cyan",
    rotates_to = "INDOORFLOOR",
    coverage = 80,
    move_cost_mod = 2,
    required_strength = 10,
    flags = { "TRANSPARENT", "SEALED", "PLACE_ITEM" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        volume = 16,
        failure_volume = 12,
        furniture = "f_displaycase_b",
        sound = "glass breaking!",
        failure_sound = "whack!",
        drops = {
            {
                item = "glass_shard",
                count = { 25, 50 },
            },
        },
    },
    shoot = {
        reduce_damage = { 2, 12 },
        reduce_damage_laser = { 0, 7 },
        destroy_damage = { 40, 120 },
        no_laser_destroy = true,
    },
    examine_handler = "w16b_tile_ex_aftershock_exoplanet_8a3072a84d7f",
}
