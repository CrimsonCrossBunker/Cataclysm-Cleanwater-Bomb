local ccb = require("ccb")

ccb.content.define_mutation {
    id = "TELELIXIRDOWN_active",
    name = ccb.content.text("Elixir PK Surge (active)"),
    copy_from = "TELELIXIRDOWN",
    description = ccb.content.text("You are lashing out with your elixir-forged telekinetic powers."),
    consumes_rest = true,
    cost = 1,
    cooldown = "1 m",
    on_activate = "telelixir_cast_once",
    valid = false,
    transform = {
        target = "TELELIXIRDOWN",
        message = ccb.content.text("You rein your powers back in for now."),
        active = false,
        moves = 10,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telelixir_random",
    name = ccb.content.text_without_extraction("[Ψ]Telelixir Random Choice"),
    description = ccb.content.text_without_extraction("Part of the Telekinetic Elixir spell that chooses another spell to cast.  It's a bug if you have it."),
    flags = { "WONDER", "NO_PROJECTILE", "RANDOM_TARGET", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    message = "",
    effect = "none",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_range = 8,
    max_range = 15,
    extra_spells = { { spell = "telelixir_slam" }, { spell = "telelixir_push" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telelixir_slam",
    name = ccb.content.text_without_extraction("[Ψ]Telelixir Slam"),
    description = ccb.content.text_without_extraction("One spell for the telekinetic elixir mutation.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    message = "",
    effect = "attack",
    effect_data = "downed",
    shape = "blast",
    difficulty = 1,
    min_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telelixir_push",
    name = ccb.content.text_without_extraction("[Ψ]Telelixir Shove"),
    description = ccb.content.text_without_extraction("One spell for the telekinetic elixir mutation.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    message = "",
    effect = "directed_push",
    shape = "blast",
    difficulty = 1,
    min_damage = 3,
    max_damage = 8,
}
