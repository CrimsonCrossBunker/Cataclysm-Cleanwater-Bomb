local ccb = require("ccb")

-- The Pirate of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_reagents",
    unique_name = ccb.content.text("Helen Tavrel, Former Pirate"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD_REAGENT",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_REAGENT",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
