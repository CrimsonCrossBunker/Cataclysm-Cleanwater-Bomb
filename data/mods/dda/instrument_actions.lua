local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local storm_weather = {
    portal_storm = true,
    distant_portal_storm = true,
    close_portal_storm = true,
}

local anomaly_sites = {
    "unvitrified_orchard", "LIXA_surface_1a", "temple_stairs", "mine_amigara_finale_central",
    "highlands", "exodii_base_x0y0z0", "microlab_portal_security1", "labyrinth_entrance",
    "corpse_surface", "corpse_brain", "xedra_rural_church", "morgantown_2b",
    "cabin_3_reverberation", "cabin_3_reverberation_hint", "radiosphere_radio_tower_top",
    "mine_spiral_finale_s", "string_dimension_crossroads", "inner_cabins",
    "default_portal_storm_dungeon_overmap",
}

local function detects_anomaly(position)
    if storm_weather[services.weather.current().weather.value] then
        return true
    end
    local origin = services.coords.project_to(position, "omt")
    for _, site in ipairs(anomaly_sites) do
        if services.overmap.matches_location_near(origin, site, 10) then
            return true
        end
    end
    return false
end

ccb.runtime.handler("scan_anomalous_weather", function(use)
    if detects_anomaly(use.item_position) then
        use:message(ccb.services.translate("The instruments whir for a moment before the computer emits 3 sharp beeps.  The LED screen reads \"ANOMALOUS CONDITIONS DETECTED - FULL SCAN RECOMMENDED\"."))
    else
        use:message(ccb.services.translate("The instruments whir for a moment before the computer beeps once.  The LED screen reads \"CONDITIONS NORMAL\"."))
    end
    return 0
end)

local murky_slide = id("item", "microscope_slide_water_murky")
local soil_slide = id("item", "microscope_slide_soil")

local function has_slide(character, slide)
    return checked(services.inventory.has_items(character, slide, 1, 0))
end

ccb.runtime.handler("observe_microscope_samples", function(use)
    local character = use.character
    if not character then
        return 0
    end
    local choices = {}
    if has_slide(character, murky_slide) then
        choices[#choices + 1] = { id = "water", label = ccb.services.translate("Murky water sample") }
    end
    if has_slide(character, soil_slide) then
        choices[#choices + 1] = { id = "soil", label = ccb.services.translate("Soil sample") }
    end
    choices[#choices + 1] = { id = "cancel", label = ccb.services.translate("Cancel") }
    local choice = services.interaction.choose(choices, { allow_cancel = true })
    if character.subtype ~= "avatar" then
        return 0
    end
    if choice.id == "water" and has_slide(character, murky_slide) then
        use:message(use:expand_text(ccb.services.translate("You place the slide on the stage, adjust the light and focus the lens, you manage to see  <microscope_water_murky>")))
    elseif choice.id == "soil" and has_slide(character, soil_slide) then
        use:message(use:expand_text(ccb.services.translate("You place the slide on the stage, adjust the light and focus the lens, you manage to see <microscope_soil>")))
    elseif choice.id == "cancel" then
        use:message(ccb.services.translate("You changed your mind."))
    end
    return 0
end)

local moon_phases = {
    new = 0, waxing_crescent = 1, waxing_half = 2, waxing_gibbous = 3,
    full = 4, waning_gibbous = 5, waning_half = 6, waning_crescent = 7,
}

local function report_reading(template, reading)
    services.messages.add((template:gsub("<context_val:[^>]+>", ("%.6g"):format(reading))))
end

ccb.runtime.handler("report_debug_weather", function()
    local precise = services.weather.current().precise
    report_reading(ccb.services.translate("moon_phase: <context_val:moon_phase>"),
        moon_phases[services.time.now():moon_phase()])
    report_reading(ccb.services.translate("temperature: <context_val:temperature> °C"), precise.temperature_c)
    report_reading(ccb.services.translate("humidity: <context_val:humidity> %"), precise.humidity)
    report_reading(ccb.services.translate("pressure: <context_val:pressure> mbar"), precise.pressure)
    report_reading(ccb.services.translate("windpower: <context_val:windpower> mph"), precise.wind_speed_mph)
    report_reading(ccb.services.translate("precipitation: <context_val:precipitation> mm/h"),
        precise.precipitation_mm_per_hour)
    return 0
end)

ccb.runtime.handler("toggle_debug_timer", function(use)
    local item = use.item
    local stored = services.items.get_var(item, "set_time")
    local started = 0
    if stored.ok then
        local value = stored.value
        if value.kind ~= "empty" then
            started = assert(tonumber(value.value or value.display), "Invalid timer start")
        end
    elseif stored.error.code ~= "not_found" then
        error(stored.error.message)
    end

    local now = services.time.now().turn
    if started == 0 then
        checked(services.items.set_var(item, "set_time", now))
        services.messages.add("Debug timer starts counting.")
    else
        services.messages.add(("%.6g seconds has passed since activation of a timer.  The timer has been reset.")
            :format(now - started))
        checked(services.items.set_var(item, "set_time", 0))
    end
    return 0
end)
