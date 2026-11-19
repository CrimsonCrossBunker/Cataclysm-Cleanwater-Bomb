local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_WING_SLAP",
    name = ccb.content.text("Wing Slap"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slap %s with your wings"),
        ccb.content.text("<npcname> slaps %s with their wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_wing_slap" },
    flat_bonuses = { { stat = "movecost", scale = 20 } },
}

ccb.content.define_technique {
    id = "VINE_LIMB_WHIP",
    name = ccb.content.text("Vine whip"),
    messages = {
        ccb.content.text("You whip %s with your vines"),
        ccb.content.text("<npcname> whips %s with their vines"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_vine_limb" },
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -3.75 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}
