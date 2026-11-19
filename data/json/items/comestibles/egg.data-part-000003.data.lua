local ccb = require("ccb")

-- Gar eggs are poisonous - this is not an oversight. This is also why these are omitted from the cooking requirement group.
ccb.content.define_item {
    id = "egg_gar_longnose",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    inheritance = { add = { rot_spawn = { monster = "mon_fry_gar_longnose", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}
