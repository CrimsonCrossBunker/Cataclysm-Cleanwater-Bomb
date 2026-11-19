local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_BAD",
    line = ccb.content.text("&While the veterans indulge your storytelling, they clearly seem not too pleased nor impressed by your tale."),
    on_enter = { { actions = { actions.adjust_faction_trust(-5) } } },
    replies = {
        {
            text = ccb.content.text("Well, ugh…  I should be going now…"),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
    line = ccb.content.text("&You make some small talk and share a pair of drinks after finishing your story."),
    on_enter = {
        {
            actions = {
                actions.add_effect("speaker", "drunk", { turns = 1200 }),
                actions.adjust_faction_trust(1),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
    line = ccb.content.text("&The clearly drunk mercenaries hail you as minor celebrity and invite you to a pair of rounds when your tale is finished."),
    on_enter = {
        {
            actions = {
                actions.add_effect("speaker", "drunk", { turns = 4200 }),
                actions.adjust_faction_trust(3),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah I guess it really did happen just like that."),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_BUTCHERY",
    line = ccb.content.text("&The veterans eagerly accept your challenge, and none of you can really stomach the prospect of more drinks after the first pair of tales."),
    on_enter = {
        {
            actions = {
                actions.add_effect("speaker", "drunk", { turns = 1200 }),
                actions.adjust_faction_trust(1),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_LIXA",
    line = ccb.content.text("&The expressions on both the mercs' faces are a mix of confusion and visceral disgust as you relate your tale.  Finally, the younger mercenary blurts out, \"None of us wanted to touch that contract since the intercom was being so shifty about it.\"  \"You're my kind of free-range lunatic!\"  The older mercenary interjects.  \"I'll drink to that!\"."),
    on_enter = { { actions = { actions.adjust_faction_trust(10) } } },
    replies = {
        {
            text = ccb.content.text("Yeah, that was certainly an…  interesting experience."),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_TOWER",
    line = ccb.content.text("&The veteran's expressions turn to a mixture of awe and fear as your tale nears conclusion, the younger mercenary is finally after a long  \"We heard someone had gone and completed that death trap contract, but I still couldn't believe it.\"  \"You're a damn madman!\"  The older mercenary interjects in agreement.  \"I'll drink to that!\"."),
    on_enter = { { actions = { actions.adjust_faction_trust(10) } } },
    replies = {
        {
            text = ccb.content.text("Yeah looking back I really don't know why I did it."),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
