local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "fcl_augmentation_clinic_n1", "fcl_augmentation_clinic_n2", "fcl_augmentation_clinic_n3",
        "fcl_augmentation_clinic_n4",
    },
    name = ccb.content.text("augmentation clinic"),
    spawns = { group = "FCL_GROUP_AUG_CLINIC", population = { 4, 10 }, chance = 80 },
    symbol = "P",
    color = "yellow",
    flags = { "SIDEWALK" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "fcl_mealgrub_protein_farm_n1", "fcl_mealgrub_protein_farm_n2", "fcl_mealgrub_protein_farm_n3" },
    name = ccb.content.text("mealgrub protein farm"),
    spawns = { group = "FCL_GROUP_MEALGRUB_FARM", population = { 4, 10 }, chance = 80 },
    symbol = "Q",
    color = "cyan",
    flags = { "SIDEWALK", "SOURCE_FOOD" },
    see_cost = "high",
}
