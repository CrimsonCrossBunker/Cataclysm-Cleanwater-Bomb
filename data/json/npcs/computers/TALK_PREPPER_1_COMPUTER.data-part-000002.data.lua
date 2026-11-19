local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE",
    line = ccb.content.text("&From: Ryan\nSubject: RE: Airport Facility\n\nyes its possible.  most airports have tunnels underneath for staff and others to move around.  obviously ordinary people cant go in and most airports are just normal but there are definitely some international hubs of travel with hidden chambers in them and some even with tunnels out to the surrounding area.  so elites dont have to go anywhere else to do their work and risk being seen.  they have to be staffed by spies or people who dont know whats really going on."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE2",
    line = ccb.content.text("&To: Ryan\nSubject: RE: RE: Airport Facility\n\nHe only goes to the airport and nowhere else.  I think he has to be one of the people running it.  I remember bragg_eagle saying there were managers in Denver who would spend time where normal employees couldn't go and I don't see ANYONE else going in there.  He dresses like a construction worker or something.  It's not like anything I've ever seen at an airport."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE3",
    line = ccb.content.text("&To: Ryan\nSubject: RE: RE: RE: Airport Facility\n\nYeah I deleted it, don't worry.  Look, this is what he looks like.\n\nATTACHMENTS: MVI 0022.mov"),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}
