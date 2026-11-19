local ccb = require("ccb")

-- The Librarian of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_librarian",
    unique_name = ccb.content.text("Librarian, A"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD_LIBRARIAN",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_LIBRARIAN",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}
