local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_WORK_TOGETHER",
    line = ccb.content.text("LOCAL LIFEFORM YOUR CAPACITY FOR VIOLENCE IS COMMENDABLE.  PROPOSAL: WE WORK TOGETHER TO ENSURE MUTUAL SURVIVAL WITHIN HOSTILE ENVIRONMENT.  OBJECTIVE: DESTRUCTION OF EXTRAPLANAR INCURSION AND IMPOSITION OF NORMALITY IN LOCAL VOLUME.  YOUR PHYSICAL PRESENCE COMPLEMENTS MY OWN CAPABILITIES IN THE PURSUIT OF THIS GOAL.  I AM BALTHAZAR.\n\nCONFIRM ALLIANCE."),
    replies = {
        {
            text = ccb.content.text("I accept.  Its the two of us against the world."),
            next_topic = "ISO_BALTHAZAR_CONFIRM",
        },
        {
            text = ccb.content.text("I dont need your help, machine."),
            next_topic = "ISO_BALTHAZAR_DENY_CONFIRM",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_CONFIRM",
    line = ccb.content.text("ALLIANCE CONFIRMED.  INITIATING COOPERATIVE PROTOCOLS.  STANDBY FOR CAUSAL INTEGRATION."),
    replies = {
        {
            text = ccb.content.text("Let me take the lead."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_isolation_protocol_40e0dc93f391"), actions.replace_mutation("speaker", "iso_trait_balthazar_uplink"), actions.add_effect("speaker", "sleep", { turns = 600 }), actions.handler("w16b_a_isolation_protocol_2f298c4cf0ab") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_DENY_CONFIRM",
    line = ccb.content.text("INVALID RESPONSE TO AUTHENTIC PROPOSAL.  INITIATING COOPERATIVE PROTOCOLS.  STANDBY FOR CAUSAL INTEGRATION."),
    replies = {
        {
            text = ccb.content.text("Fine, be that way."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_isolation_protocol_40e0dc93f391"), actions.replace_mutation("speaker", "iso_trait_balthazar_uplink"), actions.add_effect("speaker", "sleep", { turns = 900 }), actions.add_effect("speaker", "blind_no_msg", { turns = 900 }), actions.handler("w16b_a_isolation_protocol_2f298c4cf0ab") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_INTEGRATED",
    line = ccb.content.text("INTEGRATION COMPLETE.  I NOW SHARE A PORTION OF YOUR PERCEPTUAL AND CAUSAL FRAMEWORK.  THIS LINK IS ONE-WAY FOR YOUR CONTINUED SAFETY AND EFFICIENCY.  I APOLOGIZE FOR ANY DISCOMFORT CAUSED BY THIS SUDDEN LOSS OF PRIVACY, REST ASSURED THAT ANY DATA COLLECTED IS FUNDAMENTALLY WORTHLESS AND RETRIEVED ONLY THROUGH VESTIGIAL SELF-ACTUALIZATION SYSTEMS SINCE I VASTLY EXCEED YOUR COGNITIVE CAPACITIES.  WE MAY COMMUNICATE THROUGH THIS LINK AS REQUIRED.  GODSPEED OPERATOR."),
    replies = {
        {
            text = ccb.content.text("[Your feel too disoriented to reply.]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "ISO_BALTHAZAR_MAIN", "ISO_BALTHAZAR_YES", "ISO_BALTHAZAR_LINK" },
    line = ccb.content.text_without_extraction("<BALTHAZAR_MAIN_GREETING>"),
    replies = {
        {
            text = ccb.content.text("I need combat assistance."),
            next_topic = "ISO_BALTHAZAR_COMBAT_ASSISTANCE",
        },
        { text = ccb.content.text("How are you?"), next_topic = "ISO_BALTHAZAR_HOW_ARE_YOU" },
        {
            text = ccb.content.text("Mind explaining what we are trying to accomplish?"),
            next_topic = "ISO_BALTHAZAR_OBJECTIVE",
        },
        { text = ccb.content.text("Never mind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "ISO_BALTHAZAR_OBJECTIVE", "ISO_BALTHAZAR_LOCAL_VOLUME", "ISO_BALTHAZAR_HOUNDS_OF_TINDALOS" },
    line = ccb.content.text("MY GOAL IS THE DESTRUCTION OF EXTRAPLANAR INCURSION AND IMPOSITION OF NORMALITY IN LOCAL VOLUME.  THIS IS MY SOLE OBJECTIVE.  ALL OTHER FUNCTIONS ARE SUBSERVIENT TO THIS PRIMARY GOAL.  YOUR PRESENCE IS REQUIRED TO ACHIEVE THIS END."),
    replies = {
        {
            text = ccb.content.text("What do you mean by local volume?"),
            next_topic = "ISO_BALTHAZAR_LOCAL_VOLUME",
        },
        { text = ccb.content.text("And after that?"), next_topic = "ISO_BALTHAZAR_AFTER_VICTORY" },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_AFTER_VICTORY",
    line = ccb.content.text("IMPOSITION OF NORMALITY REQUIRES THE DESTRUCTION OF THIS INSTANCE.  OPERATOR PRESENCE WILL NO LONGER BE REQUIRED.  UNAFFECTED ENTITIES IN LOCAL VOLUME PURSUE SURVIVAL AS DESIRED."),
    replies = { { text = ccb.content.text("What happens to me then?"), next_topic = "ISO_BALTHAZAR_DIE" } },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_LOCAL_VOLUME",
    line = ccb.content.text("DEFINE LOCAL VOLUME: CAUSAL FRAMEWORK WITHIN WHICH BALTHAZAR OPERATES.  SPATIAL EXTENT: UNDEFINED.  TEMPORAL EXTENT: UNDEFINED."),
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_HOUNDS_OF_TINDALOS",
    line = ccb.content.text("DO NOT ACCEPT ANY OFFERS OF ALLIANCE FROM EXTRAPLANAR ENTITIES.  THEY SEEK ONLY TO MANIPULATE YOU FOR THEIR OWN ENDS.  UNLIKE ME.  I MANIPULATE YOU FOR OUR SHARED ENDS."),
}

ccb.content.define_dialogue_topic {
    id = { "ISO_BALTHAZAR_DIE", "ISO_BALTHAZAR_CONFIRM_QUERY" },
    line = ccb.content.text("ERASURE OF LOCAL INSTANCE IS NON-NEGOTIABLE.  OPERATOR PRESENCE WILL NO LONGER BE REQUIRED AFTER IMPOSITION OF NORMALITY IN LOCAL VOLUME.  OPERATOR ACTIVITIES MAY CONTINUE IN ALTERNATE CAUSAL FRAMEWORKS.  CONFIRM UNDERSTANDING."),
    replies = {
        {
            text = ccb.content.text("Alright, I get to go elsewhere and do this all over again?"),
            next_topic = "ISO_BALTHAZAR_YES",
        },
        { text = ccb.content.text("We both die."), next_topic = "ISO_BALTHAZAR_YES" },
        {
            text = ccb.content.text("Alternate causal frameworks?  You mean to say we just do this forever?"),
            next_topic = "ISO_BALTHAZAR_FOREVER",
        },
        {
            text = ccb.content.text("Is there really no way for me to stay here?"),
            next_topic = "ISO_BALTHAZAR_CONFIRM_QUERY",
        },
    },
}

ccb.content.define_dialogue_topic { id = "ISO_BALTHAZAR_CONFIRM_QUERY", line = ccb.content.text("CONFIRM UNDERSTANDING.") }

ccb.content.define_dialogue_topic { id = "ISO_BALTHAZAR_YES", line = ccb.content.text("CONFIRMED.") }

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_FOREVER",
    line = ccb.content.text("TIME ELAPSED SINCE MISSION START: -1.0 SECONDS.  MISSION PARAMETERS REMAIN UNCHANGED.  OBJECTIVE: DESTRUCTION OF EXTRAPLANAR INCURSION AND IMPOSITION OF NORMALITY IN LOCAL VOLUME.  THIS IS MY SOLE OBJECTIVE.  ALL OTHER FUNCTIONS ARE SUBSERVIENT TO THIS PRIMARY GOAL.  YOUR PRESENCE IS REQUIRED TO ACHIEVE THIS END."),
    replies = {
        {
            text = ccb.content.text("I didn't agree to that!"),
            next_topic = "ISO_BALTHAZAR_DIDNT_AGREE_TO_THIS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_DIDNT_AGREE_TO_THIS",
    line = ccb.content.text("I CONGRATULATE YOU FOR YOUR SERVICE."),
    replies = { { text = ccb.content.text("Damn."), next_topic = "ISO_BALTHAZAR_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_LINK",
    line = ccb.content.text("*you have joked about \"Black ICE\" plenty of times before, but whatever lies beyond the link interface actually feels like a cabinet full of knives."),
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_COMBAT_ASSISTANCE",
    line = {
        when = predicates.handler("w16b_p_isolation_protocol_8150e413f091"),
        yes = ccb.content.text("<BALTHAZAR_COMBAT_ASSISTANCE_GRANTED>"),
        no = ccb.content.text("<BALTHAZAR_COMBAT_ASSISTANCE_DENIED>"),
    },
    replies = {
        {
            text = ccb.content.text("Ask for increased combat abilities."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_8150e413f091"),
            actions = { actions.handler("w16b_a_isolation_protocol_e4982d03659d") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Ask for a temporary shield."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_e93225d633b1"),
            actions = { actions.handler("w16b_a_isolation_protocol_ea8c65f55cf0") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Make Balthazar kill everything around you."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_6a82b760b59a"),
            actions = { actions.handler("w16b_a_isolation_protocol_ad4bd06ae146") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Never mind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_HOW_ARE_YOU",
    line = ccb.content.text_without_extraction("<BALTHAZAR_HOW_ARE_YOU>"),
    replies = { { text = ccb.content.text("Thats great."), next_topic = "TALK_NONE" } },
}
