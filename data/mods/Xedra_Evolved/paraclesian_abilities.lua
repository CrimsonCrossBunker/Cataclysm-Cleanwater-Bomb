local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local effects = services.effects
local spells = services.spells
local needs = services.needs
local env = services.gameplay.environment

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function player_message(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(services.translate(text), tone)
    end
end

local function has_trait(character, trait_name)
    return value(mutations.has_id_text(character, trait_name))
end

local function has_effect(character, effect_name)
    return value(effects.has(character, id("effect", effect_name)))
end

local function add_effect(character, effect_name, turns, options)
    value(effects.add(character, id("effect", effect_name),
        services.time.duration_from_turns(turns), options))
end

local function add_permanent_effect(character, effect_name)
    add_effect(character, effect_name, 1, { permanent = true })
end

local function remove_effect(character, effect_name)
    value(effects.remove(character, id("effect", effect_name)))
end

local function deactivate_trait(character, trait_name)
    value(mutations.invoke_activation(character, id("mutation", trait_name), false))
end

local function read_number(character, key)
    return value(services.variables.get_number(character, key)).value or 0
end

local function set_number(character, key, amount)
    value(services.variables.set(character, key, amount, { include_before = false }))
end

local function cast_generic_spell_mutation(character, spell_id, prep_time, message_success, message_fail, energy_amount)
    local cost = energy_amount or 0
    local stamina = value(needs.get(character)).stamina
    if stamina <= cost then
        if message_fail ~= "" then
            player_message(character, message_fail, "bad")
        end
        return
    end
    if prep_time > 0 then
        value(services.characters.adjust(character, { moves = -math.modf(prep_time * 100) }))
    end
    if cost > 0 then
        value(needs.set(character, { stamina = stamina - cost }))
    end
    local options = { targeted = true }
    if message_success ~= "" then
        options.message = services.translate(message_success)
    end
    value(services.characters.cast_spell(character, id("spell", spell_id), options))
end

-- Paraclesian Fae Sight
ccb.runtime.handler("paraclesian_fae_sight_on", function(context)
    add_permanent_effect(context.character, "effect_paraclesian_see_fae")
end)

ccb.runtime.handler("paraclesian_fae_sight_process", function(context)
    local character = context.character
    local mana = value(spells.mana(character)).current
    if mana >= 1 then
        if services.random.native_probability(1, 8) then
            value(spells.set_mana_raw(character, mana - 1))
        end
    else
        player_message(character, "You do not have enough mana to fuel your fae sight!", "bad")
        remove_effect(character, "effect_paraclesian_see_fae")
    end
end)

ccb.runtime.handler("paraclesian_fae_sight_off", function(context)
    remove_effect(context.character, "effect_paraclesian_see_fae")
end)

-- Sylph abilities
local sylph_jump_heights = { ["2"] = 2, ["4"] = 4, ["6"] = 6 }

ccb.runtime.handler("sylph_jump_high", function(context)
    local character = context.character
    local choice = ccb.presentation.choose("", {
        {
            id = "2",
            label = services.translate("Leap two stories up"),
            description = services.translate("Leap straight up two stories."),
        },
        {
            id = "4",
            label = services.translate("Leap four stories up"),
            description = services.translate("Leap straight up four stories."),
        },
        {
            id = "6",
            label = services.translate("Leap six stories up"),
            description = services.translate("Leap straight up six stories."),
        },
        {
            id = "cancel",
            label = services.translate("Cancel"),
            description = services.translate("Do nothing."),
        },
    })
    local delta = choice and sylph_jump_heights[choice]
    if not delta then
        return
    end
    local snap = value(services.creatures.snapshot(character))
    if snap.outside and (delta ~= 6 or has_trait(character, "THRESH_SYLPH")) then
        add_effect(character, "effect_sylph_levitation", 5)
        local target = services.coords.tripoint_abs_ms(snap.position.x, snap.position.y, snap.position.z + delta)
        local found = services.world.find_location(target, nil, { outdoor_only = true })
        player_message(character, "With a burst of wind, you leap into the air.", "good")
        if found.found and found.position then
            value(services.relocation.teleport_character(character, found.position))
        end
    else
        player_message(character, "You cannot jump with a ceiling above you!", "bad")
    end
end)

ccb.runtime.handler("sylph_lightning_melee_on", function(context)
    local character = context.character
    value(mutations.replace(character, id("mutation", "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE")))
    player_message(character, "Lightning sparks from you hands.", "good")
end)

ccb.runtime.handler("sylph_lightning_melee_process", function(context)
    local character = context.character
    if value(spells.mana(character)).current < 10 then
        player_message(character, "You do not have enough mana to maintain your fulgurating strikes!", "bad")
        value(mutations.erase(character, id("mutation", "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE")))
        ccb.tasks.after_character_turn(character, 0, "sylph_lightning_melee_deactivate")
    end
end)

ccb.runtime.handler("sylph_lightning_melee_off", function(context)
    value(mutations.erase(context.character, id("mutation", "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE")))
end)

ccb.runtime.handler("sylph_lightning_melee_deactivate", function(context)
    deactivate_trait(context.character, "SYLPH_LIGHTNING_MELEE_ATTACKS")
end)

-- Salamander abilities
local burning_limbs = { "torso", "head", "arm_l", "arm_r", "leg_r", "leg_l" }

ccb.runtime.handler("salamander_fire_footsteps", function(context)
    local character = context.character
    add_effect(character, "effect_hidden_flame_immunity", 1)
    env.add_field_area(value(services.creatures.snapshot(character)).position, "fd_fire", {
        radius = 0,
        hit_player = false,
    })
end)

ccb.runtime.handler("salamander_health_for_mana", function(context)
    local character = context.character
    local mana = value(spells.mana(character))
    if mana.current < mana.maximum then
        value(spells.set_mana_raw(character, math.min(mana.current + 1000, mana.maximum)))
        for _, part in ipairs(burning_limbs) do
            add_effect(character, "effect_salamander_burning_damage", 30, { body_part = id("body_part", part) })
        end
    else
        player_message(character, "You have no need to restore your mana now!", "mixed")
    end
end)

ccb.runtime.handler("salamander_cooking_heat_toggle", function(context)
    local character = context.character
    local heat_item = id("item", "item_salamander_cooking_heat")
    if not value(services.inventory.has_type(character, heat_item)) then
        value(services.inventory.receive_item(character, heat_item, 1))
        player_message(character, "Your hands grow warm.", "good")
    else
        value(services.inventory.remove_type(character, heat_item))
        player_message(character, "The heat from your hands fades away.", "neutral")
    end
end)

ccb.runtime.handler("salamander_smoke_form_on", function(context)
    local character = context.character
    add_permanent_effect(character, "effect_salamander_smoke_form")
    value(mutations.replace(character, id("mutation", "SALAMANDER_SMOKE_FORM_ASCEND")))
    value(mutations.replace(character, id("mutation", "SALAMANDER_SMOKE_FORM_APPEARANCE")))
end)

ccb.runtime.handler("salamander_smoke_form_off", function(context)
    local character = context.character
    remove_effect(character, "effect_salamander_smoke_form")
    value(mutations.erase(character, id("mutation", "SALAMANDER_SMOKE_FORM_ASCEND")))
    value(mutations.erase(character, id("mutation", "SALAMANDER_SMOKE_FORM_APPEARANCE")))
    add_effect(character, "effect_salamander_smoke_immunity", 15)
end)

ccb.runtime.handler("salamander_smoke_form_ascend", function(context)
    local character = context.character
    local snap = value(services.creatures.snapshot(character))
    if read_number(character, "salamander_near_fire") ~= 1
        and not env.field_exists(snap.position, "fd_salamander_heat")
    then
        player_message(character, "You must be in warm air to ascend!", "bad")
        return
    end
    if not snap.outside then
        player_message(character, "The ceiling above blocks your attempt to rise!", "bad")
        return
    end
    local target = services.coords.tripoint_abs_ms(snap.position.x, snap.position.y, snap.position.z + 2)
    local found = services.world.find_location(target, nil, { outdoor_only = true })
    player_message(character, "You soar upward on the rising smoke.", "good")
    if found.found and found.position then
        value(services.relocation.teleport_character(character, found.position))
    end
end)

ccb.runtime.handler("salamander_berserk_stance_on", function(context)
    local character = context.character
    if has_effect(character, "effect_salamander_berserk_stance") then
        player_message(character, "You are already under the effects of Wildfire Soul!", "mixed")
        return
    end
    local pain = value(services.creatures.snapshot(character)).pain
    set_number(character, "salamander_pain_value", pain)
    if pain ~= 0 then
        value(needs.modify_raw_pain(character, -pain))
    end
    value(effects.add(character, id("effect", "effect_salamander_berserk_stance"), services.time.duration(24, "hour")))
end)

ccb.runtime.handler("salamander_berserk_stance_off", function(context)
    local character = context.character
    if not has_effect(character, "effect_salamander_berserk_stance") then
        return
    end
    local saved = read_number(character, "salamander_pain_value")
    local penalty = math.modf(saved * 1.15)
    if penalty ~= 0 then
        value(needs.modify_raw_pain(character, penalty))
    end
    remove_effect(character, "effect_salamander_berserk_stance")
end)

-- Undine abilities
local river_mapping_locations = {
    "generic_river_bank", "generic_river", "river_center", "river",
    "river_c_not_ne", "river_c_not_nw", "river_c_not_se", "river_c_not_sw",
    "lake_shore", "lake_surface",
    "ocean", "ocean_shore", "ocean_surface", "ocean_bed", "ocean_water_cube",
}

ccb.runtime.handler("undine_river_mapping", function(context)
    local character = context.character
    if not value(services.characters.is_underwater(character)) then
        return
    end
    local pos = value(services.creatures.snapshot(character)).position
    local omt = pos:project_to("omt")
    local matched = false
    for _, loc in ipairs(river_mapping_locations) do
        if services.overmap.matches_location(omt, loc) then
            matched = true
            break
        end
    end
    if not matched then
        return
    end
    local map_id = id("item", "undine_waters_map")
    value(services.inventory.receive_item(character, map_id, 1))
    local maps = value(services.inventory.items_of_type(character, map_id, true))
    if #maps > 0 then
        value(services.items.activate(maps[1], character, "reveal_map", { target = pos }))
    end
    value(services.inventory.remove_type(character, map_id))
end)

ccb.runtime.handler("undine_water_form_on", function(context)
    local character = context.character
    value(mutations.replace(character, id("mutation", "UNDINE_WATER_FORM_TRAITS")))
    value(mutations.replace(character, id("mutation", "UNDINE_WATER_FORM_CAMOUFLAGE")))
    player_message(character, "Your body falls apart in a rush of water.", "neutral")
    value(services.inventory.receive_item(character, id("item", "water"), services.random.native_int(30, 100)))
end)

ccb.runtime.handler("undine_water_form_off", function(context)
    local character = context.character
    value(mutations.erase(character, id("mutation", "UNDINE_WATER_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "UNDINE_WATER_FORM_CAMOUFLAGE")))
    player_message(character, "Your body reconstitutes itself from the waters.", "neutral")
end)
