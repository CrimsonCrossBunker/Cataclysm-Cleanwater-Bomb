local ccb = require("ccb")

-- Not for use in edible recipes, and should require ~200% as much as normal for applicable inedible recipes.
ccb.content.define_item {
    id = "bone_tainted",
    name = ccb.content.plural_text("tainted bone", "tainted bones"),
    description = ccb.content.text("A rotten, brittle bone from some unnatural creature or other.  Could be used to make some stuff, like charcoal or glue.  You could eat it, but it will poison you."),
    copy_from = "bone",
    color = "light_gray",
    survival_price = "5 cent",
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone_tainted", recipe = "meal_bone_tainted_mill_1_4" },
    comestible = { fun = -10 },
    use_actions = { "POISON" },
}

-- No extend support for vitamins, we need to overwrite
ccb.content.define_item {
    id = "bone_human",
    copy_from = "bone",
    name = ccb.content.plural_text("human bone", "human bones"),
    description = ccb.content.text("A bone from a human being.  Could be used to make some stuff, if you're feeling sufficiently ghoulish."),
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        vitamins = {
            { id = "calcium", amount = "25588 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bone_demihuman",
    copy_from = "bone",
    name = ccb.content.plural_text("demihuman bone", "demihuman bones"),
    description = ccb.content.text("A bone from a demihuman being.  Could be used to make some stuff, if you're feeling sufficiently ghoulish."),
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}
