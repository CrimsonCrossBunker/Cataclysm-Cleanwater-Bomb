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

local function terrain_id(position)
    return value(services.map.snapshot(value(services.map.tile(position)))).terrain.value
end

local function arvore_on_natural_terrain(position)
    local tile = terrain_id(position)
    return env.terrain_has_flag(position, "SHRUB")
        or env.terrain_has_flag(position, "DIGGABLE")
        or env.terrain_has_flag(position, "YOUNG")
        or tile == "t_barkfloor"
        or tile == "t_barkfloor_noroof"
end

local unsuitable_ierde_earth = {
    t_vitrified_sand = true,
    t_pit_corpsed = true,
    t_fungus = true,
    t_glassed_sand = true,
    t_rubber_mulch = true,
    t_swater_surf = true,
    t_woodchips = true,
}

local function ierde_on_natural_earth_or_underground(position)
    if position.z <= -1 then
        return true
    end
    local tile = terrain_id(position)
    if unsuitable_ierde_earth[tile] then
        return false
    end
    return env.terrain_has_flag(position, "DIGGABLE")
        or tile == "t_rock_floor"
        or tile == "t_rock_floor_no_roof"
end

-- Arvore abilities
ccb.runtime.handler("arvore_seed_bearer", function(context)
    local character = context.character
    local snap = value(services.creatures.snapshot(character))
    if not (snap.outside and arvore_on_natural_terrain(snap.position)
        and read_number(character, "arvore_is_in_wilderness") == 1)
    then
        player_message(character, "You must be surrounded by the wild to call forth regional seeds.", "bad")
        return
    end
    local is_winter = services.time.now():season() == "winter"
    if not has_effect(character, "effect_arvore_seedbearer_cooldown") and not is_winter then
        remove_effect(character, "effect_arvore_seedbearer_available")
        player_message(character, "You bring forth seeds.", "good")
        local count = value(mutations.category_count(character, id("mutation_category", "ARVORE"), "ALL", true))
        local iterations = 1 + math.modf(count / 5)
        for _ = 1, iterations do
            value(services.inventory.receive_group(character, id("item_group", "farming_seeds")))
        end
        add_effect(character, "effect_arvore_seedbearer_cooldown", 432000 + services.random.native_int(0, 431999))
    elseif is_winter then
        player_message(character, "Your seeds slumber and dream of spring.", "mixed")
    else
        player_message(character, "You need more time before you can summon seeds again.", "bad")
    end
end)

ccb.runtime.handler("arvore_vine_drag", function(context)
    cast_generic_spell_mutation(context.character, "arvore_vine_drag_spell", 1,
        "Vines lash out and drag your target in!",
        "You are too parched to lash out with any vines.", 0)
end)

ccb.runtime.handler("arvore_tree_form_on", function(context)
    local character = context.character
    local snap = value(services.creatures.snapshot(character))
    if snap.outside and arvore_on_natural_terrain(snap.position) then
        value(mutations.replace(character, id("mutation", "CHLOROMORPH")))
        value(mutations.replace(character, id("mutation", "LEAVES3")))
        value(mutations.replace(character, id("mutation", "ARVORE_TREE_FORM_TRAITS")))
    else
        player_message(character, "You must be outside on diggable ground to become one with the forest.", "bad")
    end
end)

ccb.runtime.handler("arvore_tree_form_off", function(context)
    local character = context.character
    value(mutations.erase(character, id("mutation", "CHLOROMORPH")))
    value(mutations.erase(character, id("mutation", "LEAVES3")))
    value(mutations.erase(character, id("mutation", "ARVORE_TREE_FORM_TRAITS")))
    remove_effect(character, "effect_arvore_tree_immobility")
end)

-- Homullus abilities
ccb.runtime.handler("homullus_doll_form_toggle", function(context)
    local character = context.character
    if not has_trait(character, "HOMULLUS_DOLL_FORM_TRAITS") then
        value(mutations.replace(character, id("mutation", "HOMULLUS_DOLL_FORM_TRAITS")))
        if not has_trait(character, "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") then
            value(mutations.replace(character, id("mutation", "HOMULLUS_DOLL_FORM_ANGER_RELATIONS")))
        end
        local pos = value(services.creatures.snapshot(character)).position
        if value(services.monsters.count_nearby(pos, nil, { radius = 45, attitude = "both" })) == 0 then
            set_number(character, "doll_form_movement", 0)
            if has_trait(character, "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") then
                value(mutations.erase(character, id("mutation", "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER")))
                value(mutations.replace(character, id("mutation", "HOMULLUS_DOLL_FORM_ANGER_RELATIONS")))
            end
        end
        player_message(character, "Your limbs stiffen and your skin takes on an even more waxen appearance.", "good")
    else
        value(mutations.erase(character, id("mutation", "HOMULLUS_DOLL_FORM_TRAITS")))
        value(mutations.erase(character, id("mutation", "HOMULLUS_DOLL_FORM_ANGER_RELATIONS")))
        player_message(character, "A small semblance of life returns to you.", "neutral")
    end
end)

ccb.runtime.handler("homullus_doll_form_process", function(context)
    local character = context.character
    local movement = read_number(character, "doll_form_movement")
    if movement > 0 then
        set_number(character, "doll_form_movement", math.max(0, movement - (services.random.native_int(0, 3) + 1)))
    end
end)

-- Ierde abilities
ccb.runtime.handler("ierde_no_sleep_meditate", function(context)
    local character = context.character
    if value(services.creatures.snapshot(character)).position.z <= -1 then
        cast_generic_spell_mutation(character, "ierde_no_sleep_meditate_spell", 1,
            "You settle down, feeling the ground beneath you, and begin your vigil", "", 0)
    else
        player_message(character, "You must be underground to begin your vigil!", "bad")
    end
end)

ccb.runtime.handler("ierde_detect_monsters_on", function(context)
    local character = context.character
    if ierde_on_natural_earth_or_underground(value(services.creatures.snapshot(character)).position) then
        add_permanent_effect(character, "effect_ierde_sense_nearby_monsters")
    else
        player_message(character,
            "You must be in contact with the living earth or underground to activate The Soil Knows Those Who Tread Upon It",
            "bad")
    end
end)

ccb.runtime.handler("ierde_detect_monsters_off", function(context)
    remove_effect(context.character, "effect_ierde_sense_nearby_monsters")
end)

ccb.runtime.handler("ierde_smashing_punch", function(context)
    cast_generic_spell_mutation(context.character, "ierde_smashing_punch_spell", 0.5,
        "You gather yourself for a moment and strike.", "", 0)
end)

ccb.runtime.handler("ierde_sink_into_earth", function(context)
    local character = context.character
    local pos = value(services.creatures.snapshot(character)).position
    local tile = terrain_id(pos)
    if not ((env.terrain_has_flag(pos, "DIGGABLE")
        or tile == "t_soil"
        or tile == "t_rock"
        or tile == "t_rock_floor"
        or tile == "t_railroad_rubble"
        or tile == "t_dirt_underground")
        and tile ~= "t_grass_alien"
        and not unsuitable_ierde_earth[tile])
    then
        player_message(character, "You must be on living earth or stone to sink into it.", "bad")
        return
    end
    if pos.z == -9 then
        local saved = value(services.variables.get_tripoint(character, "IERDE_sleep_in_earth_starting_point"))
        if saved.exists and saved.value then
            value(services.relocation.teleport_character(character, saved.value))
        end
        player_message(character, "You feel yourself rising until you stand in the clear air once again.", "good")
        return
    end
    if tile == "t_rock_floor_no_roof"
        or tile == "t_rock_floor"
        or tile == "t_rock_smooth"
        or (env.terrain_has_flag(pos, "DIGGABLE") and tile ~= "t_grass_alien" and not unsuitable_ierde_earth[tile])
    then
        value(services.variables.set(character, "IERDE_sleep_in_earth_starting_point", pos, { include_before = false }))
        local dest = services.coords.tripoint_abs_ms(pos.x, pos.y, -9)
        player_message(character, "The earth parts beneath you and you sink down into the stone.", "good")
        value(services.relocation.teleport_character(character, dest, { force = true }))
        value(mutations.replace(character, id("mutation", "IERDE_STONE_SLEEP")))
    else
        player_message(character, "You must be standing on the living earth to sink into the stone!", "bad")
    end
end)

ccb.runtime.handler("ierde_rooted_in_place_on", function(context)
    local character = context.character
    if ierde_on_natural_earth_or_underground(value(services.creatures.snapshot(character)).position) then
        add_permanent_effect(character, "effect_ierde_rooted_in_place")
    else
        player_message(character, "You must be standing on the living earth to root yourself in place.", "bad")
    end
end)

ccb.runtime.handler("ierde_rooted_in_place_off", function(context)
    local character = context.character
    if has_effect(character, "effect_ierde_rooted_in_place") then
        remove_effect(character, "effect_ierde_rooted_in_place")
    end
end)

-- Omitting legacy morale_perm_fancy, which is undefined in content data and rejected by id("morale", ...).
local full_morale_neutralization_ids = {
    "morale_bile", "morale_food_good", "morale_food_hot", "morale_chat", "morale_chat_uncaring",
    "morale_ate_with_table", "morale_ate_without_table", "morale_music", "morale_honey", "morale_game",
    "morale_marloss", "morale_mutagen", "morale_feeling_good", "morale_support", "morale_photos",
    "morale_craving_nicotine", "morale_craving_caffeine", "morale_craving_alcohol", "morale_craving_opiate",
    "morale_craving_speed", "morale_craving_cocaine", "morale_craving_crack", "morale_craving_mutagen",
    "morale_craving_diazepam", "morale_craving_marloss", "morale_food_bad", "morale_cannibal",
    "morale_demicannibal", "morale_vegetarian", "morale_antiveggy", "morale_meatarian", "morale_antimeat",
    "morale_antifruit", "morale_lactose", "morale_antijunk", "morale_antiwheat", "morale_sweettooth",
    "morale_no_digest", "morale_wet", "morale_dried_off", "morale_cold", "morale_hot", "morale_feeling_bad",
    "morale_bad_protein_bar", "morale_killed_innocent", "morale_killed_friend", "morale_killed_monster",
    "morale_mutilate_corpse", "morale_mutagen_elf", "morale_mutagen_chimera", "morale_mutagen_mutation",
    "morale_moodswing", "morale_book", "morale_comfy", "morale_scream", "morale_perm_masochist",
    "morale_perm_radiophile", "morale_perm_noface", "morale_perm_fpmode_on", "morale_perm_hoarder",
    "morale_perm_optimist", "morale_perm_badtemper", "morale_perm_numb", "morale_perm_constrained",
    "morale_perm_nomad", "morale_game_found_kitten", "morale_haircut", "morale_shave", "morale_vomited",
    "morale_play_with_pet", "morale_pyromania_startfire", "morale_pyromania_nearfire",
    "morale_pyromania_nofire", "morale_perm_filthy", "morale_butcher", "morale_gravedigger",
    "morale_funeral", "morale_tree_communion", "morale_accomplishment", "morale_failure", "morale_nightmare",
    "morale_migo_bio_tech", "morale_impossible_shape", "morale_afs_drugs", "morale_social", "morale_asocial",
    "morale_sunrise", "morale_sunset", "morale_ate_dross", "morale_drank_blood",
    "morale_craving_lotus_blossom", "morale_forest_unity", "morale_broke_fae_ban",
    "morale_homullus_self_deception", "morale_ierde_meditation", "morale_boring_fruit", "morale_vw_no_fun",
}

ccb.runtime.handler("ierde_full_morale_neutralization", function(context)
    local character = context.character
    for _, morale_id in ipairs(full_morale_neutralization_ids) do
        value(needs.remove_morale(character, id("morale", morale_id)))
    end
end)
