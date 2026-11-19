local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Work1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        yes = ccb.content.text("Well, now that you mention it, with the back bay cleared I could probably set up back there and start work.  I don't know if I can handle it.  The last time I was back there was the last time I saw… if… if someone were to clean up back there, wipe away some memories, then I could start renovating it into a better living space."),
        no = ccb.content.text("There isn't much to do with a hammer and a saw here indoors, and working outside is too dangerous.  If we had enough space for me to do some shuffling around, I could build some privacy walls in here.  I tried to set up a bit of a shop in the garage space, but I had to keep taking everything down for caravan loading and unloading and couldn't get anything done.  The caravans bring food, so they get priority, I can't argue with that."),
    },
    replies = {
        {
            text = ccb.content.text("What do you need to get things cleaned up?  Can I help?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
            next_topic = "TALK_REFUGEE_Boris_Work2",
        },
        {
            text = ccb.content.text("I'm sorry.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
