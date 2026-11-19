local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_b",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "CCCCCCCCCCCCCC       ",
            "#:#:####+##::####### ",
            "..A..It............# ",
            ".EE..It............I ",
            ".....It..JJJJ......+.",
            "EE.EEIO..JJJJ...333I.",
            "AA.AAIo.........3.HI.",
            "EE.EEIo..iiii...H.i:.",
            "AA.AAIo..iiii...H.i:.",
            "IIDIIII.........3.iI.",
            ".........iiii...c.gI.",
            ".....I...iiii...3.gI.",
            "IDIDII.........IIIII.",
            "&.I.&I.........D...I.",
            "q.I.qIggggghhhhI...I.",
            "IIIIIIIIIIIIIIII...I.",
            "q.I..nnnA.IBBBF....I.",
            "&.D..AA...D........I+",
            "###l....n.I........D.",
            "wC+...fpppIBBBBBBBBI.",
            "wC###################",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_safes_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".LL.",
            ".LL.",
            ".//.",
            ".44.",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_safes_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".LL.",
            ".LL.",
            ".//.",
            ".44.",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_storage_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBBB",
            "B..B",
            "B..F",
            "II+I",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_unlooted_storage_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBBB",
            "B..B",
            "B..F",
            "II+I",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "destroyed_furniture_concrete_floor",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "a",
        },
        terrain = { a = "t_thconc_floor" },
        flags = { "DISMANTLE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "no_items_concrete_floor",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_thconc_floor" },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN", "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_occupied_a",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            ",,''''''''''''''''",
            "'CCCCCCCC'''''''''",
            "##:::##+##########",
            "!dddddjjj/3$dIa4ga",
            "SG..../...3.dI.../",
            ".G....gA..3tdIa../",
            "!g..Annn..dttIIIPI",
            ".g/...A...dttD...A",
            "..........ddcI...n",
            "SG...........D...A",
            "Gg.i.iK....GdI...q",
            "...i.iK....GdIK/Y/",
            ".g.i.i.....KdIYYjY",
            "............A###+#",
            "Gg..........A+ www",
            "Gg....BBBSIID# w  ",
            "G......G.SIo.#   x",
            "S.Sttt.SSSI&q#xxxx",
        },
        palettes = { "gunstore_palette_occupied" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_group_placements = { { group = "GROUP_PREPPER_HOUSE", x = { 5, 13 }, y = { 5, 13 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_a",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            ",,''''''''''''''''",
            "'CCCCCCCC'''''''''",
            "##:::##+##########",
            "!gggggjjj$3.hIBBBB",
            "S.........3.gIB..B",
            "!0...iJ...3.gIB..F",
            "!....iJ...H..III+I",
            "S....i!...H..D...E",
            "S....i!...kHcI...n",
            "S............D...f",
            "S.YK.ii.J...hIn..q",
            "!.Yt.ii.J...hInA.r",
            "S.Yt.ii.J...hInA.l",
            "S.Oo.ii.J....###+#",
            "!.Oo.ii.J....+wwwx",
            "!.Oo.ii.!.IID#wxxx",
            "S.........I..#xx..",
            "SS!!SSS!S!I&q#....",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "gunstore_barricaded_safes_a", weight = 50 },
                    { id = "gunstore_barricaded_handloading_a", weight = 50 },
                },
            },
        },
        loot_placements = { { group = "SUS_gunstore_optics_display", x = 10, y = 8, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_a",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            ",,''''''''''''''''",
            "''''''''''''''''''",
            "##:::##+##########",
            "!gggggjjj$3.gI1   ",
            "S.........3.gI    ",
            "!0...iJ...3.gI    ",
            "!....iJ...H..I    ",
            "S....i!...H..D...A",
            "S....i!...kHcI...n",
            "S............D...f",
            "S.YK.ii.J...hIn..q",
            "!.Yt.ii.J...hInA.r",
            "S.Yt.ii.J...hInA.l",
            "S.Oo.ii.J....###+#",
            "!.Oo.ii.J....+...w",
            "!.Oo.ii.!.IID#....",
            "S.........I..#w...",
            "SS!!SSS!S!I&q#w...",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "gunstore_looted_safes_a", weight = 50 },
                    { id = "gunstore_looted_handloading_a", weight = 50 },
                },
            },
            ["1"] = {
                choices = {
                    { id = "gunstore_looted_storage_a", weight = 9 },
                    { id = "gunstore_unlooted_storage_a", weight = 1 },
                },
            },
            ["."] = {
                choices = { { id = "gunstore_looted_floor", weight = 4 }, { id = "null", weight = 20 } },
            },
        },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 2, 16 }, y = { 4, 16 } } },
        loot_placements = { { group = "SUS_gunstore_optics_display", x = 10, y = 8, repetitions = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_ransacked_a",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            ",,''''''''''''''''",
            "''''''''''''''''''",
            "##:::##+##########",
            "!gggggjjj$3.gIBBBB",
            "S.........3.gIB..B",
            "!0...iJ...3.gIB..F",
            "!....iJ...H..III+I",
            "S....i!...H..D...A",
            "S....i!...kHcI...n",
            "S............D...f",
            "S.YK.ii.J...hIn..q",
            "!.Yt.ii.J...hInA.r",
            "S.Yt.ii.J...hInA.l",
            "S.Oo.ii.J....###+#",
            "!.Oo.ii.J....+...w",
            "!.Oo.ii.!.IID#....",
            "S.........I..#w...",
            "SS!!SSS!S!I&q#w...",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "gunstore_looted_safes_a", weight = 50 },
                    { id = "gunstore_looted_handloading_a", weight = 50 },
                },
            },
            g = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            h = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            H = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            Y = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 23 },
                },
            },
            i = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 15 },
                },
            },
            J = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 20 },
                },
            },
            t = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 30 },
                },
            },
            O = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 20 },
                },
            },
            o = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 35 },
                },
            },
            K = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 30 },
                },
            },
            ["!"] = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 30 },
                },
            },
            S = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 30 },
                },
            },
            ["."] = {
                choices = { { id = "gunstore_looted_floor", weight = 10 }, { id = "null", weight = 20 } },
            },
        },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 2, 16 }, y = { 4, 16 }, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_occupied_b",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "CCCCCCCCCCCCCC       ",
            "#:#:####+##::####### ",
            ".....IdGGGUUUUG....# ",
            ".....IdA....G.....GI ",
            ".....Id...t.......U+.",
            ".....Id...t.....333I.",
            ".....Id.........3.dI.",
            ".....Id.....t...d.i:.",
            ".EEE.Id...ttt...d.i:.",
            "IIDIIII.........3.iI.",
            ".UUU.......t....c.dI.",
            ".....I..iiii....3.dI.",
            "IDIDII..iiii...IIIII.",
            "&.I.&I.........D../I.",
            "qoI.qIdddddddddI..aI.",
            "IIIIIIIIIIIIIIII..nI.",
            "q.IttnnnA/Igggii..nI.",
            "&.D..AA...D......./I+",
            "###l....n.Ia.......D.",
            "wC+A..fpppIgGGa.i.aI.",
            "wC###################",
        },
        palettes = { "gunstore_palette_occupied" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_group_placements = { { group = "GROUP_PREPPER_HOUSE", x = { 6, 20 }, y = { 7, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_b",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "                     ",
            "#:#:####+##::####### ",
            "..A..It............# ",
            ".EE..It............I ",
            ".....It..JJJJ......+.",
            "EE.EEIO..JJJJ...333I.",
            "AA.AAIo.........3.HI.",
            "EE.EEIo..iiii...H.i:.",
            "AA.AAIo..iiii...H.i:.",
            "IIDIIII.........3.iI.",
            ".........iiii...c.gI.",
            ".....I...iiii...3.gI.",
            "IDIDII.........IIIII.",
            "&.I.&I.........D...I.",
            "q.I.qIggggghhhhI...I.",
            "IIIIIIIIIIIIIIII...I.",
            "q.I..nnnA.IBBBF....I.",
            "&.D..AA...D........I+",
            "###l....n.I........D.",
            "w +...fpppIBBBBBBBBI.",
            "w ###################",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["."] = {
                choices = { { id = "gunstore_looted_floor", weight = 4 }, { id = "null", weight = 20 } },
            },
        },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 6, 20 }, y = { 7, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_ransacked_b",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "                     ",
            "#:#:####+##::####### ",
            "..A..It............# ",
            ".EE..It............I ",
            ".....It..JJJJ......+.",
            "EE.EEIO..JJJJ...333I.",
            "AA.AAIo.........3.HI.",
            "EE.EEIo..iiii...H.i:.",
            "AA.AAIo..iiii...H.i:.",
            "IIDIIII.........3.iI.",
            ".........iiii...c.gI.",
            ".....I...iiii...3.gI.",
            "IDIDII.........IIIII.",
            "&.I.&I.........D...I.",
            "q.I.qIggggghhhhI...I.",
            "IIIIIIIIIIIIIIII...I.",
            "q.I..nnnA.IBBBF....I.",
            "&.D..AA...D........I+",
            "###l....n.I........D.",
            "w +...fpppIBBBBBBBBI.",
            "w ###################",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            g = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            h = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            H = {
                choices = { { id = "no_items_concrete_floor", weight = 50 }, { id = "null", weight = 50 } },
            },
            i = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 15 },
                },
            },
            J = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 20 },
                },
            },
            t = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 30 },
                },
            },
            O = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 20 },
                },
            },
            o = {
                choices = {
                    { id = "destroyed_furniture_concrete_floor", weight = 10 },
                    { id = "no_items_concrete_floor", weight = 60 },
                    { id = "null", weight = 35 },
                },
            },
            ["."] = {
                choices = { { id = "gunstore_looted_floor", weight = 10 }, { id = "null", weight = 20 } },
            },
        },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 6, 20 }, y = { 7, 20 }, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_handloading_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".``.",
            ".``.",
            ".``.",
            ".33.",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_placements = { { id = "press", x = 1, y = 3 }, { id = "press", x = 2, y = 3 } },
        loot_placements = { { group = "boxed_primers_full", x = { 1, 2 }, y = 3, repetitions = { 16, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_handloading_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".``.",
            ".``.",
            ".``.",
            ".33.",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_placements = { { id = "press", x = { 1, 2 }, y = 3, chance = 20 } },
        loot_placements = { { group = "boxed_primers_full", x = { 1, 2 }, y = 3, repetitions = { 0, 6 } } },
    },
}
