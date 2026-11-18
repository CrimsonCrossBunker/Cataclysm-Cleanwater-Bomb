local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local completion = "finish_inventor_research"
local research = {}

local blocked_traits = {
    "CHANGELING_MAGIC", "NATIVE_SHAPESHIFTER", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
    "LILIN_TRAITS", "GRACKEN", "ARVORE", "IERDE", "HOMULLUS",
    "SALAMANDER", "SYLPH", "UNDINE", "VAMPIRE",
}

local difficulty_keys = {
    "base_difficulty_1", "base_difficulty_2", "base_difficulty_3",
    "energy_difficulty_1", "energy_difficulty_2", "energy_difficulty_3",
    "AI_difficulty_1", "dimension_difficulty_1",
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function world_number(key)
    return checked(services.variables.get_global_number(key)).value or 0
end

local function increment_world_number(key, amount)
    checked(services.variables.set_global(key, world_number(key) + amount, { include_before = false }))
end

local function vitamin(character, name)
    return checked(services.needs.get_vitamin(character, id("vitamin", name)))
end

local function set_vitamin(character, name, amount)
    checked(services.needs.set_vitamin(character, id("vitamin", name), (math.modf(amount))))
end

local function add_research_sparks(character, amount)
    set_vitamin(character, "creative_spark_research", vitamin(character, "creative_spark_research") + amount)
end

local function can_research(character)
    for _, trait in ipairs(blocked_traits) do
        if checked(services.mutations.has_id_text(character, trait)) then
            return false
        end
    end
    return true
end

local function show_message(character, message, severity)
    if character.subtype ~= "npc" then
        services.messages.add(checked(services.text.expand_for(message, character, nil, nil, nil, true)), severity)
    end
end

local function show_snippet(character, category, severity)
    if character.subtype ~= "npc" then
        show_message(character, services.snippets.native_random(category) or "", severity)
    end
end

local function process_sparks(character)
    local spark = vitamin(character, "creative_spark")
    if spark > 0 and can_research(character) then
        local total = 0
        for _, key in ipairs(difficulty_keys) do
            total = total + world_number(key)
        end
        add_research_sparks(character, spark * math.floor(total / #difficulty_keys))
        set_vitamin(character, "creative_spark", 0)
    end
    show_message(character, services.translate("creative_spark_research = <u_val:creative_spark_research>,\n base_difficulty_1 = <u_val:base_difficulty_1>,\n base_difficulty_2 = <u_val:base_difficulty_2>,\n base_difficulty_3 = <u_val:base_difficulty_3>,\n energy_difficulty_1 = <u_val:energy_difficulty_1>,\n energy_difficulty_2 = <u_val:energy_difficulty_2>,\n energy_difficulty_3 = <u_val:energy_difficulty_3>,\n dimension_sparks = <u_val:dimension_sparks>,\n dimension_difficulty_1 = <u_val:dimension_difficulty_1>."), "debug")
end

local function unlock_recipe(character, recipe, candidates)
    local ids = {}
    for index, candidate in ipairs(candidates) do
        ids[index] = id("recipe", candidate)
    end
    if checked(services.progression.grant_random_missing(character, "recipe", ids)).granted then
        show_snippet(character, "inventor_success", "good")
    else
        checked(services.recipes.forget(character, id("recipe", recipe)))
        show_message(character, services.translate("You reach the limit of what can be done at this level.  It is time to move forward."),
            "info")
    end
end

local function finish_research(character, recipe, spec)
    local difficulty = world_number(spec.difficulty_key)
    local secondary = spec.secondary
    local enough_sparks = vitamin(character, "creative_spark_research") >= difficulty
    if enough_sparks
        and (not secondary or world_number(secondary.sparks_key) >= world_number(secondary.difficulty_key))
        and can_research(character) then
        add_research_sparks(character, -difficulty)
        if secondary then
            increment_world_number(secondary.sparks_key, world_number(secondary.difficulty_key))
        end
        increment_world_number(spec.difficulty_key, spec.difficulty_gain)
        if secondary then
            increment_world_number(secondary.difficulty_key, secondary.difficulty_gain)
        end
        if spec.process_before_unlock then
            process_sparks(character)
        end
        unlock_recipe(character, recipe, spec.unlocks)
        if not spec.process_before_unlock then
            process_sparks(character)
        end
    else
        show_snippet(character, "inventor_fail", "bad")
        if not secondary then
            process_sparks(character)
        end
        add_research_sparks(character, spec.failure_sparks)
        if secondary then
            increment_world_number(secondary.sparks_key, secondary.failure_sparks)
        end
    end
end

ccb.runtime.handler(completion, function(payload)
    local recipe = payload.recipe_id
    local spec = research[recipe]
    for _ = 1, payload.batch do
        finish_research(payload.character, recipe, spec)
    end
end, 1)

local function register(options)
    research[options.id] = options.research
    local recipe = content.Recipe {
        id = options.id,
        name = options.name,
        description = options.description,
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_RESEARCH",
        skill = "deduction",
        difficulty = options.difficulty,
        duration_moves = options.hours * 60 * 60 * 100,
        activity_level = 1,
        autolearn = false,
        flags = { "BLIND_EASY", "SECRET" },
        scripted_output = true,
    }:tool_charges("laptop", options.laptop_charges)
        :on_complete(completion)
    for _, required in ipairs(options.tools or {}) do
        recipe:tool(required, 1)
    end
    if options.ai_tool then
        recipe:quality("AI_TOOL", 1, 1)
    end
    if options.printouts then
        recipe:component_any {
            { id = "medium_printout_portal_storm_data", count = 1 },
            { id = "small_printout_portal_storm_data", count = 3 },
        }
    end
    content.add(recipe)
end

register {
    id = "inventor_research_base_1",
    name = content.text("novice research"),
    description = content.text("Research the unknown parts of your powers, brainstorm the ways to use them."),
    difficulty = 2,
    hours = 2,
    laptop_charges = 20,
    research = {
        difficulty_key = "base_difficulty_1",
        difficulty_gain = 2,
        failure_sparks = 1,
        unlocks = {
            "inventor_leg_weight",
            "inventor_jump_boots",
            "inventor_sniper",
            "inventor_shotgun",
            "inventor_pistol",
            "megachette",
            "software_math_inventor",
            "software_electronics_reference_inventor",
            "combatsaw_spear_off",
            "inventor_carry_hands",
            "inventor_water_purifier",
            "inventor_coffee",
            "inventor_gaming_rig",
            "inventor_research_base_2",
        },
    },
}

register {
    id = "inventor_research_base_2",
    name = content.text("intermediate research"),
    description = content.text("Research the unknown parts of your powers, brainstorm the ways to use them."),
    difficulty = 4,
    hours = 3,
    laptop_charges = 40,
    research = {
        difficulty_key = "base_difficulty_2",
        difficulty_gain = 3,
        failure_sparks = 2,
        process_before_unlock = true,
        unlocks = {
            "helmet_inventor",
            "inventor_fists",
            "wolf_mask",
            "magnetic_holster",
            "binary_sword",
            "cosmic_dagwood",
            "bio_launcher",
            "bio_warhead",
            "portable_dark_age",
            "trinket_damage",
            "trinket_range",
            "trinket_sound",
            "choke_wideshot",
            "mod_inv_pistol_booster",
            "mod_inv_pistol_double_tap",
            "inventor_oxygen_jelly_machine",
            "inventor_research_base_3",
            "inventor_research_energy_1",
            "software_AI",
            "stunning_qr_trap",
        },
    },
}

register {
    id = "inventor_research_base_3",
    name = content.text("difficult research"),
    description = content.text("Research the unknown parts of your powers, brainstorm the ways to use them."),
    difficulty = 6,
    hours = 4,
    laptop_charges = 60,
    tools = { "software_math" },
    research = {
        difficulty_key = "base_difficulty_3",
        difficulty_gain = 4,
        failure_sparks = 3,
        process_before_unlock = true,
        unlocks = {
            "inventor_backpack",
            "vision_halo",
            "sonic_gun",
            "mace_magic",
            "stunning_arg_trap",
            "inventor_fists_plus",
            "inventor_plasma_axe_off",
            "inventor_research_energy_1",
            "inventor_research_bionic",
        },
    },
}

register {
    id = "inventor_research_bionic",
    name = content.text("bionic research"),
    description = content.text("Research how to create devices that are contained within the body."),
    difficulty = 7,
    hours = 4,
    laptop_charges = 60,
    tools = { "software_math", "software_electronics_reference" },
    research = {
        difficulty_key = "base_difficulty_3",
        difficulty_gain = 4,
        failure_sparks = 3,
        process_before_unlock = true,
        unlocks = {
            "bio_inventor_mana_kj_penalty_switch",
            "bio_inventor_calorie_storage",
            "bio_inventor_creative_fuel",
            "bio_inventor_book_burn_boost",
        },
    },
}

register {
    id = "inventor_research_energy_1",
    name = content.text("novice energy research"),
    description = content.text("Research an innovative ways to generate and use energy."),
    difficulty = 3,
    hours = 3,
    laptop_charges = 20,
    tools = { "software_math" },
    research = {
        difficulty_key = "energy_difficulty_1",
        difficulty_gain = 2,
        failure_sparks = 1,
        unlocks = {
            "battery_gun",
            "ray_gun",
            "inventor_light_minus_cell",
            "inventor_light_cell",
            "inventor_medium_cell",
            "inventor_heavy_cell",
            "inventor_welder",
            "heater_tool",
            "inventor_electric_fist",
            "inventor_research_energy_2",
        },
    },
}

register {
    id = "inventor_research_energy_2",
    name = content.text("intermediate energy research"),
    description = content.text("Research an innovative ways to generate and use energy."),
    difficulty = 5,
    hours = 4,
    laptop_charges = 40,
    tools = { "software_math", "software_electronics_reference" },
    research = {
        difficulty_key = "energy_difficulty_2",
        difficulty_gain = 3,
        failure_sparks = 2,
        unlocks = {
            "aura_force",
            "ray_rifle",
            "ion_gun",
            "accelerator_gun",
            "inventor_grenade_noise_expl",
            "inventor_grenade_noise_emp",
            "inventor_grenade_noise_fire",
            "heater_gun",
            "inventor_lasmod_close_range",
            "inventor_lasmod_long_range",
            "inventor_lasmod_capasitor",
            "inventor_lasmod_energy_safe",
            "inventor_lasmod_adv_cooler",
            "inventor_lasmod_radiator",
            "inventor_lasmod_chonky_radiator",
            "inventor_lasmod_spooky_heat_sink",
            "inventor_research_energy_3",
        },
    },
}

register {
    id = "inventor_research_energy_3",
    name = content.text("difficult energy research"),
    description = content.text("Research an innovative ways to generate and use energy."),
    difficulty = 7,
    hours = 5,
    laptop_charges = 60,
    tools = { "software_math", "software_electronics_reference" },
    ai_tool = true,
    research = {
        difficulty_key = "energy_difficulty_3",
        difficulty_gain = 4,
        failure_sparks = 3,
        unlocks = {
            "inventor_glauncher",
            "inventor_glauncher_fire",
            "inventor_glauncher_elec",
            "inventor_glauncher_direct",
            "death_ray",
            "inventor_lasmod_mega_capasitor",
            "inventor_lasmod_adv_adv_cooler",
            "inventor_lasmod_recuperator",
            "inventor_lasmod_mega_everything",
            "inventor_lasmod_more_capacitors",
            "inventor_research_ai_1",
            "inventor_research_dimension_1",
            "nre_recorder_inventor",
        },
    },
}

register {
    id = "inventor_research_ai_1",
    name = content.text("intelligent agent research"),
    description = content.text("Research a practical approaches to use different intelligent agents as a tool or weapon."),
    difficulty = 8,
    hours = 5,
    laptop_charges = 40,
    tools = { "software_math", "software_electronics_reference" },
    ai_tool = true,
    research = {
        difficulty_key = "base_difficulty_3",
        difficulty_gain = 5,
        failure_sparks = 4,
        process_before_unlock = true,
        secondary = {
            sparks_key = "AI_sparks",
            difficulty_key = "AI_difficulty_1",
            difficulty_gain = 5,
            failure_sparks = 4,
        },
        unlocks = {
            "bot_sniperbot",
            "bot_shotgunbot",
            "bot_meleebot",
            "crafting_assistant",
            "bot_bitebot",
        },
    },
}

register {
    id = "inventor_research_dimension_1",
    name = content.text("dimensionalism research"),
    description = content.text("Research practical methods of using netherium based physics."),
    difficulty = 10,
    hours = 10,
    laptop_charges = 100,
    printouts = true,
    research = {
        difficulty_key = "base_difficulty_3",
        difficulty_gain = 5,
        failure_sparks = 5,
        process_before_unlock = true,
        secondary = {
            sparks_key = "dimension_sparks",
            difficulty_key = "dimension_difficulty_1",
            difficulty_gain = 5,
            failure_sparks = 4,
        },
        unlocks = {
            "rip_ticket",
            "inventor_warp_grenade",
            "inventor_portal_closer",
            "teleporter_inventor",
            "xedra_inventor_time_pierce_tool_inventor",
            "xedra_inventor_damage_reversal_device",
        },
    },
}
