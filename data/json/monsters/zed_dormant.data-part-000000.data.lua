local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "kill_pseudo_zombie",
    name = ccb.content.text_without_extraction("kill pseudo zombie"),
    description = ccb.content.text_without_extraction("You should not see this.  Kills pseudo zombie to turn it into a corpse for revival."),
    valid_targets = { "self" },
    max_level = 1,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "PERCENTAGE_DAMAGE", "NO_FAIL" },
    base_casting_time = 1,
    shape = "blast",
    min_damage = 100,
    max_damage = 100,
    min_aoe = 1,
    max_aoe = 1,
    message = "",
    effect = "attack",
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pseudo_dormant_trap_setup",
    name = ccb.content.text_without_extraction("dormant corpse setup"),
    description = ccb.content.text_without_extraction("You should not see this.  Sets up trap for dormant zombies."),
    valid_targets = { "self" },
    max_level = 1,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    base_casting_time = 1,
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    message = "",
    effect = "add_trap",
    effect_data = "tr_dormant_corpse",
    extra_spells = { { spell = "kill_pseudo_zombie", self = true } },
}
