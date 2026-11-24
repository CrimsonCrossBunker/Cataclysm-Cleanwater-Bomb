local ccb = require("ccb")

-- A generic mercenary for decorative purposes.
ccb.content.define_npc {
    id = "salvor_camp_solo",
    suffix = ccb.content.text("mercenary"),
    class = "NC_AFS_SOLO",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_SALVOR_CAMP_SOLO",
    faction = "independents",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_CAMP_SOLO",
    line = {
        choices = {
            ccb.content.text("&<mypronoun> looks you up and down, sizing you up."),
            ccb.content.text("What do you want?"),
            ccb.content.text("You lost or something?"),
            ccb.content.text("Like what you see?"),
            ccb.content.text("&<mypronoun> simply ignores you as they flick a spent cigarette into the snow."),
            ccb.content.text("Mind your own business."),
            ccb.content.text("&<mypronoun> gives you a dismissive look."),
            ccb.content.text("Piss off."),
            ccb.content.text("I'm not here to chat.  What do you want?"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
