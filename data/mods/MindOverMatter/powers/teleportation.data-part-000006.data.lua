local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_warper_combat_warp_chance_attacked",
    name = ccb.content.text_without_extraction("[Ψ]Flickerflash Stance Attacked Warp Chance"),
    description = ccb.content.text_without_extraction("Chance to teleport when being attacked by a target"),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS" },
    effect = "short_range_teleport",
    shape = "blast",
    min_aoe = 1,
    max_aoe = 2,
}
