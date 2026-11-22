local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "labyrinth2_scarlet_sea_portal",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x0_y0" },
        { point = { 1, 0, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x1_y0" },
        { point = { 0, 1, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x0_y1" },
        { point = { 1, 1, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x1_y1" },
    },
    city_distance = { 0, -1 },
    occurrences = { 33, 100 },
    rotate = false,
    locations = { "labyrinth2" },
    flags = { "EXTRADIMENSIONAL", "NETHERUM_LABYRINTH2", "GLOBALLY_UNIQUE" },
}

ccb.content.define_mutable_overmap_special {
    id = "labyrinthine_structure",
    root = "entrance",
    locations = { "netherum_labyrinth_sparkling_chasm" },
    flags = { "EXODII", "EXTRADIMENSIONAL", "NETHERUM_LABYRINTH", "OVERMAP_UNIQUE" },
    occurrences = { 99, 100 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { 10, 10, 0 },
            to = { -10, -10, 0 },
            locations = { "netherum_labyrinth_sparkling_chasm" },
        },
    },
    joins = { "passage_to_passage" },
    overmaps = {
        entrance = {
            overmap = "labyrinth_entrance_north",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        crossroads = {
            overmap = "labyrinth_hall_nesw",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        tee = {
            overmap = "labyrinth_hall_nes",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
        },
        straight_passage = { overmap = "labyrinth_hall_ew", east = "passage_to_passage", west = "passage_to_passage" },
        corner = { overmap = "labyrinth_hall_ne", north = "passage_to_passage", east = "passage_to_passage" },
        dead_end = { overmap = "labyrinth_hall_end_west", west = "passage_to_passage" },
    },
    phases = {
        {
            {
                overmap = "straight_passage",
                max = { poisson = 20 },
            },
            {
                overmap = "corner",
                max = { poisson = 30 },
            },
            {
                overmap = "tee",
                max = { poisson = 20 },
            },
            { overmap = "dead_end", weight = 1 },
        },
        {
            { overmap = "dead_end", weight = 2000 },
            { overmap = "straight_passage", weight = 20 },
            { overmap = "corner", weight = 100 },
            { overmap = "tee", weight = 20 },
            { overmap = "crossroads", weight = 1 },
        },
    },
}

ccb.content.define_mutable_overmap_special {
    id = "labyrinthine_structure_boiler",
    root = "entrance",
    locations = { "netherum_labyrinth_sparkling_chasm" },
    flags = { "EXODII", "EXTRADIMENSIONAL", "NETHERUM_LABYRINTH", "OVERMAP_UNIQUE" },
    occurrences = { 0, 0 },
    check_for_locations_area = {
        {
            from = { 10, 10, 0 },
            to = { -10, -10, 0 },
            locations = { "netherum_labyrinth_sparkling_chasm" },
        },
    },
    joins = { "passage_to_passage" },
    overmaps = {
        entrance = {
            overmap = "labyrinth_nl_exit_boiler_north",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        crossroads = {
            overmap = "labyrinth_hall_nesw",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        tee = {
            overmap = "labyrinth_hall_nes",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
        },
        straight_passage = { overmap = "labyrinth_hall_ew", east = "passage_to_passage", west = "passage_to_passage" },
        corner = { overmap = "labyrinth_hall_ne", north = "passage_to_passage", east = "passage_to_passage" },
        dead_end = { overmap = "labyrinth_hall_end_west", west = "passage_to_passage" },
    },
    phases = {
        {
            {
                overmap = "straight_passage",
                max = { poisson = 20 },
            },
            {
                overmap = "corner",
                max = { poisson = 30 },
            },
            {
                overmap = "tee",
                max = { poisson = 20 },
            },
            { overmap = "dead_end", weight = 1 },
        },
        {
            { overmap = "dead_end", weight = 2000 },
            { overmap = "straight_passage", weight = 20 },
            { overmap = "corner", weight = 100 },
            { overmap = "tee", weight = 20 },
            { overmap = "crossroads", weight = 1 },
        },
    },
}
