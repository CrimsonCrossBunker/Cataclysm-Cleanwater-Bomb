local ccb = require("ccb")

ccb.content.define_npc {
    id = "forge_lord_pirate",
    suffix = ccb.content.text("Former Pirate"),
    class = "NC_FORGE_PIRATE",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_FORGE_PIRATE",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
