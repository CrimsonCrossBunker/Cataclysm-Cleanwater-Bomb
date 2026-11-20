local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi2",
    line = ccb.content.text(
        --~ That's right, I did.  My mother's mother was a woman of the old kind, and so was my father's father.  My father's mother, she was a grandma, a little piece of old London-Town, but I had a jaryi and a taita and a tamoi (these are words for grandparents in a guarani dialect).  They were all there, right to the end.  Standing by, we were, one and all.  No time for stories, though.  Back to the here and now.
        "Right so, a fine notice.  Rubik's mother-twice, she were a woman o'th'old kind.  And were her mate, and Rubik's father-twice.  Rubik's father-mother, she were a gran, a fitty bit of ol' London-Town, right so, but Rubik had a jaryi and a taita and a tamoi.\" Rubik's voice goes distant for a moment.  \"An' they was all there, right to the end.  Standin' by, we were, one and all.\" They pause, then seem to snap back.  \"No time for stories, kennit?  Back to the here an' now."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_rubik_jaryi_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, let's talk about business again."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_explain",
    line = ccb.content.text(
        --~ Without any indication of its location, there's too much ground to cover, and we have many other things to look for.  This one is pretty easy to see, so maybe some of the locals can help find it.
        "'Tis a gull's errand, with narry a sign.  Our stompers cannot cover each squarrel, and they've many a dropsy to search.  This'n be a right easy spot for keen eyes, so mayhap your sameworlds can be of a snap."),
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_find",
    line = ccb.content.text(
        --~ that's up to you, I think.  If I could find it myself, I'd send quads out there.  Maybe it would be worth asking around to other survivors?  Seems like a good job for a local guide.
        "That's be for your assert, an I'm ken.  If ol' Rubik could find 'er, us'n'd send out the stompers.  For a yark an' a lark, though, couldst ask another of your sameworld?  Mercants or traveler-such?  It be a fine slick to a local guide."),
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_reward",
    line = {
        when = predicates.has_trait("speaker", "CBM_Interface"),
        yes = ccb.content.text("Ye'll win the endless delight of ol' Rubik?\"  You hear a tinny chuckle from behind Rubik's faceplate.  \"O'course.  Ol' Rubik can find f'r ye something a mite special, from the ol' CBM vaults.  Mayahp a choice?  We're kickin' a thriceways.\"  Rubik reaches into the desk in front of them and pulls out a tiny, green-glowing CRT that, amid all the strange alien technology, looks bizarrely familiar, like something from a 1970's sci-fi movie.  They scroll rapidly down a list to find three items, which they tap to emphasize.  'air filtration CBM', 'blood analysis CBM', and 'radiation scrubber system CBM'.\n\n\"Think on it, decide on a last."),
        no = ccb.content.text("Ye'll win the endless delight of ol' Rubik?\"  You hear a tinny chuckle from behind Rubik's faceplate.  \"O'course.  Ol' Rubik can find f'r ye something a mite special from the ol' vaults, or, us'n can fix ye with some goods like ol' Rubik's, aye - stuck in the flesh and to the bone, wired into the brain."),
    },
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
