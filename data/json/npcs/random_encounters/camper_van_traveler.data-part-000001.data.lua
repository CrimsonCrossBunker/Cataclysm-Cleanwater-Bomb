local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  <npc_name> considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I don't believe I've heard about anything like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.text(", nodding along.  \"Yeah, I remember something like that a while back.  Pretty memorable building, I think it's what you're looking for.\""),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

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
