local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local id = services.types.id

local contraband_flag = id("json_flag", "CONTRABAND")
local oneirosis_vit = id("vitamin", "oneirosis_vitamin")
local eff_stim = id("effect", "stim")
local eff_depressants = id("effect", "depressants")
local eff_oneirosis = id("effect", "oneirosis")
local eff_invisibility = id("effect", "invisibility")
local turn_1 = services.time.duration(1, "turn")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function global_number(key)
    return checked(variables.get_global_number(key)).value or 0
end

local function set_global(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

local function has_effect_safe(character, eff_id, intensity)
    if not eff_id:is_valid() then return false end
    return checked(services.effects.has(character, eff_id, nil, intensity))
end

local function emit_hallucination_if_active(character)
    if not has_effect_safe(character, eff_oneirosis, 2) or character.subtype ~= "avatar" then
        return
    end
    local text = services.snippets.native_random("<oneirosis_auditory_hallucination>")
    if text and text ~= "" then
        services.messages.add(text, "warning")
    end
end

local function run_oneirosis_tick(character)
    if not character or not character:is_valid() or character.subtype == "monster" then return end
    local delta = has_effect_safe(character, eff_stim, 20) and 3 or -3
    local cur = checked(services.needs.get_vitamin(character, oneirosis_vit))
    checked(services.needs.set_vitamin(character, oneirosis_vit, math.modf(cur + delta)))
    emit_hallucination_if_active(character)
end

local function toggle_blackout(character)
    local next_val = (global_number("blackout") == 1) and 0 or 1
    set_global("blackout", next_val)
    if character and character.subtype == "avatar" then
        if next_val == 0 then
            services.messages.add(services.translate("<color_light_blue>*ding* \"Attention, residents of the local sector: Power has been RESTORED, we apologize for any inconvenience, and thank you for your understanding.\"</color>"))
        else
            services.messages.add(services.translate("<color_light_blue>*ding* \"Attention, residents of the local sector: Power grid FAILURE imminent, we apologize for any inconvenience, and thank you for your understanding.\"</color>"))
        end
    end
    checked(services.weather.refresh())
end

ccb.runtime.handler("hunvre_contraband_scanner_trigger", function(payload)
    local creature = payload.creature
    if global_number("lights_are_off") == 0
        and creature and creature:is_valid() and creature.subtype ~= "monster"
        and checked(services.inventory.has_item_flag(creature, contraband_flag)) then
        services.messages.add_if_audible(services.translate("You hear an alarm."))
        local p = payload.position
        local pos = services.coords.tripoint_abs_ms(p.x, p.y, p.z)
        services.sound.emit(pos, 25, "alarm", services.translate("\"An alarm blares from the scanner!\""))
    end
    return false
end)

ccb.runtime.handler("hunvre_toggle_blackout_use", function(context)
    toggle_blackout(context.character)
    return 0
end)

local smartphone = content.Item {
    id = "smart_phone_hunvre",
    copy_from = "smart_phone_hunvre",
}
smartphone:on_use("hunvre_toggle_blackout_use", content.text("Switch the lights"))
content.upsert(smartphone)

ccb.runtime.handler("hunvre_blackout_due", function(payload)
    local character = payload.character
    if not character or not character:is_valid() then return end
    toggle_blackout(character)
    ccb.tasks.after_character_turn(character, services.random.native_int(12 * 3600, 48 * 3600), "hunvre_blackout_due")
end)

ccb.runtime.handler("hunvre_weather_due", function(payload)
    local character = payload.character
    if not character or not character:is_valid() then return end
    local prev = global_number("current_temperature")
    local step = (services.random.native_int(0, 1) == 0) and 10 or -10
    local next_temp = math.max(-20, math.min(30, prev + step))
    set_global("current_temperature", next_temp)
    if prev ~= next_temp then
        if character.subtype == "avatar" then
            if prev > next_temp then
                services.messages.add(services.translate("<color_light_blue>*ding* \"Attention, residents of the local sector: Due to active thermal balancing you may experience a temporary DECLINE in the ambient temperature, we apologize for any inconvenience, and thank you for your understanding.\"</color>"))
            else
                services.messages.add(services.translate("<color_light_blue>*ding* \"Attention, residents of the local sector: Due to active thermal balancing you may experience a temporary RISE in the ambient temperature, we apologize for any inconvenience, and thank you for your understanding.\"</color>"))
            end
        end
        checked(services.weather.refresh())
    end
    ccb.tasks.after_character_turn(character, services.random.native_int(12 * 3600, 48 * 3600), "hunvre_weather_due")
end)

ccb.runtime.handler("hunvre_announcements_due", function() end)

ccb.runtime.handler("hunvre_storyteller_begin", function()
    set_global("blackout", 0)
    set_global("current_temperature", 10)
    run_oneirosis_tick(services.characters.avatar())
end)
ccb.runtime.on("game:game_begin", "hunvre_storyteller_begin")

ccb.runtime.handler("hunvre_oneirosis_due", function(payload)
    local character = payload.character
    if not character or not character:is_valid() then return end
    run_oneirosis_tick(character)
    ccb.tasks.after_character_turn(character, services.random.native_int(3600, 7200), "hunvre_oneirosis_due")
end)

ccb.runtime.handler("hunvre_oneirosis_hallucinations_due", function(payload)
    local character = payload.character
    if not character or not character:is_valid() then return end
    emit_hallucination_if_active(character)
    if not has_effect_safe(character, eff_oneirosis, 1) then
        ccb.tasks.after_character_turn(character, services.random.native_int(300, 3600), "hunvre_oneirosis_hallucinations_due")
    end
end)

ccb.runtime.handler("hunvre_oneirosis_sleep", function(event)
    local character = event.actors.character
    if not character or not character:is_valid() then return end
    if has_effect_safe(character, eff_oneirosis, 4) and not has_effect_safe(character, eff_depressants, 20) then
        if character.subtype == "avatar" then
            services.messages.add(services.translate("As sleep comes you feel yourself falling faster and faster, as you fall you feel a gentle warmth enveloping you, an intense feeling of happiness, your senses start to get blurrier, it goes on for infinity, then, you can't feel anything anymore."))
        end
        checked(services.characters.die(character))
    end
end)
ccb.runtime.on("game:character_falls_asleep", "hunvre_oneirosis_sleep")

ccb.runtime.handler("hunvre_ship_ready", function(event)
    local character = event.actors.character
    if not character or not character:is_valid() or character.subtype == "monster" then return end
    if not ccb.tasks.has_character_turn(character, "hunvre_blackout_due") then
        ccb.tasks.after_character_turn(character, services.random.native_int(12 * 3600, 48 * 3600), "hunvre_blackout_due")
    end
    if not ccb.tasks.has_character_turn(character, "hunvre_weather_due") then
        ccb.tasks.after_character_turn(character, services.random.native_int(12 * 3600, 48 * 3600), "hunvre_weather_due")
    end
    if not ccb.tasks.has_character_turn(character, "hunvre_oneirosis_due") then
        ccb.tasks.after_character_turn(character, services.random.native_int(3600, 7200), "hunvre_oneirosis_due")
    end
    if not has_effect_safe(character, eff_oneirosis, 1)
        and not ccb.tasks.has_character_turn(character, "hunvre_oneirosis_hallucinations_due") then
        ccb.tasks.after_character_turn(character, services.random.native_int(300, 3600), "hunvre_oneirosis_hallucinations_due")
    end
end)
ccb.runtime.on("character_ready", "hunvre_ship_ready")

ccb.runtime.handler("hunvre_euzhvil_phase", function(impact)
    local caster = impact.caster
    local target = impact.target_creature
    if not caster or not caster:is_valid() or not target or not target:is_valid() then return end
    if not eff_invisibility:is_valid() then return end
    local cpos = checked(services.creatures.snapshot(caster)).position
    local tpos = checked(services.creatures.snapshot(target)).position
    if cpos:game_distance(tpos) > 5 then
        local res = services.effects.add(caster, eff_invisibility, turn_1)
        if not res.ok and res.error.code ~= "rejected" then error(res.error.message) end
    else
        checked(services.effects.remove(caster, eff_invisibility))
    end
end)

content.add(content.Spell {
    id = "hunvre_euzhvil_phase_spell",
    name = "Euzhvil phase",
    description = "Euzhvil phase invisibility check.",
    message = "",
    sound_description = "",
    valid_targets = { "hostile" },
    shape = "blast",
    energy_source = "NONE",
    spell_class = "NONE",
    base_casting_time = 0,
    min_range = 100,
    max_range = 100,
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
}:lua_impact("hunvre_euzhvil_phase"))
