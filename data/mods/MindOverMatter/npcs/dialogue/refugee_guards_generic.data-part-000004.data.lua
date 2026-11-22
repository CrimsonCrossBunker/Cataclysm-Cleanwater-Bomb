local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
