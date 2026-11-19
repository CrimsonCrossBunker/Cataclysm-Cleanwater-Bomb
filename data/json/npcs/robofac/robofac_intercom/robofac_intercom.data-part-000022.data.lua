local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- These lines are being paraphrased mostly from written information, so repeating things or using distinct phrasing is fine
ccb.content.define_dialogue_topic {
    id = {
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_1", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
    },
    line = ccb.content.text("Understand that I'm not an expert about this.\"  The voice sighs.  You hear the person on the other side typing on a keyboard for several seconds.  \"I will explain it as best I can, but again, I'm not a professional.  Whatever caused the apocalypse, it… broke something about the way our world works.  I'm sure you've noticed that 'normal' physics don't always apply anymore.  We are, as of right now, uncertain if our models were wrong, or if this is something fundamentally different to our reality.\"\n\n\"From what we've observed, these events are what happen at the peak of a cyclical effect.  This is gross oversimplification, and I don't know the science behind it, but… I guess the simplest way to think of it is that 'our' reality is moving closer and further from this other place, or model, or so on.  Like a yo-yo.  When these two things are closest together, we get portal storms.  Otherwise, things are… I wouldn't say normal, not anymore, but they are as close to normal as we get now.\"\n\n\"Reading a footnote here… we're looking to gather data about these storms using a device developed specifically for the purpose.  I'll add that to your contracts list, if you want to know more about it."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_portal_storms", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_portal_storms" }, { "yes" }),
            },
            once = "told_about_portal_storms",
        },
    },
    replies = {
        {
            text = ccb.content.text("Are there any warning signs?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
        },
        {
            text = ccb.content.text("Is there any way to stay safe during one?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3",
        },
        {
            text = ccb.content.text("That sounds pretty bad.  Is this going to get worse?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
        },
        {
            text = ccb.content.text("How can you know all this?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5",
        },
        {
            text = ccb.content.text("Is there anything useful I could find in one of these storms?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
        },
        {
            text = ccb.content.text("Thank you for the information."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_END",
        },
    },
}
