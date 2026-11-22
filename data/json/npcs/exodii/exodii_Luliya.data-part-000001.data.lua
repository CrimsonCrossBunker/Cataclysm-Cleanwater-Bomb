local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } }),
        yes = {
            choices = {
                ccb.content.text("Inikwani dehina metahi tegwazhi."),
            },
        },
        no = ccb.content.text("&You see a tall golden figure with female features.  Strapped to the back of the head with copper wire is a glass cylinder containing long frizzy black hair.  The body stands still and emits an unpleasant beeping sound.  On the back there is a large red button with strange markings.  There is a golden harp of some kind in their hand."),
    },
    replies = {
        {
            text = ccb.content.text("[Push the big red button.]"),
            next_topic = "TALK_LULIYA_BUTTON",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } })),
        },
        {
            text = ccb.content.text("[Use Stethoscope] Is this alive?"),
            next_topic = "TALK_LULIYA_PULSE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } })), predicates.has_item("speaker", "stethoscope") }),
        },
        {
            text = ccb.content.text("[Do nothing.]"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } })),
        },
        {
            text = ccb.content.text("Do you speak English?  [slowly and loudly]  ENGLISH?"),
            next_topic = "TALK_LULIYA_ENGLISH",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_language_u_not_english_luliya" } })) }),
        },
        {
            text = ccb.content.text("[You point to your chest.]  <u_name>.  [You point at the golden figure.]  What is your name?"),
            next_topic = "TALK_LULIYA_NAME",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_name_u_luliya_name" } })) }),
        },
        {
            text = ccb.content.text("I heard you playing that.  [You point at the golden harp she holds]  La la la.  Do you like music, Luliya?"),
            next_topic = "TALK_LULIYA_MUSIC",
            when = predicates.handler("dlg_p_dda_9ceba3cb700d"),
        },
        {
            text = ccb.content.text("I can't understand you."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_luliya" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_BUTTON",
    line = ccb.content.text("&You hear a loud static discharge, a rough mechanical chugging sound, and then high-pitched shrieking with strange distortions and modulations in the sound.  The golden figure shudders, arms flailing.  \"ቆዳዬ! ቆዳዬ በእሳት ላይ ነው! እየሞትኩ ነው!\""),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "general_meeting_u_met_luliya", "yes"), actions.handler("dlg_a_dda_1b60f4c40dad") } },
    },
    replies = {
        {
            text = ccb.content.text("Hello.  Are you all right?  I just hit the button on your back."),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("I'm not understanding that.  Can you try again?"),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("Speak English ya <freaking> robot.  We don't take kindly to that kind of thing here.  [You frown menacingly]"),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("State your name and function machine."),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("[INT 11]  Huh.  That sounds a little familiar, a little like Arabic.  Earabiun?  [slowly and clearly]  EARABIUN?"),
            next_topic = "TALK_LULIYA_ARABIC",
            when = predicates.minimum_attribute("speaker", "intelligence", 11),
        },
        {
            text = ccb.content.text("No, I'm done with this."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_PULSE",
    line = ccb.content.text("&You press your stethoscope to the chest of the figure and hear a clear, strong heartbeat and a strange whirring sound that sounds like clockwork."),
    replies = {
        { text = ccb.content.text("So she's alive then."), next_topic = "TALK_LULIYA" },
        {
            text = ccb.content.text("Probably fine then.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
