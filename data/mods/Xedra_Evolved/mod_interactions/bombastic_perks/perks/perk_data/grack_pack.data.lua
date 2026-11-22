local ccb = require("ccb")

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
