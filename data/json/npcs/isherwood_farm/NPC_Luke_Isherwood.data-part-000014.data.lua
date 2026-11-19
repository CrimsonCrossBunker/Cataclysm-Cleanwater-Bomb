local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan",
    line = ccb.content.text("OK so I have an idea on how we can breach that tower.  We need a truck and some dynamite.  I've heard about some bandits in a truck robbing people nearby.  If you can take care of the bandits I'll pick up the truck later"),
    replies = {
        {
            text = ccb.content.text("I think I can manage two bandits."),
            actions = { actions.assign_mission("MISSION_LUKE_RETRIEVE_TRUCK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text("Surely we can think of a better way in."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Part_2",
    line = ccb.content.text("So now that we've got the truck we need the boom.  See if you can find some dynamite at the old mines?  Once we got the dynamite I'll rig that up to a kitchen timer and we'll have a bomb on wheels.  I'll need 50lbs to light that truck up like the 4th of July!"),
    replies = {
        {
            text = ccb.content.text("This is gonna rad as heck as long as it works."),
            actions = { actions.assign_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        { text = ccb.content.text("Not doing it."), next_topic = "TALK_DONE" },
    },
}
