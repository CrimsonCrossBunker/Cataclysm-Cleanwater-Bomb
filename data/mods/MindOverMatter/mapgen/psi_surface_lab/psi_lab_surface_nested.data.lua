local ccb = require("ccb")

-- 11x11 round meeting room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "   ccccc   ",
            "  ctttttc  ",
            " cttxtxttc ",
            " ctx   xtc ",
            " ctt   ttc ",
            " ctx   xtc ",
            " cttxtxttc ",
            "  ctttttc  ",
            "   ccccc   ",
            "           ",
        },
        palettes = { "lab_surface_palette" },
        item_groups = { c = { group = "office", chance = 8 }, t = { group = "electronics", chance = 15 } },
        rotation = { 0, 3 },
    },
}

-- 11x11 round meeting room filled with the black seas of infinity
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    weight = 400,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "   ccccc   ",
            "  ctttttc  ",
            " cttxtxttc ",
            " ctx   xtc ",
            " ctt   ttc ",
            " ctx   xtc ",
            " cttxtxttc ",
            "  ctttttc  ",
            "   ccccc   ",
            "           ",
        },
        terrain = {
            c = "t_nether_water_sh",
            t = "t_nether_water_sh",
            x = "t_nether_water_sh",
            [" "] = "t_nether_water_sh",
        },
        palettes = { "lab_surface_palette" },
        item_groups = { c = { group = "office", chance = 8 }, t = { group = "electronics", chance = 15 } },
        rotation = { 0, 3 },
    },
}

-- 11x11 room where everything has been eaten by nether water
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        terrain = { [" "] = "t_nether_water_sh" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 11x11 small lecture room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "  dc dc dc ",
            "% dc dc dc ",
            "% dc dc dc ",
            "% dc dc dc ",
            "%          ",
            "% dc dc dc ",
            "% dc dc dc ",
            "% dc dc dc ",
            "  dc dc dc ",
            "           ",
        },
        terrain = { ["%"] = "t_carpet_concrete_yellow" },
        palettes = { "lab_surface_palette" },
        item_groups = { d = { group = "office", chance = 8 } },
        rotation = { 0, 3 },
    },
}

-- 11x11 computer lab
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            "           ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            " cxxc cxxc ",
            "           ",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 11x11 presentation room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_room_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            " %%%%%s%%% ",
            "  %r%%Cx%  ",
            "           ",
            " cccc cccc ",
            " cccc cccc ",
            " cccc cccc ",
            " cccc cccc ",
            " cccc cccc ",
            " cccc cccc ",
            " cccc cccc ",
            "           ",
        },
        terrain = {
            [" "] = "t_carpet_concrete_red",
            c = "t_carpet_concrete_red",
            ["%"] = "t_floor",
            r = "t_floor",
            s = "t_floor",
            C = "t_floor",
        },
        palettes = { "lab_surface_palette" },
        item_groups = { c = { group = "office", chance = 10 }, C = { group = "office", chance = 45 } },
        rotation = { 0, 3 },
    },
}

-- 12x12 lobby centerpiece
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_centerpiece_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "  ]]]]]]]]  ",
            " ]]~~~~~~]] ",
            "]]~~..i.~~]]",
            "]~~.bI#B.~~]",
            "]~.i####I.~]",
            "]~.bB#|##i~]",
            "]~.b##|#I.~]",
            "]~i.I###b.~]",
            "]~~..#IBi~~]",
            "]]~~.I..~~]]",
            " ]]~~~~~~]] ",
            "  ]]]]]]]]  ",
        },
        terrain = {
            ["~"] = "t_water_sh",
            ["."] = { { id = "t_grass" }, { id = "t_grass_long" }, { id = "t_grass_tall" } },
            ["#"] = "t_rock_wall",
            B = "t_grass",
            b = "t_grass",
            I = { { id = "t_tree_maple" }, { id = "t_tree_dead_warped" } },
            i = { { id = "t_tree_young" }, { id = "t_tree_dead_warped" } },
        },
        furniture = { B = "f_boulder_medium", b = "f_boulder_small" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 12x12 lobby centerpiece
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_centerpiece_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "]]]]   bbbbb",
            "].~]   ]]]]b",
            "]iB]   ]i.]b",
            "]]]]   ]~I]b",
            "       ]]]]b",
            "b]]]]]      ",
            "b]B~~]      ",
            "b].I.]  ]]]]",
            "b]~~B]  ]~.]",
            "b]]]]]  ]BI]",
            "bbbbbb  ]]]]",
            "        bbbb",
        },
        terrain = {
            ["~"] = "t_water_sh",
            ["."] = { { id = "t_grass" }, { id = "t_grass_long" }, { id = "t_grass_tall" } },
            ["#"] = "t_rock_wall",
            B = "t_grass",
            I = { { id = "t_tree_maple" }, { id = "t_tree_dead_warped" } },
            i = { { id = "t_tree_young" }, { id = "t_tree_dead_warped" } },
        },
        furniture = { B = "f_boulder_small" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 12x12 lobby centerpiece
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_centerpiece_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "  ]]]]]]]]  ",
            " ]]bbbbbb]] ",
            "]]........]]",
            "]b..~~~~..b]",
            "]b.~~~~~~.b]",
            "]b.~~SS~~.b]",
            "]b.~~SS~~.b]",
            "]b.~~~~~~.b]",
            "]b..~~~~..b]",
            "]]........]]",
            " ]]bbbbbb]] ",
            "  ]]]]]]]]  ",
        },
        terrain = { b = "t_grass", S = "t_sidewalk", ["~"] = "t_water_sh" },
        furniture = { S = "f_statue" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 12x12 lobby centerpiece
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_centerpiece_12x12",
    weight = 500,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "  ]]]]]]]]  ",
            " ]]bbbbbb]] ",
            "]]........]]",
            "]b..~~~~..b]",
            "]b.~X~~X~.b]",
            "]b.~~SS~~.b]",
            "]b.~~SS~~.b]",
            "]b.~X~~X~.b]",
            "]b..~~~~..b]",
            "]]........]]",
            " ]]bbbbbb]] ",
            "  ]]]]]]]]  ",
        },
        terrain = { b = "t_grass", S = "t_sidewalk", ["~"] = "t_nether_water_sh" },
        furniture = { S = "f_statue" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        nested_glyphs = {
            X = {
                choices = { { id = "portal_field_nether_water", weight = 1 }, { id = "null", weight = 20 } },
            },
        },
    },
}

-- 12x12 lobby centerpiece
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_centerpiece_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "bbbb]]]]bbbb",
            "b||b %% b||b",
            "b||b %% b||b",
            "bbbb %% bbbb",
            "]   :%%:   ]",
            "]%%%%DF%%%%]",
            "]%%%%FD%%%%]",
            "]   :%%:   ]",
            "bbbb %% bbbb",
            "b||b %% b||b",
            "b||b %% b||b",
            "bbbb]]]]bbbb",
        },
        terrain = { b = "t_sidewalk" },
        furniture = { S = "f_statue" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}
