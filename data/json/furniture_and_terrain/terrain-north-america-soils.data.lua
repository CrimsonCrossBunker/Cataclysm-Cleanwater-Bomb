local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_atlas_soil_loam",
    copy_from = "t_dirt",
    name = ccb.content.text("loam"),
    description = ccb.content.text("A crumbly mixture of sand, silt, and clay."),
    looks_like = "t_dirt",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled loam"),
    description = ccb.content.text("The upper layer of this loam has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam",
    copy_from = "t_dirt",
    name = ccb.content.text("sandy soil"),
    description = ccb.content.text("Pale, gritty topsoil with a large proportion of sand."),
    looks_like = "t_dirt",
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled sandy soil"),
    description = ccb.content.text("The upper layer of this sandy soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam",
    copy_from = "t_dirt",
    name = ccb.content.text("silt-rich soil"),
    description = ccb.content.text("Fine, powdery earth that packs smoothly when it is wet."),
    looks_like = "t_dirt",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled silt-rich soil"),
    description = ccb.content.text("The upper layer of this silt-rich soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam",
    copy_from = "t_dirt",
    name = ccb.content.text("clay loam"),
    description = ccb.content.text("Loamy topsoil with enough clay to hold together when damp."),
    looks_like = "t_dirt",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled clay loam"),
    description = ccb.content.text("The upper layer of this clay loam has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay",
    copy_from = "t_dirt",
    name = ccb.content.text("heavy clay soil"),
    description = ccb.content.text("Dense, clay-rich soil that forms hard clods as it dries."),
    looks_like = "t_dirt",
    color = "red",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled heavy clay soil"),
    description = ccb.content.text("The upper layer of this heavy clay soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "red",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic",
    copy_from = "t_dirt",
    name = ccb.content.text("organic-rich soil"),
    description = ccb.content.text("Dark soil mixed with a great deal of decomposed plant material."),
    looks_like = "t_dirt",
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled organic-rich soil"),
    description = ccb.content.text("The upper layer of this organic-rich soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly",
    copy_from = "t_dirt",
    name = ccb.content.text("gravelly soil"),
    description = ccb.content.text("Loose topsoil interspersed with small stones and gravel."),
    looks_like = "t_dirt",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled gravelly soil"),
    description = ccb.content.text("The upper layer of this gravelly soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous",
    copy_from = "t_dirt",
    name = ccb.content.text("calcareous soil"),
    description = ccb.content.text("Pale soil mixed with chalky particles of calcium carbonate."),
    looks_like = "t_dirt",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled calcareous soil"),
    description = ccb.content.text("The upper layer of this calcareous soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie",
    copy_from = "t_dirt",
    name = ccb.content.text("dark prairie soil"),
    description = ccb.content.text("Deep, dark topsoil rich in organic material from grass roots."),
    looks_like = "t_dirt",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled dark prairie soil"),
    description = ccb.content.text("The upper layer of this dark prairie soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic",
    copy_from = "t_dirt",
    name = ccb.content.text("volcanic soil"),
    description = ccb.content.text("Loose, porous earth formed from volcanic material."),
    looks_like = "t_dirt",
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled volcanic soil"),
    description = ccb.content.text("The upper layer of this volcanic soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol",
    copy_from = "t_dirt",
    name = ccb.content.text("leached forest soil"),
    description = ccb.content.text("Acidic forest soil with a light layer of leached material."),
    looks_like = "t_dirt",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_tilled",
    copy_from = "t_dirtmound",
    name = ccb.content.text("tilled leached forest soil"),
    description = ccb.content.text("The upper layer of this leached forest soil has been loosened for planting."),
    looks_like = "t_dirtmound",
    color = "light_gray",
}
