local ccb = require("ccb")

-- NO_I18N
-- 100 ml venom
ccb.content.define_item {
    id = "venom_gland",
    abstract = true,
    name = ccb.content.text_without_extraction("venom gland"),
    category = "chems",
    mass = "130 g",
    volume = "110 ml",
    symbol = "o",
    looks_like = "mutant_bug_hydrogen_sacs",
    comestible = { kind = "FOOD", shelf_life = "4 hours" },
}

ccb.content.define_item {
    id = "venom_wasp",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("wasp venom gland", "wasp venom glands"),
    description = ccb.content.text("A fragile, slightly quivering organ for the production and storage of wasp venom.  You could extract some very useful chemicals from it with the right know-how, but only if you hurry."),
    color = "light_green",
    comestible = { fun = -50 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "venom_bee",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("bee venom gland", "bee venom glands"),
    description = ccb.content.text("A fragile, slightly quivering organ for the production and storage of honeybee venom.  You could extract some very useful chemicals from it with the right know-how, but only if you hurry."),
    color = "yellow",
    comestible = { fun = -50 },
    use_actions = { "POISON" },
}
