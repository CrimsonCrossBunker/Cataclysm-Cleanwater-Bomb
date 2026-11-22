local ccb = require("ccb")

ccb.content.define_spell {
    id = "gracken_arm_push_spell",
    shape = "blast",
    effect = "directed_push",
    name = ccb.content.text_without_extraction("Gracken Long Arms Spell"),
    description = ccb.content.text_without_extraction("Push a target away from you."),
    message = "You extend your arms and push the %s away from you!",
    flags = { "SILENT" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_7", fallback = 0 },
    min_range = { handler = "wave14a_xedra_evolved_stat_8", fallback = 0 },
    difficulty = 1,
}
