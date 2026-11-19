local ccb = require("ccb")

ccb.content.define_city_building {
    id = "magiclysm_augmentation_clinic",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "magiclysm_augmentation_clinic_ground_north" },
        { point = { 0, 0, 1 }, terrain = "magiclysm_augmentation_clinic_top_north" },
        { point = { 0, 0, 2 }, terrain = "magiclysm_augmentation_clinic_roof_north" },
    },
    locations = { "land" },
    city_sizes = { 12, -1 },
}
