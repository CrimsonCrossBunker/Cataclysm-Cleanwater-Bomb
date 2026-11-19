local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_mi-go",
    copy_from = "meat_mi-go",
    name = ccb.content.plural_text("mi-go ichor", "mi-go ichor"),
    description = ccb.content.text("Goo from inside a mi-go, perhaps some kind of blood?  It's obviously alien, given its pink color and strange, nostril-stinging odor.  It would not be advisable to try to eat it."),
    display_type = "BY_VOLUME",
    looks_like = "blood",
    symbol = "~",
    materials = { "mi-go_blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1 },
}
