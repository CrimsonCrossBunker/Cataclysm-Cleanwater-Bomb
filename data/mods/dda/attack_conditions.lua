local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function flag(creature, name)
    return checked(services.creatures.has_flag_text(creature, name))
end

local function intensity(creature, name)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name)))
end

ccb.runtime.handler("allow_acid_charge", function(attack)
    return intensity(attack.attacker, "maimed_acid_gland") == nil
end)

ccb.runtime.handler("allow_acid_slash", function(attack)
    return intensity(attack.attacker, "maimed_acid_gland") == nil
        and intensity(attack.attacker, "maimed_claws") == nil
        and intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "acid_charged") ~= nil
end)

ccb.runtime.handler("allow_armed_strike", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("allow_bio_op_takedown", function(attack)
    return services.random.native_int(0, 1) == 0
        and intensity(attack.target, "downed") == nil
end)

ccb.runtime.handler("allow_bite_grab", function(attack)
    return not flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_mandible") == nil
end)

ccb.runtime.handler("allow_bite_humanoid", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_dermatik_impale", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and not (flag(attack.attacker, "ACIDBLOOD")
            or flag(attack.attacker, "PARAIMMUNE")
            or intensity(attack.attacker, "dermatik") ~= nil)
end)

ccb.runtime.handler("allow_drag_followup", function(attack)
    return services.random.native_int(0, 3) ~= 0
        and flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_elec_charge", function(attack)
    return intensity(attack.attacker, "maimed_capacitor") == nil
end)

ccb.runtime.handler("allow_free_arm_grab", function(attack)
    return not flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_free_filament_grab", function(attack)
    return not flag(attack.attacker, "GRAB_FILTER")
        and not flag(attack.target, "GRAB")
        and intensity(attack.attacker, "sectioned_filaments") == nil
end)

ccb.runtime.handler("allow_grab_2", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and intensity(attack.attacker, "grabbing_2") == nil
end)

ccb.runtime.handler("allow_grab_3", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and intensity(attack.attacker, "grabbing_3") == nil
end)

ccb.runtime.handler("allow_grab_4", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and intensity(attack.attacker, "grabbing_4") == nil
end)

ccb.runtime.handler("allow_grab_5", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and intensity(attack.attacker, "grabbing_5") == nil
end)

ccb.runtime.handler("allow_leg_sweep", function(attack)
    return services.random.native_int(0, 1) == 0
        and flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_mandible") == nil
        and intensity(attack.target, "downed") == nil
end)

ccb.runtime.handler("allow_longswipe", function()
    return services.random.native_int(0, 4) == 0
end)

ccb.runtime.handler("allow_mon_shocker_chargeup_attack", function(attack)
    return (intensity(attack.attacker, "effect_shocker_zombie_charge_up") or -1) >= 4
        and not flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_mon_shocker_chargeup_attack_grab", function(attack)
    return (intensity(attack.attacker, "effect_shocker_zombie_charge_up") or -1) >= 4
        and flag(attack.attacker, "GRAB_FILTER")
        and intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_mutant_spinneret", function(attack)
    return flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_nether_cucumber_grab_followup", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
        and intensity(attack.attacker, "sectioned_filaments") == nil
end)

ccb.runtime.handler("allow_nether_cucumber_lash", function(attack)
    return intensity(attack.attacker, "sectioned_filaments") == nil
end)

ccb.runtime.handler("allow_smash", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and attack.attacker_size > attack.target_size
end)

ccb.runtime.handler("allow_smash_equal", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and attack.attacker_size == attack.target_size
end)

ccb.runtime.handler("allow_sting", function(attack)
    return intensity(attack.attacker, "maimed_stinger") == nil
end)

ccb.runtime.handler("allow_stretch_attack", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
end)

ccb.runtime.handler("allow_tail_club", function(attack)
    return intensity(attack.attacker, "maimed_tail") == nil
end)

ccb.runtime.handler("allow_void_spider_bite", function(attack)
    return intensity(attack.target, "WEBBED") ~= nil
        or intensity(attack.target, "GRABBED") ~= nil
end)

ccb.runtime.handler("allow_while_grabbing", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
end)

local shock_charge = services.types.id("effect", "effect_shocker_zombie_charge_up")

ccb.runtime.handler("shocker_can_charge", function(attack)
    return (checked(services.effects.exact_intensity(attack.attacker, shock_charge)) or -1) <= 5
end)

ccb.runtime.handler("shocker_charge", function(hit)
    -- An omitted intensity increments an existing charge through the native effect rules.
    checked(services.effects.add(hit.attacker, shock_charge, services.time.duration(12, "turn")))
end)

ccb.runtime.handler("hekatonkheire_rend", function(attack)
    local attacker = attack.attacker
    local grapples = 0
    local first_grab = intensity(attacker, "grabbing") ~= nil
    if first_grab then
        grapples = 1
    end
    -- The second hold is counted twice while the first is also active.
    if intensity(attacker, "grabbing_2") ~= nil then
        grapples = grapples + (first_grab and 2 or 1)
    end
    for index = 3, 5 do
        if intensity(attacker, "grabbing_" .. index) ~= nil then
            grapples = grapples + 1
        end
    end
    checked(services.variables.set(attacker, "grappled", grapples, { include_before = false }))
    if grapples > 1 then
        checked(services.monsters.cast_spell(attacker, services.types.id("spell", "HEKATONKHEIRE_REND_AND_TEAR")))
    end
    return true
end)
