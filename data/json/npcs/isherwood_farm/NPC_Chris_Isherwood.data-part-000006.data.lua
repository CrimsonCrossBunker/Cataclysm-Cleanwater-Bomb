local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Your dad asked me to come find you, said you've been looking for your uncle."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK1",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, he said you had some interesting ideas about the world ending."),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
        {
            text = ccb.content.text("Do you think, monsters that kidnaped Barry are responsible for end of the world?"),
            next_topic = "TALK_CHRIS_THEORIES2",
            when = predicates.handler("dlg_p_dda_3563a6faba65"),
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY",
    line = ccb.content.text("&Chris looks you up and down, and nods.  \"I'm definitely not going to say no to a willing body, and you look like you know what's up.\"  He sighs.  \"To be honest with you, I've been a bit stuck.  I can't tackle that thing alone, and I'm not willing to bring my dad or Uncle Eddie in either.  Dad's got a bum knee - don't tell him I said that - and Eddie's not that great a shot.  Luke's still too young for something like this… you get the idea.\"  He leans forward, self-consciously running his hand through his hair.  \"I think if we work together maybe we'd stand a chance.  I don't have a great plan though.  That tower doesn't look like something a person could just storm up to full-frontal style.\""),
    replies = {
        {
            text = ccb.content.text("Actually, I was just planning to go in by myself.  I've handled worse."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_GO_IT_ALONE",
            when = predicates.handler("dlg_p_dda_1cb9d4920113"),
        },
        {
            text = ccb.content.text("I've got my own team here, we'll take this.  You stay back here, keep the family safe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_OWN_TEAM",
            when = predicates.handler("dlg_p_dda_430389987a1c"),
        },
        {
            text = ccb.content.text("Yeah, I think we should work together on this.  Do you mind if I take the lead?  I've probably got more experience."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
