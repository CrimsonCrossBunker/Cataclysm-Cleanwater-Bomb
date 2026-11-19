local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_01",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " .~ ",
            "..~ ",
            "...~",
            " ..~",
        },
        terrain = { ["."] = "t_clay", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_02",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " .~ ",
            "...~",
            " ..~",
            ". ~~",
        },
        terrain = { ["."] = "t_clay", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_03",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ",i~ ",
            "iii~",
            "iii~",
            ",i~ ",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_04",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ",i~ ",
            ",,i~",
            " ,i~",
            ",i~~",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_06",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ",i~ ",
            ",ii~",
            ",,i~",
            ",i~ ",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_01",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ~. ",
            "~.. ",
            "~.. ",
            " ~  ",
        },
        terrain = { ["."] = "t_clay", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_02",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ~. ",
            " ~..",
            "~.. ",
            "~.  ",
        },
        terrain = { ["."] = "t_clay", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_03",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ~i,",
            "~ii,",
            "~ii,",
            " ~i,",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_04",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ~i,",
            "~ii,",
            "~i, ",
            " ~,,",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_05",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ~~ ",
            "~~~~",
            "~~~ ",
            " ~ ~",
        },
        terrain = { ["#"] = "t_dirtmound", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_lr_06",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "~i, ",
            "~i, ",
            "~~i,",
            "~~i,",
        },
        terrain = { i = "t_water_moving_sh", ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        furniture = { i = "f_cattails" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_8x8_ll_02",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ,~~,, ",
            " ,,~,,~,",
            " ,~~,,, ",
            ",~,,,,, ",
            ",~~,,,~,",
            " ,~,,~, ",
            "  ,~~~, ",
            ", ,~~,  ",
        },
        terrain = { ["~"] = "t_water_moving_sh", [","] = "t_grass_long" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_4x4_ll_05",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "  ~ ",
            "  ~ ",
            " # ~",
            "   ~",
        },
        terrain = { ["#"] = "t_dirtmound", ["~"] = "t_water_moving_sh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { id = "mon_squirrel_red", x = 2, y = 3 } },
        loot_placements = { { id = "hazelnut", x = 1, y = 2 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stream_8x8_ll_01",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ----^ ",
            "^-------",
            " -------",
            "-------^",
            "------- ",
            "  ####  ",
            "   ~  ^ ",
            "^  ~^  ^",
        },
        terrain = {
            ["-"] = "t_water_sh",
            ["~"] = "t_water_moving_sh",
            [","] = "t_grass_long",
            ["^"] = "t_stump",
        },
        furniture = { ["#"] = "f_beaver_dam" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { id = "mon_beaver", x = { 0, 8 }, y = { 0, 8 }, repetitions = 8 } },
    },
}
