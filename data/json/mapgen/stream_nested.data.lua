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
