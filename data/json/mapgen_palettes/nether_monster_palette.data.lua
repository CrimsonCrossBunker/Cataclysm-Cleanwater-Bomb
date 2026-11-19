local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_flesh_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_floor_flesh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_bone_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_floor_bone" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_wall_flesh_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_wall_flesh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_nm_flesh_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_floor_flesh_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_floor_flesh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_nm_flesh_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_slope_down_flesh_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_slope_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_nm_flesh_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_wall_bone_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_wall_bone" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_nm_bone_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_nm_wall_teeth_bone_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_wall_teeth" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_nm_bone_roof", x = 0, y = 0, z = 1 } },
    },
}
