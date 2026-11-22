local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_TAP",
    line = {
        when = predicates.has_trait("interlocutor", "NPC_WHISKEY"),
        yes = {
            choices = {
                ccb.content.text("Take a look at our selection and let me know what you're interested in."),
                ccb.content.text("We have a decent variety of drinks.  What interests you?"),
                ccb.content.text("What are you in the mood for?"),
            },
        },
        no = ccb.content.text("Our selection is a bit limited at the moment.  If you're willing to help out, I can get some more variety in here."),
    },
    replies = {
        {
            text = ccb.content.text("Just a glass of water, please."),
            next_topic = "TALK_DONE",
            actions = { actions.update_map("tacoma_commune_glass_water", "ranch_camp_51"), actions.handler("dlg_a_dda_df0892817ffd") },
        },
        {
            text = ccb.content.text("[$8] I'll take a beer."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_22a7b1bd6868") },
        },
        {
            text = ccb.content.text("[$12] I'll take a shot of brandy."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_BRANDY"),
            actions = { actions.handler("dlg_a_dda_120b90d90d9e"), actions.update_map("tacoma_commune_shot_brandy", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("[$12] I'll take a shot of rum."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_RUM"),
            actions = { actions.handler("dlg_a_dda_13aed4f4da60"), actions.update_map("tacoma_commune_shot_rum", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("[$15] I'll take a shot of whiskey."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_WHISKEY"),
            actions = { actions.handler("dlg_a_dda_5adf4fb1b6c9"), actions.update_map("tacoma_commune_shot_whiskey", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("On second thought, don't bother."),
            next_topic = "TALK_RANCH_BARKEEP",
        },
    },
}
