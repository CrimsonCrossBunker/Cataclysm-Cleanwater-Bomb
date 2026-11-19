local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_dragon_claw",
    name = ccb.content.text("Dragon Claw"),
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    messages = {
        ccb.content.text("You lash out at %s with a Dragon Claw"),
        ccb.content.text("<npcname> lashes out at %s with a Dragon Claw"),
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}
