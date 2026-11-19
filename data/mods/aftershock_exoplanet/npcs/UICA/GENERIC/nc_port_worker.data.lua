local ccb = require("ccb")

-- For crew and customs officers in port Augustmoon.  They have some level of military training.
ccb.content.define_npc_class {
    id = "NC_UICA_PORT_CREW",
    name = ccb.content.text("Augustmoon Crew"),
    job_description = ccb.content.text("I'm part of the Augustmoon crew."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_PORT_CREW_worn",
    carry = "NC_UICA_PORT_CREW_carry",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 2, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "mechanics", bonus = { rng = { 4, 6 } } },
        { skill = "fabrication", bonus = { rng = { 4, 6 } } },
        { skill = "electronics", bonus = { rng = { 4, 6 } } },
    },
}
