local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Mood",
    line = ccb.content.text("I'm just here, really.  I'm the local mechanic around here, I just fiddle with the machinery.  Just about all of it is a <freaking> <name_b>, older than dirt and nearly unfixable.  They're running a wood-fire generator for power, the <freaking> thing is the noisiest clunker I've ever heard."),
    replies = {
        {
            text = ccb.content.text("How have things changed after that deal with Helena?"),
            next_topic = "TALK_GODCO_Corrie_Result_rewardIcon",
            when = predicates.all({ predicates.any_equal({ "icon", { scope = "speaker", key = "mission_reward_godco_machine_reward" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_reward_unclaimed_machine_reward" } }) }),
        },
        {
            text = ccb.content.text("How have things changed after that deal with Helena?"),
            next_topic = "TALK_GODCO_Corrie_Result_rewardRation",
            when = predicates.all({ predicates.any_equal({ "ration", { scope = "speaker", key = "mission_reward_godco_machine_reward" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_reward_unclaimed_machine_reward" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("No rest for the weary…"), next_topic = "TALK_DONE" },
    },
}
