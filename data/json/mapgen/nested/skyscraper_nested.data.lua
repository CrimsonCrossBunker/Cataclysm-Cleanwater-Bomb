local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_toilet_il",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "iiii+",
            "TiSi|",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_storage2_il",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "MMnn=",
            "hMnn|",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_cleaning1_il",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "iiii=",
            "Syyy|",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_cleaning2_il",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "iiii=",
            "SCCy|",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_toilet_ir",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "+iiii",
            "|SiTi",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_storage2_ir",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "=nnMM",
            "|nnMh",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_cleaning1_ir",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "=iiii",
            "|Syyy",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_5x5_cleaning2_ir",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "=iiii",
            "|yCCS",
            "|||||",
            "*****",
            "*****",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_8x8_eating_al",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "**|HHH||",
            "**VCSoe|",
            "**VCiii|",
            "**G::tM|",
            "**G::tM|",
            "**Vtt:a|",
            "**VMM89|",
            "**||||||",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr1_r",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "M..^",
            ".d..",
            "xd..",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr2_r",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "F...",
            "M.x.",
            "ddd.",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr3_r",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ccx^",
            "M...",
            "ddd.",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr1_l",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "^d.F",
            ".d..",
            ".xcc",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr2_l",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "^..F",
            ".d..",
            ".dcc",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "skyscraper_4x4_cr3_l",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "^FFF",
            "....",
            ".acc",
            "....",
        },
        palettes = { "skyscraper_office_palette" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
