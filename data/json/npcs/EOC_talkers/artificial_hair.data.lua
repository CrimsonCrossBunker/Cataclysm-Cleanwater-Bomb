local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BIO_ADJUST_YOUR_BEARD",
    line = ccb.content.text("How do you want your artificial beard to look?"),
    replies = {
        {
            text = ccb.content.text("Get a clean shave."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_NONE") },
        },
        {
            text = ccb.content.text("Get a neck beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_NECKBEARD") },
        },
        {
            text = ccb.content.text("Get some sideburns."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_SIDEBURNS") },
        },
        {
            text = ccb.content.text("Get a soul patch."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_SOUL_PATCH") },
        },
        {
            text = ccb.content.text("Get a chin strip."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_CHIN_STRIP") },
        },
        {
            text = ccb.content.text("Get some 3-day stubble."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_3DAYSTUBBLE") },
        },
        {
            text = ccb.content.text("Get a toothbrush mustache."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_TOOTHBRUSH") },
        },
        {
            text = ccb.content.text("Get a chin strap."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_CHIN_STRAP") },
        },
        {
            text = ccb.content.text("Get a mustache."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_MUSTACHE") },
        },
        {
            text = ccb.content.text("Get a walrus mustache."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_WALRUS") },
        },
        {
            text = ccb.content.text("Get a Zappa."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_ZAPPA") },
        },
        {
            text = ccb.content.text("Get a goatee."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_GOATEE") },
        },
        {
            text = ccb.content.text("Get a circle beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_CIRCLE") },
        },
        {
            text = ccb.content.text("Get a short boxed beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_SHORTBOXED") },
        },
        {
            text = ccb.content.text("Get a horseshoe."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_HORSESHOE") },
        },
        {
            text = ccb.content.text("Get some mutton chops."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_MUTTONCHOPS") },
        },
        {
            text = ccb.content.text("Get a gunslinger beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_GUNSLINGER") },
        },
        {
            text = ccb.content.text("Get a chin curtain."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_CHIN_CURTAIN") },
        },
        {
            text = ccb.content.text("Get a handlebar mustache."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_HANDLEBAR") },
        },
        {
            text = ccb.content.text("Get a Van Dyke."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_VANDYKE") },
        },
        {
            text = ccb.content.text("Get a regular beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_BEARD") },
        },
        {
            text = ccb.content.text("Get a anchor beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_ANCHOR") },
        },
        {
            text = ccb.content.text("Get a royale beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_ROYALE") },
        },
        {
            text = ccb.content.text("Get a Shenandoah."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_SHENANDOAH") },
        },
        {
            text = ccb.content.text("Get a long beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_BEARD_LONG") },
        },
        {
            text = ccb.content.text("Get a very long beard."),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "ARTIFICIAL_FACIAL_HAIR_BEARD_VERY_LONG") },
        },
        {
            text = ccb.content.text("Don't change anything."),
            next_topic = "TALK_DONE",
        },
    },
}
