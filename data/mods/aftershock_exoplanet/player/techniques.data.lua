local ccb = require("ccb")

ccb.content.define_technique {
    id = "AFS_PRESSURE_CRUNCH",
    name = ccb.content.text("Pressure Crunch"),
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    crit_tec = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    stun_dur = 3,
    knockback_dist = 2,
    weighting = 1,
    messages = {
        ccb.content.text("You smash %s with a pressurized slam"),
        ccb.content.text("<npcname> smashes %s with a pressurized slam"),
    },
    description = ccb.content.text("Heavy stun and knockback, 1.5x bash damage, crit only"),
}
