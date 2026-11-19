local ccb = require("ccb")
local services = ccb.services
local effects = services.effects
local inventory = services.inventory
local variables = services.variables
local id = services.types.id
local step_radius = { min_radius = 1, max_radius = 1, allow_unloaded_candidates = true }

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function position(creature)
    return checked(services.creatures.snapshot(creature)).position
end

local function has_flag(actor, flag)
    return checked(services.creatures.has_flag_text(actor, flag))
end

local function number(owner, name)
    return checked(variables.get_number(owner, name)).value or 0
end

local function set_number(owner, name, value)
    checked(variables.set(owner, name, value, { include_before = false }))
end

local function hostile_monsters_nearby(origin)
    return checked(services.monsters.count_nearby(origin, nil, { radius = 1 }))
end

local function teleport(character, destination)
    return checked(services.relocation.teleport_character(character, destination)).handle
end

local function adjust_duelist_reach(character, momentum_id)
    local momentum = checked(effects.exact_intensity(character, momentum_id)) or -1
    local reach = id("json_flag", "REACH_ATTACK")
    local reach_marker = "duelist_reach_modified"
    if momentum <= 1 and has_flag(character, "MELEE_PERK_DUELIST_LUNGE")
        and (checked(inventory.wielded_matches(character, id("weapon_category", "LONG_THRUSTING_SWORDS")))
            or checked(inventory.wielded_matches(character, id("weapon_category", "FENCING_WEAPONRY")))) then
        -- The original 0.05-turn cost truncates to zero in time_duration.
        local weapon = checked(inventory.wielded(character))
        if not checked(services.items.has_flag(weapon, reach)) then
            checked(services.items.set_flag(weapon, reach, true))
            set_number(weapon, reach_marker, 1)
        end
        return
    end

    local weapon = checked(inventory.wielded(character))
    local weapon_uid = weapon and weapon.locator.stable_id
    for _, item in ipairs(checked(inventory.carried_items(character))) do
        -- The original removal selected the wielded item and any marked carried item.
        if item.locator.stable_id == weapon_uid or number(item, reach_marker) == 1 then
            checked(services.items.set_flag(item, reach, false))
            set_number(item, reach_marker, 0)
        end
    end
end

local function after_automatic_movement(character)
    local momentum = id("effect", "mabuff:buff_perk_momentum")
    local duration = services.time.duration_from_turns(2)
    if checked(services.mutations.has_id_text(character, "MELEE_PERK_MOMENTUM")) then
        checked(effects.add(character, momentum, duration))
    end
    if checked(services.mutations.has_id_text(character, "MELEE_PERK_MOMENTUM_2")) then
        checked(effects.add(character, id("effect", "perk_dex_bonus"), duration))
    end
    adjust_duelist_reach(character, momentum)

    if has_flag(character, "MELEE_PERK_POISE_MOUNTAIN") then
        local poise = number(character, "poise")
        if poise > 0 then set_number(character, "poise", poise - 1) end
    end
    if has_flag(character, "MELEE_PERK_POISE_FOOTWORK") and has_flag(character, "MELEE_PERK_POISE") then
        local poise = number(character, "poise")
        if poise < 4 then set_number(character, "poise", poise + 1) end
    end
end

ccb.runtime.handler("perk_duelist_lunge", function(combat)
    local attacker = combat.attacker
    local target = combat.target
    -- An empty location in the previous loop's context resolved to the absolute origin.
    local attempt = services.coords.tripoint_abs_ms(0, 0, 0)
    for _ = 1, 20 do
        if number(attacker, "done_step_closer") == 1 then break end

        local original = position(attacker)
        attempt = services.world.find_location(position(target), nil, step_radius).position or attempt
        attacker = teleport(attacker, attempt)
        if original:game_distance(attempt) > 1 then
            attacker = teleport(attacker, original)
        else
            after_automatic_movement(attacker)
            set_number(attacker, "done_step_closer", 1)
        end
    end
    set_number(attacker, "done_step_closer", 0)
end)

ccb.runtime.handler("perk_retreat_on_dodge", function(combat)
    local attacker = combat.attacker
    if not has_flag(attacker, "MELEE_PERK_MOVING_DODGE") then return end

    local attempt = services.coords.tripoint_abs_ms(0, 0, 0)
    for _ = 1, 10 do
        local original = position(attacker)
        if hostile_monsters_nearby(original) == 0 then break end

        attempt = services.world.find_location(original, nil, step_radius).position or attempt
        attacker = teleport(attacker, attempt)
        if hostile_monsters_nearby(position(attacker)) == 0 then
            after_automatic_movement(attacker)
        else
            attacker = teleport(attacker, original)
        end
    end
end)
