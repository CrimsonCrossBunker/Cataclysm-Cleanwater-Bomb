local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_tunnel_base",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
            "************************",
        },
        palettes = { "afs_tunnel_any" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tunnel_natural_feature",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "  ,, ,,,    ",
            " ,,,,,,  ,, ",
            "  ,,IssI,,, ",
            "   ,s,ww,,, ",
            "  ,,,sww ,  ",
            "  ,,Iww,,,, ",
            "  ,wwI,, ,  ",
            "    ww,I    ",
            "   , ,,,    ",
            "   ,    ,,  ",
            "            ",
        },
        palettes = { "afs_tunnel_any" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tunnel_natural_feature",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "            ",
            "  ,##  ##   ",
            "  ##  ,###  ",
            "    ,,ss,   ",
            "  ##ss ,,,  ",
            "  ###   s   ",
            "   #  ww##  ",
            "         ## ",
            "    ######  ",
            "      ##    ",
        },
        palettes = { "afs_tunnel_any" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tunnel_natural_feature",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " ,,I    ,   ",
            " ,,,   ,,,  ",
            "s,,#,I ,,,, ",
            "  #sss,,,#, ",
            ",Iss,,ss,,, ",
            ",,,,,sss,,, ",
            " ,,,,  II,  ",
            " ,,#,,,,##,,",
            ",,,I ,,  ## ",
            "     I#,,#, ",
            "         ,, ",
        },
        palettes = { "afs_tunnel_any" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
