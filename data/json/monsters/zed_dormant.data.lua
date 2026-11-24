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

-- NO_I18N
ccb.content.define_monster {
    id = "mon_pseudo_dormant_zombie",
    name = ccb.content.plural_text("zombie", "zombies"),
    description = ccb.content.text_without_extraction("Fake zombie used for spawning dormant zombies.  If you see this, open an issue on GitHub."),
    copy_from = "mon_zombie",
    looks_like = "corpse_mon_zombie",
    hp = 5,
    speed = 1,
    flags = { "FILTHY", "REVIVES", "DORMANT", "QUIETDEATH", "NOT_HALLUCINATION" },
    zombify_into = "mon_zombie",
    attacks = {
        {
            id = "pseudo_dormant_trap_setup_attk",
            spell = { id = "pseudo_dormant_trap_setup", hit_self = true },
            cooldown = 1,
            allow_no_target = true,
            casting_message = "",
            kind = "spell",
        },
    },
}

-- NO_I18N
-- NO_I18N
-- volume is damage/3, so 20
ccb.content.define_spell {
    id = "cause_loud_moaning",
    name = ccb.content.text_without_extraction("cause loud moaning"),
    description = ccb.content.text_without_extraction("You should not see this.  Causes loud noise."),
    valid_targets = { "ground", "ally" },
    max_level = 1,
    shape = "blast",
    effect = "noise",
    flags = { "NO_EXPLOSION_SFX" },
    sound_type = "combat",
    sound_id = "melee_attack",
    sound_variant = "monster_melee_hit",
    sound_description = ccb.content.text("a zombie moaning!"),
    min_damage = 60,
    max_damage = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wake_up_dormant",
    name = ccb.content.text_without_extraction("dormant corpse waking up"),
    description = ccb.content.text_without_extraction("You should not see this.  Causes all dormant corpses in the tile to revive."),
    valid_targets = { "ground" },
    max_level = 1,
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 1,
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    effect = "revive_dormant",
    effect_data = "ZOMBIE",
    extra_spells = { { spell = "cause_loud_moaning" } },
}
