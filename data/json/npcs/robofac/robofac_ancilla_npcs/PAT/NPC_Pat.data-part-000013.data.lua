local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&The radio is silent for a moment, then Pat chirps back in, laughing.  \"Yeah, right.  Come by heah sometime and show me your integrated toastah, and maybe I'll believe ya'.\""),
        no = ccb.content.text("&Pat stares at you for a second, and then starts to laugh.  \"Oh, yah?  Well, no kiddin' huh?  If it wasn't for the whole end'a'the'world thing, I'd call ya' crazy, but this freakin' world keeps gettin' weirder by the day… wait, wait, wait, nah.  You're fahkin' with me, right?  Almost had me!\""),
    },
    replies = {
        {
            text = ccb.content.text("[Use your Infolink to chirp Pat's radio]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_80af6556c707"),
        },
        {
            text = ccb.content.text("[Open your finger and show off the Fingerhack]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_72b8a19c68d6"),
        },
        {
            text = ccb.content.text("[Light up your LED Tattoo]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_e962ad0af22f"),
        },
        {
            text = ccb.content.text("[Open your finger and show off the Fingerpick]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_ab82dca84eb2"),
        },
        {
            text = ccb.content.text("[Show off your Shotgun Arm] This…  is my BOOMSTICK!"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_a1150702cf50"),
        },
        {
            text = ccb.content.text("[Arm and trigger your Alarm System]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_44c74770e2b9"),
        },
        {
            text = ccb.content.text("[Extend your Bionic Claws] Check it out, bub."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_e3b016def5dc"),
        },
        {
            text = ccb.content.text("[Do some sick moves using your Uncanny Dodge]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_55c5c3002c81"),
        },
        {
            text = ccb.content.text("[Charge up your EMP Projector to make a cool noise]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_7867852f4ce5"),
        },
        {
            text = ccb.content.text("[Light your Finger Lighter] Need a light?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_4215f45fca37"),
        },
        {
            text = ccb.content.text("[Wiggle your Squeaky Ankles] Well, I didn't say it was anything useful…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_268bb7bcbc95"),
        },
        {
            text = ccb.content.text("[Loudly ZAP your Super Stun Gun]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_d2a1e7e5e1e4"),
        },
        {
            text = ccb.content.text("[Use your Weather Reader to perfectly recite current atmospheric conditions] Who needs a weather station when you've got implants?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_86ad941963b9"),
        },
        {
            text = ccb.content.text("[Briefly activate your Cloaking Device]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_30939c5bf4f6"),
        },
        {
            text = ccb.content.text("[Activate your Chain Lightning to cast a bolt between your hands]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_1f63a4ba4885"),
        },
        {
            text = ccb.content.text("[Show off your Fingertip Razors and wiggle your eyebrows]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_7d717bbd7627"),
        },
        {
            text = ccb.content.text("[Activate your Protective Lenses]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_102670331900"),
        },
        {
            text = ccb.content.text("[Warp your face using your Facial Distortion]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_51e6bdc8575d"),
        },
        {
            text = ccb.content.text("[Blink in space using Probability Travel]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_4c999bc5d4ed"),
        },
        {
            text = ccb.content.text("[Show off your Monomolecular Blade]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_c6d96b776296"),
        },
        {
            text = ccb.content.text("[Unroll your Cable Charger from your hip] This is my charging system, believe it or not."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_24f55b5d7727"),
        },
        {
            text = ccb.content.text("[Zap the wall with your Finger Laser]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_c75ea311f6cc"),
        },
        {
            text = ccb.content.text("[Show off your Intravenous Needletip]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_d5f2a8f74049"),
        },
        {
            text = ccb.content.text("[Fire up your Integrated Multimeter and start touching things on Pat's desk]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_0513e239e925"),
        },
        {
            text = ccb.content.text("[Use your Artificial Night Generator to dim the room]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_df9541c49459"),
        },
        {
            text = ccb.content.text("[Fire up your Integrated Circuitry Toolset and touch a bit on solder on the desk]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8eae28e0437c"),
        },
        {
            text = ccb.content.text("[Show off your Autonomous Surgical Scalpels]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_273cf9ed3600"),
        },
        {
            text = ccb.content.text("[ZIT-ZIT-ZOOO - whir up the impact wrench in your Integrated Multitool]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_fb0498f374e3"),
        },
        {
            text = ccb.content.text("Maybe I'll visit in person…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Yeah, just kidding…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}
