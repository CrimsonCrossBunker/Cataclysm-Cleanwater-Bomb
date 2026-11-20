local ccb = require("ccb")

-- Legs are important to this monster as he needs them to climb and leap.
ccb.content.define_monster {
    id = "mon_inner_cabins_interstice_horror",
    name = ccb.content.plural_text("pallid horror", "pallid horrors"),
    description = ccb.content.text("You're barely able to believe this thing was ever human; it scrambles about on all fours in contorted configurations.  Its pale eyes dart around, searching for unseen horrors."),
    copy_from = "mon_zombie_base",
    species = { "MUTANT", "ZOMBIE" },
    hp = 120,
    speed = 110,
    symbol = "@",
    color = "red",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 3,
    bleed_rate = 50,
    vision_day = 2,
    vision_night = 100,
    grab_strength = 15,
    harvest = "zombie_humanoid_shadow",
    weakpoints = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.5 },
            coverage = 3,
            id = "the head",
        },
        {
            name = ccb.content.text("the eyes"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            id = "the eyes",
        },
        {
            name = ccb.content.text("the leg"),
            armor_multiplier = { physical = 0.75 },
            coverage = 3,
            id = "the leg",
        },
    },
    weakpoint_sets = {},
    attacks = {
        { id = "scratch", damage = { { type = "cut", amount = 12 } } },
        {
            id = "grab_drag",
            cooldown = 12,
            grab_settings = { drag_distance = 10, drag_deviation = 1, move_cost_multiplier = 0.2 },
        },
        { cooldown = 20, maximum_range = 3, kind = "leap" },
    },
    upgrade = false,
    inheritance = {
        add = {
            move_skills = { climb = 8 },
            flags = {
                "SMELLS",
                "GOODHEARING",
                "HAS_MIND",
                "CAN_OPEN_DOORS",
                "PRIORITIZE_TARGETS",
                "SILENTMOVES",
            },
        },
    },
}
