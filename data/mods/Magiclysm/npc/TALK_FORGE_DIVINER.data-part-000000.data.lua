local ccb = require("ccb")

-- The Diviner of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_diviner",
    unique_name = ccb.content.text("Mary Machen"),
    suffix = ccb.content.text("Diviner"),
    class = "NC_FORGE_LORD_DIVINER",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_DIVINER",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
