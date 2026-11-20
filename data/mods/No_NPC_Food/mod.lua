local ccb = require("ccb")

return ccb.ModDefinition {
    id = "no_npc_food",
    name = ccb.content.text("Disable NPC Needs"),
    authors = { "Coolthulhu" },
    maintainers = { "Coolthulhu" },
    description = ccb.content.text("Makes NPCs not require food, water or rest."),
    category = "rebalance",
    dependencies = { "ccb" },
    world_options = {
        NO_NPC_FOOD = true,
    },
}
