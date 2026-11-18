local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local sky_island = ccb.content.is_mod_active("skyisland")

local shelters = {
    { "church_1", 5 },
    { "church_2ndfloor_1", 5 },
    { "church_3rdfloor_1", 5 },
    { "church_roof_1", 5 },
    { "rural_church_parking", 5 },
    { "rural_church", 5 },
    { "rural_church_basement", 5 },
    { "rural_church_steeple", 5 },
    { "rural_church_steeple_roof", 5 },
    { "cathedral_7_NW", 5 },
    { "cathedral_7_NE", 5 },
    { "cathedral_6_NW", 5 },
    { "cathedral_6_NE", 5 },
    { "cathedral_5_NW", 5 },
    { "cathedral_5_NE", 5 },
    { "cathedral_4_NW", 5 },
    { "cathedral_4_NE", 5 },
    { "cathedral_7_NW", 5 },
    { "cathedral_7_NE", 5 },
    { "cathedral_6_NW", 5 },
    { "cathedral_6_NE", 5 },
    { "cathedral_5_NW", 5 },
    { "cathedral_5_NE", 5 },
    { "cathedral_4_NW", 5 },
    { "cathedral_4_NE", 5 },
    { "cathedral_3_NW", 5 },
    { "cathedral_3_NE", 5 },
    { "cathedral_3_SW", 5 },
    { "cathedral_3_SE", 5 },
    { "cathedral_2_NW", 5 },
    { "cathedral_2_NE", 5 },
    { "cathedral_2_SW", 5 },
    { "cathedral_2_SE", 5 },
    { "cathedral_1_NW", 5 },
    { "cathedral_1_NE", 5 },
    { "cathedral_1_SW", 5 },
    { "cathedral_1_SE", 5 },
    { "cathedral_b_NW", 5 },
    { "cathedral_b_NE", 5 },
    { "cathedral_b_SW", 5 },
    { "cathedral_b_SE", 5 },
    { "synagogue", 5 },
    { "synagogue_roof", 5 },
    { "synagogue_upper_roof", 5 },
    { "generic_river_bank", 3 },
    { "generic_river", 3 },
    { "river_center", 3 },
    { "river", 3 },
    { "river_c_not_ne", 3 },
    { "river_c_not_nw", 3 },
    { "river_c_not_se", 3 },
    { "river_c_not_sw", 3 },
    { "lake_shore", 3 },
    { "lake_surface", 3 },
    { "ocean", 3 },
    { "ocean_shore", 3 },
    { "ocean_surface", 3 },
    { "ocean_bed", 3 },
    { "ocean_water_cube", 3 },
    { "ocean_surface", 3 },
}

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(key)
    return value(services.variables.get_global_number(key)).value or 0
end

local function set_number(key, amount)
    value(services.variables.set_global(key, amount, { include_before = false }))
end

local function away_from_island(character)
    return not sky_island or value(services.mutations.has_id_text(character, "awayfromhome"))
end

local function active_night(character)
    return services.gameplay.environment.is_night()
        and not value(services.effects.has(character, id("effect", "sleep")))
        and not value(services.effects.has(character, id("effect", "effect_vampire_torpor")))
        and number("Anathema_Ready") > 0
end

local function exposed(character)
    local snapshot = value(services.creatures.snapshot(character))
    if not snapshot.outside then return false end
    local origin = snapshot.position:project_to("omt")
    for _, shelter in ipairs(shelters) do
        if services.overmap.matches_location_near(origin, shelter[1], shelter[2]) then return false end
    end
    return true
end

local function warning(character)
    if not away_from_island(character) or not active_night(character)
        or not exposed(character) then return end
    local warnings = number("Anathema_Warnings") + 1
    set_number("Anathema_Warnings", warnings)
    local snippet = services.snippets.native_random("Anathema_Warnings_Snippets") or ""
    local text = value(services.text.expand_for(snippet, character, nil, nil, nil, true))
    if warnings < 2 then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    services.messages.add(text, "neutral")
end

ccb.runtime.handler("anathema_encounter_message", function(event)
    local text = value(services.text.expand_for(services.translate("You feel a threat closing in, more dangerous than anything you've ever faced.  Your vampiric instincts urge you to flee, as fighting them is certain to cause your death.\nRUN."), event.character, nil, nil, nil, true))
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
end)

local function schedule_encounter()
    ccb.tasks.after_avatar_turn(services.random.native_int(15 * 60, 9 * 3600), "anathema_encounter_due")
end

ccb.runtime.handler("anathema_encounter_due", function(event)
    local character = event.character
    if away_from_island(character) and services.random.native_int(0, 5) == 0
        and active_night(character) and number("Anathema_Warnings") >= 1
        and exposed(character) then
        set_number("Anathema_Ready", 0)
        local position = value(services.creatures.snapshot(character)).position
        value(services.spawns.population(id("monster", "mon_vampire_anathema"), position, {
            count = 1, min_radius = 30, max_radius = 40,
        }))
        ccb.tasks.after_character_turn(character, 1, "anathema_encounter_message")
    else
        warning(character)
    end
    schedule_encounter()
end)

ccb.runtime.handler("anathema_encounter_ready", function(event)
    if event.actors.character.subtype == "avatar" and not ccb.tasks.has_avatar_turn("anathema_encounter_due") then
        schedule_encounter()
    end
end)
ccb.runtime.on("character_ready", "anathema_encounter_ready")
