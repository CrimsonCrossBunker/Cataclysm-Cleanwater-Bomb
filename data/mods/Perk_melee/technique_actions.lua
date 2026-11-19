local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function position(creature)
    return checked(services.creatures.snapshot(creature)).position
end

local function hostile_monsters_nearby(creature, radius)
    return checked(services.monsters.count_nearby(position(creature), nil, { radius = radius }))
end

ccb.runtime.handler("allow_perk_execution", function(combat)
    local damage = checked(services.variables.get_number(combat.attacker, "perk_mymelee")).value or 0
    local target = combat.target
    local hp
    if target.subtype == "monster" then
        hp = checked(services.creatures.snapshot(target)).hp
    else
        hp = checked(services.characters.hp(target, id("body_part", "torso")))
    end
    return damage >= hp and hostile_monsters_nearby(combat.attacker, 2) < 2
        and combat.attacker_size + 1 >= combat.target_size
end)

ccb.runtime.handler("allow_perk_make_way", function(combat)
    return hostile_monsters_nearby(combat.attacker, 1) > 1
end)

ccb.runtime.handler("allow_perk_shoulder_tackle", function(combat)
    if combat.attacker_size + 1 < combat.target_size then return false end
    local momentum = checked(services.effects.exact_intensity(combat.attacker, id("effect", "mabuff:buff_perk_momentum")))
    if momentum == nil or momentum <= 2 then return false end
    local creatures = services.creatures
    local target = combat.target
    return checked(services.effects.exact_intensity(target, id("effect", "downed"))) == nil
        and (checked(creatures.has_body_type(target, "human")) or checked(creatures.has_body_type(target, "angel")))
        and (not checked(creatures.has_flag_text(target, "FLIES")) or checked(creatures.has_flag_text(target, "DISABLE_FLIGHT")))
end)

ccb.runtime.handler("allow_perk_poise_parry", function(combat)
    return checked(services.variables.get_number(combat.attacker, "poise")).value == 4
end)

ccb.runtime.handler("perk_execution_applied", function(combat)
    local attacker = combat.attacker
    local stamina = checked(services.needs.get(attacker)).stamina
    checked(services.needs.set(attacker, { stamina = stamina + 1200 }))
    if not checked(services.creatures.has_flag_text(attacker, "MELEE_PERK_BRUTALITY")) then
        return
    end

    local observers = services.monsters.seeing_position(position(attacker), 60)
    local stunned = id("effect", "stunned")
    local duration = services.time.duration_from_turns(2)
    for _, monster in ipairs(observers) do
        if checked(services.creatures.has_flag_text(monster, "HAS_MIND"))
            or checked(services.creatures.has_flag_text(monster, "HUMAN")) then
            checked(services.effects.add(monster, stunned, duration))
        end
    end
end)

ccb.runtime.handler("perk_clear_momentum", function(combat)
    local attacker = combat.attacker
    checked(services.effects.remove(attacker, id("effect", "mabuff:buff_perk_momentum")))
    checked(services.effects.remove(attacker, id("effect", "perk_dex_bonus")))
end)

ccb.runtime.handler("perk_make_way_applied", function(combat)
    checked(services.characters.cast_spell(combat.attacker, id("spell", "make_way_push")))
end)

ccb.runtime.handler("perk_stagger_attacker", function(combat)
    checked(services.effects.add(combat.target, id("effect", "staggered"), services.time.duration_from_turns(2)))
end)
