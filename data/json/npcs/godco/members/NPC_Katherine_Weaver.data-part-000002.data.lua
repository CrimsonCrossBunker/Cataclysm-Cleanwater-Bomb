local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Corrie",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
        yes = ccb.content.text("She knows this and that about electronics.  The generator we have here was made by her.  Nice to have one here, even though there's not much use for it yet."),
        no = ccb.content.text("I hear she knows this and that about electronics.    She keeps herself occupied by doing menial tasks around the camp, looking for payment."),
    },
}
