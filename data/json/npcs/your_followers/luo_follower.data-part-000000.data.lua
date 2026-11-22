local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_Luo", "TALK_FRIEND_Luo_Abilities" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *pshhhttt* Hey stinkyface.  It's your favorite mushroom girl.  Over."), no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = ccb.content.text("So, here we are.  What's up?") } },
    replies = {
        {
            text = ccb.content.text("[rules] Let's talk about how we'll work together."),
            next_topic = "TALK_DONE",
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("I'd like to know a bit more about your abilities."),
            next_topic = "TALK_FRIEND_Luo_Abilities",
            actions = { "reveal_stats" },
        },
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("There's something I want you to do."),
            next_topic = "TALK_LUO_ORDERS",
        },
        {
            text = ccb.content.text("I just wanted to talk for a bit."),
            next_topic = "TALK_LUO_SOCIAL",
            when = predicates.handler("dlg_p_dda_5d493fb3087d"),
        },
        {
            text = ccb.content.text("Can you help me understand something?  (HELP/TUTORIAL)"),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("I'm going to go my own way for a while."),
            next_topic = "TALK_LEAVE",
        },
        {
            text = ccb.content.text("[DEBUG MIND CONTROL] Now listen closely… (DEBUG FUNCTIONS)"),
            next_topic = "TALK_ALLY_DEBUG",
            when = predicates.has_trait("speaker", "DEBUG_MIND_CONTROL"),
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}
