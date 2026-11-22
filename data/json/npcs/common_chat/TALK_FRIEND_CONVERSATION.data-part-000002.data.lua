local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_CHAT",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_4af84673eeb8"),
            yes = {
                choices = {
                    {
                    when = predicates.has_item("speaker", "beer"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_item("speaker", "european_pilsner"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_item("speaker", "drink_hard_seltzer"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_item("speaker", "pale_ale"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_item("speaker", "india_pale_ale"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_item("speaker", "wine_barley"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.handler("dlg_p_dda_e13e38001d0d"),
                    yes = ccb.content.text("<chitchat_prefix_summer>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.handler("dlg_p_dda_0b5c98d989be"),
                    yes = ccb.content.text("<chitchat_prefix_winter>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
                    {
                    when = predicates.has_effect("interlocutor", "infected"),
                    yes = ccb.content.text("<chitchat_prefix_infected>  <neutralchitchat_later>"),
                    no = ccb.content.text("<neutralchitchat_later>"),
                },
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
            no = {
                choices = {
                    {
                    when = predicates.has_item("speaker", "beer"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_item("speaker", "european_pilsner"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_item("speaker", "drink_hard_seltzer"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_item("speaker", "pale_ale"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_item("speaker", "india_pale_ale"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_item("speaker", "wine_barley"),
                    yes = ccb.content.text("<chitchat_prefix_booze>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.handler("dlg_p_dda_e13e38001d0d"),
                    yes = ccb.content.text("<chitchat_prefix_summer>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.handler("dlg_p_dda_0b5c98d989be"),
                    yes = ccb.content.text("<chitchat_prefix_winter>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
                    {
                    when = predicates.has_effect("interlocutor", "infected"),
                    yes = ccb.content.text("<chitchat_prefix_infected>  <neutralchitchat>"),
                    no = ccb.content.text("<neutralchitchat>"),
                },
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
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            actions = { "morale_chat_activity", actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }) },
            switch = true,
        },
    },
}
