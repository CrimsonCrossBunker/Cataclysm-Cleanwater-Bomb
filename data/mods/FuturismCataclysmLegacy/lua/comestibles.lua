local ccb = require("ccb")
local content = ccb.content

content.replace(content.Item {
    id = "panacea",
    copy_from = "panacea",
    name = content.plural_text("Panaceus", "Panaceii"),
    symbol = "!",
    color = "red",
}:activate_effects {
    message = content.text("You feel AMAZING!"),
    effects = {
        { id = "panacea", duration_turns = 60 },
        { id = "cureall" },
        { id = "fcl_cureall", duration_turns = 60 },
    },
    damage_over_time = {
        {
            damage_type = "pure",
            duration_turns = 60,
            amount = -10,
            bodyparts = { "torso", "head", "arm_l", "leg_l", "arm_r", "leg_r" },
        },
    },
}:flag("NPC_SAFE"):flag("IRREPLACEABLE_CONSUMABLE"))
