local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "labyrinthine_structure_flooded",
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
            overmap = "labyrinth_flooded_entrance_north",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        crossroads = {
            overmap = "labyrinth_flooded_hall_nesw",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        tee = {
            overmap = "labyrinth_flooded_hall_nes",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
        },
        straight_passage = { overmap = "labyrinth_flooded_hall_ew", east = "passage_to_passage", west = "passage_to_passage" },
        corner = {
            overmap = "labyrinth_flooded_hall_ne",
            north = "passage_to_passage",
            east = "passage_to_passage",
        },
        dead_end = { overmap = "labyrinth_flooded_hall_end_west", west = "passage_to_passage" },
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
    id = "labyrinthine_structure_overgrown",
    root = "entrance",
    locations = { "labyrinth2" },
    flags = { "EXODII", "EXTRADIMENSIONAL", "NETHERUM_LABYRINTH2" },
    occurrences = { 0, 20 },
    check_for_locations_area = {
        {
            from = { 10, 10, 0 },
            to = { -10, -10, 0 },
            locations = { "labyrinth2" },
        },
    },
    joins = { "passage_to_passage" },
    overmaps = {
        entrance = {
            overmap = "labyrinth_overgrown_entrance_north",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        crossroads = {
            overmap = "labyrinth_overgrown_hall_nesw",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        tee = {
            overmap = "labyrinth_overgrown_hall_nes",
            north = "passage_to_passage",
            south = "passage_to_passage",
            east = "passage_to_passage",
        },
        straight_passage = {
            overmap = "labyrinth_overgrown_hall_ew",
            east = "passage_to_passage",
            west = "passage_to_passage",
        },
        corner = {
            overmap = "labyrinth_overgrown_hall_ne",
            north = "passage_to_passage",
            east = "passage_to_passage",
        },
        dead_end = { overmap = "labyrinth_overgrown_hall_end_west", west = "passage_to_passage" },
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
            { overmap = "dead_end", weight = 1500 },
            { overmap = "straight_passage", weight = 20 },
            { overmap = "corner", weight = 100 },
            { overmap = "tee", weight = 20 },
            { overmap = "crossroads", weight = 1 },
        },
    },
}
