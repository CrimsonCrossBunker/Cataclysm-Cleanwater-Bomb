local content = require("ccb").content

-- enchantment_bionic.json
content.add(content.Enchantment { id = "ench_bio_physical_buffs", has = "WORN", condition = "ACTIVE" }
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("BONUS_DODGE", { add = 1 })
    :value("SPEED", { add = 10 }))

-- enchantment_item.json
content.add(content.Enchantment { id = "ench_mom_fifth_sun_targeting_assistance", has = "WORN", condition = "ACTIVE", name = content.text("Targeting assistance"), description = content.text("Your gear relays targeting data to your weapons, reducing dispersion by 25%.") }
    :value("WEAPON_DISPERSION", { multiply = -0.25 }))

-- enchantments_baneful.json
content.add(content.Enchantment { id = "enchant_riftwalker_teleport", has = "HELD", condition = "ALWAYS" }
    :every(3, { id = "teleport_blink_monster" }))

content.add(content.Enchantment { id = "enchant_pyrokin_fever", has = "HELD", emitter = "emit_pyrokin_fever", condition = "ALWAYS" }
    :value("LUMINATION", { add = 50 }))

content.add(content.Enchantment { id = "enchant_teleport_potion_comedown", has = "HELD", condition = "ALWAYS" }
    :every(7800, { id = "teleport_blink_monster" }))

-- enchantments_player.json
content.add(content.Enchantment { id = "enchant_clair_potion", has = "HELD", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = 1 })
    :value("HEARING_MULT", { multiply = 2.5 })
    :every(2, { id = "clair_potion_clairvoyance" }))

content.add(content.Enchantment { id = "ench_clair_group_tactics", has = "HELD", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = -1 })
    :every(2, { id = "clair_group_tactics_aoe" }))

content.add(content.Enchantment { id = "enchant_electrokin_zap_enemies", has = "HELD", condition = "ALWAYS" }
    :hit_me({ id = "electrokin_zap_attacked", self = false, trigger_once_in = 2 }))

content.add(content.Enchantment { id = "enchant_clair_sense_rads", has = "HELD", condition = "ALWAYS" }
    :every(10, { id = "clair_sense_rads_outside_spawn_item" }))

content.add(content.Enchantment { id = "enchant_photokin_blinding_glare", has = "HELD", condition = "ALWAYS" }
    :value("LUMINATION", { add = 10001 })
    :hit_me({ id = "photokin_blinding_glare_attack", self = false, trigger_once_in = 3 })
    :hit_you({ id = "photokin_blinding_glare_attack", self = false, trigger_once_in = 3 }))

content.add(content.Enchantment { id = "enchant_pyrokinetic_aura", has = "HELD", emitter = "emit_pyrokin_fever", condition = "ALWAYS" }
    :value("LUMINATION", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 40 })
    :hit_me({ id = "pyro_aura_attacked", self = false })
    :hit_you({ id = "pyro_aura_attack", self = false }))

content.add(content.Enchantment { id = "enchant_electrokin_potion", has = "HELD", condition = "ALWAYS" }
    :incoming_damage("electric", { add = -5 })
    :hit_me({ id = "electro_potion_attacked", self = false }))

content.add(content.Enchantment { id = "enchant_photokin_potion_hide", has = "HELD", condition = "ALWAYS" }
    :value("STEALTH_MODIFIER", { add = 25 }))

content.add(content.Enchantment { id = "enchant_photokin_potion_unhide", has = "HELD", condition = "ALWAYS" }
    :value("STEALTH_MODIFIER", { add = -25 }))

content.add(content.Enchantment { id = "enchant_pyrokin_potion", has = "HELD", condition = "ALWAYS" }
    :incoming_damage("heat", { add = -50 })
    :hit_me({ id = "pyro_aura_attacked", self = false }))

content.add(content.Enchantment { id = "enchant_teleport_potion", has = "HELD", condition = "ALWAYS" }
    :hit_you({ id = "teleport_slow_monster", self = false, level = 1, trigger_message = content.text("The air around your enemy warps slightly.") }))
