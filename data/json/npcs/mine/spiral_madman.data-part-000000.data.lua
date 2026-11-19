local ccb = require("ccb")

-- Former miner, poor fellow succumbed to spiral madness.
ccb.content.define_npc {
    id = "spiral_madman",
    suffix = ccb.content.text("miner"),
    class = "NC_SPIRAL_MADMAN",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_SPIRAL_MADMAN_FIRST_MEETING",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_SPIRAL_MADMAN",
    name = ccb.content.text("Miner"),
    job_description = ccb.content.text("Spirals."),
    common = false,
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    worn = "NC_SPIRAL_MADMAN_worn",
    weapon = "NC_SPIRAL_MADMAN_wield",
}
