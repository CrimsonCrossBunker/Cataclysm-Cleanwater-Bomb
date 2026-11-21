local ccb = require("ccb")

ccb.content.define_mutation {
    id = "GETS_RANDOM_MISSION",
    name = ccb.content.text_without_extraction("Assign Random Mission"),
    description = ccb.content.text_without_extraction("This is an AI tag to give a static NPC a random mission.  If you see this, it's a bug."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    starts_active = true,
    on_process = "give_random_mission",
}

ccb.content.define_mutation {
    id = "GETS_RANDOM_MISSION_NOMOVE",
    name = ccb.content.text_without_extraction("Assign Random No-move Mission"),
    description = ccb.content.text_without_extraction("This is an AI tag to give a static NPC a random mission that doesn't involve them following you.  If you see this, it's a bug."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    starts_active = true,
    on_process = "give_random_mission",
}
