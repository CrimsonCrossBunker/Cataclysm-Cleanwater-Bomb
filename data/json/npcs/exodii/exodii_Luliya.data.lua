local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Materials manager and music fan from another Ethiopia.
ccb.content.define_npc {
    id = "exodii_materials",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_EXODII_TYPE_2_Materials",
    unique_name = ccb.content.text("Luliya"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_LULIYA",
    faction = "exodii",
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_2_Materials",
    name = ccb.content.text("Cyborg, type 2"),
    job_description = ccb.content.text("I'm a cyborg."),
    traits = {
        { trait = "EXODII_BODY_2" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "NPC_STASIS" },
    },
    common = false,
    strength = { rng = { 0, 6 } },
    dexterity = { rng = { 0, 6 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 4 } },
    weapon = "NC_EXODII_TYPE_2_carried",
    worn = "EMPTY_GROUP",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = 0 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
        { skill = "speech", bonus = { rng = { 5, 8 } } },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_ENGLISH",
    line = ccb.content.text("&A long pause, then she shakes her head  \"Inigilizinya yelemi.  No.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_language_u_not_english_luliya", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("All right then.  You seem to understand what I mean.  And the word no."),
            next_topic = "TALK_LULIYA",
        },
        { text = ccb.content.text("Fine.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_NAME",
    line = ccb.content.text("&A long pause.  You can't see her eyes but it seems like she is studying your face.  \"Sime Luliya ibalalehu.\"  She points to her own chest.  \"Luliya.\"  She points to your chest.  \"<u_name>.  Siletewawekini desi bilonyali, <u_name>.\"  She strums a pleasant melody on her krar."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_name_u_luliya_name", "yes") } } },
    replies = {
        {
            text = ccb.content.text("We're getting somewhere.  Pleased to meet you Luliya."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_ARABIC",
    line = ccb.content.text("&A long pause, then she shakes her head.  \"Ayi arebinya alinagerimi.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_language_u_not_arabic_luliya", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("All right then.  It seems like you do kind of understand it though."),
            next_topic = "TALK_LULIYA",
        },
        { text = ccb.content.text("Fine.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_MUSIC",
    line = ccb.content.text("&She nods enthusiastically and strums a few notes on her krar.  \"Awo muzika iwedalehu.\""),
    replies = {
        {
            text = ccb.content.text("[Use Guitar] I happen to have a nice guitar, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "acoustic_guitar"),
        },
        {
            text = ccb.content.text("[Use Trumpet] I happen to have a nice trumpet, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "trumpet"),
        },
        {
            text = ccb.content.text("[Use Saxophone] I happen to have a nice saxophone, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "saxophone"),
        },
        {
            text = ccb.content.text("[Use Violin] I happen to have a nice violin, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "violin"),
        },
        {
            text = ccb.content.text("[Use Harmonica] I happen to have a nice harmonica, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "harmonica_holder"),
        },
        {
            text = ccb.content.text("[Use Cowbell] I happen to have a nice cowbell, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "cow_bell"),
        },
        {
            text = ccb.content.text("Huh, you know music, good to know.  I'll try and find something to play and come back."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_MUSIC2",
    line = ccb.content.text("&You perform on your musical instrument with everything you have, giving a strong performance.  Luliya sways and begins to play her instrument and sing along.  The music and her voice are beautiful, she sounds like she has had some formal musical training."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "general_music_u_jammed_luliya", "yes"), actions.handler("dlg_a_dda_b37aabecb038") } },
    },
    replies = {
        {
            text = ccb.content.text("Fun, thank you for playing with me, Luliya."),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("Fun, thank you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
