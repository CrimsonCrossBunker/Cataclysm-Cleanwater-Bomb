local ccb = require("ccb")

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
