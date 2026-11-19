local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "cabin_6",
    weight = 450,
    layout = {
        rows = {
            "*£££££*££££.~.£££££££*££",
            "££***£££***.~.******££££",
            "£*********..~..*******££",
            "£*******....~....******£",
            "££******.#w#+#w####****£",
            "*£******.wb    + T#***££",
            "*£***....#b  ct# 5#.***£",
            "££***.##w###=###+##.***£",
            "£**...#15SFR &#  D#.***£",
            "£**...w2     R# BBw.**££",
            "£*....w3 CC   + BB#.**£*",
            "££...€#y ll  A#####%**£*",
            "£~~~~~+       +  D#.**££",
            "£.....#cttc#+## BBw.***£",
            "£**...#cttc# R# BB#.***£",
            "£***..##ww##+###w##.**££",
            "££**................**££",
            "£*......**********.****£",
            "£*......*********...***£",
            "£*......*********.W.**££",
            "£*......*********...**££",
            "£*......**************£*",
            "££......**£££****££££££*",
            "*££££££££££*££££££**££**",
        },
        palettes = { "cabin_palette" },
        terrain = {
            ["*"] = {
                { id = "t_region_tree", copies = 1 },
                { id = "t_region_tree_evergreen", copies = 1 },
                { id = "t_region_shrub", copies = 5 },
                { id = "t_region_groundcover_forest", copies = 10 },
                { id = "t_region_groundcover", copies = 25 },
            },
            W = "t_wooden_well",
        },
        furniture = {
            ["£"] = "f_magic_brambles",
            ["€"] = { { id = "f_diesel_generator", copies = 2 }, { id = "f_null", copies = 1 } },
        },
        fill_terrain = "t_floor",
        nested = {
            {
                choices = {
                    { id = "roof_6x6_garden_3", weight = 25 },
                    { id = "roof_6x6_greenhouse_bloodthorne", weight = 25 },
                    { id = "roof_6x6_garden_2", weight = 25 },
                },
                x = 2,
                y = 17,
            },
            { id = "bloodthorne_druid_11x11_basement_stairs", x = 5, y = 7 },
            { id = "bloodthorne_druid_safehouse_bathroom_roof", x = 15, y = 4 },
        },
        item_placements = {
            { id = "plant_imbuement", x = 10, y = 8, chance = 65 },
            { id = "manual_arvore_lashing_bough", x = 8, y = 14, chance = 2 },
            { id = "alchemy_recipe_plant_imbuement", x = 13, y = 11, chance = 50 },
        },
        monster_placements = {
            { id = "mon_thornhound", x = 3, y = 3, chance = 50 },
            { id = "mon_thornhound", x = 19, y = 3, chance = 50 },
            { id = "mon_thornhound", x = 18, y = 17, chance = 50 },
        },
    },
}
