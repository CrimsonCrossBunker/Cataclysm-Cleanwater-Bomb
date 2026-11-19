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

-- 4x4 fancy office upstairs on West side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_W4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "H dd",
            "H cd",
            "   d",
            " BBB",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 fancy office upstairs on West side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_W4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "HHBB",
            "H  d",
            "  cd",
            "  ix",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 fancy office upstairs on West side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_W4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "HH i",
            "H  d",
            "  cd",
            "  dd",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 fancy office upstairs on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_E4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dd H",
            "dc H",
            "d   ",
            "BBB ",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 fancy office upstairs on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_E4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBHH",
            "d  H",
            "dc  ",
            "xi  ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 fancy office upstairs on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_E4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "i HH",
            "d  H",
            "dc  ",
            "dd  ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "i c ",
            "    ",
            " HHH",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "B cd",
            "B  d",
            "i  d",
            "  cd",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ddiB",
            "dc i",
            "  cd",
            "  dd",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with entirely nether water
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    weight = 500,
    layout = {
        size = { width = 4, height = 4 },
        terrain = { [" "] = "t_nether_water_sh" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBHH",
            "i   ",
            "  cd",
            " xdd",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SWdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "cddc",
            "    ",
            " iBB",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on east side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "ic  ",
            "B   ",
            "BBB ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
                { group = "collection_mindsight_and_note", chance = 10 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on east side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    weight = 150,
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dðdd",
            "ic  ",
            "B   ",
            "BBB ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
            },
            ["ð"] = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "collection_force_field_and_note", chance = 100 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dc B",
            "d  B",
            "d  i",
            "dc  ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "Bidd",
            "i cd",
            "dc  ",
            "dd  ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "HHBB",
            "   i",
            "dc  ",
            "ddx ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 4x4 upstairs office with south wall door on East side
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_SEdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "cddc",
            "    ",
            "BBi ",
        },
        furniture = { i = "f_filing_cabinet" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 offices
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "dB rB",
            "dc  B",
            "Bf   ",
            "dc   ",
            "dx   ",
        },
        terrain = {
            [" "] = "t_floor",
            f = "t_floor",
            r = "t_floor",
            H = "t_floor",
            d = "t_floor",
            c = "t_floor",
            B = "t_floor",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            r = { group = "tools_science", chance = 80 },
            f = { group = "SUS_fridge_breakroom", chance = 50, repetitions = 4 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 offices
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "xddBl",
            "dc   ",
            "     ",
            "dc   ",
            "ddd  ",
        },
        terrain = {
            [" "] = "t_floor",
            f = "t_floor",
            r = "t_floor",
            H = "t_floor",
            d = "t_floor",
            c = "t_floor",
            l = "t_floor",
            s = "t_floor",
            B = "t_floor",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            r = { group = "tools_science", chance = 80 },
            f = { group = "SUS_fridge_breakroom", chance = 50, repetitions = 4 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 single office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " rHHH",
            "    H",
            "x    ",
            "dc   ",
            "ddBB ",
        },
        terrain = {
            [" "] = "t_floor",
            r = "t_floor",
            H = "t_floor",
            d = "t_floor",
            c = "t_floor",
            B = "t_floor",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            r = { group = "tools_science", chance = 80 },
            f = { group = "SUS_fridge_breakroom", chance = 50, repetitions = 4 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 single office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "dx  B",
            "dc  B",
            "f    ",
            "    c",
            "dHH  ",
        },
        terrain = {
            [" "] = "t_carpet_concrete_red",
            f = "t_carpet_concrete_red",
            r = "t_carpet_concrete_red",
            H = "t_carpet_concrete_red",
            d = "t_carpet_concrete_red",
            c = "t_carpet_concrete_red",
            B = "t_carpet_concrete_red",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            r = { group = "tools_science", chance = 80 },
            f = { group = "SUS_fridge_breakroom", chance = 50, repetitions = 4 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 three-seat office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_office_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "dxBdd",
            "ds cx",
            "B    ",
            "dc   ",
            "ddB  ",
        },
        terrain = {
            [" "] = "t_linoleum_gray",
            r = "t_linoleum_gray",
            d = "t_linoleum_gray",
            c = "t_linoleum_gray",
            s = "t_linoleum_gray",
            B = "t_linoleum_gray",
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 25, repetitions = { 1, 3 } },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            i = { group = "office", chance = 95 },
            r = { group = "tools_science", chance = 80 },
            f = { group = "SUS_fridge_breakroom", chance = 50, repetitions = 4 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
    },
}

-- 5x5 meeting room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_meeting_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " ctc ",
            " txt ",
            " ctc ",
            "     ",
        },
        terrain = { [" "] = "t_floor", c = "t_floor", t = "t_floor" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            t = {
                { group = "office", chance = 15, repetitions = 2 },
                { group = "electronics", chance = 5 },
                { group = "dist_lab_file_phavian_memo", chance = 3 },
            },
        },
    },
}

-- 5x5 meeting room with nether water
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_meeting_5x5",
    weight = 400,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " ctc ",
            " txt ",
            " ctc ",
            "     ",
        },
        terrain = { [" "] = "t_nether_water_sh", c = "t_nether_water_sh", t = "t_nether_water_sh" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            t = {
                { group = "office", chance = 15, repetitions = 2 },
                { group = "electronics", chance = 5 },
                { group = "dist_lab_file_phavian_memo", chance = 3 },
            },
        },
    },
}

-- 5x5 three-seat office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_meeting_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ccc ",
            "ctttc",
            "     ",
            "ctttc",
            " ccc ",
        },
        terrain = { [" "] = "t_floor", c = "t_floor", t = "t_floor" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            t = {
                { group = "office", chance = 15, repetitions = 2 },
                { group = "electronics", chance = 5 },
                { group = "dist_lab_file_phavian_memo", chance = 3 },
            },
        },
    },
}

-- 5x5 three-seat office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_meeting_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  c  ",
            " ctc ",
            " ctc ",
            " ctc ",
            "  c  ",
        },
        terrain = { [" "] = "t_floor", c = "t_floor", t = "t_floor" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            t = {
                { group = "office", chance = 15, repetitions = 2 },
                { group = "electronics", chance = 5 },
                { group = "dist_lab_file_phavian_memo", chance = 3 },
            },
        },
    },
}

-- 5x5 three-seat office
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_meeting_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "xx1xx",
            "cc cc",
            "     ",
            "cc cc",
            "xx1xx",
        },
        terrain = { [" "] = "t_floor", c = "t_floor", t = "t_floor", ["1"] = "t_floor" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
    },
}

-- 5x5 lab front room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_front_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bb  f",
            "Hs  f",
            "     ",
            "os   ",
            "bbbbS",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "psi_lab", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab front room catalytic fluid cracking workspace
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_front_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bb  f",
            "Us  f",
            "     ",
            "os   ",
            "bbbbS",
        },
        furniture = { U = "f_catalytic_cracking_reactor" },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_fluid_catalytic_lab", chance = 60, repetitions = { 1, 5 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab front room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_front_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bb bb",
            "Hs sH",
            "     ",
            "     ",
            "fCSCh",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 15, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab front room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_front_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bb dd",
            "bs cx",
            "     ",
            "bs  f",
            "bbSDC",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab front room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_front_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "F   h",
            "s S  ",
            "  b  ",
            " sbs ",
            "fbbbf",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            F = { group = "dissection", chance = 60, repetitions = { 1, 3 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab back room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_back_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bbSbb",
            "bs sb",
            "     ",
            " s   ",
            "Fbhf8",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "psi_lab", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            F = { group = "dissection", chance = 60, repetitions = { 1, 3 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab back room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_back_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bFSFb",
            "fs sf",
            "     ",
            " sHs ",
            "bbMbb",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "psi_lab", chance = 30, repetitions = { 1, 2 } },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            F = { group = "dissection", chance = 60, repetitions = { 1, 3 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab back room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_back_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bbSbb",
            "Fs sF",
            "     ",
            "#=#sb",
            "N #bb",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 15, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            F = { group = "dissection", chance = 60, repetitions = { 1, 3 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 5x5 lab back room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_back_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "dc|cd",
            "|-|-|",
            "     ",
            "|-|-|",
            "dc|cd",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            d = {
                { group = "office", chance = 50, repetitions = { 2, 5 } },
                { group = "tools_science", chance = 30, repetitions = { 1, 3 } },
                { group = "dist_lab_file_matrix_research", chance = 3 },
            },
        },
    },
}

-- 5x5 lab back room
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_2partworkspace_back_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "bbMbb",
            "SsGsF",
            "     ",
            "fsHsb",
            "bbMbb",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 15, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 60, repetitions = { 1, 5 } },
            F = { group = "dissection", chance = 60, repetitions = { 1, 3 } },
            S = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
        },
    },
}

-- 8x8 lobby cafe
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_cafe_8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrf%%%%%",
            "r%%%%%%%",
            "CCCCvvv%",
            " sss    ",
            "s    s  ",
            "ts  sts ",
            "  s  s  ",
            " sts    ",
        },
        terrain = { r = "t_linoleum_white", f = "t_linoleum_white" },
        furniture = { v = "f_glass_fridge" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            v = { group = "coffee_shop", chance = 90, repetitions = { 2, 10 } },
            C = { group = "coffee_shop", chance = 80, repetitions = { 2, 8 } },
            r = { group = "magazines", chance = 80, repetitions = { 2, 10 } },
        },
    },
}

-- 8x8 lobby cafe with alien overgrowth
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_cafe_8x8",
    weight = 500,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrf%%%%%",
            "r%%%%%%%",
            "CCCCvvv%",
            " sss    ",
            "s    s  ",
            "ts  sts ",
            "  s  s  ",
            " sts    ",
        },
        terrain = {
            r = "t_linoleum_white",
            f = "t_linoleum_white",
            [" "] = {
                { id = "t_grass_alien", copies = 3 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_strconc_floor", copies = 3 },
            },
            s = {
                { id = "t_grass_alien", copies = 3 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_strconc_floor", copies = 3 },
            },
            t = {
                { id = "t_grass_alien", copies = 3 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_strconc_floor", copies = 3 },
            },
            ["%"] = {
                { id = "t_grass_alien", copies = 1 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_linoleum_white", copies = 3 },
            },
        },
        furniture = { v = "f_glass_fridge" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            v = { group = "coffee_shop", chance = 90, repetitions = { 2, 10 } },
            C = { group = "coffee_shop", chance = 80, repetitions = { 2, 8 } },
            r = { group = "magazines", chance = 80, repetitions = { 2, 10 } },
        },
    },
}

-- 8x8 lobby comfy seating area
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_cafe_8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "HHH   HH",
            "Httc ctH",
            "Httc ctH",
            " cc  ctH",
            " cc   c ",
            "Httc    ",
            "Httc    ",
            "HHc     ",
        },
        furniture = {
            c = {
                { id = "f_armchair" },
                { id = "f_armchair" },
                { id = "f_null" },
                { id = "f_null" },
                { id = "f_null" },
                { id = "f_null" },
            },
        },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = { t = { group = "magazines", chance = 20 } },
    },
}

-- 8x8 lobby comfy seating area
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_cafe_8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "HHBHHBHH",
            "        ",
            "HHH     ",
            "ttH  Htt",
            "     HHH",
            " c      ",
            "ctc  ctc",
            " c      ",
        },
        furniture = { c = "f_armchair" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = { t = { group = "magazines", chance = 20 } },
    },
}

-- 8x8 lobby juice bar
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_cafe_8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "tt tt tt",
            "ss ss ss",
            "        ",
            "  ssss  ",
            "  CCCC  ",
            "  %%%C  ",
            "  x%%%  ",
            "  Cffr  ",
        },
        furniture = { f = "f_glass_fridge" },
        palettes = { "lab_surface_palette" },
        rotation = { 0, 3 },
        item_groups = {
            f = { group = "SUS_fridge_breakroom", chance = 90, repetitions = { 2, 4 } },
            C = { group = "produce", chance = 80, repetitions = { 2, 8 } },
            r = { group = "magazines", chance = 80, repetitions = { 2, 10 } },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- analytical lab with GC/HPLC/MS and NMR
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "ffC|bNb|FFb",
            "   |   |ssb",
            "::=|::=|  S",
            "          U",
            "GM   MH   U",
            "bs  sbbs  b",
            "bs  sbbs  b",
            "bb&  So   a",
            "####      S",
            "Ull#e     C",
            "   =    &CC",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 15, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- biolab with decon shower
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "ffC|hhh|Cff",
            "   |   |   ",
            "::=|A=A|:=:",
            "S         S",
            "bs  Sbs  sb",
            "F   Fb    o",
            "F  sbE    F",
            "bs       sb",
            "####e#=####",
            "Ull### llll",
            "   =H=    &",
        },
        furniture = { H = "f_shower" },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 15, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "dissection", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- biolab with imaging equipment
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "ffC|c O|c 0",
            "   |  I|  I",
            "::-|-::|-::",
            "           ",
            "     xx   b",
            "S    sx  sb",
            "bs    &   b",
            "bbF&     SC",
            "####e#=####",
            "Ull### llll",
            "   =H=    &",
        },
        furniture = { H = "f_shower" },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_placements = { { id = "matrix_crystal_biokinesis", x = 10, y = 0, chance = 30 } },
        item_groups = {
            b = {
                { group = "tools_science", chance = 15, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 15, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "dissection", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- lab with small sub-rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbFbbbbHMob",
            "bs sS s  sS",
            "f        &b",
            "#####-#####",
            "bbbS# #f bb",
            "Fs  - -  sb",
            "bbb&# #& Sb",
            "##### #####",
            "llUSC #8Hbb",
            "f   & -  sb",
            "      #f &S",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 15, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "dissection", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- microbio lab with EM and shakers
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbi|hhh|ffC",
            "Fs |   |   ",
            "b  |A=A|=::",
            "Fs         ",
            "b   Eb   ob",
            "b  sbbs  sb",
            "b  sbbs  sb",
            "a   So  &bb",
            "S      ####",
            "S     e#Ull",
            "CC&    =   ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 15, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom, black glass and crystal
-- microbio lab with EM and shakers
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbi|hhh|ffC",
            "Fs |   |   ",
            "b  |A=A|=::",
            "Fs         ",
            "b   Eb   ob",
            "b  sbbs  sb",
            "b  sbbs  sb",
            "a   So  &bb",
            "S      ####",
            "S     e#Ull",
            "CC&    =   ",
        },
        terrain = {
            _ = "t_nether_glass_floor",
            s = "t_nether_glass_floor",
            b = "t_nether_glass_floor",
            U = "t_nether_glass_floor",
            l = "t_nether_glass_floor",
        },
        furniture = {
            _ = { { id = "f_null", copies = 10 }, { id = "f_nether_crystal_structure", copies = 1 } },
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 15, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- lab with small sub-rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbFbbbbHMbb",
            "bs sS s  sS",
            "f        &b",
            "#####-#####",
            "bS f# #Sbbb",
            "bs  - -  sF",
            "F  &# #&obb",
            "bHSC# #####",
            "##### #& Gb",
            "llU#& -  sb",
            "   -  #S Fb",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 15, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "dissection", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- lab with small sub-rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbFbbbbHMbb",
            "bs sS s  sS",
            "f        &b",
            "#####-#####",
            "bbbS# #f Sb",
            "Fs  - -  sb",
            "bbo&# #&  F",
            "##### #CSHb",
            "bG &# #####",
            "bs  - &#Ull",
            "bF S#  -   ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 10, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "dissection", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- big analytical lab with most tools
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bFFb|N |ffC",
            "bssb|:-|   ",
            "S      |-:|",
            "bs bMH   &b",
            "b   bs   sb",
            "b  sb     F",
            "bs bbo   sb",
            "S  &SC  Sbb",
            "b      ####",
            "bs    &#Ull",
            "bbG    -   ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "distribution_matrix_dust", chance = 10, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- some sort of engineering lab with lots of computers and stuff
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "555555555dd",
            "         cx",
            ":A:A:-:A:A:",
            "           ",
            "f    E    &",
            "bx   bs  xb",
            "bs  sb   sb",
            "    xbx   b",
            "F        Ul",
            "bs         ",
            "bbb& CSC&  ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- psionic research lab, nether corrupted
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    weight = 600,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "5555bbbbbbb",
            "N__X_ś_X___",
            "x___xEx____",
            "ȼ________ȼx",
            ":A:A:-:A:A:",
            "i==e===== b",
            "i========sb",
            "dc==sb===xb",
            "F   sb   Ul",
            "bs         ",
            "bbb& CSC&  ",
        },
        terrain = {
            _ = "t_nether_glass_floor",
            X = "t_nether_glass_floor",
            E = "t_nether_glass_floor",
            ["ȼ"] = "t_nether_glass_floor",
            ["ś"] = "t_nether_glass_floor",
            ["="] = { { id = "t_nether_glass_floor", copies = 1 }, { id = "t_strconc_floor", copies = 1 } },
        },
        furniture = {
            ["ȼ"] = "f_counter",
            ["ś"] = "f_stool",
            _ = { { id = "f_null", copies = 10 }, { id = "f_nether_crystal_structure", copies = 1 } },
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        nested_glyphs = {
            X = {
                choices = { { id = "portal_field_concrete_floor", weight = 1 }, { id = "null", weight = 25 } },
            },
        },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
            E = { { group = "matrix_crystal_drained_group", chance = 100 } },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- psionic research lab, with possible matrix crystal
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "5555bbbbbbb",
            "N    s     ",
            "x   xEx    ",
            "c        cx",
            ":A:A:-:A:A:",
            "i  e      b",
            "i        sb",
            "dc  sb   xb",
            "F   sb   Ul",
            "bs         ",
            "bbb& CSC&  ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_placements = { { id = "schematics_matrix_crystal_ground", x = 0, y = 10, chance = 75 } },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
            E = {
                { group = "matrix_crystal_drained_group", chance = 85 },
                { group = "dist_matrix_crystals", chance = 50 },
            },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- psionic research lab, with possible matrix crystal
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "bbbbbbb5555",
            "     s    N",
            "    xEx   x",
            "xc        c",
            ":A:A:-:A:A:",
            "b     e   i",
            "bs        i",
            "bx   bs  cd",
            "lU   bs   F",
            "         sb",
            "  &CSC &bbb",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_placements = { { id = "schematics_matrix_crystal_ground", x = 10, y = 10, chance = 75 } },
        item_groups = {
            b = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            U = { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            l = { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
            E = {
                { group = "matrix_crystal_drained_group", chance = 85 },
                { group = "dist_matrix_crystals", chance = 50 },
            },
        },
    },
}

-- 11x11 large lab workspace, doors left side bottom
-- lab with small sub-rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Wdoor_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "BbbbUUUdddd",
            "Bc c     cd",
            "B   1 &  &d",
            "#####-#####",
            "bbbS# #BBdd",
            "Es  - -  cd",
            "bbb&# #&1Sd",
            "##### #####",
            "lllSC #bbbb",
            "f   & -  sb",
            "      #f1&S",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            B = {
                { group = "psionic_recipes_beginner", chance = 25 },
                { group = "psionic_recipes_armor", chance = 5 },
                { group = "psionic_recipes_medicine", chance = 5 },
                { group = "lab_bookshelves", chance = 50, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            d = {
                { group = "tools_electronics", chance = 40, repetitions = { 1, 2 } },
                { group = "supplies_metal", chance = 30, repetitions = { 1, 2 } },
                { group = "supplies_metal_precious", chance = 15, repetitions = { 1, 2 } },
                { group = "matrix_crystal_drained_group", chance = 40, repetitions = { 1, 3 } },
            },
            U = {
                { group = "tools_electronics", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_metal", chance = 30, repetitions = { 1, 4 } },
                { group = "supplies_metal_precious", chance = 25, repetitions = { 1, 3 } },
                { group = "distribution_matrix_dust", chance = 35, repetitions = { 1, 4 } },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            E = {
                { group = "matrix_crystal_drained_group", chance = 55 },
                { group = "dist_matrix_crystals", chance = 10 },
            },
        },
    },
}

-- 11x11 large lab workspace, doors right side bottom
-- lab with small sub-rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "psi_phavian_lab_workspace_Edoor_11x11",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "ddddUUUbbbB",
            "dc     c cB",
            "d&  & 1   B",
            "#####-#####",
            "BBdd# #Sbbb",
            "dc  - -  sE",
            "dS1&# #&bbb",
            "##### #####",
            "bbbb# CSUll",
            "bs  - &   f",
            "S&1f#      ",
        },
        palettes = { "lab_workspace_palette" },
        rotation = { 0, 3 },
        item_groups = {
            b = { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            B = {
                { group = "psionic_recipes_beginner", chance = 20 },
                { group = "psionic_recipes_armor", chance = 5 },
                { group = "psionic_recipes_medicine", chance = 5 },
                { group = "lab_bookshelves", chance = 50, repetitions = { 1, 3 } },
            },
            f = { group = "supplies_reagents_lab", chance = 70, repetitions = { 2, 5 } },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            d = {
                { group = "tools_electronics", chance = 40, repetitions = { 1, 2 } },
                { group = "supplies_metal", chance = 30, repetitions = { 1, 2 } },
                { group = "supplies_metal_precious", chance = 15, repetitions = { 1, 2 } },
                { group = "matrix_crystal_drained_group", chance = 40, repetitions = { 1, 3 } },
            },
            U = {
                { group = "tools_electronics", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_metal", chance = 30, repetitions = { 1, 4 } },
                { group = "supplies_metal_precious", chance = 25, repetitions = { 1, 3 } },
                { group = "distribution_matrix_dust", chance = 35, repetitions = { 1, 4 } },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            E = {
                { group = "matrix_crystal_drained_group", chance = 55 },
                { group = "dist_matrix_crystals", chance = 10 },
            },
        },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "supplies_reagents_lab", x = 0, y = 0, chance = 90, repetitions = { 5, 20 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "tools_science", x = 0, y = 0, chance = 90, repetitions = { 5, 10 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "electronics", x = 0, y = 0, chance = 90, repetitions = { 1, 10 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "hardware_bulk", x = 0, y = 0, chance = 90, repetitions = { 1, 5 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "produce", x = 0, y = 0, chance = 90, repetitions = { 5, 10 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "supplies_samples_lab", x = 0, y = 0, chance = 90, repetitions = { 10, 20 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "snacks", x = 0, y = 0, chance = 50, repetitions = { 5, 10 } } },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_cardboard_box", copies = 2 },
                { id = "f_crate_c", copies = 3 },
                { id = "f_crate_o" },
            },
        },
        item_group_placements = { { group = "hospital_lab", x = 0, y = 0, chance = 90, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_counter" },
        item_group_placements = { { group = "snacks", x = 0, y = 0, chance = 60, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_fridge" },
        item_group_placements = {
            { group = "SUS_fridge", x = 0, y = 0, chance = 60, repetitions = { 1, 3 } },
            { group = "SUS_fridge_breakroom", x = 0, y = 0, chance = 60, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = { { id = "f_IV_pole" }, { id = "f_desk" }, { id = "f_counter" } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        terrain = { X = { { id = "t_grass_alien" } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = { { id = "f_autoclave" }, { id = "f_console_broken" }, { id = "f_centrifuge" } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = {
            X = {
                { id = "f_machinery_old" },
                { id = "f_machinery_light" },
                { id = "f_machinery_electronic" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_glass_cabinet" },
        item_group_placements = { { group = "lab_bookshelves", x = 0, y = 0, chance = 70, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "surface_sub_hall_clutter",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        furniture = { X = "f_glass_cabinet" },
        item_group_placements = {
            {
                group = "distribution_matrix_dust",
                x = 0,
                y = 0,
                chance = 50,
                repetitions = { 1, 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "portal_field_nether_water",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_nether_water_sh", x = 0, y = 0 } },
        field_placements = { { id = "fd_fatigue", x = 0, y = 0, intensity = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "portal_field_concrete_floor",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_strconc_floor", x = 0, y = 0 } },
        field_placements = { { id = "fd_fatigue", x = 0, y = 0, intensity = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "portal_field_floor",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_floor", x = 0, y = 0 } },
        field_placements = { { id = "fd_fatigue", x = 0, y = 0, intensity = 3 } },
    },
}
