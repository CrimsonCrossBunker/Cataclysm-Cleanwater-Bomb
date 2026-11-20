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

ccb.runtime.handler("allow_civilian_bloodbag_bloodbag_daze_self", function(attack)
    return intensity(attack.attacker, "dazed") == nil
end)

ccb.runtime.handler("allow_dragonfly_giant_grab", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
        and intensity(attack.attacker, "maimed_wings") == nil
end)

ccb.runtime.handler("allow_dream_shadow_mon_spell_shadow_damage_reduction", function(attack)
    return intensity(attack.attacker, "effect_monster_shadow_damage_reduction") == nil
end)

ccb.runtime.handler("allow_feral_xe_dreamer_feral_dreamer_dream_knife", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
          and intensity(attack.attacker, "disarmed") == nil
        and intensity(attack.attacker, "effect_xe_feral_dreamer_dream_dagger") ~= nil
end)

ccb.runtime.handler("allow_feral_xe_dreamer_feral_xe_dreamer_summon_dream_dagger", function(attack)
    return not flag(attack.attacker, "NO_SPELLCASTING")
        and intensity(attack.attacker, "effect_xe_feral_dreamer_dream_dagger") == nil
end)

ccb.runtime.handler("allow_jabberwock_bite_jabberwock_1", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_luna_attuned_revenant_mon_luna_attuned_revenant_moon_withdrawal", function(attack)
    return not snapshot(attack.attacker).outside
end)

ccb.runtime.handler("allow_luna_attuned_revenant_smash", function(attack)
    return snapshot(attack.attacker).outside
end)

ccb.runtime.handler("allow_march_lord_autumn_xe_autumn_swirl_of_autumn_leaves", function(attack)
    return intensity(attack.attacker, "effect_monster_swirl_of_autumn_leaves") == nil
end)

ccb.runtime.handler("allow_march_lord_autumn_xe_touch_of_frailty", function(attack)
    return intensity(attack.target, "effect_changeling_autumn_touch_of_frailty_monster") == nil
end)

ccb.runtime.handler("allow_march_lord_spring_xe_march_lord_create_grasses", function(attack)
    return snapshot(attack.attacker).outside
        and snapshot(attack.target).outside
        and services.environment.terrain_has_flag(snapshot(attack.target).position, "DIGGABLE")
end)

ccb.runtime.handler("allow_march_lord_spring_xe_march_lord_summon_plants", function(attack)
    return snapshot(attack.target).outside
        and services.environment.terrain_has_flag(snapshot(attack.target).position, "GRAZABLE")
end)

ccb.runtime.handler("allow_march_lord_spring_xe_spring_march_lord_viridian_cuirass", function(attack)
    return snapshot(attack.attacker).outside
        and services.environment.terrain_has_flag(snapshot(attack.attacker).position, "GRAZABLE")
        and intensity(attack.attacker, "effect_monster_viridian_cuirass") == nil
end)

ccb.runtime.handler("allow_treant_crush", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("allow_triffid_greenseer_xe_greenseer_destroy_summon", function(attack)
    return snapshot(attack.target).outside
        and services.environment.terrain_has_flag(snapshot(attack.target).position, "DIGGABLE")
        and species(attack.target, "SUMMONED_CREATURE")
end)

ccb.runtime.handler("allow_vampire_anathema_vampire_anathema_final_form", function(attack)
    return intensity(attack.attacker, "effect_anathema_final_form") == nil
        and snapshot(attack.attacker).hp < 100
end)

ccb.runtime.handler("allow_vampire_anathema_vampire_anathema_heal", function(attack)
    return intensity(attack.attacker, "effect_anathema_final_form") == nil
        and snapshot(attack.attacker).hp < 200
end)

ccb.runtime.handler("allow_vampire_anathema_vampire_anathema_setup", function(attack)
    return intensity(attack.attacker, "effect_anathema_resilience") == nil
end)

ccb.runtime.handler("allow_vampire_anathema_vampire_anathema_starts_battle", function(attack)
    return intensity(attack.attacker, "effect_anathema_battle_started") == nil
        and snapshot(attack.attacker).hp < 200
end)

ccb.runtime.handler("allow_wild_huntsman_wild_huntsman_illumination_spell", function(attack)
    return intensity(attack.target, "wild_hunt_illumination_spell") == nil
end)

ccb.runtime.handler("allow_zombie_monochrome_3_xedra_monster_erosion_buff_special", function(attack)
    return intensity(attack.attacker, "effect_xedra_monster_erosion") == nil
end)

ccb.runtime.handler("allow_zombie_monochrome_zombie_monochrome_reset_hp_attack", function(attack)
    return snapshot(attack.attacker).hp < snapshot(attack.attacker).hp_max
end)

ccb.runtime.handler("monster_attack_armed", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("monster_attack_intact_legs", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
end)

ccb.runtime.handler("monster_attack_intact_mandibles", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
end)
