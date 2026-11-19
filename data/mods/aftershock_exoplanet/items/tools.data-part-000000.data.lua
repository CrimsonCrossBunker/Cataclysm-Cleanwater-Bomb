local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_ipav_patch_kit",
    copy_from = "syringe",
    name = ccb.content.plural_text("IPAV patch kit", "IPAV patch kits"),
    description = ccb.content.text("A small applicator used to mend IPAV armor.  Official UICA doctrine dictates that IPAV armor is rated to survive a single combat encounter, and this kit is only to be used in emergency situations where resupply is not possible.  It contains a single dose of high density polymer gel that can be applied to damaged plates for temporary repair."),
    price = "400 USD",
    survival_price = "400 USD",
    tool = {},
}
