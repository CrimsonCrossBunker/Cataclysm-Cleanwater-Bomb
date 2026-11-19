local ccb = require("ccb")

-- The Alchemist of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_alchemist",
    unique_name = ccb.content.text("Alchemist"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD_ALCHEMIST",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "male",
    chat = "TALK_FORGE_LORD_ALCHEMIST",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
