local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
    line = {
        when = predicates.any_equal({ "north", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
        yes = ccb.content.gendered_line("I'm going north, up towards the border and the big wide wilderness.  I heard that there's some sort of safe spot up there, where people didn't go crazy and try to kill each other.  I don't know whether or not that's true, but at the very least, the colder climate might help keep the <zombies> down.", { "interlocutor" }),
        no = {
            when = predicates.any_equal({ "south", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
            yes = ccb.content.text("I'm going south.  Hopefully somebody down there fared better than the people I knew up here.  Besides, I won't have to worry about freezing my <freaking> butt off when winter comes."),
            no = {
                when = predicates.any_equal({ "east", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
                yes = ccb.content.gendered_line("I'm going east, towards the coastline.  I heard some rumors that Rhode Island was still holding itself together, so I'm going to go and check that out.  Heck, I might just go out to sea myself, live on an old oil rig or something like that.", { "interlocutor" }),
                no = {
                    when = predicates.any_equal({ "west", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
                    yes = ccb.content.text("I'm going west, see how things are out there in tumbleweed territory.  You see, the Midwest didn't have a whole lot of people in it compared the East Coast, so there logically shouldn't be as many <zombies> as there are here.  I just hope that everything hasn't collapsed, that someone's still holding on."),
                    no = ccb.content.text("ERROR: DIRECTION PARAMETERS EITHER NOT PICKED OR OUT OF BOUNDS"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("When will you be leaving?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
