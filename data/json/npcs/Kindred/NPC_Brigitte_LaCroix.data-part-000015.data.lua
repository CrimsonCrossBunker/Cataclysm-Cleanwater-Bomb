local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_METCOOPER2",
    line = ccb.content.text("You have?  A most peculiar coincidence.  How did he act towards you?"),
    replies = {
        {
            text = ccb.content.text("I've confronted him.  He ended up attacking me."),
            next_topic = "TALK_BONE_SEER_COOPERFIGHT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } }),
        },
        {
            text = ccb.content.text("He was reasonable.  We talked, then parted ways peacefully."),
            next_topic = "TALK_BONE_SEER_COOPERPEACE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })),
        },
        {
            text = ccb.content.text("I agree with him.  What he does is necessary."),
            next_topic = "TALK_BONE_SEER_COOPERAGREE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }) }),
        },
    },
}
