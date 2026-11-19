local ccb = require("ccb")
local services = ccb.services
local effects = services.effects
local inventory = services.inventory
local variables = services.variables
local id = services.types.id
local insight = require("insight")
local step_radius = { min_radius = 1, max_radius = 1, allow_unloaded_candidates = true }
local reach_marker = "duelist_reach_modified"

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

local function remove_duelist_reach(character, reach)
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

local function adjust_duelist_reach(character, momentum_id)
    local momentum = checked(effects.exact_intensity(character, momentum_id)) or -1
    local reach = id("json_flag", "REACH_ATTACK")
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

    remove_duelist_reach(character, reach)
end

local function lose_poise(character)
    local poise = number(character, "poise")
    if poise > 0 then set_number(character, "poise", poise - 1) end
end

local function gain_poise(character)
    if not has_flag(character, "MELEE_PERK_POISE") then return end
    local poise = number(character, "poise")
    if poise < 4 then set_number(character, "poise", poise + 1) end
end

local function add_momentum(character, momentum)
    if checked(services.mutations.has_id_text(character, "MELEE_PERK_MOMENTUM")) then
        checked(effects.add(character, momentum, services.time.duration_from_turns(2)))
    end
end

local function add_momentum_dexterity(character, bonus)
    if checked(services.mutations.has_id_text(character, "MELEE_PERK_MOMENTUM_2")) then
        checked(effects.add(character, bonus, services.time.duration_from_turns(2)))
    end
end

local function after_movement(character)
    local momentum = id("effect", "mabuff:buff_perk_momentum")
    add_momentum_dexterity(character, id("effect", "perk_dex_bonus"))
    adjust_duelist_reach(character, momentum)

    if has_flag(character, "MELEE_PERK_POISE_MOUNTAIN") then
        lose_poise(character)
    end
end

local function after_automatic_movement(character)
    add_momentum(character, id("effect", "mabuff:buff_perk_momentum"))
    after_movement(character)
    if has_flag(character, "MELEE_PERK_POISE_FOOTWORK") then
        gain_poise(character)
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

local function retreat(attacker)
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
    return attacker
end

local function retreat_on_dodge(character)
    if has_flag(character, "MELEE_PERK_MOVING_DODGE") then
        return retreat(character)
    end
    return character
end

ccb.runtime.handler("perk_retreat_on_dodge", function(combat)
    retreat_on_dodge(combat.attacker)
end)

ccb.runtime.handler("perk_style_moved", function(style)
    after_movement(style.character)
end)

ccb.runtime.handler("perk_style_dodged", function(style)
    lose_poise(retreat_on_dodge(style.character))
end)

ccb.runtime.handler("perk_style_blocked", function(style)
    gain_poise(style.character)
end)

ccb.runtime.handler("perk_style_paused", function(style)
    local character = style.character
    local momentum = id("effect", "mabuff:buff_perk_momentum")
    local dexterity_bonus = id("effect", "perk_dex_bonus")
    if has_flag(character, "MELEE_PERK_CAREFREE_STANCE") then
        checked(effects.remove(character, id("effect", "mabuff:buff_perk_tempo")))
        checked(effects.remove(character, momentum))
        checked(effects.remove(character, dexterity_bonus))
    end
    local intensity = checked(effects.exact_intensity(character, momentum)) or -1
    if intensity > 1 and has_flag(character, "MELEE_PERK_MOMENTUM_DUELIST") then
        checked(effects.remove(character, momentum))
        checked(effects.remove(character, dexterity_bonus))
        add_momentum_dexterity(character, dexterity_bonus)
        add_momentum(character, momentum)
        adjust_duelist_reach(character, momentum)
    end
    if has_flag(character, "MELEE_PERK_POISE_MOUNTAIN") then
        gain_poise(character)
    end
end)

ccb.runtime.handler("perk_style_killed", function(style)
    insight.restore_after_kill(style.character)
    if has_flag(style.character, "MELEE_PERK_TEMPO_ZONING") then
        local character = retreat(style.character)
        checked(effects.remove(character, id("effect", "mabuff:buff_perk_tempo")))
    end
end)

ccb.runtime.handler("perk_momentum_ended", function(event)
    if event.data.effect ~= "mabuff:buff_perk_momentum" then return end
    local character = event.actors.character or services.characters.avatar()
    if character:is_valid() then
        remove_duelist_reach(character, id("json_flag", "REACH_ATTACK"))
    end
end)
ccb.runtime.on("game:character_loses_effect", "perk_momentum_ended")

ccb.runtime.handler("perk_tempo_assault", function(event)
    local attacker = event.actors.speaker
    local victim = event.participants.interlocutor
    if not attacker or not victim or not attacker:is_valid() then return end
    if event.type == "character_melee_attacks_character" and (not event.data.hits or not victim.dead) then
        return
    end
    if not has_flag(attacker, "MELEE_PERK_TEMPO_ASSAULT")
        or position(attacker):game_distance(victim.position) > 1 then
        return
    end

    attacker = teleport(attacker, victim.position)
    after_automatic_movement(attacker)
    local mark = "assault_attacked"
    for _, monster in ipairs(services.monsters.seeing_position(position(attacker), 1)) do
        if monster:is_valid() and number(monster, mark) ~= 1 then
            -- The follow-up is an Avatar attack, even when another character triggered the event.
            local avatar = services.characters.avatar()
            if avatar:is_valid() then
                local choice = checked(services.characters.choose_technique(avatar, monster))
                checked(services.characters.attack(avatar, monster, choice.technique.value))
            end
            if monster:is_valid() then
                set_number(monster, mark, 1)
            end
        end
    end
    if attacker:is_valid() then
        set_number(attacker, mark, 0)
    end
end)
ccb.runtime.on("game:character_kills_monster", "perk_tempo_assault")
ccb.runtime.on("game:character_melee_attacks_character", "perk_tempo_assault")
