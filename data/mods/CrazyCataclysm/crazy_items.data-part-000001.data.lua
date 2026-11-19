local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_chest_gun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Ionic Overload Generator CBM", "Ionic Overload Generator CBMs"),
    description = ccb.content.text("A powerful ion energy generator is implanted on your chest.  Fires a powerful, ever-expanding energy blast.  The resulting blast ignites oxygen creating fires as it moves and an explosion on impact.  Close range use is highly discouraged."),
    price = "2 kUSD 200 USD",
    bionic = { difficulty = 8 },
}
