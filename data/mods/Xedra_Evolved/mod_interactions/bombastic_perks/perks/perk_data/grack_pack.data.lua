local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "perk_GRACKEN_FRIENDSHIP_spell",
    name = ccb.content.text_without_extraction("The Gracken Friendship Spell"),
    description = ccb.content.text_without_extraction("Befriends Gracken with the Grack Pack perk."),
    message = ccb.content.text("You quickly display the secret hand signs and the gracken's hands blurring in response."),
    teachable = false,
    valid_targets = { "ally", "hostile" },
    skill = "deduction",
    flags = { "NO_PROJECTILE", "RECHARM", "CHARM_PET", "SILENT", "NO_HANDS", "NO_LEGS" },
    extra_spells = { { spell = "perk_GRACKEN_FRIENDSHIP_aggression" } },
    effect = "charm_monster",
    shape = "blast",
    min_damage = 1000,
    max_damage = 1000,
    min_duration = 3153600000,
    max_duration = 3153600000,
    min_range = 6,
    max_range = 6,
    targeted_monsters = { "mon_gracke" },
}

ccb.content.define_spell {
    id = "perk_GRACKEN_FRIENDSHIP_aggression",
    skill = "deduction",
    shape = "blast",
    name = ccb.content.text_without_extraction("The Gracken Friendship Aggression Adjustments"),
    description = ccb.content.text_without_extraction("Adjusts aggression to make gracken more likely to attack your enemies."),
    message = "",
    teachable = false,
    flags = { "NO_PROJECTILE", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "ally", "hostile" },
    targeted_monsters = { "mon_gracke" },
    min_range = 6,
    max_range = 6,
    impact_handler = "w16b_sp_imp_xedra_evolved_5eb3ca580107",
}
