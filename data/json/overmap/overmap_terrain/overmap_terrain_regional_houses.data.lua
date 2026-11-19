local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "house_regional_cape_cod",
    copy_from = "generic_city_house",
    name = ccb.content.text("Cape Cod cottage"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_craftsman",
    copy_from = "generic_city_house",
    name = ccb.content.text("Craftsman bungalow"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_shotgun",
    copy_from = "generic_city_house",
    name = ccb.content.text("Gulf Coast shotgun house"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_prairie",
    copy_from = "generic_city_house",
    name = ccb.content.text("Prairie farmhouse"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_brick_bungalow",
    copy_from = "generic_city_house",
    name = ccb.content.text("Brick bungalow"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_adobe",
    copy_from = "generic_city_house",
    name = ccb.content.text("Pueblo Revival adobe house"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_quebec",
    copy_from = "generic_city_house",
    name = ccb.content.text("Quebec stone cottage"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_mexican_patio",
    copy_from = "generic_city_house",
    name = ccb.content.text("Mexican patio house"),
}

ccb.content.define_overmap_terrain {
    id = "house_regional_ranch",
    copy_from = "generic_city_house",
    name = ccb.content.text("Suburban ranch house"),
}

ccb.content.define_overmap_terrain {
    id = {
        "house_regional_cape_cod_roof", "house_regional_craftsman_roof", "house_regional_shotgun_roof",
        "house_regional_prairie_roof", "house_regional_brick_bungalow_roof",
        "house_regional_adobe_roof", "house_regional_quebec_roof", "house_regional_mexican_patio_roof",
        "house_regional_ranch_roof",
    },
    copy_from = "generic_city_house_roof",
}
