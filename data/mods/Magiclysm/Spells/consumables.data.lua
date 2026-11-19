local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flower_fern_spell",
    name = ccb.content.text_without_extraction("Flower fern effect"),
    description = ccb.content.text_without_extraction("Gives small positive effect."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "NO_HANDS" },
    effect = "attack",
    effect_data = "flower_fern_eff",
    shape = "blast",
    message = ccb.content.text("You feel better!"),
    min_duration = 60000,
    max_duration = 60000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "glowing_mushroom_spell",
    name = ccb.content.text_without_extraction("Glowing mushroom effect"),
    description = ccb.content.text_without_extraction("Gives small speed increasing effect."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "NO_HANDS" },
    effect = "attack",
    effect_data = "glowing_mushroom_eff",
    shape = "blast",
    message = ccb.content.text("You feel lighter!"),
    min_duration = 60000,
    max_duration = 60000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "whiskflower_spell",
    name = ccb.content.text_without_extraction("Whiskflower effect"),
    description = ccb.content.text_without_extraction("Make you drunk."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "NO_HANDS" },
    effect = "attack",
    message = ccb.content.text("You wobble as you feel inebriated"),
    effect_data = "drunk",
    shape = "blast",
    min_duration = 120000,
    max_duration = 120000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sojourners_palm_spell",
    name = ccb.content.text_without_extraction("Sojourners palm effect"),
    description = ccb.content.text_without_extraction("teleport you in a small area."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "NO_HANDS" },
    effect = "short_range_teleport",
    shape = "blast",
    message = ccb.content.text("Your vision shifts in a flash of colors and you reappear elsewhere."),
    min_range = 1,
    max_range = 1,
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "funnelcap_spell",
    name = ccb.content.text_without_extraction("Funnelcap effect"),
    description = ccb.content.text_without_extraction("Restore a bit of mana."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "NO_HANDS" },
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    message = ccb.content.text("You recover mana!"),
    min_damage = 15,
    max_damage = 25,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pfruit_regeneration_spell",
    name = ccb.content.text_without_extraction("Apple Potion Healing Effect"),
    description = ccb.content.text_without_extraction("Heals the target."),
    valid_targets = { "self" },
    min_damage = -1,
    max_damage = -1,
    effect = "attack",
    shape = "blast",
    flags = { "SILENT" },
}
