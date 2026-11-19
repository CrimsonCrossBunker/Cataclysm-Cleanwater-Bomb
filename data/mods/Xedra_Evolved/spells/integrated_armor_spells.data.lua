local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "integrated_coal_skin_burnback",
    name = ccb.content.text_without_extraction("Coal Skin Burnback"),
    description = ccb.content.text_without_extraction("The burnback effect from the burning coals skin."),
    effect = "attack",
    shape = "blast",
    min_damage = 3,
    max_damage = 3,
    valid_targets = { "hostile" },
    damage_type = "heat",
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "integrated_flame_skin_burnback",
    name = ccb.content.text_without_extraction("Flame Skin Burnback"),
    description = ccb.content.text_without_extraction("The burnback effect from the flaming skin."),
    effect = "attack",
    shape = "blast",
    min_damage = 7,
    max_damage = 13,
    valid_targets = { "hostile" },
    damage_type = "heat",
    min_range = 2,
    max_range = 2,
}
