local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Check for anything amiss*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Sense Hostility] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_sense_hostility",
            when = predicates.handler("dlg_p_mindovermatter_5b3ce0810487"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_danger_sense" },
    line = ccb.content.text("&You open your senses to any dangers.  You have a faint sense of foreboding, but that's it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_sense_hostility" },
    line = ccb.content.text("&A quick check reveals nothing out of the ordinary.  To <npc_name>, you're just another face in the crowd."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_scan" },
    line = {
        choices = {
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_generic>"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD1" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_EVAC_GUARD1_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EVAC_GUARD1_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD1_danger_sense" },
    line = ccb.content.text("&You open your senses, alert for danger, but don't sense anything.  <npc_name> bears you no ill will at all."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD1" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD1_scan" },
    line = {
        choices = {
            ccb.content.text("«Oh great.  Another one.»"),
            ccb.content.text("«Idle hands make a waste of time.»"),
            { when = predicates.conversation_state("daylight"), yes = {
                choices = {
                    ccb.content.text("«We need to post sentries outside that'll turn some of these people away.»"),
                },
            }, no = {
                choices = {
                    ccb.content.text("«We really should start locking the doors at night so these people can't get in.»"),
                },
            } },
            {
            when = predicates.handler("dlg_p_mindovermatter_81c9b49d3f15"),
            yes = {
                choices = {
                    { when = predicates.actor_state("speaker", "male"), yes = {
                        choices = {
                            ccb.content.text("«Wow, I'm amazed he's lived this long.»"),
                        },
                    }, no = {
                        choices = {
                            ccb.content.text("«Wow, I'm amazed she's lived this long.»"),
                        },
                    } },
                },
            },
            no = {
                choices = {
                    { when = predicates.actor_state("speaker", "male"), yes = {
                        choices = {
                            ccb.content.text("«No point in learning his name.  He'll probably be dead soon anyway.»"),
                        },
                    }, no = {
                        choices = {
                            ccb.content.text("«No point in learning her name.  She'll probably be dead soon anyway.»"),
                        },
                    } },
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_EVAC_GUARD1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD2" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_EVAC_GUARD2_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EVAC_GUARD2_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD2_danger_sense" },
    line = ccb.content.text("&You open your senses, alert for danger, but don't sense anything.  <npc_name> is sincere in their friendliness, or least isn't hiding a dagger behind their back."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD2_scan" },
    line = {
        choices = {
            ccb.content.text("«Not bad playing tour guide.  Better than having to fight.»"),
            {
                when = predicates.conversation_state("daylight"),
                yes = {
                    choices = {
                        ccb.content.text("«Another day after <the_cataclysm>.  One foot in front of the other.»"),
                    },
                },
                no = {
                    choices = {
                        ccb.content.text("«So tired.  That's what I get for drawing the night shift.»"),
                        ccb.content.text("«At least in here I can see them coming.  If I were out there…»"),
                    },
                },
            },
            {
                when = predicates.actor_state("speaker", "male"),
                yes = {
                    choices = { ccb.content.text("«How much did it take to get here?  What has he lost?»") },
                },
                no = {
                    choices = { ccb.content.text("«How much did it take to get here?  What has she lost?»") },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD2" } },
}
