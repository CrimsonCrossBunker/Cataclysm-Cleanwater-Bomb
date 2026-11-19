local ccb = require("ccb")

-- A naked prisoner trapped in a horrifying cage, watching horrible things happen.
ccb.content.define_npc {
    id = "mi-go_prisoner",
    temporary_suffix = "Prisoner",
    class = "NC_PRISONER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_MI-GO_PRISONER1",
    faction = "no_faction",
}

-- Skills intentionally kept low.  This character should probably have a higher chance of having insanity type traits eventually.
ccb.content.define_npc_class {
    id = "NC_PRISONER",
    name = ccb.content.text("Prisoner"),
    common = false,
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = { { skill = "ALL", level = { sum = { { dice = { 3, 3 } }, { constant = -5 } } } } },
    worn = "naked_prisoner",
    carry = "naked_prisoner",
    weapon = "naked_prisoner",
}
