local ccb = require("ccb")

return ccb.ModDefinition {
    id = "alt_map_key",
    name = ccb.content.text("Alternative Map Key"),
    authors = { "Sunshine", "thaelina" },
    maintainers = { "thaelina" },
    description = ccb.content.text("Standardizes overmap symbols.  Symbols are color coded based on categories and use the first letter of the tile name.  Note: This mod is useless if you use tiles instead of ASCII for the overmap display."),
    category = "misc_additions",
    dependencies = { "ccb" },
    load_with_data = true,
}
