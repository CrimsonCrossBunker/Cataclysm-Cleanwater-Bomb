local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mine_entrance_roof", "mine_entrance_loading_zone_roof" } },
    layout = {
        rows = {
            "                                                ",
            "                                                ",
            "                                                ",
            "5---------------------                          ",
            "-....................-                          ",
            "-....................-                          ",
            "-....................-                          ",
            "-....................-                          ",
            "-....................-                          ",
            "----------------------                          ",
            "                                                ",
            "-------------                                   ",
            "-...........-   --------------                  ",
            "-...........-   -............-                  ",
            "-...........-   -............-                  ",
            "-...........-   -............-                  ",
            "-...........-   -............-                  ",
            "-...........-   -............-   ------         ",
            "-...........-   -............-   -....-         ",
            "-...........-   -............-   -....-         ",
            "-...........-   -............-   -....-         ",
            "-...........-   -............-   -....-         ",
            "-...........-   -............-   -....-         ",
            "------------5   5------------5   5-----         ",
        },
        palettes = { "roof_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mechanical_fluid",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_mechanical_fluid", x = 0, y = 0, intensity = 1, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gasoline_diesel_motor_oil",
    layout = {
        size = { width = 1, height = 1 },
        liquid_placements = {
            { id = "gasoline", x = 0, y = 0, one_in = 20 },
            { id = "diesel", x = 0, y = 0, one_in = 20 },
            { id = "motor_oil", x = 0, y = 0, one_in = 20 },
        },
    },
}
