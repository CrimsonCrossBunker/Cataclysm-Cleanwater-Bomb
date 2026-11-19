local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_0", "megastore_1_0_0", "megastore_2_0_0", "megastore_0_1_0", "megastore_1_1_0",
        "megastore_2_1_0", "megastore_0_2_0", "megastore_2_2_0",
    },
    name = ccb.content.text("megastore"),
    symbol = "M",
    color = "blue",
    extras = "build",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "megastore_1_2_0",
    name = ccb.content.text("megastore"),
    symbol = "+",
    color = "light_blue",
    extras = "build",
    see_cost = "full_high",
    flags = {
        "SIDEWALK", "RISK_EXTREME", "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_GUN", "SOURCE_AMMO",
        "SOURCE_FABRICATION", "SOURCE_COOKING", "SOURCE_TAILORING", "SOURCE_CONSTRUCTION",
        "SOURCE_WEAPON", "SOURCE_VEHICLES", "SOURCE_CLOTHING", "SOURCE_MEDICINE", "SOURCE_BOOKS",
        "SOURCE_LUXURY",
    },
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_1", "megastore_0_1_1", "megastore_0_2_1", "megastore_1_0_1", "megastore_1_1_1",
        "megastore_1_2_1", "megastore_2_0_1", "megastore_2_1_1", "megastore_2_2_1",
    },
    name = ccb.content.text("megastore, second floor"),
    symbol = "M",
    color = "blue",
    extras = "build",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_roof", "megastore_0_1_roof", "megastore_0_2_roof", "megastore_1_0_roof",
        "megastore_1_2_roof", "megastore_2_0_roof", "megastore_2_1_roof", "megastore_2_2_roof",
    },
    name = ccb.content.text("megastore roof"),
    symbol = "M",
    color = "blue",
    extras = "build",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "megastore_1_1_roof",
    copy_from = "megastore_0_0_roof",
}
