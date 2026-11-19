local ccb = require("ccb")

ccb.content.define_terrain {
    abstract = "t_north_america_tree",
    copy_from = "t_tree_abstract",
    builtin_examine = "none",
}

ccb.content.define_terrain {
    abstract = "t_north_america_conifer",
    copy_from = "t_north_america_tree",
    looks_like = "t_tree_pine",
    roof = "t_treetop_evergreen",
    symbol = "4",
    color = "green",
}

ccb.content.define_terrain {
    abstract = "t_north_america_shrub",
    copy_from = "t_shrub",
    builtin_examine = "none",
}

ccb.content.define_terrain {
    id = "t_tree_white_spruce",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("white spruce"),
    description = ccb.content.text("A North American tree of the species Picea glauca."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_black_spruce",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("black spruce"),
    description = ccb.content.text("A North American tree of the species Picea mariana."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_tamarack",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("tamarack"),
    description = ccb.content.text("A North American tree of the species Larix laricina."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_jack_pine",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("jack pine"),
    description = ccb.content.text("A North American tree of the species Pinus banksiana."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_paper_birch",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("paper birch"),
    description = ccb.content.text("A North American tree of the species Betula papyrifera."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_douglas_fir",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Douglas-fir"),
    description = ccb.content.text("A North American tree of the species Pseudotsuga menziesii."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_western_redcedar",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("western redcedar"),
    description = ccb.content.text("A North American tree of the species Thuja plicata."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_western_hemlock",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("western hemlock"),
    description = ccb.content.text("A North American tree of the species Tsuga heterophylla."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_sitka_spruce",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Sitka spruce"),
    description = ccb.content.text("A North American tree of the species Picea sitchensis."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_ponderosa_pine",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("ponderosa pine"),
    description = ccb.content.text("A North American tree of the species Pinus ponderosa."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_lodgepole_pine",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("lodgepole pine"),
    description = ccb.content.text("A North American tree of the species Pinus contorta."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_oregon_white_oak",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("Oregon white oak"),
    description = ccb.content.text("A North American tree of the species Quercus garryana."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_blue_oak",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("blue oak"),
    description = ccb.content.text("A North American tree of the species Quercus douglasii."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_southern_live_oak",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("southern live oak"),
    description = ccb.content.text("A North American tree of the species Quercus virginiana."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_shagbark_hickory",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("shagbark hickory"),
    description = ccb.content.text("A North American tree of the species Carya ovata."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_bur_oak",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("bur oak"),
    description = ccb.content.text("A North American tree of the species Quercus macrocarpa."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_eastern_cottonwood",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("eastern cottonwood"),
    description = ccb.content.text("A North American tree of the species Populus deltoides."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_pacific_madrone",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Pacific madrone"),
    description = ccb.content.text("A North American tree of the species Arbutus menziesii."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_subalpine_fir",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("subalpine fir"),
    description = ccb.content.text("A North American tree of the species Abies lasiocarpa."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_colorado_pinyon",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Colorado pinyon"),
    description = ccb.content.text("A North American tree of the species Pinus edulis."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_mexican_pinyon",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Mexican pinyon"),
    description = ccb.content.text("A North American tree of the species Pinus cembroides."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_montezuma_pine",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("Montezuma pine"),
    description = ccb.content.text("A North American tree of the species Pinus montezumae."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_shrub_big_sagebrush",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("big sagebrush"),
    description = ccb.content.text("A North American plant of the species Artemisia tridentata."),
}

ccb.content.define_terrain {
    id = "t_shrub_dwarf_birch",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("dwarf birch"),
    description = ccb.content.text("A North American plant of the species Betula glandulosa."),
}

ccb.content.define_terrain {
    id = "t_shrub_creosote_bush",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("creosote bush"),
    description = ccb.content.text("A North American plant of the species Larrea tridentata."),
}

ccb.content.define_terrain {
    id = "t_shrub_saguaro",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("saguaro"),
    description = ccb.content.text("A North American plant of the species Carnegiea gigantea."),
    transforms_into = "t_shrub_saguaro_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "saguaro_harv",
        growth = {
            base_c = 12,
            optimum_c = 32,
            min_c = 0,
            max_c = 49,
            degree_days = 660,
            water_mm = 70,
            growing_days = 73,
            water_peak = 0.5,
        },
        bearing_days = 24,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_chamise",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("chamise"),
    description = ccb.content.text("A North American plant of the species Adenostoma fasciculatum."),
}

ccb.content.define_terrain {
    id = "t_shrub_snowberry",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("common snowberry"),
    description = ccb.content.text("A common snowberry shrub.  Its pale fruit is food for wildlife and is poisonous to people."),
}

ccb.content.define_terrain {
    id = "t_tree_bald_cypress",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("bald cypress"),
    description = ccb.content.text("A North American tree of the species Taxodium distichum."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_longleaf_pine",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("longleaf pine"),
    description = ccb.content.text("A North American tree of the species Pinus palustris."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_shrub_wax_myrtle",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("southern wax myrtle"),
    description = ccb.content.text("A North American plant of the species Morella cerifera."),
}

ccb.content.define_terrain {
    id = "t_tree_gumbo_limbo",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("gumbo-limbo"),
    description = ccb.content.text("A North American tree of the species Bursera simaruba."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_spanish_cedar",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("Spanish cedar"),
    description = ccb.content.text("A North American tree of the species Cedrela odorata."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_netleaf_oak",
    copy_from = "t_north_america_conifer",
    name = ccb.content.text("netleaf oak"),
    description = ccb.content.text("A North American tree of the species Quercus rugosa."),
    looks_like = "t_tree_pine",
}

ccb.content.define_terrain {
    id = "t_tree_texas_mesquite",
    copy_from = "t_north_america_tree",
    name = ccb.content.text("honey mesquite"),
    description = ccb.content.text("A North American tree of the species Prosopis glandulosa."),
    looks_like = "t_tree",
}

ccb.content.define_terrain {
    id = "t_shrub_prickly_pear",
    copy_from = "t_north_america_shrub",
    looks_like = "t_shrub",
    name = ccb.content.text("Engelmann's prickly pear"),
    description = ccb.content.text("A North American plant of the species Opuntia engelmannii."),
    transforms_into = "t_shrub_prickly_pear_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "prickly_pear_harv",
        growth = {
            base_c = 10,
            optimum_c = 31,
            min_c = -5,
            max_c = 47,
            degree_days = 1210,
            water_mm = 155,
            growing_days = 118,
            water_peak = 0.58,
        },
        bearing_days = 44,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_saguaro_harvested",
    copy_from = "t_shrub_saguaro",
    looks_like = "t_shrub_saguaro",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_saguaro",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_prickly_pear_harvested",
    copy_from = "t_shrub_prickly_pear",
    looks_like = "t_shrub_prickly_pear",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_prickly_pear",
    builtin_examine = "harvested_plant",
}
