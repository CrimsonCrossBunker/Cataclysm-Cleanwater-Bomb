local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function any(character, traits)
    for _, trait in ipairs(traits) do
        if has(character, trait) then return true end
    end
    return false
end

local function gain(character, trait)
    checked(services.mutations.replace(character, id("mutation", trait)))
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function set(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function learn(character, spell, level)
    checked(services.spells.set_level(character, id("spell", spell), level))
end

local seasonal = { "CHANGELING_SEASONAL_MAGIC_SPRING", "CHANGELING_SEASONAL_MAGIC_SUMMER",
    "CHANGELING_SEASONAL_MAGIC_AUTUMN", "CHANGELING_SEASONAL_MAGIC_WINTER" }
local capacities = { "CHANGELING_DREAMSPARK_STORAGE_10", "CHANGELING_DREAMSPARK_STORAGE_20",
    "CHANGELING_DREAMSPARK_STORAGE_30", "CHANGELING_DREAMSPARK_STORAGE_40", "CHANGELING_DREAMSPARK_STORAGE_50" }
local paraclesians = { "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE" }
local old_effects = {
    "effect_arvore_sylph_undine_wearing_iron", "effect_arvore_sylph_undine_wearing_steel",
    "effect_ierde_salamander_wearing_iron", "effect_ierde_salamander_wearing_steel",
    "effect_changeling_wearing_iron", "effect_changeling_wearing_steel",
}

local function migrate_wind_dodge(character)
    if not has(character, "WIND_BLOWS_WILLOW_BENDS") then return end
    local arvore = has(character, "ARVORE")
    local level = checked(services.spells.effective_level(character, "paraclesian_spell_dodge_bonus"))
    set(character, "migration_spell_level", level)
    checked(services.mutations.erase(character, id("mutation", "WIND_BLOWS_WILLOW_BENDS")))
    gain(character, arvore and "WIND_BLOWS_WILLOW_BENDS_ARVORE" or "WIND_BLOWS_WILLOW_BENDS_SYLPH")
    local key = arvore and "paraclesian_spell_dodge_bonus_arvore" or "paraclesian_spell_dodge_bonus_sylph"
    checked(services.variables.set_global(key, number(character, "migration_spell_level"), { include_before = false }))
end

local function restore_knowledge(character, skill, proficiency)
    if checked(services.skills.level(character, skill)) > 0 then
        local prof = id("proficiency", proficiency)
        checked(services.proficiencies.set_practiced_time(character, prof, services.proficiencies.definition(prof).time_to_learn))
    end
end

ccb.runtime.handler("recover_xedra_character_on_load", function()
    local character = services.characters.avatar()
    if not has(character, "LILIN_TRAITS") then
        checked(services.effects.remove(character, id("effect", "effect_lilin_no_ruach")))
    end
    if has(character, "WEREWOLF_ANIMAL_FORM") then
        gain(character, "WEREWOLF_SPELLS")
        gain(character, "WEREWOLF_MANA_TRAIT")
    end
    if any(character, seasonal) and not any(character, capacities) then
        gain(character, "CHANGELING_DREAMSPARK_STORAGE_10")
        learn(character, "changeling_gain_dreamsparks", 1)
        set(character, "maximum_dreamdross_storage_value", 10)
    end
    migrate_wind_dodge(character)
    if has(character, "WEREWOLF_ANIMAL_FORM") then
        if number(character, "werewolf_give_xp_value") ~= 1 then
            set(character, "werewolf_xp_threshold", 100)
            set(character, "werewolf_give_xp_value", 1)
        end
        if number(character, "werewolf_give_xp_updater_value") ~= 1 then
            set(character, "werewolf_xp_threshold_updater", 250)
            set(character, "werewolf_give_xp_updater_value", 1)
        end
    end
    for _, old in ipairs(old_effects) do
        checked(services.effects.remove(character, id("effect", old)))
    end
    if number(character, "paraclesian_technology_update") ~= 1 and any(character, paraclesians) then
        restore_knowledge(character, "computers", "prof_paraclesian_computer_understanding")
        restore_knowledge(character, "electronics", "prof_paraclesian_electronics_understanding")
        set(character, "paraclesian_technology_update", 1)
    end
    if any(character, seasonal) then
        checked(services.recipes.learn(character, id("recipe", "prac_gramarye_changeling")))
    end
end)
ccb.runtime.on("game:game_load", "recover_xedra_character_on_load")

local function vampiric(character)
    return has(character, "VAMPIRE") or has(character, "DHAMPIR_TRAIT")
        or checked(services.effects.has(character, id("effect", "vampire_virus"), nil, -1))
end

ccb.runtime.handler("recover_xedra_character_on_begin", function()
    local character = services.characters.avatar()
    if has(character, "COMMUNE_NIGHT") then learn(character, "vampire_commune_with_night_spell", 0) end
    if number(character, "vampire_blood_scale_updated") ~= 1 then
        local blood = id("vitamin", "human_blood_vitamin")
        if vampiric(character) and checked(services.needs.get_vitamin(character, blood)) <= 0 then
            checked(services.needs.set_vitamin(character, blood, 500))
        end
        set(character, "vampire_blood_scale_updated", 1)
    end
    if vampiric(character) then gain(character, "VAMPIRE_BLOOD_ARTS") end
    if not checked(services.variables.get(character, "timer_xe_RandEnc")).exists then
        set(character, "timer_xe_RandEnc", services.time.now().turn)
    end
end)
ccb.runtime.on("game:game_begin", "recover_xedra_character_on_begin")

ccb.runtime.handler("start_xedra_paraclesian_technology", function()
    local character = services.characters.avatar()
    if any(character, paraclesians) then set(character, "paraclesian_technology_update", 1) end
end)
ccb.runtime.on("game:game_start", "start_xedra_paraclesian_technology")

ccb.runtime.handler("recover_old_vampire_torpor", function(task)
    checked(services.needs.set(task.character, { sleepiness = 0 }))
    checked(services.needs.set(task.character, { sleep_deprivation = 0 }))
end)
