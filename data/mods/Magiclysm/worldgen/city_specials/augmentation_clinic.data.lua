local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "magiclysm_augmentation_clinic_ground", "magiclysm_augmentation_clinic_top",
        "magiclysm_augmentation_clinic_roof",
    },
    vision_levels = "city_building",
    copy_from = "generic_city_building",
    name = ccb.content.text("augmentation clinic"),
    symbol = "A",
    color = "cyan",
    extend = { flags = { "RISK_EXTREME", "SOURCE_MEDICINE", "SOURCE_CHEMISTRY" } },
}
