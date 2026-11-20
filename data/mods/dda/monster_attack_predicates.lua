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

local function intensity(creature, name, body_part)
    local part = body_part and services.types.id("body_part", body_part)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name), part))
end

ccb.runtime.handler("allow_amalgamation_zapper_shock_blast", function(attack)
    return intensity(attack.attacker, "maimed_capacitor") == nil
        and intensity(attack.attacker, "elec_charged") ~= nil
end)

ccb.runtime.handler("allow_amalgamation_zapper_shock_cone", function(attack)
    return intensity(attack.attacker, "maimed_capacitor") == nil
end)

ccb.runtime.handler("allow_ant_soldier_mega_drag_followup", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_ant_soldier_mega_grab_drag", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and not flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("allow_centipede_mega_drag_followup", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
        and flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_centipede_mega_grab_drag", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
        and not flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("allow_darkman_wraith_summon_shadow_spell", function(attack)
    return intensity(attack.attacker, "photophobia") == nil
end)

ccb.runtime.handler("allow_darkman_wraith_summon_shadow_spell_photophobia", function(attack)
    return intensity(attack.attacker, "photophobia") ~= nil
end)

ccb.runtime.handler("allow_dragonfly_giant_grab", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
        and intensity(attack.attacker, "maimed_wings") == nil
end)

ccb.runtime.handler("allow_flying_polyp_flying_polyp_out_of_phase", function(attack)
    return intensity(attack.attacker, "effect_polyp_out_of_phase") == nil
end)

ccb.runtime.handler("allow_frog_husk_dusty_frog_leap", function(attack)
    return intensity(attack.attacker, "fragile_frog") ~= nil
end)

ccb.runtime.handler("allow_jabberwock_bite_jabberwock_1", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_lieutenant_shadow_ltnt_illuminate_you", function(attack)
    return intensity(attack.target, "Shadow_Reveal") == nil
        and (attack.target.subtype == "avatar" or attack.target.subtype == "npc")
end)

ccb.runtime.handler("allow_lieutenant_shadow_ltnt_life_drain", function(attack)
    return services.environment.terrain_has_flag(snapshot(attack.target).position, "PLOWABLE")
        and (attack.target.subtype == "avatar" or attack.target.subtype == "npc")
end)

ccb.runtime.handler("allow_nether_huntsman_gun", function(attack)
    return intensity(attack.attacker, "maimed_huntsman_arm") == nil
end)

ccb.runtime.handler("allow_proxy_bigfrog_ranged_pull", function(attack)
    return not flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_tongue") == nil
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_1", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 2
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_2", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 4
        and snapshot(attack.attacker).hp < 2501
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_3", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 6
        and snapshot(attack.attacker).hp < 2001
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_4", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 10
        and snapshot(attack.attacker).hp < 1501
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_5", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 12
        and snapshot(attack.attacker).hp < 1001
end)

ccb.runtime.handler("allow_singularity_reclaimer_mon_singularity_reclaimer_summon_6", function(attack)
    return (intensity(attack.attacker, "effect_monster_no_double_cast") or -1) < 14
        and snapshot(attack.attacker).hp < 501
end)

ccb.runtime.handler("allow_skeleton_hulk_smash", function(attack)
    return attack.target_size <= 4
end)

ccb.runtime.handler("allow_skeleton_hulk_smash_equal", function(attack)
    return attack.target_size == 5
end)

ccb.runtime.handler("allow_yrax_delta_gun", function(attack)
    return intensity(attack.attacker, "yrax_overcharged") ~= nil
end)

ccb.runtime.handler("allow_zombie_brute_smash", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and attack.target_size <= 4
end)

ccb.runtime.handler("allow_zoose_brute_bite", function(attack)
    return not flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("monster_attack_armed", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("monster_attack_character_target", function(attack)
    return (attack.target.subtype == "avatar" or attack.target.subtype == "npc")
end)

ccb.runtime.handler("monster_attack_intact_arms", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("monster_attack_intact_legs", function(attack)
    return intensity(attack.attacker, "maimed_leg") == nil
end)

ccb.runtime.handler("monster_attack_intact_mandibles", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
end)

ccb.runtime.handler("allow_dermatik_juvenile_flightless_mon_juv_dermatik_wingmolt", function()
    return services.random.native_int(0, 2) == 0
end)

ccb.runtime.handler("allow_spider_cellar_mega_spell", function(attack)
    return intensity(attack.attacker, "maimed_leg") ~= nil
end)
