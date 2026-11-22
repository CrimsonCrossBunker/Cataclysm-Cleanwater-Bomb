local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_ILLNESS" },
    line = {
        choices = {
            ccb.content.text("And?"),
            ccb.content.text("Yeah, it is what it is."),
            ccb.content.text("Those storms at the end of world…  I was fine before them."),
            ccb.content.text("You noticed, did you?"),
            ccb.content.text("Yeah, I've had it for years at this point.  Not much I can do about it now, though."),
            ccb.content.text("Really wish I had gotten some more treatment before, you know."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure your illness for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_VITAKINETIC_HEALING",
    line = { when = predicates.handler("dlg_p_mindovermatter_83ff787adb53"), yes = ccb.content.text("We'll talk about that after you're done operating that vehicle."), no = { when = predicates.handler("dlg_p_mindovermatter_ad31ba7ddf09"), yes = ccb.content.text("I don't want to talk about that while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_mindovermatter_c12d8bd39fb6"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_mindovermatter_170fbd5b08e8"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_mindovermatter_f11538b5053e"),
                        yes = ccb.content.text("I'm too tired, let me rest first."),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_vitakinetic_heal"),
                            yes = ccb.content.text("I already told you no.  Let it go."),
                            no = ccb.content.text("I have some reason to refuse healing."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_LUNGS" },
    line = {
        choices = {
            ccb.content.text("* coughs.  \"Yeah, I'm not feeling so great"),
            ccb.content.text("No.  No I don't."),
            ccb.content.text("Yeah, I think I'm coming down with something."),
            ccb.content.text("Ugh, yeah.  If only I could call in sick, you know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure it for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_EYES" },
    line = {
        choices = {
            ccb.content.text("They just itch like crazy at all time lately."),
            ccb.content.text("Yeah, I guess.  Must have got something in them."),
            ccb.content.text("Yeah, I think I'm coming down with something."),
            ccb.content.text("Ugh, yeah.  If only I could call in sick, you know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure it for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}
