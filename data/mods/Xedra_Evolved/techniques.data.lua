local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_SALAMANDER_WING_BUFFET",
    name = ccb.content.text("Wing Buffet"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "gramarye", level = 3 } },
    messages = {
        ccb.content.text("You buffet %s with your burning wings"),
        ccb.content.text("<npcname> buffets %s with their burning wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_salamander_wing_slap" },
    flat_bonuses = {
        { stat = "damage", damage_type = "heat", scaling_stat = "gramarye", scale = 1 },
        { stat = "movecost", scale = 20 },
    },
}
