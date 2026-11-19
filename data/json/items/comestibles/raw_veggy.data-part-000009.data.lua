local ccb = require("ccb")

-- Note: Legacy item ID, this is not actually a vegetable at all anymore.
ccb.content.define_item {
    id = "veggy_tainted",
    name = ccb.content.plural_text("alien fungus chunk", "alien fungus chunks"),
    category = "other",
    copy_from = "veggy",
    looks_like = "mushroom",
    description = ccb.content.text("A chunk of fungal matter from some sort of alien mushroom creature.  Eating unfamiliar mushrooms is a bad idea."),
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "FUNGAL_VECTOR" },
    comestible = { shelf_life = "40 hours", fun = -10, smoking_result = "dry_veggy_tainted" },
    use_actions = { "POISON" },
}
