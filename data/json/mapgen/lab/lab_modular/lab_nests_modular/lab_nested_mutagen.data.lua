local ccb = require("ccb")

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q J  ",
            "  JA ",
            "     ",
            "  J  ",
            " AJ  ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q N  ",
            "  NA ",
            "     ",
            "  N  ",
            " AN  ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q c Y",
            "  ch ",
            "    o",
            "  l  ",
            "ɱhcP ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " Ph  ",
            " ccc ",
            " ccc ",
            "  h  ",
            " k   ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for mutagen research areas.  Science crate loot.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_small_animals_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 2, 10 },
            },
        },
    },
}

-- A nested map for mutagen research areas.  Small animals for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_small_animal_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "lab_rats_1x1", weight = 50 },
                    { id = "lab_hares_1x1", weight = 50 },
                    { id = "lab_rabbits_1x1", weight = 50 },
                    { id = "lab_black_rats_1x1", weight = 50 },
                    { id = "lab_foxes_1x1", weight = 50 },
                    { id = "lab_racoons_1x1", weight = 50 },
                    { id = "lab_pigeon_1x1", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- A nested map for mutagen research areas.  mid size animals.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medium_animal_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_cats_1x1", weight = 50 }, { id = "lab_dog_1x1", weight = 50 } },
                x = 0,
                y = 0,
            },
        },
    },
}

-- A nested map for mutagen research areas.  mid size animals.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medium_animal_1x1_MUTANT",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "lab_cats_1x1_MUTANT", weight = 50 },
                    { id = "lab_dog_1x1_MUTANT", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}
