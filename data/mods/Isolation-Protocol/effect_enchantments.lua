local content = require("ccb").content

-- Player/sorcery_effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_iso_eldritch_damage_shield_0" }
    :value("FORCEFIELD", { add = 1 })
    :value("LUMINATION", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_iso_eldritch_cold_damage_blast_0" }
    :value("SPEED", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_iso_eldritch_invisibile_and_intangible_0" }
    :mutation("ISO_ELDRITCH_INVISIBLE_AND_INTANGIBLE_GRAPHICS"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_iso_eldritch_invisibile_and_intangible_1" }
    :value("SPEED", { multiply = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_iso_eldritch_cure_poison_disease_gas_0" }
    :mutation("TOXICFLESH"))
