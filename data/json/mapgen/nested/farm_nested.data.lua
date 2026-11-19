local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_haybale",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "@@",
            "@@",
        },
        palettes = { "farm_lots" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%%%%%%%%%%%%%%%%%%%%%%%/",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "////////////////////////",
            "////////////////////////",
            "%%H/////////////////%%%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%/////////////////////%/",
            "%%%%%%%%%%%%%%%%%%%%%%%/",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence3",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "%%%%%//////////////%%%%%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "P//////////////////////%",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "PPPPPPPPPPPPPPPPPPPPPPPP",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence4",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "PPPP%%%%PPPPPPPP%%%%PPPP",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence5",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "PPPPPP%%%//////%%%PPPPPP",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "P//////////////////////P",
            "PPPPPPPPPPPPPPPPPPPPPPPP",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence6",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%//////////////////////%",
            "%%%%%%%%%%%//%%%%%%%%%%%",
        },
        palettes = { "farm_house" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dirtroad_to_farm_2side",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "..........//i//.........",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
        },
        palettes = { "farm_lots" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dirtroad_to_farm_stills",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "..//i//.................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
        },
        palettes = { "farm_lots" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dirtroad_to_farm_parking",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "/ii//.iiiiiiiiiiii../ii/",
            "//ii/..iiiiiiiiii../ii//",
            "//......................",
            "........................",
            "........................",
            ".../ii...iiiiii...ii///.",
            "..////i.../ii....i////..",
            "....///ii.//...ii///....",
            ".....///ii.//.ii///.....",
            "......//.i.//.i.//......",
            "......//.i.//.i.//......",
            "......./...//.../.......",
            "......./...//.../.......",
        },
        palettes = { "farm_lots" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dirtroad_to_farm_twd",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "iiiiiiiii...............",
            "iiiiiiiiiiiii...........",
            "iiiiiiiiiiiiii..........",
            "/////////iiiiii.........",
            "/////////////ii.........",
            "//////////////i.........",
            "iiiiiiii///////.........",
            "iiiiiiiiiii////.........",
            "////////iiii///i........",
            "//////////ii///i........",
            "//////////ii///i........",
            ".......///ii////........",
            ".......////ii///........",
            "........///ii///........",
            "........///ii///........",
            "........///ii///........",
        },
        palettes = { "farm_lots" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shed_5x5_garden_E_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "-----",
            "-...-",
            "-...-",
            "-...-",
            "-----",
        },
        palettes = { "roof_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_paddock_gate_n",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  c  ",
            "?___?",
            "___??",
            "????_",
            " ?_? ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_paddock_gate_e",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ?_? ",
            "??__ ",
            "_?__c",
            "???_ ",
            " _?? ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_paddock_gate_s",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ?_? ",
            "????_",
            "___??",
            "?___?",
            "  c  ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_paddock_gate_w",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ?_? ",
            " __??",
            "c__?_",
            " _???",
            " ??_ ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_tree_benches",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "___",
            "_t_",
            "___",
        },
        terrain = { t = "t_region_tree_forest" },
        furniture = { _ = "f_bench" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_stumps",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "s s",
            "   ",
            " s ",
        },
        terrain = { s = "t_stump" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_firering",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "s s",
            " f ",
            " s ",
        },
        terrain = { s = "t_stump" },
        furniture = { f = "f_firering" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_horseposts",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "% %",
            "   ",
            "%  ",
        },
        terrain = { ["%"] = "t_splitrail_fence" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_shed_trail_supplies_N_roof",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "---",
            "-.-",
            "---",
        },
        palettes = { "roof_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_paddock_feeder",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "?__?",
            "_rr_",
            "_rr_",
            "?__?",
        },
        palettes = { "paddock" },
        terrain = { r = "t_cattle_feeder" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "2x2_feed", weight = 50 } },
                x = 1,
                y = 1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_showjump_EW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "?e?",
            "_j_",
            "?e?",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_showjump_NS",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "?_?",
            "eje",
            "?_?",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_showjump_shrub_NS",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " ?_? ",
            "sejes",
            " ?_? ",
            "     ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_showjump_shrub_EW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  s  ",
            " ?e? ",
            "?_j_?",
            " ?e? ",
            "  s  ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_showjump_water_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "www",
            "eje",
            "?_?",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_showjump_water_W",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "we?",
            "wj_",
            "we?",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_showjump_shrubs_water_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " ?_? ",
            "sejes",
            " www ",
            "     ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_showjump_shrubs_water_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  s  ",
            " ?ew ",
            " _jw ",
            " ?ew ",
            "  s  ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_paddock_divider_v",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "                        ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "           %            ",
            "                        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "5x5_paddock_gate_e", x = 7, y = 2 },
            { id = "5x5_paddock_gate_w", x = 11, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_paddock_divider_h",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "%%%% %%%%%%%%%%%%%%%%%% ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "5x5_paddock_gate_n", x = 2, y = 11 },
            { id = "5x5_paddock_gate_s", x = 2, y = 7 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_paddock_divider_d_U",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                      % ",
            "                    %c% ",
            "                    %   ",
            "                   %%   ",
            "                   %    ",
            "                  %%    ",
            "                  %     ",
            "                 %%     ",
            "                 %      ",
            "                %%      ",
            "                %       ",
            "               %%       ",
            "               %        ",
            "              %%        ",
            "              %         ",
            "             %%         ",
            "             %          ",
            "            %%          ",
            "            %           ",
            "           %%           ",
            "           %            ",
            "                        ",
            "                        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_paddock_divider_d_D",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "%                       ",
            "%c%                     ",
            "  %                     ",
            "  %%                    ",
            "   %                    ",
            "   %%                   ",
            "    %                   ",
            "    %%                  ",
            "     %                  ",
            "     %%                 ",
            "      %                 ",
            "      %%                ",
            "       %                ",
            "       %%               ",
            "        %               ",
            "        %%              ",
            "         %              ",
            "         %%             ",
            "          %             ",
            "          %%            ",
            "           %            ",
            "                        ",
            "                        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_fence_gate",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "%%%%%%%%cccccccc%%%%%%%%",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_dirt_road_turnback_paddock",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            ".                      .",
            "...                 ....",
            "_.....           ......_",
            "__.....        .......__",
            "___..................___",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_dirt_road_turnback_house",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "...     ",
            "__......",
            " _______",
            "  _.....",
            "   .    ",
            "        ",
            "        ",
            "        ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_dirt_road_turnback_greenhouse",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            ".____.",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "15x15_dirt_road_turnback_yard",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "/             /",
            " /           / ",
            "  /        //  ",
            "   ////////    ",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Spawns jumps in a clockwise 19x19 circle from [ 2, 2 ]. Rarely has a central jump.
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_paddock_showjumps",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "3x3_showjump_EW", weight = 25 },
                    { id = "5x5_showjump_shrub_EW", weight = 25 },
                },
                x = 6,
                y = 2,
            },
            {
                choices = {
                    { id = "3x3_showjump_EW", weight = 75 },
                    { id = "5x5_showjump_shrub_EW", weight = 25 },
                },
                x = 11,
                y = 2,
            },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "3x3_showjump_NS", weight = 25 },
                    { id = "5x5_showjump_shrub_NS", weight = 25 },
                },
                x = 16,
                y = 6,
            },
            {
                choices = {
                    { id = "3x3_showjump_NS", weight = 75 },
                    { id = "5x5_showjump_shrub_NS", weight = 25 },
                },
                x = 16,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "3x3_showjump_EW", weight = 25 },
                    { id = "5x5_showjump_shrub_EW", weight = 20 },
                    { id = "3x3_showjump_water_W", weight = 5 },
                },
                x = 12,
                y = 16,
            },
            {
                choices = {
                    { id = "3x3_showjump_EW", weight = 75 },
                    { id = "5x5_showjump_shrub_EW", weight = 20 },
                    { id = "3x3_showjump_water_W", weight = 5 },
                },
                x = 7,
                y = 16,
            },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "3x3_showjump_NS", weight = 25 },
                    { id = "5x5_showjump_shrub_NS", weight = 20 },
                    { id = "3x3_showjump_water_N", weight = 5 },
                },
                x = 2,
                y = 12,
            },
            {
                choices = {
                    { id = "3x3_showjump_NS", weight = 75 },
                    { id = "5x5_showjump_shrub_NS", weight = 20 },
                    { id = "3x3_showjump_water_N", weight = 5 },
                },
                x = 2,
                y = 7,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "5x5_showjump_shrubs_water_E", weight = 10 },
                    { id = "5x5_showjump_shrubs_water_S", weight = 10 },
                },
                x = 9,
                y = 9,
            },
        },
    },
}

-- Same as 24x24_paddock_showjumps but without shrub/water jumps.
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_track_showjumps",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "3x3_showjump_EW", weight = 50 } },
                x = 6,
                y = 2,
            },
            { id = "3x3_showjump_EW", x = 11, y = 2 },
            {
                choices = { { id = "null", weight = 50 }, { id = "3x3_showjump_NS", weight = 50 } },
                x = 16,
                y = 6,
            },
            { id = "3x3_showjump_NS", x = 16, y = 11 },
            {
                choices = { { id = "null", weight = 50 }, { id = "3x3_showjump_EW", weight = 50 } },
                x = 12,
                y = 16,
            },
            { id = "3x3_showjump_EW", x = 7, y = 16 },
            {
                choices = { { id = "null", weight = 50 }, { id = "3x3_showjump_NS", weight = 50 } },
                x = 2,
                y = 12,
            },
            { id = "3x3_showjump_NS", x = 2, y = 7 },
            {
                choices = { { id = "null", weight = 80 }, { id = "3x3_showjump_NS", weight = 20 } },
                x = 9,
                y = 9,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_splitrail_fence",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        palettes = { "paddock" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
