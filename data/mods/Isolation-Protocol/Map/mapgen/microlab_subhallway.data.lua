local ccb = require("ccb")

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "mlb_generic_subhallway",
    layout = {
        rows = {
            "##########|  |##########",
            "#######||||YY||||#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######||||YY||||#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######||||YY||||#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######||||YY||||#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######|XX=  =XX|#######",
            "#######||||  ||||#######",
            "##########|YY|##########",
            "##########|  |##########",
        },
        nested = {
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
        },
        fill_terrain = "t_strconc_floor",
        palettes = { "microlab" },
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "mlb_generic_subhallway",
    layout = {
        rows = {
            "##########|  |##########",
            "##########|YY||#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "####|||||||   |#########",
            "####|i i  |   |#########",
            "####|     |   |#########",
            "####|2|2| |   |#########",
            "####|;|;|  Y  |#########",
            "####|||||  Y  |#########",
            "####|;|;|  Y  |#########",
            "####|2|2| |   |#########",
            "####|     |   |#########",
            "####|i i  |   |#########",
            "####|||||||   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|   |#########",
            "##########|YY||#########",
            "##########|  |##########",
        },
        nested = {
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
        },
        fill_terrain = "t_strconc_floor",
        palettes = { "microlab" },
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "mlb_generic_subhallway",
    layout = {
        rows = {
            "##########|  |##########",
            "##########|YY|##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|YY|##########",
            "##########|YY|##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|  |##########",
            "##########|YY|##########",
            "##########|  |##########",
        },
        nested = {
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
        },
        fill_terrain = "t_strconc_floor",
        palettes = { "microlab" },
    },
}
