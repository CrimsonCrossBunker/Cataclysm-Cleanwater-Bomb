local content = require("ccb").content

-- jetpacks.json
content.add(content.Enchantment { id = "afs_ench_jetpack_sprint", condition = "ACTIVE", name = content.text("Powered Movement"), description = content.text("You are using a jetpack to boost your movement speed.") }
    :value("MOVE_COST", { multiply = -0.5 }))

-- item_enchants.json
content.add(content.Enchantment { id = "ench_cold_armor", has = "WORN", condition = "ALWAYS", name = content.text("Cold Barrier"), description = content.text("Reduces incoming cold damage by 25%.") }
    :incoming_damage("cold", { multiply = -0.25 }))

content.add(content.Enchantment { id = "afs_ench_exo_big_carry", has = "WORN", condition = "ACTIVE", name = content.text("Load Support Module"), description = content.text("Provides 20kg of additional storage.") }
    :value("CARRY_WEIGHT", { add = 20000 }))

content.add(content.Enchantment { id = "afs_ench_exo_small_carry", has = "WORN", condition = "ACTIVE", name = content.text("Small Load Support Module"), description = content.text("Provides 10kg of additional storage.") }
    :value("CARRY_WEIGHT", { add = 10000 }))

content.add(content.Enchantment { id = "afs_ench_exo_recoil", has = "WORN", condition = "ACTIVE", name = content.text("Recoil Mitigation System"), description = content.text("Reduces weapon dispersion.") }
    :value("WEAPON_DISPERSION", { multiply = -0.3 }))

content.add(content.Enchantment { id = "afs_ench_exo_forcefield_bash_cut", has = "WORN", condition = "ACTIVE", name = content.text("Low Energy Forcefield"), description = content.text("Reduces incoming bash and cut damage by 25.") }
    :incoming_damage("bash", { add = -25 })
    :incoming_damage("cut", { add = -25 }))

content.add(content.Enchantment { id = "afs_ench_exo_forcefield_ballistic_pierce", has = "WORN", condition = "ACTIVE", name = content.text("High Energy Forcefield"), description = content.text("Reduces incoming pierce and bullet damage by 40.") }
    :incoming_damage("stab", { add = -40 })
    :incoming_damage("bullet", { add = -40 }))

content.add(content.Enchantment { id = "afs_ench_exo_AR_module", has = "WORN", condition = "ACTIVE", name = content.text("Education Assist"), description = content.text("Assists with learning and study.") }
    :value("LEARNING_FOCUS", { add = 15 }))

content.add(content.Enchantment { id = "afs_ench_cryo_ui", has = "WORN", condition = "ACTIVE" }
    :every(120, { id = "afs_cryosuit_ui_spell" }))

content.add(content.Enchantment { id = "afs_ench_climate_control_warm", has = "WORN", condition = "ACTIVE", name = content.text("Cold Climate Control"), description = content.text("You are wearing equipment that helps handle harsh climates.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

content.add(content.Enchantment { id = "afs_ench_climate_control_1", has = "WORN", condition = "ACTIVE", name = content.text("Exosuit Climate Control"), description = content.text("Your active jumpsuit helps maintain your body temperature.") }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment { id = "ench_exo_carry", has = "WORN", condition = "ACTIVE", name = content.text("EXO Frame Carry"), description = content.text("You are wearing equipment that gives 20kg carry weight.") }
    :value("CARRY_WEIGHT", { add = 20000 }))

content.add(content.Enchantment { id = "ench_smart_gun", has = "WIELD", condition = "ALWAYS", name = content.text("Smart Gun"), description = content.text("Your gun aims itself, reducing your dispersion by 90%.") }
    :value("WEAPON_DISPERSION", { multiply = -0.9 }))

content.add(content.Enchantment { id = "ench_ballistic_assist", has = "WORN", condition = "ALWAYS", name = content.text("Ballistic assist"), description = content.text("Your gear relays targeting data to your weapons, reducing dispersion by 10%.") }
    :value("WEAPON_DISPERSION", { multiply = -0.1 }))

-- enchantments.json
content.add(content.Enchantment { id = "cranial_explosion" }
    :every(2332800, { id = "head_go_bye" }))

content.add(content.Enchantment { id = "melee_counteraction", condition = "ACTIVE" }
    :hit_me({ id = "afs_generic_free_turn", self = true, trigger_message = content.text("You react with machine-like precision."), npc_trigger_message = content.text("%1$s's reacts with robotic precision.") }))

content.add(content.Enchantment { id = "melee_optimization", condition = "ACTIVE" }
    :hit_you({ id = "afs_generic_speed_bonus", self = true }))

content.add(content.Enchantment { id = "heightened_performance", condition = "ACTIVE" }
    :value("DEXTERITY", { add = 1 })
    :value("STRENGTH", { add = 1 })
    :value("SPEED", { add = 3 })
    :value("HUNGER", { multiply = 1.1 })
    :value("THIRST", { multiply = 1.1 })
    :value("METABOLISM", { multiply = 1.1 })
    :value("SOCIAL_PERSUADE", { add = -10 })
    :value("SOCIAL_INTIMIDATE", { add = 2 }))

content.add(content.Enchantment { id = "protect_cold", condition = "ACTIVE" }
    :incoming_damage("cold", { add = -15 }))

content.add(content.Enchantment { id = "enchant_afs_electrokin_zap_enemies", has = "HELD", condition = "ALWAYS" }
    :hit_me({ id = "afs_electrokin_zap_attacked", self = false, trigger_once_in = 2 }))
