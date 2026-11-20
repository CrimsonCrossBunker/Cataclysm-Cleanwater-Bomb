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

local function chosen_spell(creature)
    return checked(services.variables.get_number(creature, "feral_dabbler_chosen_spell_number")).value or 0
end

ccb.runtime.handler("allow_ankheg_ankheg_bite_with_acid", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and intensity(attack.attacker, "maimed_acid_gland") == nil
end)

ccb.runtime.handler("allow_ankheg_ankheg_bite_without_acid", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and intensity(attack.attacker, "maimed_acid_gland") ~= nil
end)

ccb.runtime.handler("allow_ankheg_mon_ankheg_acid_barf", function(attack)
    return snapshot(attack.attacker).hp < 60
        and intensity(attack.attacker, "maimed_acid_gland") == nil
end)

ccb.runtime.handler("allow_demon_spider_demon_spider_fire_heal", function(attack)
    return services.environment.field_exists(snapshot(attack.attacker).position, "fd_fire", false)
end)

ccb.runtime.handler("allow_demon_spider_spinneret_fire", function(attack)
    return intensity(attack.target, "webbed") ~= nil
end)

ccb.runtime.handler("allow_dragon_black_wyrmling_black_whelp_breath", function(attack)
    return intensity(attack.attacker, "effect_dragon_deep_breath") ~= nil
end)

ccb.runtime.handler("allow_feral_animist_enhanced_feral_high_animist_bleed_spell", function(attack)
    return (intensity(attack.attacker, "effect_feral_animist_inner_voice") ~= nil
          or intensity(attack.attacker, "effect_feral_animist_inner_voice") == nil
            and not flag(attack.attacker, "MUTE"))
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_animist_enhanced_feral_high_animist_guardian_spirit", function(attack)
    return (intensity(attack.attacker, "effect_feral_animist_inner_voice") ~= nil
          or intensity(attack.attacker, "effect_feral_animist_inner_voice") == nil
            and not flag(attack.attacker, "MUTE"))
        and intensity(attack.attacker, "effect_feral_animist_guardian_spirit") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_animist_enhanced_feral_high_animist_inner_voice", function(attack)
    return flag(attack.attacker, "MUTE")
        and intensity(attack.attacker, "maimed_arm") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_feral_animist_enhanced_feral_high_animist_smite_spell", function(attack)
    return (intensity(attack.attacker, "effect_feral_animist_inner_voice") ~= nil
          or intensity(attack.attacker, "effect_feral_animist_inner_voice") == nil
            and not flag(attack.attacker, "MUTE"))
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_feral_animist_enhanced_feral_high_animist_summon_wisps", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_feral_animist_feral_animist_guardian_spirit", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "effect_feral_animist_guardian_spirit") == nil
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_cop_feral_dabbler_ethereal_grasp", function(attack)
    return not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 26
end)

ccb.runtime.handler("allow_feral_cop_feral_dabbler_soldier_magicmissile", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 25
end)

ccb.runtime.handler("allow_feral_druid_enhanced_feral_high_druid_thornskin", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "effect_feral_druid_thornskin") == nil
end)

ccb.runtime.handler("allow_feral_earthshaper_enhanced_feral_earthshaper_high_golem_summon", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and (services.environment.terrain_has_flag(snapshot(attack.target).position, "DIGGABLE")
          or services.environment.terrain_has_flag(snapshot(attack.target).position, "PLOWABLE"))
end)

ccb.runtime.handler("allow_feral_human_magician_spell", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_cure_light_wounds", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 2
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_light_target", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 3
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_sound_bomb", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 1
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_spell_picker", function(attack)
    return chosen_spell(attack.attacker) == 0
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_summon_wisps", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 4
end)

ccb.runtime.handler("allow_feral_human_pipe_feral_dabbler_windrunning", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and chosen_spell(attack.attacker) == 5
        and intensity(attack.attacker, "enchant_windrun_monster") == nil
end)

ccb.runtime.handler("allow_feral_lab_magician_feral_thaum_sci_spell_blindflash", function(attack)
    return not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_lab_magician_smash", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_magus_enhanced_feral_high_magus_repulsion_wave", function(attack)
    return not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and snapshot(attack.attacker).position:game_distance(snapshot(attack.target).position) == 1
end)

ccb.runtime.handler("allow_feral_stormshaper_feral_stormshaper_stormhammer_attack", function(attack)
    return intensity(attack.attacker, "effect_feral_stormshaper_stormhammer") ~= nil
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_stormshaper_feral_stormshaper_summon_stormhammer", function(attack)
    return intensity(attack.attacker, "effect_feral_stormshaper_stormhammer_cooldown") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_feral_technomancer_feral_technomancer_bless", function(attack)
    return intensity(attack.attacker, "effect_feral_technomancer_bless") == nil
        and not flag(attack.attacker, "MUTE")
        and not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_jabberwock_bite_jabberwock_1", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_mi_go_fleshwarper_migo_fleshwarper_enhance_flesh_initial", function(attack)
    return intensity(attack.attacker, "effect_monster_no_double_cast") == nil
end)

ccb.runtime.handler("allow_mi_go_fleshwarper_migo_fleshwarper_enhance_flesh_spell", function(attack)
    return intensity(attack.attacker, "effect_migo_enhance_flesh_monster") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_mi_go_nethermancer_migo_nethermancer_nether_shield", function(attack)
    return intensity(attack.attacker, "effect_migo_nether_shield_monster") == nil
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_ogre_grab", function(attack)
    return intensity(attack.attacker, "disarmed") ~= nil
end)

ccb.runtime.handler("allow_ogre_mage_mon_ogre_mage_invisibility_spell", function(attack)
    return snapshot(attack.attacker).hp < 150
        and not flag(attack.attacker, "NO_SPELLCASTING")
end)

ccb.runtime.handler("allow_rust_monster_rust_monster_kill_iron_golem", function(attack)
    return species(attack.target, "IRON_GOLEM")
end)

ccb.runtime.handler("allow_treant_crush", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("allow_troll_mon_troll_regenerate_limb", function(attack)
    return snapshot(attack.attacker).hp > 200
        and intensity(attack.attacker, "maimed_arm") ~= nil
end)

ccb.runtime.handler("allow_zombie_levinbolt_levinbolt_zombie_spell_attack", function(attack)
    return not flag(attack.attacker, "NO_SPELLCASTING")
        and not flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("monster_attack_armed", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("monster_attack_intact_arms", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("monster_attack_intact_legs", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
end)

ccb.runtime.handler("monster_attack_spellcasting_available", function(attack)
    return not flag(attack.attacker, "NO_SPELLCASTING")
end)
