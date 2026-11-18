local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local effects = services.effects
local id = services.types.id
local duration = services.time.duration

local tesseract_id = "iso_eldritch_stun_blind_deaf"
local umbral_id = "iso_eldritch_invisibile_and_intangible"
local scales_id = "iso_eldritch_damage_shield"
local umbral = id("effect", "effect_iso_eldritch_invisibile_and_intangible")
local incorporeal = id("effect", "incorporeal")
local scales = id("effect", "effect_iso_eldritch_damage_shield")
local scales_counter = "iso_eldritch_damage_shield_counter"
local destruction = id("effect", "effect_iso_eldritch_mass_aoe_zombie_destruction")
local destruction_preventer = id("effect", "effect_iso_eldritch_mass_aoe_zombie_destruction_preventer")
local whole_body = id("body_part", "bp_null")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function is_character(actor)
    return actor ~= nil and (actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character")
end

local function spell_level(actor, spell)
    if not is_character(actor) then return 0 end
    return checked(services.spells.effective_level(actor, spell))
end

local function add_effect(actor, effect, length, options)
    local result = effects.add(actor, effect, length, options)
    if not result.ok and result.error.code ~= "rejected" then error(result.error.message) end
end

local function has_effect(actor, effect, minimum)
    return actor ~= nil and checked(effects.has(actor, effect, whole_body, minimum))
end

local function scaled_duration(spell, spell_id, minimum, maximum)
    local function register_bound(stat, bounds)
        local name = spell_id .. "_" .. stat
        ccb.runtime.handler(name, function(payload)
            return spell_level(payload.speaker, spell_id) * bounds[1] + bounds[2]
        end)
        spell:dynamic_stat(stat, name)
    end
    register_bound("min_duration", minimum)
    register_bound("max_duration", maximum)
end

local function toggle_cost(spell, spell_id, active_effect, energy, casting_time)
    local energy_handler = spell_id .. "_energy"
    local casting_handler = spell_id .. "_casting_time"
    ccb.runtime.handler(energy_handler, function(payload)
        return has_effect(payload.speaker, active_effect, 0) and 0 or energy
    end)
    ccb.runtime.handler(casting_handler, function(payload)
        return has_effect(payload.speaker, active_effect, 0) and 10 or casting_time
    end)
    spell:dynamic_stat("base_energy_cost", energy_handler):dynamic_stat("final_energy_cost", energy_handler)
    spell:dynamic_stat("base_casting_time", casting_handler):dynamic_stat("final_casting_time", casting_handler)
end

local tesseract_effects = { id("effect", "blind"), id("effect", "deaf"), id("effect", "stunned") }
ccb.runtime.handler("iso_tesseract_impact", function(impact)
    local target = impact.target_creature
    local level = spell_level(target, tesseract_id)
    local turns = services.random.native_float(level * 1.50 + 3.00, level * 3.75 + 9.00)
    local length = duration(math.modf(turns), "turn")
    for _, effect in ipairs(tesseract_effects) do
        add_effect(target, effect, length)
    end
end)

do
    local spell = content.Spell {
        id = tesseract_id,
        name = ccb.content.text("Inescapable Tesseract of Thought"),
        description = ccb.content.text("Lock the target's mind away from its senses, leaving it incapable of perceiving the outside world in any way."),
        message = content.text("You cast %s!"),
        sound_description = content.text("an explosion."),
        valid_targets = { "hostile" },
        flags = { "ENERVATION_SPELL", "RANDOM_DAMAGE", "VERBAL", "SOMATIC", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
        spell_class = "iso_eldritch_sorcery",
        magic_type = "iso_eldritch_sorcery",
        difficulty = 1,
        max_level = 30,
        shape = "blast",
        min_duration = 300,
        max_duration = 900,
        min_range = 4,
        range_increment = 0.33,
        max_range = 20,
        base_energy_cost = 150,
        base_casting_time = 125,
    }
    scaled_duration(spell, tesseract_id, { 150, 300 }, { 375, 900 })
    content.add(spell:lua_impact("iso_tesseract_impact"))
end

ccb.runtime.handler("iso_umbral_cast_in_darkness", function(payload)
    local caster = payload.speaker
    return is_character(caster) and checked(services.characters.snapshot(caster)).senses.fine_detail_vision_legacy >= 3
end)

ccb.runtime.handler("iso_umbral_impact", function(impact)
    local target = impact.target_creature
    if has_effect(target, umbral, -1) then
        checked(effects.remove(target, incorporeal))
        checked(effects.remove(target, umbral))
        return
    end
    local level = spell_level(target, umbral_id)
    local turns = services.random.native_float(level * 9.11 + 28.51, level * 21.53 + 84.35)
    if target.subtype == "avatar" then
        local message = ccb.services.translate("Duration is <context_val:buff_duration>.")
        services.messages.add(checked(services.text.expand_for(message, target, impact.caster, nil,
            { buff_duration = turns })), "debug")
    end
    local length = duration(math.modf(turns), "turn")
    add_effect(target, umbral, length)
    add_effect(target, incorporeal, length)
end)

do
    local spell = content.Spell {
        id = umbral_id,
        name = ccb.content.text("The Umbral Transfiguration"),
        description = ccb.content.text("Turn yourself into a living shadow, becoming intangible and imperceptible, allowing you slip past enemies with ease.  However, you cannot cast it in areas of bright light."),
        message = content.text("You cast %s!"),
        sound_description = content.text("an explosion."),
        valid_targets = { "self" },
        flags = { "TRANSFORMATION_SPELL", "VERBAL", "SOMATIC", "NO_LEGS" },
        spell_class = "iso_eldritch_sorcery",
        magic_type = "iso_eldritch_sorcery",
        difficulty = 5,
        max_level = 30,
        shape = "blast",
        min_duration = 2851,
        max_duration = 8435,
        base_energy_cost = 450,
        base_casting_time = 500,
    }
    scaled_duration(spell, umbral_id, { 911, 2851 }, { 2153, 8435 })
    toggle_cost(spell, umbral_id, umbral, 450, 500)
    spell:caster_when("iso_umbral_cast_in_darkness", "")
    content.add(spell:lua_impact("iso_umbral_impact"))
end

ccb.runtime.handler("iso_scales_impact", function(impact)
    local target = impact.target_creature
    if has_effect(target, scales, -1) then
        checked(effects.remove(target, scales))
        return
    end
    checked(services.variables.set(target, scales_counter, 0, { include_before = false }))
    add_effect(target, scales, duration(1, "turn"), { permanent = true })
end)

do
    local spell = content.Spell {
        id = scales_id,
        name = ccb.content.text("Impenetrable Coruscating Scales of Vishkan"),
        description = ccb.content.text("Summon the power of an elder wyrm, creating a shell of impenetrable dragon scales around your body.  The scales will withstand a number of blows before the enchant collapse, though their lambent glow will give away your position in the dark.  The enchantment will last several blows before collapsing, and may be canceled at any time."),
        message = content.text("You cast %s!"),
        sound_description = content.text("an explosion."),
        valid_targets = { "self" },
        flags = { "ENHANCEMENT_SPELL", "VERBAL", "SOMATIC", "NO_LEGS" },
        spell_class = "iso_eldritch_sorcery",
        magic_type = "iso_eldritch_sorcery",
        difficulty = 6,
        max_level = 30,
        shape = "blast",
        base_energy_cost = 500,
        base_casting_time = 350,
    }
    toggle_cost(spell, scales_id, scales, 500, 350)
    content.add(spell:lua_impact("iso_scales_impact"))
end

local function event_actor(event, field)
    local speaker = event.participants.speaker
    if speaker then
        return not speaker.dead and event.actors.speaker or nil
    end
    if event.actors.speaker then return nil end
    return event.actors[field] or services.characters.avatar()
end

local function interrupt_destruction(actor)
    if has_effect(actor, destruction, -1) then checked(effects.remove(actor, destruction)) end
end

ccb.runtime.handler("iso_sorcery_on_ranged_attack", function(event)
    interrupt_destruction(event_actor(event, "attacker"))
end)
ccb.runtime.on("game:character_ranged_attacks_monster", "iso_sorcery_on_ranged_attack")

ccb.runtime.handler("iso_sorcery_on_move", function(event)
    interrupt_destruction(event_actor(event, "avatar_id"))
end)
ccb.runtime.on("game:avatar_moves", "iso_sorcery_on_move")

ccb.runtime.handler("iso_sorcery_on_cast", function(event)
    local actor = event_actor(event, "character")
    if has_effect(actor, destruction, -1) and not has_effect(actor, destruction_preventer, -1) then
        checked(effects.remove(actor, destruction))
    end
end)
ccb.runtime.on("game:spellcasting_finish", "iso_sorcery_on_cast")
