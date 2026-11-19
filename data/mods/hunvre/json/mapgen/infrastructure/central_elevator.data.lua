local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        { "central_elevator_0_0", "central_elevator_1_0" },
        { "central_elevator_2_0", "central_elevator_3_0" },
    },
    layout = {
        rows = {
            "########################*#######################",
            "#hhYhh#hhhYhh#  µ  #hhhh #9#9#9#9#9#9#9#9#9#t#t#",
            "#     *      *  #  *     oh#h#h#h#h#h#h#h#h#°#°#",
            "#     #hhhYhh#  µ  #hhhY #                 +   #",
            "#Y    ##O#####*o#o*#####*#+#################Y S#",
            "#h    #Y #VYV#  9  # *     +               +   #",
            "#h    o  #   *  h  * #21SFY#h#h#h#h#h#h#h#h#°#°#",
            "#h    o  #   ####### #######9#9#9#9#9#9#9#9#t#t#",
            "#h    #9h#   #             #####################",
            "#h    o  #   *                               * #",
            "#Y    o  # #*########   ###################### #",
            "#   ####+# #    TTTT#   *   +  #VYV  +bl#Y °t# #",
            "#   #lll # #       T#   #   #  #     ####S ### #",
            "#   #    # #       T#   #L L#  #      +b#S °t# #",
            "#   #lll * #h9Y     #   #L L#  +  hhh #l#Y ### #",
            "##*################+#   #L L#  # hTTT####  °t# #",
            "#   $        + R# / #   #L L#  #        +  ### #",
            "#            # R# | #   #L L#  # 1221SFY#  °t# #",
            "#            # R### #   #####*##+########Y ### #",
            "#            # R#hT #   #rrr# Y#       Y#S °t# #",
            "#            # R# Y #   +   # l#+##+##+##S ### #",
            "#            # R#   +   #rrr#  #bl#bl#bl#Y °t# #",
            "#            # R#+###########  ###############*#",
            "#            # R#  o        o6h#     #         #",
            "#            # R#  o       &#oo#     #         #",
            "#            # R#  o _________ #  #  #  #      #",
            "#ù           ####  # _________ #  #  #  #      #",
            "#            + R#  o _________ #  #  #  #      #",
            "#            # R#  o _________ #  #  #  #      #",
            "#            # R#  o _________ #  #  #  #      #",
            "#            # R#  # _________ #  #  #  #      #",
            "#            # R#  o _________ #  #  #  #      #",
            "#            # R#  o _________ #  #  #  #      #",
            "#            # R#  o           #  #  #  #      #",
            "#            # R#  #ooo#  #oooo#  #  #  #      #",
            "#            # R#      #  #    #  #     #      #",
            "#            # R#      *  *    *  #     #      #",
            "#            ############################      #",
            "#### ^        £             £         ^        #",
            "#R +                                           #",
            "#R #                                           #",
            "#R #                                           #",
            "#R #                                           #",
            "#R #                                           #",
            "#R #          #+######+######+########         #",
            "#R #          #    #    #     #      +         #",
            "#R #          #RRRR#RRRR#RRRRR#RRRRRR#         #",
            "################################################",
        },
        fill_terrain = "t_concrete",
        palettes = { "elevator" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_elevator_shop",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " ssss ",
            "#cccc#",
            "#   h#",
            "#    #",
            "# FFO#",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "elevator_shop_base", { parameter = "elevator_shop_type_palette" } },
        parameters = {
            elevator_shop_type_palette = {
                value_type = "palette",
                default = {
                    weighted = { "elevator_shop_drink", "elevator_shop_food", "elevator_shop_luxury" },
                },
                scope = "nested",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "9x9_elevator_shop",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "         ",
            "ddd  ddd ",
            "ddd  ddd ",
            "         ",
            "ddd  ddd ",
            "ddd  ddd ",
            "         ",
            "#cccccc##",
            " h    h #",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "elevator_shop_base", { parameter = "elevator_shop_type_palette" } },
        parameters = {
            elevator_shop_type_palette = {
                value_type = "palette",
                default = {
                    weighted = { "elevator_shop_drink", "elevator_shop_food", "elevator_shop_luxury" },
                },
                scope = "nested",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_elevator_shop",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "dd dd c ",
            "dd dd c ",
            "      c ",
            "dd dd ch",
            "dd dd # ",
            "dd dd # ",
            "dd dd #F",
            "      ##",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "elevator_shop_base", { parameter = "elevator_shop_type_palette" } },
        parameters = {
            elevator_shop_type_palette = {
                value_type = "palette",
                default = {
                    weighted = { "elevator_shop_drink", "elevator_shop_food", "elevator_shop_luxury" },
                },
                scope = "nested",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_elevator_shop",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "  ##########",
            "            ",
            " dd  dd  dd ",
            " dd  dd  dd ",
            " dd  dd  dd ",
            " dd  dd  dd ",
            "            ",
            "            ",
            "#cc  dd  dd ",
            "Fhc  dd  dd ",
            "O c  dd  dd ",
            "F #  dd  dd ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "elevator_shop_base", { parameter = "elevator_shop_type_palette" } },
        parameters = {
            elevator_shop_type_palette = {
                value_type = "palette",
                default = {
                    weighted = { "elevator_shop_drink", "elevator_shop_food", "elevator_shop_luxury" },
                },
                scope = "nested",
            },
        },
    },
}

ccb.content.define_overmap_terrain {
    id = {
        "central_elevator_0_0",
        "central_elevator_1_0",
        "central_elevator_2_0",
        "central_elevator_3_0",
    },
    name = ccb.content.text("central elevator"),
    symbol = "E",
    color = "light_red",
    vision_levels = "large_city_building",
    travel_cost = "structure",
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_LUXURY", "SIDEWALK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 75 },
}
