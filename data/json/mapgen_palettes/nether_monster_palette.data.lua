local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "nether_monster_palette",
    layout = {
        field_glyphs = { q = { id = "fd_fatigue", intensity = 1 }, Q = { id = "fd_fatigue", intensity = 2 } },
        terrain = {
            ["#"] = "t_nm_wall_flesh",
            O = "t_nm_wall_flesh_pupating",
            ["@"] = "t_nm_wall_bone",
            B = "t_nm_ichor_sh",
            C = "t_nm_cartilage",
            X = "t_soil",
            x = "t_dirt_underground",
            T = "t_nm_wall_teeth",
        },
        furniture = {
            g = "f_nm_tube",
            G = "f_nm_tube_emitter",
            f = "f_nm_nether_lily",
            F = "f_nm_nether_patchwork",
            l = "f_nm_nether_grass",
            L = "f_nm_nether_grass_tall",
            Z = "f_nm_nether_lichen",
        },
        traps = { P = "tr_portal" },
    },
}

ccb.content.define_mapgen_palette {
    id = "nether_monster_surface_palette",
    layout = {
        nested_glyphs = {
            ["#"] = { id = "nest_nm_wall_flesh_roof" },
            ["="] = { id = "nest_nm_floor_flesh_roof" },
            ["<"] = { id = "nest_nm_slope_down_flesh_roof" },
            ["@"] = { id = "nest_nm_wall_bone_roof" },
            T = { id = "nest_nm_wall_teeth_bone_roof" },
        },
    },
}

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
