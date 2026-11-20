local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Tech",
    line = ccb.content.text(
        --~ Not to me it doesn't.  We didn't get it from around here though.  I bet it looks pretty nice to you.
        "Not to me it don't.  We ain't tassed from around here though.  Looks fine an' fine to you I'd razz."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] Not from around here?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Bionic_Install",
    line = ccb.content.text(
        --~ If you've got what I need, I'm happy to call ahead and make the arrangements, for a fee.
        "If'n you're full an' plenty, this'n's happy to make the call, for a shiny farthing."),
    replies = {
        {
            text = ccb.content.text("I've got some stuff I'd like to install."),
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("Would you be able to take out one of my implants?"),
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("I've got some stuff I'd like to install."),
            when = predicates.has_trait("speaker", "Hub01_CBM_Interface"),
            next_topic = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
        },
        {
            text = ccb.content.text("Would you be able to take out one of my implants?"),
            when = predicates.has_trait("speaker", "Hub01_CBM_Interface"),
            next_topic = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
        },
    },
}
