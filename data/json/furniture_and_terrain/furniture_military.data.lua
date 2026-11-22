local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_m224_mortar",
    name = "M224 mortar",
    description = "Deployed and ready to be used 60 mm mortar.  You are lucky you don't need to scavenge actual firing tables, as they are clipped tightly to the mortar itself.  However you can use it only for indirect fire, with a substantial precision loss.",
    base_item = "mortar_m224",
    symbol = "#",
    color = "dark_gray",
    coverage = 15,
    move_cost_mod = 2,
    required_strength = 10,
    flags = { "SHORT", "FLAT_SURF" },
    bash = { minimum_strength = 40, maximum_strength = 70 },
    mortar = {
        ammo = { "mortar_60mm" },
        range = 3490,
        flight_time = "15 seconds",
        condition_handler = "w16b_mortar_c_dda_d4f8a86bd18c",
        condition_fail_msg = "You have absolutely no idea how to use this mortar.",
        aim_duration_handler = "w16b_mortar_dur_dda_0e910b3b75ac",
        aim_deviation_handler = "w16b_mortar_dev_dda_908d8984994c",
    },
}
