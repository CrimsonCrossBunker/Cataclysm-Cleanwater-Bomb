local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_Friends4ever",
    line = {
        when = predicates.any_equal({ "ddotd", { scope = "speaker", key = "flag_modded" } }),
        yes = ccb.content.text_without_extraction("<talk_snippet_modded_liam_Friends4ever>"),
        no = ccb.content.text("Aww, of course.  No matter what happens, you're always you and I'm always me, right?  We've been through worse than this.\"  He pauses, his brow furrowed.  \"Well, okay, maybe we haven't.  But we've stuck through it all for so many years, what's a little apocalypse gonna change?  Or a little mutation, or grievous bodily harm, or zombies, or interdimensional monster attacks and serious life-altering PTSD, or whatever.  Who cares.  You're my family, more than my birth family ever was."),
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}
