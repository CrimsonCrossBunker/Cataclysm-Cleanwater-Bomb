local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function snapshot(creature)
    return checked(services.creatures.snapshot(creature))
end

local function flag(creature, name)
    return checked(services.creatures.has_flag_text(creature, name))
end

local function species(creature, name)
    local id = services.types.id("species", name)
    return id:is_valid() and checked(services.creatures.has_species(creature, id))
end

local function intensity(creature, name, body_part)
    local part = body_part and services.types.id("body_part", body_part)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name), part))
end

local function nemesis_iteration()
    return checked(services.variables.get_global_number("Nemesis_iteration")).value or 0
end

ccb.runtime.handler("allow_amalgamation_telekinetic_shielder_psi_amalgamation_telekinetic_shielder_shield_other", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and (intensity(attack.attacker, "effect_amalgamation_telekinetic_shielder_counter") or -1) < 4
end)

ccb.runtime.handler("allow_amalgamation_telekinetic_shielder_smash", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and not flag(attack.target, "TELEKIN_SHIELD")
        and not flag(attack.target, "TELEKIN_PUSH_PULL_IMMUNE")
        and (intensity(attack.attacker, "effect_amalgamation_telekinetic_shielder_counter") or -1) == 0
end)

ccb.runtime.handler("allow_amalgamation_telepathic_distractor_psi_whispering_amalgamation_apply_mindsight", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and (intensity(attack.attacker, "eff_mind_seeing_bonus_30") == nil
          or intensity(attack.attacker, "eff_mind_seeing_bonus_10") == nil)
end)

ccb.runtime.handler("allow_bandersnatch_psi_bandersnatch_inertial_barrier", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_inertial_barrier") == nil
end)

ccb.runtime.handler("allow_civilian_biokinetic_bio_op_takedown", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
end)

ccb.runtime.handler("allow_cow_biokinetic_psi_hodag_hardened_skin", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_hardened_skin") == nil
end)

ccb.runtime.handler("allow_devourer_lab_sec_psi_lab_devourer_reactive_displacement", function(attack)
    return snapshot(attack.attacker).hp < 100
        and not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_teleport_reactive_displacement_monster") == nil
end)

ccb.runtime.handler("allow_feral_human_bio3_psi_biokin3_physical_enhancement", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_physical_enhancement_improved") == nil
end)

ccb.runtime.handler("allow_feral_human_clair2_psi_clair2_combat_sense", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_feral_combat_sense_2") == nil
end)

ccb.runtime.handler("allow_feral_human_clair2_psi_clair2_heightened_senses", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_feral_heightened_senses_2") == nil
end)

ccb.runtime.handler("allow_feral_human_clair3_psi_clair3_clear_sight", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_clair_clear_sight") == nil
end)

ccb.runtime.handler("allow_feral_human_clair3_psi_clair3_combat_sense", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_feral_combat_sense_3") == nil
end)

ccb.runtime.handler("allow_feral_human_clair3_psi_clair3_heightened_senses", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_feral_heightened_senses_3") == nil
end)

ccb.runtime.handler("allow_feral_human_clair_psi_clair_heightened_senses", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_feral_heightened_senses") == nil
end)

ccb.runtime.handler("allow_feral_human_electrokin3_psi_electrokin3_neuro_acceleration", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_neuro_acceleration_enhanced") == nil
end)

ccb.runtime.handler("allow_feral_human_porter2_psi_porter2_reactive_displacement", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_teleport_reactive_displacement_monster") == nil
end)

ccb.runtime.handler("allow_feral_human_telekin_smash", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and not flag(attack.target, "TELEKIN_SHIELD")
        and not flag(attack.target, "TELEKIN_PUSH_PULL_IMMUNE")
end)

ccb.runtime.handler("allow_feral_security_psychic_psi_biokin_guard_physical_enhancement", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_physical_enhancement") == nil
end)

ccb.runtime.handler("allow_hidebehind_psi_hidebehind_apply_mindsight", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "eff_mind_seeing_bonus_20") == nil
end)

ccb.runtime.handler("allow_hidebehind_psi_hidebehind_obscurity_activate", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "telepathic_ignorance_self") == nil
        and intensity(attack.target, "telepathic_ignorance") == nil
end)

ccb.runtime.handler("allow_hodag_psi_hodag_heightened_reflexes", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_heightened_reflex") == nil
end)

ccb.runtime.handler("allow_mi_go_telepath_psi_mi_go_telepath1_blast", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and not species(attack.target, "ROBOT")
        and not species(attack.target, "ROBOT_FLYING")
        and not species(attack.target, "NETHER_EMANATION")
        and not species(attack.target, "LEECH_PLANT")
        and not species(attack.target, "WORM")
        and not species(attack.target, "FUNGUS")
        and not species(attack.target, "SLIME")
end)

ccb.runtime.handler("allow_nether_eater_psi_eater_apply_mindsight", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "eff_mind_seeing_bonus_30") == nil
end)

ccb.runtime.handler("allow_nether_eater_psi_eater_drain_close_range", function(attack)
    return snapshot(attack.attacker).position:game_distance(snapshot(attack.target).position) <= 5
end)

ccb.runtime.handler("allow_nether_eater_psi_eater_drain_distance", function(attack)
    return snapshot(attack.attacker).position:game_distance(snapshot(attack.target).position) > 5
end)

ccb.runtime.handler("allow_nether_silent_one_passive_silent_one_buff_self", function(attack)
    return intensity(attack.attacker, "eff_mind_seeing_bonus_10") == nil
        or intensity(attack.attacker, "eff_mind_seeing_bonus_5") == nil
        or intensity(attack.attacker, "eff_mind_seeing_bonus_30") == nil
        or intensity(attack.attacker, "effect_nether_silent_one_resistances") == nil
end)

ccb.runtime.handler("allow_psi_gremlin_psi_gremlin_neuro_acceleration", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_neuro_acceleration") == nil
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_leap", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_psi_biokin3_hurricane_blows") == nil
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_psi_transcendant_alpha_hardened_skin", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_hardened_skin") == nil
        and intensity(attack.attacker, "effect_psi_biokin3_hurricane_blows") == nil
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_psi_transcendant_alpha_heightened_reflexes", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_heightened_reflex_enhanced") == nil
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_psi_transcendant_alpha_momentum_alteration", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_momentum_alteration") == nil
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_psi_transcendant_alpha_telegrab", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and not flag(attack.target, "TELEKIN_SHIELD")
end)

ccb.runtime.handler("allow_triffid_pyrokinetic_psi_triffid_flamebreaker_no_flame_buff", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.target, "effect_monster_pyrokinetic_fire_immunity") == nil
end)

ccb.runtime.handler("allow_triffid_pyrokinetic_psi_triffid_flamebreaker_quell", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and services.environment.field_exists(snapshot(attack.attacker).position, "fd_fire", false)
end)

ccb.runtime.handler("allow_zombie_nemesis_leap", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 14
end)

ccb.runtime.handler("allow_zombie_nemesis_mon_vitakinetic_weakness_2", function(attack)
    return nemesis_iteration() >= 28
        and intensity(attack.attacker, "effect_psi_null") == nil
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_break_concentration", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 16
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_hardened_skin", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 2
        and intensity(attack.attacker, "effect_monster_hardened_skin") == nil
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_inertial_barrier", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 22
        and intensity(attack.attacker, "effect_monster_inertial_barrier") == nil
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_momentum_alteration", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 10
        and intensity(attack.attacker, "effect_monster_momentum_alteration") == nil
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_primal_fear", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 24
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_regeneration", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 12
        and snapshot(attack.attacker).hp < 480
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_shock_touch", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 4
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_slow_teleport", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 18
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_telegrab", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and not flag(attack.target, "TELEKIN_SHIELD")
        and nemesis_iteration() >= 6
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_telepathic_blast", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 20
end)

ccb.runtime.handler("allow_zombie_nemesis_nemesis_telepathic_confusion", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 8
end)

ccb.runtime.handler("allow_zombie_nemesis_psi_electrokin3_revive", function(attack)
    return intensity(attack.attacker, "effect_psi_null") == nil
        and nemesis_iteration() >= 30
end)

ccb.runtime.handler("allow_zombie_nemesis_telekinetic_smash_throw", function(attack)
    return nemesis_iteration() >= 26
        and intensity(attack.attacker, "effect_psi_null") == nil
        and not flag(attack.target, "TELEKIN_SHIELD")
end)

ccb.runtime.handler("allow_zombie_nullpsi_zombie_null_nether_banish_monster", function(attack)
    return species(attack.target, "NETHER")
end)

ccb.runtime.handler("monster_attack_character_target", function(attack)
    return (attack.target.subtype == "avatar" or attack.target.subtype == "npc")
end)

ccb.runtime.handler("monster_attack_intact_arms", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("monster_attack_intact_mandibles", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
end)

ccb.runtime.handler("monster_attack_psionics_available", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
end)
