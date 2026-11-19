local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_ASK",
    line = ccb.content.text("We've been working on specialized gear for potential agents in the field, given the hardware we have available.  Given the risks we've observed from here, it seemed astute.  It seems we still have some work to do."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_armor", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_armor" }, { "yes" }),
            },
            once = "told_about_armor",
        },
    },
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_NEUTRAL" },
        {
            text = ccb.content.text("[INT 10] The pieces seemed warped.  Whatever you're using to reinforce the armor isn't strong enough."),
            when = predicates.minimum_attribute("speaker", "intelligence", 10),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_POSITIVE",
        },
    },
}
