local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local runtime = ccb.runtime

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function event_character(event)
    return event.actors.speaker or event.actors.character or event.actors.killer or services.characters.avatar()
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_effect(creature, effect)
    return checked(services.effects.has(creature, id("effect", effect), id("body_part", "bp_null"), -1))
end

local function apply(creature, effect, turns, options)
    local result = services.effects.add(creature, id("effect", effect), services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local function remove(creature, effect)
    checked(services.effects.remove(creature, id("effect", effect)))
end

local function add_insight(character, amount)
    local insight = id("vitamin", "xedra_chronomancer_insight")
    local old = checked(services.needs.get_vitamin(character, insight))
    local total = math.modf(old + amount)
    checked(services.needs.set_vitamin(character, insight, total))
end

local function show_insight(character)
    return character.subtype == "avatar"
        and checked(services.variables.get_global_number("global_xedra_chronomancy_setting_hide_insight_messages")).value ~= 1
end

local time_enemies = {
    mon_tindalos = 50, mon_zombie_monochrome_3 = 50, mon_lieutenant_shadow = 50,
    mon_hound_tindalos = 10, mon_zombie_monochrome_2 = 10, mon_skeleton_master = 10, mon_boomer_monochrome = 10,
    mon_zombie_monochrome = 5, mon_zombie_master = 5, mon_zombie_necro_boomer = 5, mon_xe_unicorn = 5, mon_xe_unicorn_foal = 5,
}

runtime.handler("gain_chronomantic_insight_on_kill", function(event)
    local character = event_character(event)
    if has_trait(character, "VAMPIRE") then return end
    local amount = time_enemies[event.data.victim_type]
    if amount and has_trait(character, "XEDRA_CHRONOMANCER") then
        add_insight(character, amount)
        if show_insight(character) then
            local message
            if amount == 50 then message = ccb.services.translate("You gain a large amount of insight into the workings of time!")
            elseif amount == 10 then message = ccb.services.translate("You gain a medium amount of insight into the workings of time.")
            else message = ccb.services.translate("You gain a small amount of insight into the workings of time.") end
            services.messages.add(message, "info")
        end
    end
    if has_effect(character, "effect_chronomancy_field") then
        add_insight(character, 1)
        if show_insight(character) then
            services.messages.add(ccb.services.translate("You gain a tiny amount of insight into the workings of time."), "info")
        end
    end
end)
runtime.on("game:character_kills_monster", "gain_chronomantic_insight_on_kill")

runtime.handler("maintain_chronomantic_field", function(event)
    if event.data.school == "XEDRA_CHRONOMANCER" then
        local difficulty = event.data.difficulty
        apply(event_character(event), "effect_chronomancy_field", difficulty * 8,
            { intensity = math.modf(difficulty * 1.5) })
    end
end)
runtime.on("game:spellcasting_finish", "maintain_chronomantic_field")

runtime.handler("learn_chronomantic_location_anchor", function(event)
    if event.data.spell == "xedra_chronomancer_revert_location" then
        checked(services.spells.set_level(event_character(event), id("spell", "xedra_chronomancer_revert_location_attune"), 1))
    end
end)
runtime.on("game:character_learns_spell", "learn_chronomantic_location_anchor")

local function is_character(speaker)
    return speaker and (speaker.subtype == "avatar" or speaker.subtype == "npc")
end

local function intelligence(speaker)
    if not is_character(speaker) then return 0 end
    return checked(services.characters.snapshot(speaker, 0)).stats.intelligence
end

local function level(speaker, spell)
    if not is_character(speaker) then return 0 end
    return checked(services.spells.effective_level(speaker, spell))
end

runtime.handler("chronomancy_level_limit", function(context)
    return 2 * intelligence(context.speaker)
end)

local function scaled(speaker, spell, multiplier)
    return level(speaker, spell) * multiplier * runtime.call_number("attribute_scaling", intelligence(speaker))
end

runtime.handler("chronomantic_paradox_power", function(context)
    return scaled(context.speaker, "xedra_chronomancer_paradox", 25)
end)
runtime.handler("chronomantic_paradox_range", function(context)
    return math.min(scaled(context.speaker, "xedra_chronomancer_paradox", 1), 20)
end)
runtime.handler("chronomantic_paradox_target", function(context)
    local target = context.interlocutor
    return target ~= nil and not checked(services.creatures.has_flag_text(target, "DIMENSIONAL_ANCHOR"))
        and not checked(services.creatures.has_flag_text(target, "STABILIZED_TIMELINE"))
end)
runtime.handler("observe_chronomantic_paradox", function(impact)
    local target, caster = impact.target_creature, impact.caster
    if not target or not is_character(caster) then return end
    local gain = checked(services.creatures.snapshot(target)).hp / 6
    add_insight(caster, gain)
    if show_insight(caster) then
        local text = ccb.services.translate("Observing this paradox gave you <context_val:insight_gain> Insight into time")
        services.messages.add(checked(services.text.expand_for(text, target, caster, nil, { insight_gain = gain })), "info")
    end
end)

local entropy_spell = "xedra_chronomancer_reverse_entropy"
local toggles = {
    [entropy_spell] = "effect_xedra_chronomancer_reverse_entropy",
    xedra_chronomancer_stable_loop = "effect_xedra_chronomancer_stable_timeloop",
    xedra_chronomancer_chronal_acceleration = "effect_xedra_chronomancer_chronal_accel",
    xedra_chronomancer_destabilizing_strikes = "effect_xedra_chronomancer_destabilizing_strikes",
    xedra_chronomancer_stabilize_timeline = "effect_xedra_chronomancer_stabilize_timeline",
}

local function recharge_inventory(character, strength)
    local batteries = {}
    for _, item in ipairs(checked(services.inventory.carried_items(character))) do
        if checked(services.items.snapshot(item, 0)).resources.chargeable then batteries[#batteries + 1] = item end
    end
    -- Native battery quantities are nonnegative integers and clamp the result at zero.
    local charges = math.floor(strength)
    for _, item in ipairs(batteries) do
        if item:is_valid() then checked(services.items.modify_battery_charges(item, charges)) end
    end
end

local function repair_inventory(character, strength, burn_repair)
    for _, item in ipairs(checked(services.inventory.carried_items(character))) do
        local snapshot = checked(services.items.snapshot(item, 0))
        local condition = snapshot.condition
        local hp = condition.max_damage - condition.damage
        local wanted = condition.max_damage - math.modf(hp + strength)
        local updates = { damage = math.max(0, math.min(wanted, condition.max_damage)) }
        if snapshot.goes_bad and snapshot.relative_rot >= 0 then
            local minutes = math.max(0, snapshot.rot.turns) / 60
            local turns = math.modf((minutes - math.min(minutes, strength)) * 60)
            updates.rot = services.time.duration_from_turns(turns)
        end
        if condition.burnt_percent ~= nil and condition.burnt > 0 then
            updates.burnt = math.modf(condition.burnt - math.max(1, math.min(condition.burnt, burn_repair)))
        end
        checked(services.items.update(item, updates))
    end
end

local function entropy_pulse(character)
    if not has_effect(character, toggles[entropy_spell]) then return end
    local scale = runtime.call_number("attribute_scaling", intelligence(character))
    local spell_level = level(character, entropy_spell)
    local interval = math.max((60 - spell_level * 2) * scale, 1)
    ccb.tasks.after_character_turn(character, math.modf(interval), "renew_reversed_entropy")
    local strength = (spell_level * 0.1 + 1) * scale
    recharge_inventory(character, strength)
    repair_inventory(character, strength, strength)
end
runtime.handler("renew_reversed_entropy", function(task) entropy_pulse(task.character) end)

runtime.handler("toggle_chronomantic_field", function(impact)
    local target = impact.target_creature
    if not target then return end
    local effect = toggles[impact.spell.value]
    if has_effect(target, effect) then
        remove(target, effect)
    else
        apply(target, effect, 1, { permanent = true })
        if impact.spell.value == entropy_spell and is_character(target) then entropy_pulse(target) end
    end
end)
runtime.handler("chronomantic_toggle_cost", function(context)
    local speaker, spell = context.speaker, context.spell.value
    if speaker and has_effect(speaker, toggles[spell]) then return 0 end
    local spell_level = level(speaker, spell)
    if context.stat == "base_casting_time" then return math.max(200 - 5 * spell_level, 50) end
    if spell == "xedra_chronomancer_stabilize_timeline" then return math.max(500 - 12.5 * spell_level, 125) end
    return math.max(1000 - 25 * spell_level, 250)
end)

runtime.handler("destabilizing_strike_damage", function(context)
    return scaled(context.speaker, "xedra_chronomancer_destabilizing_strikes", 0.2)
end)
runtime.handler("destabilizing_strike_duration", function(context)
    return scaled(context.speaker, "xedra_chronomancer_destabilizing_strikes", 100)
end)

runtime.handler("cement_chronomantic_effects", function(impact)
    local target = impact.target_creature
    if not target then return end
    for _, effect in ipairs({ "effect_xedra_time_freeze", "effect_xedra_chronomancer_stable_timeloop" }) do
        if has_effect(target, effect) then
            remove(target, effect)
            apply(target, effect, 1, { permanent = true })
        end
    end
end)

runtime.handler("chronomantic_meditation_cast_time", function(context)
    return math.max(200 - 5 * level(context.speaker, context.spell.value), 50)
end)

local function register_meditation(subject)
    local wound = subject == "wound"
    local spell_name = "xedra_chronomancer_rewrite_" .. subject .. "_causality"
    local effect = "effect_xedra_rewrite_" .. subject .. "_causality"
    local spell = id("spell", spell_name)
    local mana_handler = "sustain_chronomantic_" .. subject
    local xp_handler = "practice_chronomantic_" .. subject
    local repair_handler = "restore_chronomantic_equipment"

    local function delay(character, handler)
        local current = level(character, spell_name)
        local turns = handler == mana_handler and 180 + 12 * current or 900 - 12 * current
        ccb.tasks.after_character_turn(character, turns, handler)
    end

    runtime.handler("begin_chronomantic_" .. subject, function(impact)
        local character = impact.target_creature
        if not is_character(character) then return end
        local assigned = services.activities.assign_timed(character, id("activity", "ACT_XEDRA_CHRONOMANCER_MEDITATE"),
            services.time.duration(200, "day"))
        if not assigned.ok and assigned.error.code ~= "assignment_rejected" then checked(assigned) end
        apply(character, effect, 1, { permanent = true })
        if not wound then delay(character, repair_handler) end
        delay(character, mana_handler)
        delay(character, xp_handler)
    end)

    runtime.handler(mana_handler, function(task)
        local character = task.character
        if has_effect(character, effect) then
            local mana = checked(services.spells.mana(character)).current
            if mana >= 20 then
                local body = wound and checked(services.creatures.snapshot(character))
                if not wound or body.hp < body.hp_max then
                    checked(services.spells.set_mana_raw(character, mana - 20))
                    delay(character, mana_handler)
                    return
                end
            end
        end
        checked(services.activities.cancel(character))
    end)

    runtime.handler(xp_handler, function(task)
        local character = task.character
        if not has_effect(character, effect) then return end
        local known = services.spells.get(character, spell)
        local experience = not known.ok and known.error.code == "not_known" and -1 or checked(known).experience
        local current = level(character, spell_name)
        local delta = services.spells.experience_for_level(spell, current + 1) - services.spells.experience_for_level(spell, current)
        checked(services.spells.set_experience(character, spell, math.modf(experience + delta / 20), true))
        delay(character, xp_handler)
    end)

    if not wound then
        runtime.handler(repair_handler, function(task)
            local character = task.character
            if not has_effect(character, effect) then return end
            local strength = scaled(character, spell_name, 10)
            -- Burn damage uses Reverse Entropy mastery even during equipment meditation.
            repair_inventory(character, strength, scaled(character, entropy_spell, 10))
            for _, item in ipairs(checked(services.inventory.carried_items(character))) do
                local condition = checked(services.items.snapshot(item, 0)).condition
                local degradation = math.max(0, math.min(condition.max_damage, math.modf(condition.degradation - strength)))
                checked(services.items.update(item, { degradation = degradation }))
            end
            recharge_inventory(character, strength)
            delay(character, repair_handler)
        end)
    end
end

register_meditation("wound")
register_meditation("equipment")

runtime.handler("open_chronomancer_insight_menu", function(context)
    local character = context.character
    local insight = checked(services.needs.get_vitamin(character, id("vitamin", "xedra_chronomancer_insight")))
    checked(services.variables.set(character, "xedra_chronomancer_insight_count", insight, { include_before = false }))
    checked(services.characters.open_topic(character, id("talk_topic", "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN")))
end)
