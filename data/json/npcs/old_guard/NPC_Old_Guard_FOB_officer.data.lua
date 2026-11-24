local ccb = require("ccb")

-- Generic guard for the old guard.
ccb.content.define_npc {
    id = "old_guard_fob_officer",
    suffix = ccb.content.text("Officer"),
    unique_name = ccb.content.text("Duhring"),
    class = "NC_OG_OFFICER",
    gender = "male",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_FOB_OFFICER",
    faction = "old_guard",
}

ccb.content.define_npc_class {
    id = "NC_OG_OFFICER",
    name = ccb.content.text("Officer"),
    job_description = ccb.content.text("I'm an officer for FOB Arabella"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    worn = "NC_OG_OFFICER_worn",
    carry = "NC_OG_OFFICER_misc",
    proficiencies = { "prof_gunsmithing_basic" },
    skills = {
        { skill = "speech", bonus = { rng = { 3, 5 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "pistol", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 3, 5 } } },
        { skill = "driving", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER",
    line = {
        choices = {
            ccb.content.text("I don't have any use for you right now.  You will be informed if I need you, soldier."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you tell me about yourself?"),
            next_topic = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED",
    line = {
        choices = {
            ccb.content.text("If it wasn't clear, you are dismissed soldier."),
            ccb.content.text("I am clearly busy, soldier."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can I just ask you some questions?"),
            next_topic = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED_2",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED_2",
    line = {
        choices = {
            ccb.content.text("Go. Away."),
            ccb.content.text("If I have to tell you one more time so help me god…"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
