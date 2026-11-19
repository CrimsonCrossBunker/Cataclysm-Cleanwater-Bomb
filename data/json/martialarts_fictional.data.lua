local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_centipede_disarm",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You disarm %s with lightning speed"),
        ccb.content.text("<npcname> disarms %s with lightning speed"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    attack_vectors = { "vector_grasp" },
}
