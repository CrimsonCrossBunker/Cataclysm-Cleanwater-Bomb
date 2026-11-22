local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "dm_office_cubical_phavian",
    locations = { "land" },
    city_distance = { 40, -1 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
    tiles = {
        {
            point = { 0, 0, 0 },
            terrain = "office_cubical_phavian_north",
        },
        {
            point = { 0, 0, 1 },
            terrain = "office_cubical_phavian_roof_north",
        },
        {
            point = { 0, 0, -1 },
            terrain = "office_cubical_phavian_basement_north",
        },
        {
            point = { 0, 0, -2 },
            terrain = "office_cubical_phavian_subbasement_north",
        },
    },
    occurrences = ccb.content.is_mod_active("defense_mode") and { 100, 100 } or { 0, 0 },
}
