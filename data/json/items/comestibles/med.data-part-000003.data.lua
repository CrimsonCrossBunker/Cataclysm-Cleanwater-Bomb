local ccb = require("ccb")

ccb.content.define_item {
    id = "gummy_vitamins",
    copy_from = "vitamins",
    name = ccb.content.plural_text("gummy vitamin", "gummy vitamin"),
    description = ccb.content.text("Essential dietary nutrients conveniently packaged in a fruit-flavored chewy candy form.  An option of last resort when a balanced diet is not possible.  Excess use can cause hypervitaminosis."),
    materials = { "drug_filler" },
    survival_price = "40 cent",
    default_container = "null",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    volume = "10 ml",
    comestible = { fun = 4 },
}
