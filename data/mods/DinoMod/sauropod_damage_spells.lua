local content = require("ccb").content

for _, spell_id in ipairs({ "sauropod_hurt_self", "zauropod_hurt_self" }) do
    content.add(content.Spell {
        id = spell_id,
        name = "Wretch Hurt Self",
        description = "Hurts yourself.",
        message = content.text("You cast %s!"),
        sound_description = content.text("an explosion."),
        flags = { "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
        min_damage = 1200,
        max_damage = 1500,
        damage_type = "pure",
        valid_targets = { "hostile", "ally", "self", "ground" },
        shape = "blast",
        effect = "attack",
    })
end
