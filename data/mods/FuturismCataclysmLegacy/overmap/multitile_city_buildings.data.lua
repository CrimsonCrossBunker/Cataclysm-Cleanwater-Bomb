local ccb = require("ccb")

ccb.content.define_city_building {
    id = "house_09b",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_09_north" },
        { point = { 0, 0, 1 }, terrain = "house_09_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_bionic_north" },
    },
}

ccb.content.define_city_building {
    id = "fcl_augmentation_clinic_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "fcl_augmentation_clinic_n1_north" },
        { point = { 0, 0, 1 }, terrain = "fcl_augmentation_clinic_n2_north" },
        { point = { 0, 0, 2 }, terrain = "fcl_augmentation_clinic_n3_north" },
        { point = { 0, 0, 3 }, terrain = "fcl_augmentation_clinic_n4_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "fcl_mealgrub_protein_farm",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "fcl_mealgrub_protein_farm_n1_north" },
        { point = { 0, 0, 1 }, terrain = "fcl_mealgrub_protein_farm_n2_north" },
        { point = { 0, 0, 2 }, terrain = "fcl_mealgrub_protein_farm_n3_north" },
    },
    locations = { "land" },
}
