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

ccb.content.define_dialogue_topic {
    id = "TALK_BIO_ADJUST_YOUR_HAIR",
    line = ccb.content.text("What form should your artificial hair take?"),
    replies = {
        {
            text = ccb.content.text("Get a buzzcut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_buzzcut") },
        },
        {
            text = ccb.content.text("Get a crewcut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_crewcut") },
        },
        {
            text = ccb.content.text("Get a short cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_short") },
        },
        {
            text = ccb.content.text("Get a short cut (no fringe)."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_short_no_fringe") },
        },
        {
            text = ccb.content.text("Get a short cut (over eye)."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_short_over_eye") },
        },
        {
            text = ccb.content.text("Get a modern cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_modern") },
        },
        {
            text = ccb.content.text("Get a detective cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_detective") },
        },
        {
            text = ccb.content.text("Get a medium-length cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_medium") },
        },
        {
            text = ccb.content.text("Get a puff cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_puff") },
        },
        {
            text = ccb.content.text("Get a mohawk."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_mohawk") },
        },
        {
            text = ccb.content.text("Get a beaded cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_beaded") },
        },
        {
            text = ccb.content.text("Get a curly cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_curls") },
        },
        {
            text = ccb.content.text("Get a super princess cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_super_princess") },
        },
        {
            text = ccb.content.text("Get a long mohawk."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_long_mohawk") },
        },
        {
            text = ccb.content.text("Get a long cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_long") },
        },
        {
            text = ccb.content.text("Get a long cut (over eye)."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_long_over_eye") },
        },
        {
            text = ccb.content.text("Get a mullet."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_mullet") },
        },
        {
            text = ccb.content.text("Get a bun cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_bun") },
        },
        {
            text = ccb.content.text("Get a messy cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_messy") },
        },
        {
            text = ccb.content.text("Get a long punk cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_punk_long") },
        },
        {
            text = ccb.content.text("Get a very long cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_very_long") },
        },
        {
            text = ccb.content.text("Get an extremely long cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_extremely_long") },
        },
        {
            text = ccb.content.text("Get twin tails."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_twintails") },
        },
        {
            text = ccb.content.text("Get a braided cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_braid") },
        },
        {
            text = ccb.content.text("Get a body-length cut."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_89685fa0d951"), actions.replace_mutation("speaker", "artificial_hair_body_length") },
        },
        {
            text = ccb.content.text("Don't adjust anything."),
            next_topic = "TALK_DONE",
        },
    },
}
