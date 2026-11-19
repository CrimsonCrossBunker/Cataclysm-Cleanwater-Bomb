local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "city_block2_flr2_1", "city_block2_flr2_2", "city_block2_flr2_3", "city_block2_flr2_4" } },
    layout = {
        rows = {
            "-------------#o#ooo#o##----#ooo#-,,,,,,,-#ooo#-##oo##oo##,##oo##oo##--sss##oo###oo##------------",
            "-##oo###oo##,#4    5  #--#o#y y#o#>sss>#o# yH#o#2      R#>#R  2    #--sssoRHy 2    #ooo###ooo#--",
            "-#2     3  #>#        #--#4      ##!#!##  4    #       R#!#R       #-->#o#y        #2     yHR#s-",
            "-#         #!#        #--#       9  #9         #        ! !        #--s!           #         !ss",
            "-#         # #        #--#          #          #      ||# #||      #--s#E          #        R#>s",
            "-#         ! !      AA#--#          #          #      |t###t|      #---#K          #        R###",
            "-#        y###||Q YJJJ#--@ DLD R||||#||||R  DD #      * j#j *      #---#K JA ||||||#          l#",
            "-# A AA   Y#Ttj|Q    n@--@ DLD R|tjT#Tjt|R  LL #    RR|TT#TT|RR    @---#n J  *7    # DLD    J K@",
            "-#JJJJJJ  Q#T  *     i#--#      *  T#T  *   DD #    |||||#|||||    #---#i JA |     # DLD   AJ n@",
            "-#Q       Q#||||*| KKl#--@y   ||||||#||||||   y#    *7   #6   *    #---#K    |     # DLD   AJ i@",
            "-#lKinKK  Q#1    |*|||#--#Y   *8    #1    *   Y#LD  |    #    |  AL#---#| || |     #y       J K@",
            "-#||||||  R#     |7   #--#Q  l|     #     |l  Q#LD  |    #    |  AL@---#Q Q| ||||||#||||||    Q#",
            "-#1    *  R#     |    #--#Q  K|     #     |K  Q#LD  |    #    |y AL#-;;#QQQ| *8    #1    *  QQQ#",
            "-#     ||*|#     |    @--#Q  K|     #     |K  Q#    |||||#|||||    #-;S#|||| |     #     ||*|###",
            "-@     |j t#     |    #--#KinK|     #     |KinK#Q   *7   #6   *   Y#-;;#jYt| |     #     |j t#S-",
            "-#     |   ##@#@###@###--###@####@#####@#####@##Q  K|    #    |Q  K#--;@   * |     #     |  y@;-",
            "-#     |TTy#S;;;;----------^-----;;SVS;;-------@Y  K|    #    |Q  K@--;#TTy| |     #     |YTT#;-",
            "-####@###@##V;--------------------;;;;;--------#lniK|    #    |linK#--V#########@#####@#######V-",
            "---^----;;;;;;---------------------------------##@#####@###@@####@##-----^----------------------",
            "-------------------------------------------------^--;V;;;S;;;-----------------------------------",
            "------------------------------------------------------------------------------------------------",
            "------------------------------------------------------------------------------------------------",
            "------------------------------------------------------------------------------------------------",
            "------------------------------------------------------------------------------------------------",
        },
        palettes = { "city_block_foundation_palette" },
        fill_terrain = "t_floor",
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "bedroom_5x5_adult_N_1", weight = 20 },
                    { id = "bedroom_5x5_adult_S_1", weight = 20 },
                    { id = "bedroom_5x5_adult_W_1", weight = 20 },
                    { id = "bedroom_5x5_adult_N_2", weight = 20 },
                    { id = "bedroom_5x5_adult_E_2", weight = 20 },
                    { id = "bedroom_5x5_adult_N_2", weight = 20 },
                    { id = "bedroom_5x5_adult_N_2", weight = 20 },
                    { id = "bedroom_5x5_adult_S_2", weight = 20 },
                },
            },
            ["2"] = {
                choices = {
                    { id = "livingroom_5x5_E_1", weight = 20 },
                    { id = "livingroom_5x5_W_1", weight = 20 },
                    { id = "livingroom_5x5_E_2", weight = 20 },
                },
            },
            ["3"] = {
                choices = {
                    { id = "bonus_room_3x3_4", weight = 20 },
                    { id = "bonus_room_3x3_N_6", weight = 20 },
                    { id = "bonus_room_3x3_N_8", weight = 20 },
                },
            },
            ["4"] = {
                choices = {
                    { id = "livingroom_5x5_E_1", weight = 20 },
                    { id = "livingroom_5x5_E_2", weight = 20 },
                    { id = "bonus_room_3x3_5", weight = 20 },
                    { id = "bonus_room_3x3_E_5", weight = 20 },
                    { id = "bonus_room_2x2_1", weight = 20 },
                },
            },
            ["5"] = {
                choices = {
                    { id = "bonus_room_3x3_E_5", weight = 20 },
                    { id = "bonus_room_3x3_N_6", weight = 20 },
                    { id = "bonus_room_3x3_S_6", weight = 20 },
                    { id = "bonus_room_3x3_W_6", weight = 20 },
                    { id = "bonus_room_3x3_N_8", weight = 20 },
                    { id = "bonus_room_3x3_E_8", weight = 20 },
                    { id = "bonus_room_3x3_E_6", weight = 20 },
                },
            },
            ["6"] = {
                choices = {
                    { id = "bedroom_4x4_adult_1_W", weight = 20 },
                    { id = "bedroom_4x4_adult_1_S", weight = 20 },
                    { id = "bedroom_4x4_adult_2_N", weight = 20 },
                    { id = "bedroom_4x4_adult_2_W", weight = 20 },
                    { id = "bedroom_4x4_adult_2_E", weight = 20 },
                    { id = "bedroom_4x4_adult_2_S", weight = 20 },
                    { id = "bedroom_4x4_adult_3_S", weight = 20 },
                    { id = "bedroom_4x4_adult_3_N", weight = 20 },
                    { id = "bedroom_4x4_adult_3_E", weight = 20 },
                    { id = "bedroom_4x4_adult_3_W", weight = 20 },
                },
            },
            ["7"] = {
                choices = {
                    { id = "bedroom_4x4_adult_1_S", weight = 20 },
                    { id = "bedroom_4x4_adult_3_S", weight = 20 },
                    { id = "bedroom_4x4_adult_3_N", weight = 20 },
                    { id = "bedroom_4x4_adult_3_E", weight = 20 },
                    { id = "bedroom_4x4_adult_3_W", weight = 20 },
                },
            },
            ["8"] = {
                choices = {
                    { id = "bedroom_5x5_adult_N_1", weight = 20 },
                    { id = "bedroom_5x5_adult_S_1", weight = 20 },
                    { id = "bedroom_5x5_adult_E_1", weight = 20 },
                    { id = "bedroom_5x5_adult_N_2", weight = 20 },
                    { id = "bedroom_5x5_adult_S_2", weight = 20 },
                    { id = "bedroom_5x5_adult_E_2", weight = 20 },
                    { id = "bedroom_5x5_adult_W_2", weight = 20 },
                },
            },
            ["9"] = {
                choices = {
                    { id = "bonus_room_3x3_S_6", weight = 20 },
                    { id = "bonus_room_3x3_S_8", weight = 20 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "city_block2_roof_1", "city_block2_roof_2", "city_block2_roof_3", "city_block2_roof_4" } },
    layout = {
        rows = {
            "             ----------    ----- ooooooo ----- ----------o----------     -----------            ",
            " -----------o-........-  ---...---ooooo---...---........---........-     -.........-----------  ",
            " -.........---..G.....-  -.........................................-   ---...................-  ",
            " -....................-  -..B..............................G.......-   -.....................-  ",
            " -..E.................-  -.........................................-   -....E.........G......-  ",
            " -....................-  -.................G.......................-   -.....................---",
            " -....................-  -.........................................-   -.......................-",
            " -............D.......-  -.........................................-   -.......................-",
            " -....................-  -.........................................-   -.......................-",
            " -....................-  -.........................................-   -.......................-",
            " -....................-  -.....G....................D..............-   -.....D..............G..-",
            " -....................-  -.........................................-   -.......................-",
            " -....G...............-  -.........................................-   -.......................-",
            " -....................-  -.........................................-   -.....................---",
            " -....................-  -.........................................-   -.....................-# ",
            " -.........------------  --5-------###----------...................-  #-.....................-# ",
            " -.........##                      #>#         -...................-  #-.....................-# ",
            " --5-------#>                                  -...................-  >--5--------------------> ",
            "                                               --5--###-------------                            ",
            "                                                    #>#                                         ",
            "                                                                                                ",
            "                                                                                                ",
            "                                                                                                ",
            "                                                                                                ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested_glyphs = {
            E = {
                choices = {
                    { id = "roof_4x4_party", weight = 5 },
                    { id = "null", weight = 50 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_4x4_utility", weight = 20 },
                    { id = "roof_4x4_utility_1", weight = 20 },
                },
            },
            B = { choices = { { id = "roof_16x16_help", weight = 5 } } },
            G = {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "roof_2x2_infrastructure", weight = 20 },
                    { id = "roof_2x2_infrastructure_1", weight = 20 },
                    { id = "roof_2x2_utilities_b", weight = 20 },
                    { id = "roof_2x2_utilities_c", weight = 20 },
                    { id = "roof_2x2_utilities_d", weight = 20 },
                },
            },
            D = {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "roof_6x6_garden_1", weight = 10 },
                    { id = "roof_6x6_garden_2", weight = 10 },
                    { id = "roof_6x6_garden_3", weight = 10 },
                    { id = "roof_6x6_garden_4", weight = 10 },
                    { id = "roof_6x6_greenhouse_1", weight = 5 },
                    { id = "roof_6x6_greenhouse_2", weight = 5 },
                    { id = "roof_6x6_greenhouse_3", weight = 5 },
                },
            },
        },
    },
}

-- combines candy shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_candy_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_candy_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_candy", x = 6, y = 12 },
        },
    },
}

-- combines beauty shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_beauty_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_beauty_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_beauty", x = 6, y = 12 },
        },
    },
}

-- combines beauty shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_vitamin_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_vitamin_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_vitamin", x = 6, y = 12 },
        },
    },
}

-- combines cellphone shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_cellphone_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_cellphone_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_cellphone", x = 6, y = 12 },
        },
    },
}

-- combines music shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_music_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_music_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_music", x = 6, y = 12 },
        },
    },
}

-- combines gift shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_gift_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_gift_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_gift", x = 6, y = 12 },
        },
    },
}

-- combines electronics shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_electronics_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_electronics_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_electronics", x = 6, y = 12 },
        },
    },
}

-- combines pizza shop front & back 9x9 front, 3x3 back crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_pizza_shop",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "city_block_9x9_pizza_shop_front", x = 0, y = 0 },
            { id = "city_block_3x3_backroom_crates_pizza", x = 6, y = 12 },
        },
    },
}

-- combines general shop front & back 8x8 front, 4x4 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_clothing_shop",
    layout = {
        size = { width = 12, height = 12 },
        nested = {
            { id = "city_block_8x8_clothing_shop_front", x = 0, y = 0 },
            { id = "city_block_4x4_backroom_clothing", x = 4, y = 8 },
        },
    },
}

-- combines formal clothing shop front & back 8x8 front, 4x4 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_formal_clothing_shop",
    layout = {
        size = { width = 12, height = 12 },
        nested = {
            { id = "city_block_8x8_formal_clothing_shop_front", x = 0, y = 0 },
            { id = "city_block_4x4_backroom_clothing_formal", x = 4, y = 8 },
        },
    },
}

-- combines leather clothing shop front & back 8x8 front, 4x4 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_leather_clothing_shop",
    layout = {
        size = { width = 12, height = 12 },
        nested = {
            { id = "city_block_8x8_leather_clothing_shop_front", x = 0, y = 0 },
            { id = "city_block_4x4_backroom_clothing_leather", x = 4, y = 8 },
        },
    },
}

-- combines fur clothing shop front & back 8x8 front, 4x4 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_2_fur_clothing_shop",
    layout = {
        size = { width = 12, height = 12 },
        nested = {
            { id = "city_block_8x8_fur_clothing_shop_front", x = 0, y = 0 },
            { id = "city_block_4x4_backroom_clothing_fur", x = 4, y = 8 },
        },
    },
}
