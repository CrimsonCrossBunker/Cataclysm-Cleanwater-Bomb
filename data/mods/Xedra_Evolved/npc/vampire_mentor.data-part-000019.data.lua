local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MENTOR_CHAT",
    line = {
        choices = {
            {
            when = predicates.minimum_attribute("interlocutor", "intelligence", 8),
            yes = ccb.content.text("<insightfulchitchat>"),
            no = ccb.content.text("<thoughtfulchitchat>"),
        },
            {
            when = predicates.minimum_attribute("interlocutor", "perception", 8),
            yes = ccb.content.text("<insightfulchitchat>"),
            no = ccb.content.text("<thoughtfulchitchat>"),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "PSYCHOPATH")),
            actions = { "morale_chat_activity", actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }) },
            switch = true,
        },
        {
            text = ccb.content.text("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "PSYCHOPATH"),
            actions = { actions.handler("dlg_a_xedra_evolved_1a6836919060"), actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }) },
            switch = true,
        },
    },
}

ccb.content.define_mission {
    id = "KILL_YOUR_BEST_FRIEND",
    name = ccb.content.text("Kill your best friend"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Kill someone that is very close to you to push your vampirism further."),
        offer = ccb.content.text("If you wish to become a true vampire, you must sacrifice someone that really, really likes you."),
        accepted = ccb.content.text("It brings me joy to see someone willing to fully walk the path.  Remember, pain is always temporary, no matter how it hurts.  By this sacrifice, you won't ever be temporary again."),
        rejected = ccb.content.text("I understand.  Some never wanted to walk the path.  Such wasted potential."),
        advice = ccb.content.text("They need to be completely trusting of you, someone that thinks of themselves as your \"best friend forever\".  In addition, keep in mind that the sacrifice must be killed by none and nothing other than you, or else you'll have to find a new sacrifice."),
        inquire = ccb.content.text("Have you found someone that considers you the best person in the world?"),
        success = ccb.content.text("You visibly succeeded.  You should gain more vampiric aptitudes soon.  However, you haven't fully walked the path yet.  Give your powers some time to grow, come here again and I'll explain what to do to completely walk the path!"),
        success_lie = ccb.content.text("Either your vampirism isn't advanced enough, or you tried to bypass the sacrifice.  Either way, do that sacrifice."),
        failure = ccb.content.text("Someday you'll find a suitable sacrifice."),
    },
    complete_when = "complete_kill_your_best_friend",
}

ccb.content.define_mission {
    id = "GET_COMPONENTS_FOR_TIER_5",
    name = ccb.content.text("Find the components for the vampiric ritual"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Gather the components your book mention and bring them to your mentor."),
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
    complete_when = "complete_get_components_for_tier_5",
}
