local ccb = require("ccb")

-- Tracker to save you from being a tree for too long.  Normally wouldn't need to display it but that throws an error about undisplayed active mutations
ccb.content.define_mutation {
    id = "CHANGELING_SPRING_TURN_INTO_TREE_TRACKER",
    name = ccb.content.text("Branch of Yggdrasil"),
    description = ccb.content.text("You are in the form of a tree."),
    points = 0,
    valid = false,
    mixed_effect = true,
    player_display = true,
    active = true,
    starts_active = true,
    wet_protection = {
        { part = "head", ignored = 40 },
        { part = "leg_l", ignored = 40 },
        { part = "leg_r", ignored = 40 },
        { part = "foot_l", ignored = 40 },
        { part = "foot_r", ignored = 40 },
        { part = "arm_l", ignored = 40 },
        { part = "arm_r", ignored = 40 },
        { part = "hand_l", ignored = 40 },
        { part = "hand_r", ignored = 40 },
        { part = "torso", ignored = 40 },
    },
    ignored_by = {
        "MAMMAL", "AMPHIBIAN", "MUTANT", "CYBORG", "REPTILE", "FISH", "KRAKEN", "MIGO", "SLIME",
        "LEECH_PLANT", "INSECT", "CENTIPEDE", "INSECT_FLYING", "SPIDER", "BIRD", "MOLLUSK", "WORM",
        "ZOMBIE", "NETHER", "PLANT", "FERAL", "ROBOT", "HORROR", "ABERRATION", "HUMAN", "VAMPIRE",
        "NIGHTMARE", "HOMULLUS",
    },
    appearance = { id = "t_tree", tile_category = "terrain" },
    on_process = "track_changeling_tree_healing",
}
