local ccb = require("ccb")

return ccb.ModDefinition {
    id = "personal_portal_storms",
    name = ccb.content.text("Portal Storms Ignore NPCs"),
    authors = { "BombasticSlacks" },
    maintainers = { "BombasticSlacks" },
    description = ccb.content.text("Makes Portal Storm enemies only attack the player.  Without this critical NPCs can die to Portal Storm enemies in very unfair ways.  More work needs to be done on AI and faction base security before it will be safe to disable this."),
    category = "rebalance",
    dependencies = { "ccb" },
    ordered_data_files = true,
    world_options = {
        PORTAL_STORM_IGNORE_NPC = true,
    },
}
