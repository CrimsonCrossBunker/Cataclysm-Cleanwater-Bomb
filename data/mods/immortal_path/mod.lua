local ccb = require("ccb")

return ccb.ModDefinition {
    id = "immortal_path",
    name = ccb.content.text("灾变仙路"),
    -- en_us_name: Path of Immortals
    authors = { "EliadOArias" },
    maintainers = { "EliadOArias" },
    description = ccb.content.text("在灾变废土上踏上修仙之路。引气入体、炼气化神，于末世中求长生大道。"),
    -- en_us_description: Walk the path of cultivation on the post-cataclysm wasteland. Draw qi into your body, refine it into spirit, and seek the great way of immortality at the end of the world.
    category = "content",
    dependencies = { "ccb" },
    version = "0.0.1",
    ordered_data_files = true,
}
