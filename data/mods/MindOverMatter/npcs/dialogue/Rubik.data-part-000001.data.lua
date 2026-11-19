local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Oh, right, the alien plants.  The portals bring them.  As far as I've seen in the past, it's just going to keep getting worse.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora" },
    line = ccb.content.text("Sure, the plants o' otherworlds.  Them as comes from the wibbles.  Like as this'n's seen, 'tis all down 'n down, an I'm ken."),
    replies = {
        {
            text = ccb.content.text(" 'Down 'n down'?  So it's going to keep happening until…what?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora2",
        },
        {
            text = ccb.content.text("From the portals…like you, right?  You've seen this before?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_source",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
