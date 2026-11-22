local ccb = require("ccb")

ccb.content.define_item {
    id = "ruined_chunks",
    name = ccb.content.plural_text("butchery refuse", "butchery refuse"),
    description = "Eugh.  This is a mess of dirt, excreta, connective tissue, and bits of matter like hair and claws, leftover from the butchering process.  Eating it isn't even worth thinking about.",
    symbol = "¨",
    color = "black",
    category = "other",
    looks_like = "feces_manure",
    display_type = "BY_WEIGHT",
    mass = "250 g",
    volume = "300 ml",
    stackable = true,
    materials = { "flesh" },
    use_actions = { "POISON" },
    comestible = {
        kind = "FOOD",
        fun = -18,
        shelf_life = "8 hours",
        vitamins = {
            { id = "meat_allergen", amount = 1 },
        },
        contamination = {
            { disease = "bad_food", probability = 100 },
        },
    },
}
