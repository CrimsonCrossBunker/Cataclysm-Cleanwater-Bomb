local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_mealgrub_medium",
    name = ccb.content.plural_text("mealgrub growth medium", "mealgrub growth medium"),
    description = ccb.content.text("All sorts of organic substances rendered into a nutritious goop that can be used as a growth medium in grub aquaculture.  Public material presents it as a closed-loop food recycling product; less flattering rumors say the formula began as industrial waste-stream bioremediation research at Helixwirl Biotechnologies, a food-industry startup funded by Trans-Coast Logistics.  Whatever its origin, mealgrubs thrive within it."),
    mass = "100 g",
    default_container = "jug_plastic",
    flags = { "NUTRIENT_OVERRIDE" },
    symbol = "~",
    price = "10 USD",
    survival_price = "1 USD",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    comestible = {
        kind = "DRINK",
        quench = -10,
        healthy = -2,
        calories = 400,
        servings = 5,
        fun = -30,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "bad_food", amount = 1 },
        },
    },
    use_actions = { "BLECH" },
}

ccb.content.define_item {
    id = "fcl_mealgrub_spores",
    name = ccb.content.plural_text("mealgrub spores", "mealgrub spores"),
    description = ccb.content.text("A bottle of proprietary mealgrub seed culture sold under the cleaner-sounding trade name \"spores\".  Mealgrubs are engineered to turn nearly any organic matter into safe edible animal protein, a selling point that made them attractive to disaster logistics planners and food-tech investors.  The company line calls them modified mealworms; rumor says the stock also drew on fly larvae, nematophagous fungi, and other biological samples better left off the label."),
    mass = "100 g",
    default_container = "bottle_plastic_small",
    symbol = "~",
    price = "10 USD",
    survival_price = "1 USD",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    comestible = { kind = "DRINK", quench = -10, healthy = -2, calories = 1, servings = 100, fun = -10 },
    use_actions = { "BLECH" },
}
