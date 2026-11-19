local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_PLANS",
    line = {
        choices = {
            ccb.content.text("I don't know, look for supplies and other survivors I guess."),
            ccb.content.text("Maybe we should start boarding up this place."),
            ccb.content.text("I suppose getting a car up and running would be really be useful if we have to move."),
            ccb.content.text("We could look for a farm.  They should have food and tools, and they aren't close to cities."),
            ccb.content.text("We should probably stay away from cities, even if they have lots of supplies."),
            ccb.content.text("Maybe we should go West, the further away from the urban coastline we are, the better.  It must be hell on earth over there in the East."),
        },
    },
    replies = { { text = ccb.content.text("Hmm, okay."), next_topic = "TALK_NONE" } },
}
