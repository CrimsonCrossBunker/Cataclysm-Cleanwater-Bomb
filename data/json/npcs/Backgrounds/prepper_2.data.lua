local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY1",
    line = ccb.content.gendered_line("Oh, man.  I thought I was ready.  I had it all planned out.  Bug out bags.  Loaded guns.  Maps of escape routes.  Bunker in the back yard.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sounds like it didn't work out."),
            next_topic = "BGSS_PREPPER_2_STORY2",
        },
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_MAPS",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY2",
    line = ccb.content.gendered_line("Depends on your definition.  I'm alive, aren't I?  When Hell itself came down from the skies and monsters started attacking the cities, I grabbed my stuff and crammed into the bunker.  My surface cameras stayed online for days; I could see everything happening up there.  I watched those things stride past.  I still have nightmares about the way their bodies moved, like they broke the world just to be here.  I had nothing better to do.  I watched them rip up the cops and the military, watched the dead rise back up and start fighting the living.  I watched the nice old lady down the street rip the head off my neighbor's dog.  I saw a soldier's body twitch and grow into some kind of electrified hulk beast.  I watched it all happen.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why did you leave your bunker?"),
            next_topic = "BGSS_PREPPER_2_STORY3",
        },
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_MAPS",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_STORY3",
    line = ccb.content.gendered_line("Honestly?  I was planning to die.  After what I'd seen, I went a little crazy.  I thought it was over for sure, I figured there was no point in fighting it.  I thought I wouldn't last a minute out here, but I couldn't bring myself to end it down there.  I headed out, planning to let the <zombies> finish me off, but what can I say?  Survival instinct is a funny thing, and I killed the ones outside the bunker.  I guess the adrenaline was what I needed.  It's kept me going since then.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Hey, I'd really be interested in seeing those maps."),
            next_topic = "BGSS_PREPPER_2_MAPS",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")),
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_MAPS",
    line = ccb.content.text("Yeah, I do.  I'd be willing to part with them for, say, $1000.  Straight from your ATM account, no cash cards."),
    replies = {
        {
            text = ccb.content.text("[$1000] You have a deal."),
            next_topic = "BGSS_PREPPER_2_SOLD",
            when = predicates.handler("dlg_p_dda_e48f5767fe4f"),
            actions = { actions.handler("dlg_a_dda_59e0479701fb") },
        },
        {
            text = ccb.content.text("Whatever's in that map benefits both of us."),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = { kind = "persuade", difficulty = 40, modifiers = { { score = "VALUE", scale = 3 }, { score = "TRUST", scale = 1 } } },
            success = { next_topic = "BGSS_PREPPER_2_SOLD" },
            failure = { next_topic = "BGSS_PREPPER_2_NOSALE" },
        },
        {
            text = ccb.content.text("How 'bout you fucking hand it over and I don't get pissed off?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "BGSS_PREPPER_2_SOLD" },
            failure = { next_topic = "BGSS_PREPPER_2_NOSALE" },
        },
        {
            text = ccb.content.text("Sorry for changing the subject.  What was it you were saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_SOLD",
    line = ccb.content.text("All right.  Here they are."),
    replies = {
        {
            text = ccb.content.text("Thanks!  <done_conversation_section>"),
            next_topic = "TALK_NONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
        {
            text = ccb.content.text("Thanks!  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
        {
            text = ccb.content.text("Thanks!  <end_talking>"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_NOSALE",
    line = ccb.content.text("Nice try.  You want the maps, you pay up."),
    replies = {
        {
            text = ccb.content.text("Fine.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
