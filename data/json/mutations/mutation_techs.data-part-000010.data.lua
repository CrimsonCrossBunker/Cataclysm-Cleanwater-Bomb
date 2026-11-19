local ccb = require("ccb")

ccb.content.define_technique {
    id = "VINE_LIMB_TRIP",
    name = ccb.content.text("Vine trip"),
    messages = {
        ccb.content.text("Your vines snake around %s and knock them down"),
        ccb.content.text("<npcname> knocks down %s with their vines"),
    },
    weighting = -2,
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_vine_limb" },
    effects = {
        {
            id = "downed",
            chance = 100,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scale = -3 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_vine_limb_trip",
}
