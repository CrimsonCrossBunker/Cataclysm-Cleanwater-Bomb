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

local function species(creature, name)
    local id = services.types.id("species", name)
    return id:is_valid() and checked(services.creatures.has_species(creature, id))
end

local function intensity(creature, name, body_part)
    local part = body_part and services.types.id("body_part", body_part)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name), part))
end

ccb.runtime.handler("allow_hollow_hunter_hollow_one_weapon_knife", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("allow_jabberwock_bite_jabberwock_1", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
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

ccb.runtime.handler("allow_skeleton_animated_scratch", function(attack)
    return not (intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil)
end)

ccb.runtime.handler("allow_transcendant_alpha_psion_psi_transcendant_alpha_heightened_reflexes", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
        and intensity(attack.attacker, "effect_monster_heightened_reflex_enhanced") == nil
end)

ccb.runtime.handler("allow_treant_crush", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("monster_attack_armed", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)

ccb.runtime.handler("monster_attack_psionics_available", function(attack)
    return not flag(attack.attacker, "NO_PSIONICS")
end)
