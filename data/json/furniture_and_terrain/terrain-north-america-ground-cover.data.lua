local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on loam"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_loam_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on loam"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on loam"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_loam_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on loam"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on loam"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on loam"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_loam_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on loam"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on sandy soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_sandy_loam_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on sandy soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_sandy_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on sandy soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_sandy_loam_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on sandy soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on sandy soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_sandy_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on sandy soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_sandy_loam_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on sandy soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on silt-rich soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_silt_loam_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on silt-rich soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_silt_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on silt-rich soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_silt_loam_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on silt-rich soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on silt-rich soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_silt_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on silt-rich soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_silt_loam_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on silt-rich soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on clay loam"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_clay_loam_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on clay loam"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_clay_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on clay loam"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_clay_loam_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on clay loam"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on clay loam"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_clay_loam_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on clay loam"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_clay_loam_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on clay loam"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on heavy clay soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_heavy_clay_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on heavy clay soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_heavy_clay_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on heavy clay soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_heavy_clay_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on heavy clay soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on heavy clay soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_heavy_clay_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on heavy clay soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_heavy_clay_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on heavy clay soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on organic-rich soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_organic_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on organic-rich soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_organic_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on organic-rich soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_organic_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on organic-rich soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on organic-rich soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_organic_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on organic-rich soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_organic_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on organic-rich soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on gravelly soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_gravelly_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on gravelly soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_gravelly_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on gravelly soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_gravelly_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on gravelly soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on gravelly soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_gravelly_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on gravelly soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_gravelly_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on gravelly soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on calcareous soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_calcareous_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on calcareous soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_calcareous_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on calcareous soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_calcareous_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on calcareous soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on calcareous soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_calcareous_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on calcareous soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_calcareous_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on calcareous soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on dark prairie soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_prairie_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on dark prairie soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_prairie_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on dark prairie soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_prairie_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on dark prairie soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on dark prairie soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_prairie_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on dark prairie soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_prairie_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on dark prairie soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on volcanic soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_volcanic_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on volcanic soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_volcanic_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on volcanic soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_volcanic_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on volcanic soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on volcanic soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_volcanic_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on volcanic soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_volcanic_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on volcanic soil"),
    looks_like = "t_moss",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_grass",
    copy_from = "t_grass",
    name = ccb.content.text("grass on leached forest soil"),
    looks_like = "t_grass",
    transforms_into = "t_atlas_soil_podzol_grazed_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_long_grass",
    copy_from = "t_grass_long",
    name = ccb.content.text("long grass on leached forest soil"),
    looks_like = "t_grass_long",
    transforms_into = "t_atlas_soil_podzol_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_tall_grass",
    copy_from = "t_grass_tall",
    name = ccb.content.text("tall grass on leached forest soil"),
    looks_like = "t_grass_tall",
    transforms_into = "t_atlas_soil_podzol_long_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_dead_grass",
    copy_from = "t_grass_dead",
    name = ccb.content.text("dead grass on leached forest soil"),
    looks_like = "t_grass_dead",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_grazed_grass",
    copy_from = "t_grass_grazed",
    name = ccb.content.text("grazed grass on leached forest soil"),
    looks_like = "t_grass_grazed",
    transforms_into = "t_atlas_soil_podzol_grass",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_forest_floor",
    copy_from = "t_forestfloor",
    name = ccb.content.text("forest floor on leached forest soil"),
    looks_like = "t_forestfloor",
}

ccb.content.define_terrain {
    id = "t_atlas_soil_podzol_moss",
    copy_from = "t_moss",
    name = ccb.content.text("moss on leached forest soil"),
    looks_like = "t_moss",
}
