local ccb = require("ccb")

-- The Lord of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_merchant",
    unique_name = ccb.content.text("Valzain of Psiom"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "male",
    chat = "TALK_FORGE_LORD",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
