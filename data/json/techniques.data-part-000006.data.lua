local ccb = require("ccb")

-- this should basically always happen if you get the crit
ccb.content.define_technique {
    id = "SWEETSPOT",
    name = ccb.content.text("Sweet Spot Hit"),
    melee_allowed = true,
    crit_tec = true,
    needs_ammo = true,
    stun_dur = 1,
    knockback_dist = 2,
    weighting = 10,
    mult_bonuses = {
        { stat = "movecost", scale = 1.1 },
        { stat = "damage", damage_type = "bash", scale = 2.5 },
        { stat = "damage", damage_type = "cut", scale = 2.5 },
        { stat = "damage", damage_type = "stab", scale = 2.5 },
    },
    messages = {
        ccb.content.text("With a loud crack the piston extends, sending %s reeling"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Stun 1 turn, knockback 2 tile, crit only, requires ammo"),
    attack_vectors = { "vector_null" },
}
