local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Could you cast a spell for me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_CAST_SPELL",
            when = predicates.has_any_trait("interlocutor", { "DREAMER", "EATER", "HEDGE_MAGIC", "CHANGELING_MAGIC", "XE_NETHER_SORCERY" }),
        },
    },
}
