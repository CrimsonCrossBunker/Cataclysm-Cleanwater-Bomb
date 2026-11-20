local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_fcl_mealgrub_broth",
    name = ccb.content.plural_text("mealgrub broth", "mealgrub broth"),
    description = ccb.content.text("Growth medium seeded with mealgrub eggs.  Once placed in a growing vat, they should be ready for harvesting in around 76 hours.  The immature grub's metabolism can produce toxic by-products so caution is advisable."),
    emissions = { "emit_toxic_cloud" },
    mass = "33 g",
    color = "white",
    default_container = "jug_plastic",
    symbol = "~",
    price = "4 cent",
    survival_price = "10 cent",
    volume = "250 ml",
    phase = "liquid",
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "76 hours", products = { "fcl_mealgrub_jelly", "fcl_mealgrub_spores" } },
    comestible = { quench = -5, fun = 4, servings = 5, kind = "DRINK" },
    use_actions = { "BLECH" },
}
