local ccb = require("ccb")

-- A person from elsewhere.
ccb.content.define_npc {
    id = "portal_person",
    unique_name = ccb.content.text("Involuntary Traveler"),
    gender = "male",
    class = "NC_PORTAL_PERSON",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_PORTAL_PERSON_1",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_PORTAL_PERSON",
    name = ccb.content.text("No class"),
    common = false,
    job_description = ccb.content.text("I'm from another world."),
    traits = { { group = "Appearance_Latin" } },
    bye_message = "<end_talking_bye_portal_person>",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_PERSON_1",
    line = ccb.content.text("Dell hastro bovice?  Arand natick res?"),
    replies = { { text = ccb.content.text("What?"), next_topic = "TALK_PORTAL_PERSON_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_PERSON_2",
    line = ccb.content.text("Jand rawdle?  Ignate hasture."),
    replies = {
        {
            text = ccb.content.text("I guess there's no reason to expect an interdimensional traveler to speak English."),
            next_topic = "TALK_DONE",
        },
    },
}
