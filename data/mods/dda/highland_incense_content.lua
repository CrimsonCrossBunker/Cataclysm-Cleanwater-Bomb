local content = require("ccb").content

do
    local effect = content.EffectType {
        id = "purple_incense_effect",
        name = content.text("Resonant"),
        description = content.text("You feel strangely detached from the here and now."),
        death_message = content.text("You died."),
        rating = "neutral",
        show_in_info = true,
        maximum_intensity = 1,
        remove_message = content.text("Things seem to stitch back together."),
    }
    effect:enchantment("ench_mom_incense_nether_attunement")
    effect:enchantment("INLINE_ENCH_purple_incense_effect_1")
    content.upsert(effect)
end

do
    local effect = content.EffectType {
        id = "red_incense_effect",
        name = content.text("Ennervated"),
        description = content.text("You feel like you have one foot in the grave."),
        death_message = content.text("You died."),
        rating = "bad",
        show_in_info = true,
        maximum_intensity = 1,
        remove_message = content.text("The feeling of dread fades away."),
    }
    effect:enchantment("INLINE_ENCH_red_incense_effect_0")
    content.upsert(effect)
end

do
    local effect = content.EffectType {
        id = "yellow_incense_effect",
        name = content.text("Calm"),
        description = content.text("Something strange is happening but you can't quite feel worried about it."),
        death_message = content.text("You died."),
        rating = "good",
        show_in_info = true,
        maximum_intensity = 1,
        remove_message = content.text("The feeling of calm fades away."),
    }
    effect:enchantment("ench_mom_incense_nether_attunement")
    effect:enchantment("INLINE_ENCH_yellow_incense_effect_1")
    content.upsert(effect)
end

do
    local effect = content.EffectType {
        id = "black_incense_effect",
        name = content.text("Supernatural burning"),
        description = content.text("Invisible flames lick at your skin."),
        death_message = content.text("You died."),
        rating = "bad",
        show_in_info = true,
        main_parts_only = true,
        pain_sizing = true,
        hurt_sizing = true,
    }
    effect:resist_trait("ACIDPROOF")
    effect:modifier("perception", "amount", { base = -2 })
    effect:modifier("dexterity", "amount", { base = -2 })
    effect:modifier("strength", "amount", { base = -3, resisted_base = -1 })
    effect:modifier("speed", "amount", { base = -10 })
    effect:modifier("pain", "minimum", { base = 2 })
    effect:modifier("pain", "chance_numerator", { base = 1, resisted_base = 100 })
    effect:modifier("hurt", "minimum", { base = 2, resisted_base = 2 })
    effect:modifier("hurt", "maximum", { base = 5, resisted_base = 5 })
    effect:modifier("hurt", "chance_numerator", { base = 2, resisted_base = 30 })
    content.upsert(effect)
end

do
    local effect = content.EffectType {
        id = "green_incense_effect",
        name = content.text("Spatial Dissociation"),
        description = content.text("Distances around you don't seem to quite add up, it feels like you were walking in a dream."),
        death_message = content.text("You died."),
        rating = "neutral",
        show_in_info = true,
        maximum_intensity = 1,
        remove_message = content.text("Things seem to stitch back together."),
    }
    effect:enchantment("ench_mom_incense_nether_attunement_major")
    effect:enchantment("INLINE_ENCH_green_incense_effect_1")
    content.upsert(effect)
end

do
    local transform = content.TerrainTransform { id = "remove_black_incense" }
    transform:field {
        inputs = { "fd_black_incense" },
        results = { { "fd_null", 1 } },
    }
    content.upsert(transform)
end

do
    local spell = content.Spell {
        id = "spell_golden_incense",
        name = content.text("Golden Incense"),
        description = content.text("Grants the golden incense spell in an area around target."),
        valid_targets = { "self", "ground", "hostile", "ally" },
        flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
        effect = "attack",
        effect_data = "golden_incense_effect",
        shape = "blast",
        min_duration = 360000,
        max_duration = 360000,
    }
    content.upsert(spell)
end

do
    local spell = content.Spell {
        id = "spell_black_incense",
        name = content.text("Black Incense"),
        description = content.text("Creates a shockwave that damages nearby enemies."),
        flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
        valid_targets = { "hostile", "ground" },
        effect = "attack",
        shape = "blast",
        min_aoe = 10,
        max_aoe = 10,
        field_chance = 1,
        field = "fd_black_incense",
        min_field_intensity = 1,
        max_field_intensity = 1,
    }
    content.upsert(spell)
end

do
    local effect = content.EffectType {
        id = "golden_incense_effect",
        name = content.text("Golden Incense"),
        description = content.text("You can't shake off the smell of the golden incense.  It feels like small daggers pressing against your senses."),
        death_message = content.text("You died."),
    }
    effect:enchantment("INLINE_ENCH_golden_incense_effect_0")
    content.upsert(effect)
end

do
    local mutation = content.Mutation {
        id = "TINDALOS_IGNORE",
        name = content.text("Tindalos Ignore"),
        description = content.text("Hounds of Tindalos ignore you."),
        points = 0,
        valid = false,
        purifiable = false,
        player_display = false,
    }
    mutation:relationship("ignored_by", "TINDALOS")
    content.upsert(mutation)
end

do
    local effect = content.EffectType {
        id = "effect_tindalos_ignore_cancel",
        name = "",
        description = "",
        death_message = content.text("You died."),
    }
    content.upsert(effect)
end
