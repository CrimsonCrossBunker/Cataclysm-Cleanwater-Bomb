local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local choices = require("changeling_dream_choices")
local lineages = { "NOBLE", "COMMONER_BROWNIE", "COMMONER_POOKA", "COMMONER_SELKIE", "COMMONER_TROW" }
local seasons = { "SPRING", "SUMMER", "AUTUMN", "WINTER" }
local dreams = "changeling_advancement_dreams_counter"
local cost = "changeling_new_trait_dreamdross_research_cost"

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function gain(character, trait)
    checked(services.mutations.replace(character, id("mutation", trait)))
end

local function lose(character, trait)
    checked(services.mutations.erase(character, id("mutation", trait)))
end

local function number(character, name)
    return checked(services.variables.get_number(character, name)).value or 0
end

local function set(character, name, value)
    checked(services.variables.set(character, name, value, { include_before = false }))
end

local function set_level(character, spell)
    checked(services.spells.set_level(character, id("spell", spell), 1))
end

local function message(character, text, severity)
    if character.subtype == "avatar" then services.messages.add(text, severity) end
end

local function lineage_trait(lineage)
    return "UNKNOWING_CHANGELING_" .. lineage
end

local function any_lineage(character, start)
    for index = start, #lineages do
        if has(character, lineage_trait(lineages[index])) then return true end
    end
    return false
end

local function snippet(character, lineage)
    if character.subtype ~= "avatar" then return end
    local text = services.snippets.native_random("XE_CHANGELING_" .. lineage) or ""
    message(character, checked(services.text.expand_for(text, character, nil, nil, nil, true)), "neutral")
end

local function dream_of_power(character, lineage)
    snippet(character, lineage)
    local lineage_vitamin = id("vitamin", "mutagen_fair_folk_" .. string.lower(lineage))
    local mutagen = id("vitamin", "mutagen")
    local function adjust(vitamin, change)
        local current = checked(services.needs.get_vitamin(character, vitamin))
        checked(services.needs.set_vitamin(character, vitamin, current + change))
    end
    adjust(lineage_vitamin, 2500)
    adjust(mutagen, 1000)
    checked(services.mutations.mutate(character, 0, true))
    adjust(lineage_vitamin, -2500)
    adjust(mutagen, -1000)
    set(character, dreams, number(character, dreams) - 1)
end

local function choose(menu, available)
    local entries = {}
    for _, entry in ipairs(menu) do
        local enabled = not available or available(entry.id)
        if enabled or not menu.hide_known then
            entries[#entries + 1] = {
                id = entry.id, label = entry.label(), description = entry.description(), hotkey = entry.hotkey,
                enabled = enabled,
            }
        end
    end
    if #entries == 0 then return nil end
    return services.interaction.choose(entries, {
        title = menu.title(), allow_cancel = false, show_descriptions = true,
    }).id
end

local function dream_of_heritage(character)
    if checked(services.spells.effective_level(character, "changeling_gain_new_traits")) ~= 1
        and not checked(services.variables.get(character, cost)).exists and any_lineage(character, 1) then
        set(character, cost, 35)
        set_level(character, "changeling_gain_new_traits")
    end
    if has(character, "FAIR_FOLK_COMMONER_SELECTOR") and not any_lineage(character, 2) then
        message(character, ccb.services.translate("That night, you dream of your parents and the unknown place of your birth.  Who were they?"), "info")
        local selected = choose(choices.heritage)
        if selected then
            local lineage = "COMMONER_" .. selected
            gain(character, lineage_trait(lineage))
            lose(character, "FAIR_FOLK_COMMONER_SELECTOR")
            snippet(character, lineage)
            dream_of_power(character, lineage)
        end
    end
    for _, lineage in ipairs(lineages) do
        if has(character, lineage_trait(lineage)) and number(character, dreams) >= 1 and not has(character, "VAMPIRE") then
            dream_of_power(character, lineage)
        end
    end
end

local moon_tear_recipes = {
    "moon_tear_ingot", "moons_tears_knife_baselard", "moons_tears_broadsword", "moons_tears_arming_sword",
    "moons_tears_mace", "moons_tears_scimitar", "moons_tears_estoc", "moons_tears_spear",
    "moons_tears_battleaxe", "moons_tears_katana",
}

local function remember_home_and_forge(character)
    if has(character, "BROWNIE_TELEPORT_HOME") and number(character, "brownie_homebody_speed_bonus") >= 12 then
        set(character, "brownie_home_teleport_loc", checked(services.creatures.snapshot(character)).position)
    end
    if has(character, "TROW_MOONS_TEARS_FORGING") and services.random.native_probability(1, 15) then
        local ingot = id("recipe", "moon_tear_ingot")
        if not checked(services.recipes.knows(services.characters.avatar(), ingot)) then
            checked(services.recipes.learn(character, ingot))
        else
            local pool = {}
            for i, recipe in ipairs(moon_tear_recipes) do pool[i] = id("recipe", recipe) end
            checked(services.progression.grant_random_missing(character, "recipe", pool))
        end
        message(character, ccb.services.translate("Your dreams have revealed to you a secret of forging moon's tears."), "good")
    end
end

local function choose_season(character, menu)
    local selected = choose(menu, function(season) return not has(character, "CHANGELING_SEASONAL_MAGIC_" .. season) end)
    if selected then
        gain(character, "CHANGELING_SEASONAL_MAGIC_" .. selected)
        set_level(character, "changeling_research_new_seasonal_spells")
        set_level(character, "changeling_gain_dreamsparks")
        checked(services.recipes.learn(character, id("recipe", "prac_gramarye_changeling")))
    end
end

local function has_season(character)
    for _, season in ipairs(seasons) do
        if has(character, "CHANGELING_SEASONAL_MAGIC_" .. season) then return true end
    end
    return false
end

local function dream_of_court(character)
    local days = services.time.snapshot().turns_since_cataclysm / 86400
    if days < services.random.native_int(0, 7) + 3 or not has(character, "CHANGELING_MAGIC")
        or has_season(character) then return end
    message(character, ccb.services.translate("You dream of the lands Under the Hill.  Though you've never been there, it calls to your spirit, reminding you of your true home.  You belong to one of the great Courts of the Fair Folk, but which one?"), "mixed")
    local can_join = not has(character, "CHANGELING_COURT_SUMMER") and not has(character, "CHANGELING_COURT_WINTER")
    local court = choose(choices.court, function() return can_join end)
    if not court then return end
    gain(character, "CHANGELING_COURT_" .. court)
    gain(character, "CHANGELING_DREAMSPARK_STORAGE_10")
    set(character, "maximum_dreamdross_storage_value", 10)
    choose_season(character, choices[string.lower(court)])
    local noble = has(character, lineage_trait("NOBLE"))
    if noble then choose_season(character, choices.noble) end
    set(character, "changeling_seasonal_magic_dreamdross_research_cost", noble and 40 or 50)
    set(character, "changeling_seasonal_magic_dreamdross_research_cost_modifier", noble and 40 or 50)
end

local function common_traits(character)
    local total = 0
    for _, lineage in ipairs(lineages) do
        if has(character, lineage_trait(lineage)) then
            total = total + checked(services.mutations.category_count(character,
                id("mutation_category", "FAIR_FOLK_" .. lineage), "ALL", true))
        end
    end
    return total
end

local spark_id = "changeling_dreamspark"
local spark_count_key = "dreamdross_to_dreamsparks_value"

local function count_carried_sparks(character, spark)
    local key = spark_count_key
    set(character, key, 0)
    local count = #checked(services.inventory.items_of_type(character, spark))
    if count > 0 then set(character, key, count) end
    return count
end

local function upgrade_dreamsparks(character)
    if common_traits(character) < 10 or not has_season(character)
        or has(character, "CHANGELING_DREAMSPARK_STORAGE_50") then return end
    local spark = id("item", spark_id)
    count_carried_sparks(character, spark)
    checked(services.inventory.receive_item(character, spark, 1))
    for capacity = 10, 40, 10 do
        if common_traits(character) >= capacity and has(character, "CHANGELING_DREAMSPARK_STORAGE_" .. capacity) then
            gain(character, "CHANGELING_DREAMSPARK_STORAGE_" .. (capacity + 10))
            lose(character, "CHANGELING_DREAMSPARK_STORAGE_" .. capacity)
            set(character, "maximum_dreamdross_storage_value", capacity + 10)
            checked(services.inventory.receive_item(character, spark, number(character, spark_count_key)))
        end
    end
end

ccb.runtime.handler("changeling_noble_starting_dream", function()
    local character = services.characters.avatar()
    if has(character, lineage_trait("NOBLE")) then set(character, dreams, number(character, dreams) + 1) end
end)
ccb.runtime.on("game:game_start", "changeling_noble_starting_dream")

ccb.runtime.handler("changeling_waking_dreams", function(event)
    local character = event.actors.speaker or event.actors.character or services.characters.avatar()
    dream_of_heritage(character)
    remember_home_and_forge(character)
    dream_of_court(character)
    upgrade_dreamsparks(character)
end)
ccb.runtime.on("game:character_wakes_up", "changeling_waking_dreams")

local spark_timer = "changeling_cap_dreamsparks"
require("character_timers").register(spark_timer, spark_timer, function() return 300 end, has_season,
    function(character)
        if checked(services.effects.has(character, id("effect", "effect_extracting_dreamsparks"),
            id("body_part", "bp_null"), -1)) then return end
        local spark = id("item", spark_id)
        local excess = count_carried_sparks(character, spark) - number(character, "maximum_dreamdross_storage_value")
        if excess > 0 then checked(services.inventory.consume_by_type(character, spark, math.modf(excess), 0)) end
    end)
