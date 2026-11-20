local ccb = require("ccb")

return ccb.ModDefinition {
    id = "Mythos-Creatures",
    name = ccb.content.text("Mythos Mod - Mythos Creatures Only"),
    authors = { "mythosmod" },
    description = ccb.content.text("Removes all the zombies (including fungus zombies), cyborgs and robots from the game and replaces them with a variety of Lovecraftian monsters - intended to be part of a total conversion mod but can be used as a standalone if wanted."),
    category = "creatures",
    dependencies = { "ccb" },
    obsolete = true,
    version = "0.1",
    ordered_data_files = true,
}
