local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_weakpoint_mon",
    name = ccb.content.text_without_extraction("weakpoint monster"),
    description = ccb.content.text_without_extraction("This monster exists only for weakpoint testing purposes."),
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 10000,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 1,
    families = { "prof_debug_weakpoint", { proficiency = "prof_debug_weakpoint_expert", bonus = 100 } },
    weakpoints = {
        {
            name = ccb.content.text("the belly"),
            armor_multiplier = { bullet = 0.5 },
            armor_penalty = { bullet = 25 },
            coverage = 50,
            attack_coverage = { all = 0.5 },
            target_effect = "stunned",
            id = "the belly",
        },
        {
            name = ccb.content.text("impossible to hit"),
            coverage = 100,
            difficulty = { all = 100.0 },
            id = "impossible to hit",
        },
        {
            name = ccb.content.text("the knee"),
            armor_multiplier = { bullet = 0.0 },
            armor_penalty = { bullet = 0 },
            damage_multiplier = { all = 2.0 },
            coverage = 25,
            effects = {
                {
                    effect = "stunned",
                    duration = { "1 seconds", "3 seconds" },
                    permanent = false,
                    intensity = { 0, 0 },
                    damage_percent = { 0, 100 },
                    chance = 50,
                    message = ccb.content.text("The %s is disorientated."),
                },
            },
            id = "the knee",
        },
    },
    harvest = "zombie_humanoid",
    flags = { "IMMOBILE", "NOT_HALLUCINATION", "FILTHY" },
    armor = { bullet = 100 },
}
