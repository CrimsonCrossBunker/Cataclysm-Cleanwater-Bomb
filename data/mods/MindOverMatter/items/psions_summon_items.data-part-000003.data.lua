local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_photo_eyes",
    category = "armor",
    name = ccb.content.plural_text("photon regulation", "photon regulation"),
    description = ccb.content.text("With a little concentration, you can control the light your eyes accept.  Protects you from glare and welding arcs."),
    mass = "1 g",
    volume = "1 ml",
    materials = { "light" },
    symbol = "[",
    color = "yellow",
    qualities = { { id = "GLARE", level = 1 } },
    flags = {
        "INTEGRATED", "UNBREAKABLE", "SOFT", "WATER_FRIENDLY", "SUN_GLASSES", "NO_REPAIR", "NO_SALVAGE",
        "PERSONAL", "SEMITANGIBLE",
    },
    armor = {
        portions = {
            {
                materials = { { id = "light", coverage = 100, thickness = 0.1 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}
