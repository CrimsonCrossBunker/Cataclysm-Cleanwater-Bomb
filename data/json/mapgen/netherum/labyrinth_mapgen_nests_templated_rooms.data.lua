local ccb = require("ccb")

-- Two basic rooms, offset doors.  Fits room contents maps ls_straight_2basic_rooms_offset and ls_straight_2basic_rooms_anydoor
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!|||||||v2     v|||||||!",
            "!4_____|v      v|______!",
            "!______+.      v|______!",
            "!______+.      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v1     v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v3     v|______!",
            "!______|v      v|______!",
            "!______|v      .+______!",
            "!______|v      .+______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v1     v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!______|v      v|______!",
            "!|||||||v      v|||||||!",
        },
        palettes = { "labyrinthine_base_palette" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "ls_ns_6x6hall_basic", weight = 55 },
                    { id = "ls_ns_6x6hall_fancy", weight = 45 },
                },
            },
            ["2"] = { id = "ls_Tw_6x6hall_basic" },
            ["3"] = { id = "ls_Te_6x6hall_basic" },
            ["4"] = {
                choices = {
                    { id = "ls_straight_2basic_rooms_offset", weight = 50 },
                    { id = "ls_straight_2basic_rooms_anydoor", weight = 50 },
                },
            },
        },
    },
}

-- Bubble cell rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!1|||||vvv....vvv3|||||!",
            "!|____||vv....vv||____|!",
            "!______+........+______!",
            "!______+.....ovv||____|!",
            "!|____||vvo..ovvv4|||||!",
            "!2|||||vvvo..ovv||____|!",
            "!|____||vvo.....+______!",
            "!______+........+______!",
            "!|____||vo...ovv||____|!",
            "!1|||||vvo...ovvv3|||||!",
            "!|____||vo...ovv||____|!",
            "!______+........+______!",
            "!______+.......v||____|!",
            "!|____||vvo..ovvv4|||||!",
            "!1|||||vvvo..ovv||____|!",
            "!|____||vvo.....+______!",
            "!______+........+______!",
            "!______+......ov||____|!",
            "!|____||vvo...ovv4|||||!",
            "!2|||||vvvo...ov||____|!",
            "!|____||vvo.....+______!",
            "!______+........+______!",
            "!|____||vv....vv||____|!",
            "!||||||vvv....vvv||||||!",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = {
            ["1"] = "t_nl_metal_wall",
            ["2"] = "t_nl_metal_wall",
            ["3"] = "t_nl_metal_wall",
            ["4"] = "t_nl_metal_wall",
        },
        nested_glyphs = {
            ["1"] = { id = "ls_bubblecell_6x6_room_Wentry" },
            ["2"] = { id = "ls_bubblecell_5x5_room_Wentry" },
            ["3"] = { id = "ls_bubblecell_5x5_room_Eentry" },
            ["4"] = { id = "ls_bubblecell_6x6_room_Eentry" },
        },
    },
}

-- Bubble cell rooms2
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!||||||vvv....vvvv|||||!",
            "!|UUUU||vv....vvv||¢¢¢|!",
            "!L_____+.........+____L!",
            "!ϟ_____+.....ovvv||¢¢¢|!",
            "!|UUU|||vo...ovvvv|||||!",
            "!|||||vvvo...ovv|||¢¢¢|!",
            "!|¢¢¢||vvo......+_____L!",
            "!ϟ____+.........+_____(!",
            "!L____+......ovv|||¢¢¢|!",
            "!|¢¢¢||vvvo..ovvvv|||||!",
            "!|||||vvvvo..ovvv||UUU|!",
            "!|UUU|||v........+____L!",
            "!L_____+.........+____(!",
            "!|¢¢¢|||vvo...ovv||UUU|!",
            "!|||||vvvvo...ovvv|||||!",
            "!|¢¢¢||vvvo...o||||UUU|!",
            "!(____+........+__+___L!",
            "!L____+......ov||||UUU|!",
            "!|UUU||vvvo..ovvvv|||||!",
            "!|||||vvvvo..ovvv||UUU|!",
            "!|¢¢¢|||vvo......+____(!",
            "!L_____+.........+_ßßßL!",
            "!|UUUU||vv....vvv||ṪṪṪ|!",
            "!||||||vvv....vvvv|||||!",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

-- large room with small cells
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!4_______________|_____|",
            "!________________|_____|",
            "!________________|_____|",
            "!________________|_____|",
            "!________________|_____|",
            "!________________+_____|",
            "!________________|||||||",
            "!________________|vvvvvv",
            "!________________|2     ",
            "!________________|      ",
            "!________________+      ",
            "!________________+      ",
            "!________________|      ",
            "!________________|      ",
            "!________________|vv..vv",
            "!________________|||++||",
            "!|||||+||||++|||||_____|",
            "!______|v3     v|______|",
            "!______|v      v|______|",
            "!______|v      .+______|",
            "!______|v      .+______|",
            "!______|v      v|______|",
            "!|||||||v      v||||||||",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["4"] = "t_nl_metal_floor" },
        nested_glyphs = {
            ["1"] = { id = "ls_12x12hallcorner_basic" },
            ["2"] = { id = "ls_Ts_6x6hall_basic" },
            ["3"] = { id = "ls_Te_6x6hall_basic" },
            ["4"] = { id = "ls_cornersquarerooms_22x22_rooms" },
        },
    },
}

-- tee with large square rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "|4_____________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "||++||||||||||||||||++||",
            "vv..vvvvvvvvvvvvvvvv..vv",
            "1     2     2     1     ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "vvvvvvv....vv....vvvvvvv",
            "||||||||...vv...||||||||",
            "|______+........+______|",
            "|______|v3     v|______|",
            "|______|v      v|______|",
            "|______|v      v|______|",
            "|______|v      v|______|",
            "|______|v      v|______|",
            "||||||||v      v||||||||",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["4"] = "t_nl_metal_floor" },
        nested_glyphs = {
            ["1"] = { id = "ls_Tn_6x6hall_basic" },
            ["2"] = { id = "ls_Ts_6x6hall_basic" },
            ["3"] = { id = "ls_ns_6x6hall_basic" },
            ["4"] = { id = "ls_teesquarerooms_22x22_rooms" },
        },
    },
}

-- large room for setpiece nests
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4way_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "|||||||||||++|||||||||||",
            "|1_____________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "+______________________+",
            "+______________________+",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|______________________|",
            "|||||||||||++|||||||||||",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["1"] = "t_nl_metal_floor" },
        nested_glyphs = { ["1"] = { id = "ls_4waysquarerooms_22x22_rooms" } },
    },
}

-- single large room, ideal for nested maps
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_deadend_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!||||||||||++||||||||||!",
            "!1_____________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!______________________!",
            "!!!!!!!!!!!!!!!!!!!!!!!!",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["1"] = "t_nl_metal_floor" },
        nested_glyphs = { ["1"] = { id = "ls_4waysquarerooms_22x22_rooms" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_deadend_template_rooms",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv......vvvvvvvv!",
            "!vvvvvvvv......vvvvvvvv!",
            "!vvvvv............vvvvv!",
            "!vvvv...v......v...vvvv!",
            "!vvv...vv......vv...vvv!",
            "!vv...vvvv....vvvv...vv!",
            "!v...vvvvvvvvvvvvvv...v!",
            "!v...vvvvvvvvvvvvvv...v!",
            "!v...vvvvvvvvvvvvvv...v!",
            "!v....vvv.###.Lvvv....v!",
            "!v........#>o.........v!",
            "!v........###.........v!",
            "!v........#<#.........v!",
            "!vv.......+.+........vv!",
            "!vvvvvvvv.###.Lvvvvvvvv!",
            "!vvvvvvvvvvvvvvvvvvvvvv!",
            "!vvvvvvvvvvvvvvvvvvvvvv!",
            "!vvvvvvvvvvvvvvvvvvvvvv!",
            "!vvvvvvvvvvvvvvvvvvvvvv!",
            "!vvvvvvvvvvvvvvvvvvvvvv!",
            "!|vvvvvvvvvvvvvvvvvvvv|!",
            "!||vvvvvvvvvvvvvvvvvv||!",
            "!|||vvvvvvvvvvvvvvvv|||!",
            "!!!!!!!!!!!!!!!!!!!!!!!!",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = {
            [">"] = "t_nl_stairs_down",
            ["<"] = "t_nl_stairs_up_false",
            ["#"] = "t_nl_metal_wall",
            s = "t_nl_mist",
            ["."] = "t_nl_metal_floor",
            ["+"] = "t_nl_door_c",
            o = "t_nl_archway",
        },
        nested = {
            {
                choices = { { id = "labyrinth_stairs_1_to_2_teleporter", weight = 1 } },
                x = 0,
                y = 0,
                z = -1,
            },
        },
    },
}

-- Two rooms full of general junk and monsters.  Set up so that any of the middle edge tiles can be an entrance.
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_cornersquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "________________ ßßlßß",
            "________________ __l__",
            "_L(ṪṪƤṪ__ṪƥṪṪṪ(_ __l__",
            "________________ __l__",
            "________________ _____",
            "_(ṪṪƥṪṪ_ƤṪṪṪṪ(L_+____L",
            "________________      ",
            "________________      ",
            "_L(ṪƤṪṪ__ṪṪƥṪṪ(_      ",
            "________________      ",
            "________________      ",
            "_(ṪṪṪṪƥ__ṪṪƤṪ(L_      ",
            "________________      ",
            "________________      ",
            "_L(ṪṪṪƤṪ_ṪṪṪƥṪ(_      ",
            "________________      ",
            "     +    ++     LUUUU",
            "______          ϟ(___U",
            "_UU__U          U____U",
            "_UU__U         +_____U",
            "_UU__U         +_____U",
            "_____L          UUßṪßU",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_dining_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_cornersquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "________________ ßßlßß",
            "________________ __l__",
            "_L(ṪṪƤṪ__ṪƥṪṪṪ(_ __l__",
            "________________ __l__",
            "________________ _____",
            "_(ṪṪƥṪṪ_ƤṪṪṪṪ(L_+____L",
            "________________      ",
            "________________      ",
            "_L(ṪƤṪṪ__ṪṪƥṪṪ(_      ",
            "________________      ",
            "________________      ",
            "_(ṪṪṪṪƥ__ṪṪƤṪ(L_      ",
            "________________      ",
            "________________      ",
            "_L(ṪṪṪƤṪ_ṪṪṪƥṪ(_      ",
            "________________      ",
            "     +    ++     LUUUU",
            "______          ϟ(___U",
            "_UU__U          U____U",
            "_UU__U         +_____U",
            "_UU__U         +_____U",
            "_____L          UUßṪßU",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- Two rooms full of general junk and monsters.  Set up so that any of the middle edge tiles can be an entrance.
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_teesquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "ϟ_________ϟ(ϟ________ϟ",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "______________________",
            "L__UUcCccCccCccCcUU__L",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "L_____          _____L",
            "______          ______",
            "__UU__          A____E",
            "__UU__          Ṫ____M",
            "__UU__          Ṫ____E",
            "_____L          L(((((",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_dining_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_teesquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "ϟ_________ϟ(ϟ________ϟ",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "_ßṪß__ßṪß_____ßṪß_ßṪß_",
            "______________________",
            "L__UUcCccCccCccCcUU__L",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "                      ",
            "L_____          _____L",
            "______          ______",
            "__UU__          A____E",
            "__UU__          Ṫ____M",
            "__UU__          Ṫ____E",
            "_____L          L(((((",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_6x6_room_Wentry",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||| ",
            "|l_L_ ",
            "b____ ",
            "Ṫß___ ",
            "|((__ ",
            "||||| ",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_6x6_room_Wentry",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||| ",
            "|B_ϟ( ",
            "l____ ",
            "l____ ",
            "|B_ϟ( ",
            "||||| ",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Wentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|B__ ",
            "(L__ ",
            "|B__ ",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Wentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|b__ ",
            "l___ ",
            "|LṪß ",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Wentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|W__ ",
            "l___ ",
            "|UUU ",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Wentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|WUU ",
            "l___ ",
            "|ULU ",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_6x6_room_Eentry",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " |||||",
            " __Ll|",
            " ____b",
            " ___ßṪ",
            " __((|",
            " |||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_6x6_room_Eentry",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " |||||",
            " _ϟ(B|",
            " ____l",
            " ____l",
            " _ϟ(B|",
            " |||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Eentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            " __B|",
            " __L(",
            " __B|",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Eentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "  _b|",
            " ___l",
            " ṪßL|",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_bunk_room_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Eentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "  _W|",
            " ___l",
            " UUU|",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_bubblecell_5x5_room_Eentry",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "  LW|",
            " ___l",
            " UUU|",
            "|||||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}
