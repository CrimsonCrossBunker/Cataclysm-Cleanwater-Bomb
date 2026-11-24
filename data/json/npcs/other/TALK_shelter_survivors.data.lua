local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_EVAC_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("<greet>."),
        no = ccb.content.text("Don't come any closer!"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What's wrong?"),
            next_topic = "TALK_NPC_EVAC_SURVIVOR_CALM",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("<greet>."),
            next_topic = "TALK_NPC_EVAC_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_EVAC_SURVIVOR_CALM",
    line = ccb.content.gendered_line("Oh, you're not one of them.  Those <zombies>, I mean.  Come on in, just don't cause any trouble.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Alright, let's chat."),
            next_topic = "TALK_NPC_EVAC_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_EVAC_SURVIVOR_INTRO",
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_EVAC_SURVIVOR_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_EVAC_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow" }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = 0, fear = 0 } },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_EVAC_SURVIVOR_STORY",
    line = ccb.content.gendered_line("I found this emergency shelter when I was running from the chaos back in the cities.  Fortunately, the place hadn't been looted yet and there weren't any <zombies> lurking around; just the spot to stay 'till who knows when.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Wow."), next_topic = "TALK_NONE" } },
}
