local ccb = require("ccb")
local services = ccb.services
local profiles = require("paraclesian_training_catalog")
local tasks = ccb.tasks
local state = ccb.state.character
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_ability(character, abilities)
    for _, ability in ipairs(abilities) do
        if has_trait(character, ability) then return true end
    end
    return false
end

local function flag(character, key)
    return checked(services.variables.get_number(character, key)).value == 1
end

local function on_sky_island(position)
    if not ccb.content.is_mod_active("skyisland") then return false end
    local near = services.overmap.matches_location_near
    return ((near(position, "sky_island_core", 1) or near(position, "sky_island_subcore", 1))
            and (position.z == 6 or position.z == 7))
        or (near(position, "sky_island_core", 1) and position.z == 6)
end

local function terrain(position)
    local tile = checked(services.map.tile(position))
    return checked(services.map.snapshot(tile)).terrain.value
end

local near = services.overmap.matches_location_near
local at = services.overmap.matches_location

local function practice_in_forest(character, location, omt)
    if not flag(character, "arvore_is_in_wilderness") then return false end
    local outside = location.outside and omt.z >= 0
    return (outside and near(omt, "forest", 2) and not at(omt, "field"))
        or (outside and near(omt, "forest_thick", 2) and not at(omt, "field"))
        or flag(character, "arvore_is_in_forest")
        or terrain(location.position) == "t_barkfloor"
end

local near_settlement = require("paraclesian_settlements")

local function practice_near_civilization(_, location, omt)
    return near_settlement(omt) or near(omt, "FACTION_CAMP_ANY", 2)
        or services.overmap.is_in_city(location.position)
end

local unsuitable_ground = {
    t_grass_alien = true, t_vitrified_sand = true, t_pit_corpsed = true, t_fungus = true,
    t_glassed_sand = true, t_rubber_mulch = true, t_swater_surf = true, t_woodchips = true,
}

local function practice_in_earth(_, location, omt)
    if omt.z <= -1 then return true end
    if services.gameplay.environment.terrain_has_flag(location.position, "DIGGABLE")
        and not unsuitable_ground[terrain(location.position)] then
        return true
    end
    return at(omt, "ierde_genius_loci_NW") or at(omt, "ierde_genius_loci_NE")
        or at(omt, "ierde_genius_loci_SW") or at(omt, "ierde_genius_loci_SE")
end

local lit_items = { "torch_lit", "candle_lit", "oil_lamp_on", "oil_lamp_clay_on", "cigar_lit", "cig_lit" }

local function native_float(number)
    return (string.unpack("f", string.pack("f", number)))
end

-- The native Fahrenheit conversion promotes single-precision constants to double.
local warm_air_kelvin = (80 + native_float(459.67)) / native_float(1.8)

local function practice_in_heat(character)
    for _, item in ipairs(lit_items) do
        if checked(services.inventory.has_type(character, id("item", item))) then return true end
    end
    return flag(character, "salamander_near_fire")
        or services.weather.current().precise.temperature.value >= warm_air_kelvin
end

local wet_weather = { thunder = true, lightning = true, rain = true, rainstorm = true, drizzle = true }

local function practice_in_wind(_, location, omt)
    if location.outside and omt.z >= 1 then return true end
    local weather = services.weather.current()
    if location.outside and (weather.precise.wind_speed_mph >= 15 or wet_weather[weather.weather.value]) then
        return true
    end
    return at(omt, "sylph_genius_loci_NW") or at(omt, "sylph_genius_loci_NE")
        or at(omt, "sylph_genius_loci_SW") or at(omt, "sylph_genius_loci_SE")
end

local water = {
    t_water_dp = true, t_water_sh = true, t_swater_dp = true, t_swater_dp_underground = true,
    t_water_dp_underground = true, t_water_hot = true, t_water_murky = true,
    t_water_sh_underground = true, t_swater_sh_underground = true, t_swater_sh = true,
    t_water_moving_dp = true, t_water_moving_dp_underground = true,
    t_water_sh_murky_underground = true,
}

local function practice_in_water(character, location)
    return flag(character, "undine_is_connected_to_waters") or checked(services.characters.is_underwater(character))
        or water[terrain(location.position)]
end

local environments = {
    arvore = practice_in_forest, homullus = practice_near_civilization, ierde = practice_in_earth,
    salamander = practice_in_heat, sylph = practice_in_wind, undine = practice_in_water,
}

local function can_practice_in_environment(character, family, island_training)
    local location = checked(services.creatures.snapshot(character))
    local omt = location.position:project_to("omt")
    return (island_training and on_sky_island(omt)) or environments[family](character, location, omt)
end

local function practice(character, profile)
    local levels = {}
    local stats
    local function level(spell)
        if levels[spell] == nil then
            levels[spell] = checked(services.spells.effective_level(character, spell))
        end
        return levels[spell]
    end
    local function cap(limit)
        if type(limit) == "number" then return limit end
        stats = stats or checked(services.characters.snapshot(character, 0)).stats
        return stats[limit] * 1.5
    end

    local can_draw = false
    local eligible = {}
    local has_candidate = false
    for index, option in ipairs(profile.spells) do
        local spell, _, award_limit, draw_limit = table.unpack(option)
        local value = level(spell)
        if value < cap(draw_limit or award_limit) then can_draw = true end
        if value >= 0 and value < cap(award_limit) then
            eligible[index] = true
            has_candidate = true
        end
    end
    for _, entry in ipairs(profile.additional_draw_checks or {}) do
        if level(entry[1]) < cap(entry[2]) then can_draw = true end
    end

    -- Unknown spells pass the legacy draw condition at level -1 but cannot receive experience.
    if not can_draw or not has_candidate then return end
    local selected
    repeat
        selected = services.random.weighted_index(profile.weights)
    until eligible[selected]

    if character.subtype == "avatar" then
        if profile.family == "arvore" and has_trait(character, "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") then
            services.messages.add(ccb.services.translate("Your time spent under the shadows of the trees has increased your facility with your stolen fey magicks."), "good")
        else
            services.messages.add(profile.message(), "good")
        end
    end
    local spell = id("spell", profile.spells[selected][1])
    local experience = checked(services.spells.get(character, spell)).experience
    local deduction = math.modf(checked(services.skills.level(character, "deduction")))
    checked(services.spells.set_experience(character, spell, experience + deduction * 500 + 1))
end

local function register_timer(profile)
    local task = profile.family .. "_practice_due"
    local timer = profile.family .. "_practice_timer"
    local ready = profile.family .. "_practice_start"
    local wake = profile.family .. "_practice_wake"
    local function schedule(character)
        tasks.after_character_turn(character, services.random.native_int(6 * 3600, 36 * 3600), task)
        state.set(timer, "scheduled")
    end

    ccb.runtime.handler(task, function(payload)
        local character = payload.character
        local has_element = has_trait(character, profile.trait)
        local can_train = has_element
            or (profile.family == "arvore" and has_trait(character, "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT"))
        local applies = can_train and has_ability(character, profile.abilities)
            and can_practice_in_environment(character, profile.family, true)
        if applies then practice(character, profile) end
        if applies or has_element then
            schedule(character)
        else
            state.set(timer, "dormant")
        end
    end, 1)

    ccb.runtime.handler(ready, function(event)
        if state.get(timer) == nil then schedule(event.actors.character) end
    end, 1)
    ccb.runtime.on("character_ready", ready)

    ccb.runtime.handler(wake, function(event)
        local character = event.actors.character
        if state.get(timer) == "dormant" and has_trait(character, profile.trait) then schedule(character) end
    end, 1)
    ccb.runtime.on("character_conditions_changed", wake)
end

local by_family = {}
for _, profile in ipairs(profiles) do
    profile.weights = {}
    for index, option in ipairs(profile.spells) do
        profile.weights[index] = option[2]
    end
    by_family[profile.family] = profile
    register_timer(profile)
end

local function register_draught(family, element, message)
    local function restore_mutagen(character, vitamin)
        local current = checked(services.needs.get_vitamin(character, vitamin))
        checked(services.needs.set_vitamin(character, vitamin, current + 550))
    end

    ccb.runtime.handler("drink_" .. family .. "_destiny_draught", function(context)
        local character = context.character
        restore_mutagen(character, id("vitamin", element))
        restore_mutagen(character, id("vitamin", "mutagen"))
        if character.subtype == "avatar" then services.messages.add(message(), "info") end
        for _ = 1, 3 do
            practice(character, by_family[family])
        end
    end)
end

register_draught("arvore", "mutagen_plantkin",
    function() return ccb.services.translate("You drink the Arvore destiny draught.") end)
register_draught("salamander", "mutagen_flamekin",
    function() return ccb.services.translate("You drink the Salamander destiny draught.") end)

require("paraclesian_fae_bans")
require("paraclesian_passive_traits")(profiles, can_practice_in_environment)
require("paraclesian_spellcasting")
