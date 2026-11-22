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

ccb.content.define_spell {
    id = "teleport_warper_combat_warp_chance_attacker",
    skill = "metaphysics",
    shape = "blast",
    effect = "short_range_teleport",
    spell_class = "TELEPORTER",
    magic_type = "mom_psionics",
    name = ccb.content.text_without_extraction("[Ψ]Flickerflash Stance Attacker Warp Chance"),
    description = ccb.content.text_without_extraction("Chance to teleport when attacking a target"),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "TARGET_TELEPORT", "IGNORE_WALLS" },
    valid_targets = { "ground", "hostile" },
    min_range = 4,
    min_aoe = { handler = "wave14a_mindovermatter_stat_13", fallback = 0 },
    max_aoe = { handler = "wave14a_mindovermatter_stat_13", fallback = 0 },
}
