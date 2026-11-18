local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local intense_concentration = "effect_psi_intense_concentration"
local maintained_powers = "vitamin_maintained_powers"

local trait_modifiers = {
    { "CONCENTRATION_GOOD", 1 },
    { "CONCENTRATION_BAD", -1 },
    { "INT_ALPHA", 1 },
    { "NOMAD2", -1 },
    { "NOMAD3", -1 },
    { "PER_SLIME", -15 },
    { "PER_INTERSTICE", 2 },
    { "CONCENTRATION_DEBUG", 50 },
}

local proficiency_bonuses = {
    { "prof_concentration_basic", 1 },
    { "prof_concentration_intermediate", 1 },
    { "prof_concentration_master", 2 },
}

-- The second field is the minimum intensity that applies the listed modifier.
local effect_modifiers = {
    { "effect_disease_psionic_drain", 5, -1 },
    { "effect_disease_psionic_drain", 11, -1 },
    { "effect_psi_studying_power", 1, -2 },
    { "effect_psi_learning_new_power", 1, -3 },
    { "hallu", 1, -1 },
    { "winded", 1, -2 },
    { "nausea", 1, -1 },
    { "nausea", 4, -1 },
    { "cold", 2, -1 },
    { "hot", 2, -1 },
    { "asthma", 1, -3 },
    { "datura", 1, -3 },
    { "dazed", 1, -2 },
    { "psi_dazed", 1, -2 },
    { "psi_dazed_zap", 1, -1 },
    { "downed", 1, -2 },
    { "boomered", 1, -1 },
    { "conjunctivitis", 1, -1 },
    { "teargas", 1, -3 },
    { "smoke_eyes", 1, -1 },
    { "smoke_lungs", 1, -2 },
    { "effect_whispering_amalgamation_whispers", 1, -2 },
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_proficiency(character, proficiency)
    return checked(services.proficiencies.has_id_text(character, proficiency))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function remove_effect(character, effect)
    checked(services.effects.remove(character, id("effect", effect)))
end

local function add_effect(character, effect, turns, permanent)
    checked(services.effects.add(character, id("effect", effect), services.time.duration(turns, "turn"),
        { permanent = permanent }))
end

local function effect_intensity(character, effect)
    local result = services.effects.get(character, id("effect", effect), id("body_part", "bp_null"))
    if not result.ok and result.error.code == "not_found" then
        return -1
    end
    return checked(result).intensity
end

local function maintained_count(character)
    return checked(services.needs.get_vitamin(character, id("vitamin", maintained_powers)))
end

local function set_maintained_count(character, count)
    checked(services.needs.set_vitamin(character, id("vitamin", maintained_powers), count))
end

local function message(character, text, severity)
    if character.subtype ~= "npc" then
        services.messages.add(text, severity)
    end
end

local function concentration_limit(character)
    local intelligence = checked(services.characters.snapshot(character, 1)).stats.intelligence
    local slots = checked(services.variables.get_number(character, "bonus_concentration_powers")).value or 0
    local limit = intelligence / 4 + slots
    for _, modifier in ipairs(trait_modifiers) do
        if has_trait(character, modifier[1]) then
            limit = limit + modifier[2]
        end
    end
    for _, bonus in ipairs(proficiency_bonuses) do
        if has_proficiency(character, bonus[1]) then
            limit = limit + bonus[2]
        end
    end
    for _, modifier in ipairs(effect_modifiers) do
        local effect, threshold, amount = table.unpack(modifier)
        if effect_intensity(character, effect) >= threshold then
            limit = limit + amount
        end
    end
    return limit
end

local function release_slots(character, slots)
    for _ = 1, slots or 1 do
        set_maintained_count(character, maintained_count(character) - 1)
        local count = maintained_count(character)
        if count >= 1 and count > concentration_limit(character) then
            if not has_effect(character, intense_concentration) then
                message(character, services.translate(
                    "It's taking you a lot of concentration to maintain your powers.  You're not sure you'll be able to do it for very long."
                ), "bad")
                add_effect(character, intense_concentration, 1, true)
            end
        elseif has_effect(character, intense_concentration) then
            message(character, services.translate("The pressure on your mind lightens.  It's easier to concentrate now."), "good")
            remove_effect(character, intense_concentration)
        end
    end
end

local function release_then_clear(character, effect, slots)
    if has_effect(character, effect) then
        release_slots(character, slots)
        remove_effect(character, effect)
    end
end

local function clear_then_release(character, effect, slots)
    if has_effect(character, effect) then
        remove_effect(character, effect)
        release_slots(character, slots)
    end
end

local function remove_item(character, item)
    checked(services.inventory.remove_type(character, id("item", item)))
end

local function erase_trait(character, trait)
    local mutation = id("mutation", trait)
    -- Some former appearance traits no longer have definitions in this world.
    if mutation:is_valid() then
        checked(services.mutations.erase(character, mutation))
    end
end

local function clear_healing_effects(character)
    local parts = checked(services.characters.body_parts(character))
    for _, effect in ipairs {
        "effect_vita_concentrated_healing",
        "effect_vita_concentrated_healing_bonus",
        "effect_vita_concentrated_healing_penalty",
    } do
        local effect_id = id("effect", effect)
        for _, part in ipairs(parts) do
            checked(services.effects.remove(character, effect_id, part))
        end
        checked(services.effects.remove(character, effect_id))
    end
end

local appearance_thresholds = {
    "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH",
    "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE",
    "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME",
    "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT",
    "THRESH_ELPHA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN",
    "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN",
}

local function restore_visible_mutation_response(character)
    for _, trait in ipairs(appearance_thresholds) do
        if has_trait(character, trait) then
            local key = "dialogue_godco_godco_notalk_to_u"
            -- A native write with one possible value still draws from the RNG.
            services.random.native_int(0, 0)
            checked(services.variables.set(character, key, "yes", { include_before = false }))
            services.native_events.emit("u_var_changed", { key, "yes" })
            return
        end
    end
end

local return_from_death_due = "clear_return_from_death_due"
ccb.runtime.handler(return_from_death_due, function(payload)
    remove_effect(payload.character, "effect_vita_return_from_death")
end, 1)

local function stop_all(character)
    if has_effect(character, "effect_biokin_overcome_pain") then
        remove_effect(character, "effect_biokin_pkill_1")
        remove_effect(character, "effect_biokin_pkill_2")
        remove_effect(character, "effect_biokin_pkill_3")
        remove_effect(character, "effect_biokin_pkill_4")
        remove_effect(character, "effect_biokin_pkill_5")
        remove_effect(character, "effect_biokin_pkill_6")
        remove_effect(character, "effect_biokin_overcome_pain")
        release_slots(character)
    end
    release_then_clear(character, "effect_biokin_physical")
    release_then_clear(character, "effect_biokin_breathe_skin")
    release_then_clear(character, "effect_biokin_armor_skin")
    clear_then_release(character, "effect_biokin_climate_control")
    if has_effect(character, "effect_biokin_enhance_mobility") then
        for tier = 1, 6 do
            remove_item(character, "biokin_enhance_mobility_item_" .. tier)
        end
        remove_effect(character, "effect_biokin_enhance_mobility")
        release_slots(character)
    end
    clear_then_release(character, "effect_biokin_guided_evolution", 2)
    if has_effect(character, "effect_biokin_hammerhand") then
        remove_item(character, "biokin_hammerhand_item")
        remove_effect(character, "effect_biokin_hammerhand")
        release_slots(character)
    end
    release_then_clear(character, "effect_biokin_reflex")
    clear_then_release(character, "effect_biokin_metabolism_enhance")
    release_then_clear(character, "effect_biokin_combat_dance")
    release_then_clear(character, "effect_biokin_perfected_motion", 2)
    if has_effect(character, "effect_clair_better_senses") then
        message(character, services.translate("The world now seems separated from you by a thin veil."), "good")
        release_slots(character)
        remove_effect(character, "effect_clair_better_senses")
    end
    if has_effect(character, "effect_clair_night_eyes") then
        remove_effect(character, "effect_clair_night_eyes_1")
        remove_effect(character, "effect_clair_night_eyes_2")
        remove_effect(character, "effect_clair_night_eyes_3")
        remove_effect(character, "effect_clair_night_eyes_4")
        remove_effect(character, "effect_clair_night_eyes_5")
        remove_effect(character, "effect_clair_night_eyes_6")
        remove_effect(character, "effect_clair_night_eyes_7")
        remove_effect(character, "effect_clair_night_eyes_8")
        remove_effect(character, "effect_clair_night_eyes")
        release_slots(character)
    end
    if has_effect(character, "effect_clair_speed_reader") then
        message(character, services.translate("Your eyes ache a bit.  Maybe it's time to put the book down."), "good")
        release_slots(character)
        remove_effect(character, "effect_clair_speed_reader")
    end
    release_then_clear(character, "effect_clair_premonition")
    release_then_clear(character, "effect_clair_see_auras")
    release_then_clear(character, "effect_clair_ranged_enhance")
    release_then_clear(character, "effect_clair_dodge")
    release_then_clear(character, "effect_clair_sense_hostile_creatures")
    if has_effect(character, "effect_clair_craft_bonus") then
        release_slots(character)
        remove_effect(character, "effect_clair_craft_bonus")
        remove_effect(character, "effect_clair_craft_bonus_blindness")
        for tier = 1, 6 do
            erase_trait(character, ("CLAIR_CRAFT_BONUS_%02d"):format(tier))
        end
    end
    release_then_clear(character, "effect_clair_clear_sight")
    release_then_clear(character, "effect_clair_group_tactics_self", 2)
    release_then_clear(character, "effect_electrokin_see_electricity")
    release_then_clear(character, "effect_electrokin_zap_enemies")
    release_then_clear(character, "effect_electrokin_melee_attacks")
    if has_effect(character, "effect_electrokin_hacking_interface") then
        release_slots(character)
        for tier = 1, 12 do
            remove_item(character, "electrokinetic_electrohack_" .. tier)
        end
        remove_effect(character, "effect_electrokin_hacking_interface")
    end
    clear_then_release(character, "effect_electrokin_personal_battery")
    release_then_clear(character, "effect_electrokin_reduce_pain")
    release_then_clear(character, "effect_electrokinetic_speed_boost")
    if has_effect(character, "effect_electrokinetic_lightning_aura") then
        release_slots(character)
        remove_effect(character, "effect_electrokinetic_lightning_aura")
        add_effect(character, "effect_electrokinetic_lightning_aura_aftershock", 5)
    end
    release_then_clear(character, "effect_photokin_light_local")
    release_then_clear(character, "effect_photokin_dodge")
    clear_then_release(character, "effect_photokin_light_barrier")
    if has_effect(character, "effect_photokin_camouflage") then
        remove_effect(character, "effect_photokin_camouflage")
        for tier = 1, 6 do
            erase_trait(character, "PHOTOKINETIC_CAMOUFLAGE_" .. tier)
        end
        release_slots(character)
    end
    if has_effect(character, "effect_photokin_hide_ugly") then
        release_slots(character)
        remove_effect(character, "effect_photokin_hide_ugly")
        for tier = 1, 6 do
            erase_trait(character, ("PHOTOKIN_HIDE_UGLY_%02d"):format(tier))
        end
        restore_visible_mutation_response(character)
    end
    if has_effect(character, "effect_photokinetic_radio") then
        release_slots(character)
        remove_item(character, "item_photokinetic_radio")
        remove_item(character, "item_photokinetic_radio_on")
        remove_effect(character, "effect_photokinetic_radio")
    end
    release_then_clear(character, "effect_photokin_invisibility")
    release_then_clear(character, "effect_photokin_blinding_glare")
    if has_effect(character, "effect_pyrokinetic_fire_tool") then
        message(character, services.translate("The flames over your hand gutter and die out."), "bad")
        release_slots(character)
        remove_item(character, "pyrokinetic_fire_tool")
        remove_item(character, "pyrokinetic_fire_tool_four_arms")
        remove_item(character, "pyrokinetic_fire_tool_six_arms")
        remove_item(character, "pyrokinetic_fire_tool_eight_arms")
        remove_effect(character, "effect_pyrokinetic_fire_tool")
    end
    release_then_clear(character, "effect_pyrokinetic_cloak")
    release_then_clear(character, "effect_pyrokinetic_aura")
    if has_effect(character, "effect_pyrokinetic_torch_weld") then
        message(character, services.translate("The line of fire vanishes in an instant."), "bad")
        release_slots(character)
        remove_item(character, "pyrokinetic_torch_weld")
        remove_effect(character, "effect_pyrokinetic_torch_weld")
    end
    release_then_clear(character, "effect_pyrokinetic_flame_immunity")
    release_then_clear(character, "effect_telekinetic_momentum")
    release_then_clear(character, "effect_telekinetic_water_walking", 2)
    if has_effect(character, "effect_telekinetic_lifting_field") then
        release_slots(character)
        if has_trait(character, "TELEKINETIC") then
            for tier = 30, 1, -1 do
                erase_trait(character, "TELEKINETIC_LIFTER_" .. tier)
            end
        end
        remove_effect(character, "effect_telekinetic_lifting_field")
    end
    release_then_clear(character, "effect_telekinetic_strength")
    release_then_clear(character, "effect_telekinetic_armor")
    if has_effect(character, "effect_telekinetic_vehicle_lift") then
        message(character, services.translate("You let the vehicle settle gently to the ground."), "bad")
        release_slots(character)
        for tier = 1, 20 do
            remove_item(character, "telekin_lifting_jack_" .. tier)
        end
        remove_effect(character, "effect_telekinetic_vehicle_lift")
    end
    release_then_clear(character, "effect_telekinetic_levitation", 2)
    release_then_clear(character, "effect_telepathic_learning_bonus")
    release_then_clear(character, "effect_telepathic_psi_armor")
    release_then_clear(character, "effect_telepathic_morale")
    release_then_clear(character, "effect_telepath_sense_minds")
    release_then_clear(character, "effect_teleport_ephemeral_walk")
    release_then_clear(character, "effect_teleport_stride")
    release_then_clear(character, "effect_teleport_reactive_displacement")
    release_then_clear(character, "effect_teleport_loci_establishment")
    release_then_clear(character, "effect_teleport_warped_strikes")
    release_then_clear(character, "effect_teleport_warper_combat", 2)
    if has_effect(character, "effect_vitakin_slow_bleeding") then
        remove_effect(character, "effect_vitakin_slow_bleeding")
        remove_effect(character, "effect_vitakin_slow_bleeding_01")
        remove_effect(character, "effect_vitakin_slow_bleeding_02")
        remove_effect(character, "effect_vitakin_slow_bleeding_03")
        release_slots(character)
    end
    if has_effect(character, "effect_vita_concentrated_healing") then
        clear_healing_effects(character)
        release_slots(character)
    end
    release_then_clear(character, "effect_vita_health")
    release_then_clear(character, "effect_vita_cure_disease")
    release_then_clear(character, "effect_vita_increase_hp")
    release_then_clear(character, "effect_vitakin_no_need_for_sleep")
    release_then_clear(character, "effect_vita_super_heal", 2)
    if has_effect(character, "effect_vita_return_from_death") then
        release_slots(character)
        ccb.tasks.after_character_turn(character, services.random.native_int(2, 2), return_from_death_due)
    end
    set_maintained_count(character, 0)
    remove_effect(character, intense_concentration)
end

ccb.runtime.handler("stop_all_psychic_concentration", function(payload)
    local character = payload.target_creature
    if character and (character.subtype == "avatar" or character.subtype == "npc") then
        stop_all(character)
    end
end, 1)

content.add(content.Spell {
    id = "classless_toggleable_concentration_end",
    name = content.text("[Ψ]Stop Concentrating"),
    description = content.text(
        "End your concentration on all of your maintained powers.\n\nChanneling this power <color_green>always succeeds</color>."
    ),
    message = content.text("You stop concentrating on your powers."),
    teachable = false,
    valid_targets = { "self" },
    skill = "metaphysics",
    flags = { "PSIONIC", "NO_FAIL", "NON_MAGICAL", "SILENT", "NO_HANDS", "NO_LEGS" },
    shape = "blast",
    max_level = 1,
    energy_source = "STAMINA",
    base_energy_cost = 0,
    base_casting_time = 0,
}:lua_impact("stop_all_psychic_concentration"))

ccb.runtime.handler("broken_limb_ends_concentration", function(event)
    stop_all(event.actors.character or services.characters.avatar())
end, 1)
ccb.runtime.on("game:broken_bone", "broken_limb_ends_concentration")

local stops_concentration = {
    sleep = true,
    lying_down = true,
    stunned = true,
    psi_stunned = true,
    weary_7 = true,
    weary_8 = true,
    brainworms = true,
    pd_int_bad = true,
}

ccb.runtime.handler("effect_ends_concentration", function(event)
    local effect = event.data.effect
    if not stops_concentration[effect] then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if effect == "stunned" or effect == "psi_stunned" then
        if maintained_count(character) < 1 then
            return
        end
        message(character, services.translate("As your head rings and your mind reels, you lose control of your powers!"), "bad")
    elseif effect == "weary_7" or effect == "weary_8" then
        if has_proficiency(character, "prof_concentration_master") then
            return
        end
        message(character, services.translate("You are almost too tired to think, and can't concentrate on maintaining your powers"), "bad")
    end
    stop_all(character)
end, 1)
ccb.runtime.on("game:character_gains_effect", "effect_ends_concentration")

return stop_all
