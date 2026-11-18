local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local variables = services.variables
local timers = require("character_timers")

local banned_traits = {
    "CHANGELING_MAGIC",
    "NATIVE_SHAPESHIFTER",
    "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
    "LILIN_TRAITS",
    "GRACKEN",
    "ARVORE",
    "IERDE",
    "HOMULLUS",
    "SALAMANDER",
    "SYLPH",
    "UNDINE",
    "VAMPIRE",
}

local beginner_recipes = {
    "dreamdross_bo",
    "dreamdross_knife",
    "dreamdross_club",
    "dreamsmith_research",
    "dreamdross_lump",
    "forged_dreamstuff_ingot",
}

local enchanted_recipes = {
    "dreamforged_ballistic_plate",
    "dreamforged_ballistic_plate_small",
    "dreamforged_q_staff_ench",
    "dreamforged_longsword_ench",
    "dreamforged_warhammer_ench",
    "dreamforged_spear_ench",
    "dreamforged_halberd_ench",
    "dreamforged_glaive_ench",
    "dreamforged_naginata_ench",
    "dreamforged_mace_ench",
    "dreamforged_morningstar_ench",
    "dreamforged_estoc_ench",
    "dreamforged_arming_sword_ench",
    "dreamforged_broadsword_ench",
    "dreamforged_battleaxe_ench",
    "dreamforged_katana_ench",
    "dreamforged_knife_combat_ench",
    "dreamforged_kris_ench",
    "dreamforged_kukri_ench",
    "dreamforged_nodachi_ench",
    "dreamforged_rapier_ench",
    "dreamforged_tanto_ench",
    "dreamforged_wakizashi_ench",
    "dreamforged_zweihander_ench",
    "dreamforged_khopesh_ench",
    "dreamforged_lucerne_ench",
    "dreamforged_knuckle_ench",
    "dreamforged_fullhelmet_ench",
    "dreamforged_helmet_ench",
    "dreamforged_plate_armor_ench",
    "dreamforged_armguard_plate_ench",
    "dreamforged_boots_ench",
    "dreamforged_longbow",
    "arrow_dreamforged",
    "dreamforged_crossbow",
    "bolt_dreamforged",
    "dreamforged_hacksaw",
    "dreamforged_hammer",
    "dreamforged_halligan",
    "dreamforged_pliers_locking",
    "dreamforged_pickaxe",
    "dreamforged_picklocks",
    "dreamforged_scalpel",
    "dreamforged_e_tool",
    "dreamforged_ax",
    "dreamforged_nail",
}

local super_recipes = {
    "dreamforged_knuckle_berserk",
    "dreamforged_helmet_berserker",
    "dreamforged_armguard_plate_berserk",
    "dreamforged_boots_berserk",
    "dreamforged_fullhelmet_arcane",
    "dreamforged_glaive_healing",
    "dreamforged_tsurugi_speed",
    "dreamforged_q_staff_exp",
    "dreamforged_armguard_plate_gunslinger",
    "dreamforged_bed_of_restful_repose",
    "xedra_dreamsmith_time_trap",
    "xedra_dreamsmith_time_watch",
}

local pistol_cases = {
    "223_casing_from_dreamdross",
    "22_casing_from_dreamdross",
    "32_casing_from_dreamdross",
    "38_casing_from_dreamdross",
    "38super_casing_from_dreamdross",
    "9mm_casing_from_dreamdross",
    "10mm_casing_from_dreamdross",
    "9x18mm_casing_from_dreamdross",
    "9x21mm_casing_from_dreamdross",
    "380_casing_from_dreamdross",
    "40_casing_from_dreamdross",
    "357mag_casing_from_dreamdross",
}

local rifle_cases = {
    "3006_casing_from_dreamdross",
    "270win_casing_from_dreamdross",
    "303_casing_from_dreamdross",
    "300_casing_from_dreamdross",
    "308_casing_from_dreamdross",
    "762_51_casing_from_dreamdross",
    "44_casing_from_dreamdross",
    "454_casing_from_dreamdross",
    "45_casing_from_dreamdross",
    "45colt_casing_from_dreamdross",
    "4570_casing_from_dreamdross",
    "50beowulf_casing_from_dreamdross",
    "450_casing_from_dreamdross",
    "500_casing_from_dreamdross",
    "50_casing_from_dreamdross",
    "338lapua_casing_from_dreamdross",
    "545_casing_from_dreamdross",
    "57mm_casing_from_dreamdross",
    "458wm_casing_from_dreamdross",
    "762R_casing_from_dreamdross",
    "762_casing_from_dreamdross",
    "762_25_casing_from_dreamdross",
    "300blk_casing_from_dreamdross",
    "30carbine_casing_from_dreamdross",
}

local score = "DREAMSMITH_RECIPE_SCORE"
local target = "DREAMSMITH_RECIPE_SCORE_TARGET"
local training = "DREAMSMITH_RECIPE_SCORE_TRAINS"
local super_score = "DREAMSMITH_RECIPE_SCORE_SUPER"
local super_target = "DREAMSMITH_RECIPE_SCORE_SUPER_TARGET"
local super_training = "DREAMSMITH_RECIPE_SCORE_TRAINS_SUPER"
local craft_from_dream = "xedra_dream_craft_due"
local train_from_dream = "xedra_dreamsmith_training_due"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function may_use_dream_magic(character)
    for _, trait in ipairs(banned_traits) do
        if has_trait(character, trait) then
            return false
        end
    end
    return true
end

local function number(key)
    return checked(variables.get_global_number(key)).value or 0
end

local function store(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

local function message(character, text, kind)
    if character.subtype == "avatar" then
        services.messages.add(text, kind)
    end
end

local function offer_recipe(character, pool)
    local recipes = {}
    for index, recipe in ipairs(pool) do
        recipes[index] = id("recipe", recipe)
    end
    return checked(services.progression.grant_random_missing(character, "recipe", recipes)).granted
end

local function advance_enchanted_recipes(character)
    if has_trait(character, "DREAMSMITH") and number(score) >= number(target) then
        if offer_recipe(character, enchanted_recipes) then
            message(character, ccb.services.translate("A brilliant idea about the properties of dreamdross hits your head, and you think you know how to utilize it now."), "good")
        end
        store(score, 0)
        store(target, number(target) + 25)
    else
        message(character, ccb.services.translate("Using the dreamdross, you test out a new idea.  It fails, but you're getting closer to a breakthrough.  You can feel it."), "bad")
    end
end

local function advance_super_recipes(character)
    if has_trait(character, "DREAMSMITH") and number(super_score) >= number(super_target) + 1000 then
        if offer_recipe(character, super_recipes) then
            message(character, ccb.services.translate("You found a pretty smart way to utilize dreamdross' abilities, and you can't wait to use it."), "good")
        end
        store(super_score, 0)
        store(super_target, number(super_target) + 200)
    end
end

local function train(character)
    if not has_trait(character, "DREAMSMITH") or not may_use_dream_magic(character) then
        message(character, ccb.services.translate("You just can't seem to figure out even the simplest principles of dreamdross."), "info")
        return
    end
    store(score, number(score) + number(training))
    store(training, number(training) + 1)
    store(super_score, number(super_score) + number(super_training))
    store(super_training, number(super_training) + 1)
    advance_enchanted_recipes(character)
    advance_super_recipes(character)
end

local function try_dream_training(character)
    -- The other legacy branch tried to queue an event EOC, which the engine rejected.
    if services.random.native_int(0, 1) == 0 then
        ccb.tasks.after_character_turn(character, 1, craft_from_dream)
    end
end

ccb.runtime.handler(craft_from_dream, function(task)
    local character = task.character
    if has_trait(character, "DREAMSMITH") or has_trait(character, "INVENTOR") then
        ccb.tasks.after_character_turn(character, 1, train_from_dream)
    end
end, 1)

ccb.runtime.handler(train_from_dream, function(task)
    train(task.character)
end, 1)

ccb.runtime.handler("finish_dreamsmith_research", function(craft)
    for _ = 1, craft.batch do
        train(craft.character)
    end
end, 1)

local function recurring(key, handler, minimum, maximum, effect)
    -- These timers still roll their next interval when the character does not qualify.
    timers.register(key, handler,
        function()
            return services.random.native_int(services.time.duration(minimum, "hour").turns,
                services.time.duration(maximum, "hour").turns)
        end,
        function() return true end,
        effect)
end

recurring("dreamsmith_score_timer", "dreamsmith_score_due", 20, 28, function(character)
    if has_trait(character, "DREAMSMITH") and may_use_dream_magic(character) then
        local deduction = checked(services.skills.level(character, "deduction"))
        store(score, number(score) + deduction)
        if offer_recipe(character, beginner_recipes) then
            message(character, ccb.services.translate("Something sparked in your head, and you realize an interesting property of dreamdross.  Maybe you can forge something new?"), "info")
        end
    end
end)

recurring("dreamsmith_pistol_cases_timer", "dreamsmith_pistol_cases_due", 140, 192, function(character)
    if has_trait(character, "DREAMSMITH") and checked(services.skills.level(character, "pistol")) >= 2
        and offer_recipe(character, pistol_cases) then
        message(character, ccb.services.translate("You realize you know suddenly how to make a low caliber bullet casing."), "good")
    end
end)

recurring("dreamsmith_rifle_cases_timer", "dreamsmith_rifle_cases_due", 140, 192, function(character)
    if has_trait(character, "DREAMSMITH") and checked(services.skills.level(character, "rifle")) >= 3
        and offer_recipe(character, rifle_cases) then
        message(character, ccb.services.translate("You realize you know suddenly how to make a larger caliber bullet casing."), "good")
    end
end)

content.add(content.Recipe {
    id = "dreamsmith_research",
    name = ccb.content.text("inquire dreamdross"),
    description = ccb.content.text("You spend some time trying to understand what the dreamdross is capable of, and how you can utilize its power.  You probably need a lot of attempts to research the whole depth of this unusual metal and even your failures will make your future success more inevitable."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    duration_moves = 450000,
    activity_level = 2,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
    scripted_output = true,
}:quality("DREAM_HAMMER", 1, 1)
    :component("scrap_dreamdross", 2)
    :on_complete("finish_dreamsmith_research"))

return {
    advance_enchanted_recipes = advance_enchanted_recipes,
    may_use_dream_magic = may_use_dream_magic,
    try_dream_training = try_dream_training,
}
