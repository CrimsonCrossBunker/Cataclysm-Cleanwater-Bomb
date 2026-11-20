local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_predator",
    name = ccb.content.plural_text("zombie predator", "zombie predators"),
    description = ccb.content.text("With its joints in odd places and angles, this humanoid creature prowls across the landscape with surprising speed.  Its teeth and arms are sharpened into fine points, and black ooze seeps out from cuts between its muscles."),
    copy_from = "mon_zombie_hunter",
    species = { "ZOMBIE" },
    speed = 140,
    color = "brown_green",
    melee_skill = 5,
    melee_dice = 4,
    melee_damage = { { type = "cut", amount = 5 } },
    dodge = 5,
    weakpoints = {
        {
            name = ccb.content.text("the head"),
            head = true,
            armor_multiplier = { physical = 0.5 },
            coverage = 3,
            id = "the head",
        },
        {
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            id = "the eye",
        },
    },
    bleed_rate = 0,
    vision_day = 45,
    vision_night = 15,
    pathing = { max_distance = 5 },
    attacks = {
        {
            cooldown = 10,
            maximum_range = 5,
            minimum_target_distance = 2,
            maximum_target_distance = 4,
            kind = "leap",
        },
        {
            cooldown = 10,
            damage = { { type = "stab", amount = 10, armor_multiplier = 0.2 } },
            kind = "bite",
        },
        { id = "impale" },
    },
    upgrade = false,
    armor = { bash = 5, cut = 5, bullet = 4, electric = 1 },
}
