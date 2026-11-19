local ccb = require("ccb")

-- Room with open cells along the sides.
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4waysquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "L__|2_|2_|__|2_|2_|__L",
            "___|__|__|__|__|__|___",
            "______|__|__|__|______",
            "||_______|++|_______||",
            "2___________________2_",
            "_____1________________",
            "|||________________|||",
            "2___________________2_",
            "______________________",
            "||||______________||||",
            "___+______________+___",
            "___+______________+___",
            "||||______________||||",
            "2___________________2_",
            "______________________",
            "|||________________|||",
            "2___________________2_",
            "______________________",
            "||_______|++|_______||",
            "______|__|__|__|______",
            "___|2_|2_|__|2_|2_|___",
            "L__|__|__|__|__|__|__L",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["1"] = "t_nl_metal_floor", ["2"] = "t_nl_metal_floor" },
        nested_glyphs = { ["1"] = { id = "ls_openarea_12x12_rooms" }, ["2"] = { id = "ls_2x2_furniture" } },
    },
}

-- Basic square room with some turrets and cover.
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4waysquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "||L___AA______AA___L||",
            "|____________________|",
            "L_((______________((_L",
            "__((___________ßß_((__",
            "______ßß_______ṪṪ_____",
            "______ṪṪ______¢ÇM_____",
            "A_____MÇ¢_____¢ÇM____A",
            "A_____MÇ¢____________A",
            "_____________¢ÇM______",
            "_____MÇ¢_____¢ÇM______",
            "_____MÇ¢______________",
            "______________¢ÇM_____",
            "______MÇ¢_____¢ÇM_____",
            "______MÇ¢_____________",
            "A____________¢ÇM_____A",
            "A____MÇ¢_____¢ÇM_____A",
            "_____MÇ¢______ṪṪ______",
            "_____ṪṪ_______ßß______",
            "__((_ßß___________((__",
            "L_((______________((_L",
            "|____________________|",
            "||L___AA______AA___L||",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- large room for setpiece nests
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4waysquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "1|||||________________",
            "|____||_______________",
            "______+_____||||||||||",
            "______+_____|vvvvvvvvv",
            "|____||_____|vvvvvvvvv",
            "||||||______|vvvvvvvvv",
            "___________|||||||||||",
            "___________Fbbbbb_____",
            "L__________FdddddÇ___L",
            "___________F__________",
            "___________F__________",
            "___________F__________",
            "___________F__________",
            "L__________FdddddÇ___L",
            "___________Fbbbbb_____",
            "___________|||||||||||",
            "1|||||______|vvvvvvvvv",
            "|____||_____|vvvvvvvvv",
            "______+_____|vvvvvvvvv",
            "______+_____||||||||||",
            "|____||_______________",
            "||||||________________",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["1"] = "t_nl_metal_floor" },
        nested_glyphs = { ["1"] = { id = "ls_bubblecell_6x6_room_Wentry" } },
    },
}

-- large room for setpiece nests
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4waysquarerooms_22x22_rooms",
    layout = {
        size = { width = 22, height = 22 },
        rows = {
            "1|||||________________",
            "|____||_______________",
            "______+_____||||||||||",
            "______+_____|vvvvvvvvv",
            "|____||_____|vvvvvvvvv",
            "||||||______|vvvvvvvvv",
            "UUUUUU_____|||||||||||",
            "_____________|2_|2_|2_",
            "L____________|__|__|__",
            "_____________|+||+||+|",
            "______________________",
            "______________________",
            "_____________|+||+||+|",
            "L____________|2_|2_|2_",
            "_____________|__|__|__",
            "UUUUUU_____|||||||||||",
            "1|||||______|vvvvvvvvv",
            "|____||_____|vvvvvvvvv",
            "______+_____|vvvvvvvvv",
            "______+_____||||||||||",
            "|____||_______________",
            "||||||________________",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["1"] = "t_nl_metal_floor", ["2"] = "t_nl_metal_floor" },
        nested_glyphs = { ["1"] = { id = "ls_bubblecell_6x6_room_Wentry" }, ["2"] = { id = "ls_2x2_furniture" } },
    },
}

-- central area to place in larger rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_openarea_12x12_rooms",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " |L______L| ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " U___UU___U ",
            " |L__UU__L| ",
            "            ",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- central area to place in larger rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_openarea_12x12_rooms",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "L(        (L",
            "(|F||||||F|(",
            " |__L||L__| ",
            " |___cc___| ",
            " |___cc___| ",
            " F___||___F ",
            " F___||___F ",
            "(|___cc___| ",
            " |___cc___| ",
            " |__L||L__| ",
            "(|F||||||F|(",
            "L(        (L",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- central area to place in larger rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_openarea_12x12_rooms",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "L(        (L",
            "(|F||||||F|(",
            " |__L||L__| ",
            " |___Cc___| ",
            " |___cC___| ",
            " F__U||U__F ",
            " F__U||U__F ",
            "(|___cC___| ",
            " |___Cc___| ",
            " |__L||L__| ",
            "(|F||||||F|(",
            "L(        (L",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- central area to place in larger rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_openarea_12x12_rooms",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            " (ϟ      ϟ( ",
            "(||      ||(",
            "ϟ||      ||ϟ",
            "   cc  cc   ",
            "   cL  Lc   ",
            "            ",
            "            ",
            "   cL  Lc   ",
            "   cc  cc   ",
            " ||      ||ϟ",
            "(||      ||(",
            "ϟ(       ϟ( ",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- central area to place in larger rooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_openarea_12x12_rooms",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            " (ϟ      ϟ( ",
            "(||      ||(",
            "ϟ||      ||ϟ",
            "   ÇÇ  ÇÇ   ",
            "   ÇL  LÇ   ",
            "            ",
            "            ",
            "   ÇL  LÇ   ",
            "   ÇÇ  ÇÇ   ",
            " ||      ||ϟ",
            "(||      ||(",
            "ϟ(       ϟ( ",
        },
        palettes = { "labyrinthine_base_palette", "labyrinthine_item_palette_utility_tier0" },
    },
}

-- Small round room
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_8x8_se_entry_room",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "vvvvvvvv",
            "vv||||vv",
            "v||UU||v",
            "v|U__U|v",
            "v|U__U|v",
            "v||_L||v",
            "..+_||vv",
            "..|||vvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- Room with nooks
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_8x8_se_entry_room",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "|||v||||",
            "|U|||_U|",
            "|_____||",
            "||_(ϟ_|v",
            "v|_L(_||",
            "||_____|",
            "|__|||U|",
            "|+||v|||",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}
