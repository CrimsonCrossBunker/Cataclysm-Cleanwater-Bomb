local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "NC_ANCILLA_BOSS_CHOP_SHOP_WHO_FAILED_1" },
    line = ccb.content.text("&The mercenary chambers a round in their firearm.  \"I'm the one telling you to go.  Last warning.  No more questions.  Leave, or you're dead.  It's that simple.\""),
    replies = {
        {
            text = ccb.content.text("Alright, I hear your warning."),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ANCILLA_BOSS_CHOP_SHOP_WHAT_FAILED_1" },
    line = ccb.content.text("&The mercenary chambers a round in their firearm.  \"Somewhere you don't belong, and definitely don't want to be.  Final warning.  No more questions.  Leave, or we shoot.\""),
    replies = {
        {
            text = ccb.content.text("Alright, I hear your warning."),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ANCILLA_BOSS_CHOP_SHOP_WHO_ELSE_FAILED_1" },
    line = ccb.content.text("&The mercenary chambers a round in their firearm.  \"Just us and the guy who told us to shoot anyone that comes by.  Last chance.  No more questions.  Leave.  Or I'll fill you with holes, and the doc can turn you into one of his fucked up experiments.\""),
    replies = {
        {
            text = ccb.content.text("Alright, I hear your warning."),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_2",
        },
    },
}
