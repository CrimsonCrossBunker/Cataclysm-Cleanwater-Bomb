local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local persistent = ccb.state.world
local id = services.types.id
local M = {}

for _, options in ipairs {
    {
        id = "small_printout_portal_storm_data",
        name = ccb.content.text("short NRE printout"),
        description = ccb.content.text("A sequence of overlapping numbers plotted in thermal paper, at times so densely-packed that they disappear into thick blots of oxide-colored ink.  A few number sequences repeat in an almost orderly fashion, but you can't tell whether that means anything."),
        category = "books", mass_grams = 1, volume_ml = 4, color = "white", symbol = ",",
    },
    {
        id = "medium_printout_portal_storm_data", copy_from = "small_printout_portal_storm_data",
        name = ccb.content.text("NRE printout"),
        description = ccb.content.text("A long sequence of overlapping numbers plotted in thermal paper, at times so densely-packed that they disappear into thick blots of oxide-colored ink.  The blots and numbers are arranged in a strangely pleasing pattern."),
        mass_grams = 3, volume_ml = 8,
    },
    {
        id = "large_printout_portal_storm_data", copy_from = "small_printout_portal_storm_data",
        name = ccb.content.text("long NRE printout"),
        description = ccb.content.text("A very, very long sequence of overlapping numbers plotted in thermal paper.  It is almost 15 feet long."),
        mass_grams = 10, volume_ml = 50,
    },
    {
        id = "nre_anomaly_printout_data", copy_from = "small_printout_portal_storm_data",
        name = ccb.content.text("NRE anomaly printout"),
        description = ccb.content.text("A long sequence of overlapping numbers plotted in thermal paper, at times so densely-packed that they disappear into thick blots of oxide-colored ink.  The printed values increased along rhythmical waves, but the number 5 is always skipped."),
        mass_grams = 10, volume_ml = 50,
    },
} do
    local printout = ccb.content.Item(options)
    if options.id == "small_printout_portal_storm_data" then
        printout:material("paper", 1)
        printout:flag("TRADER_AVOID")
    end
    ccb.content.add(printout)
end

function M.has_recorder(character)
    return state.checked(services.inventory.has_items(character, id("item", "nre_recorder"), 0, 1))
        or state.checked(services.inventory.has_items(character, id("item", "robofac_mobile_weather_station"), 0, 1))
end

function M.capture(character)
    if not M.has_recorder(character) then return end
    travel.set(character, "generic_nre_anomaly", travel.number(character, "generic_nre_anomaly") + 1)
    state.message(character, services.translate("The NRE recorder emits a sharp beep!"), "info")
end

local function printout(character, item, count)
    state.message(character, services.translate("The recorder whirs as it starts printing the recorded data."), "info")
    state.checked(services.inventory.receive_item(character, id("item", item), count))
end

function M.print(character)
    if travel.number(character, "portal_storm_record") <= 0 and travel.number(character, "generic_nre_anomaly") <= 0 then
        state.message(character, services.translate("The recorder prints: \"NO DATA\" in a short piece of paper"), "info")
        return
    end
    for _, tier in ipairs {
        { 25, "large_printout_portal_storm_data" },
        { 3, "medium_printout_portal_storm_data" },
        { 1, "small_printout_portal_storm_data" },
    } do
        if travel.number(character, "portal_storm_record") >= tier[1] then
            printout(character, tier[2], 1)
            travel.set(character, "portal_storm_record", 0)
        end
    end
    local anomalies = travel.number(character, "generic_nre_anomaly")
    if anomalies >= 1 then
        printout(character, "nre_anomaly_printout_data", math.modf(anomalies))
        travel.set(character, "generic_nre_anomaly", 0)
    end
end

ccb.runtime.handler("nre_print_data", function(payload)
    if payload.character then M.print(payload.character) end
    return 0
end)
local recorder = ccb.content.Item {
    id = "nre_recorder", name = ccb.content.text("NRE recorder"),
    description = ccb.content.text("A strange apparatus, seemingly consisting of a glass-encased microphone linked to a small thermal printer and digital screen.  The screen remains perpetually blank, save for a battery indicator on its upper right, and on its left side lies a single red button: \"PRINT DATA\"."),
    mass_grams = 225, volume_ml = 2735, price_cents = 15000, price_postapoc_cents = 100,
    symbol = ";", color = "red",
}
recorder:material("plastic", 1)
recorder:material("aluminum", 1)
recorder:flag("WATER_BREAK")
recorder:melee_damage("bash", 2)
recorder:tool { ammo_types = { "battery" }, charges_per_use = 10 }
recorder:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
recorder:on_use("nre_print_data", ccb.content.text("Activate"), ccb.content.text("Activate the recorder's printer."))
ccb.content.add(recorder)
for _, options in ipairs {
    {
        id = "xedra_mobile_weather_station", name = ccb.content.text("mobile hazardous environment weather station"),
        -- Based on the ecoTech Mini Met and aem weather backpacks, with interdimensional equipment.
        description = ccb.content.text("A sleek black case housing a mix of mundane and otherworldly devices that can be deployed from the top of the box.  It is also equipped with a built-in analysis computer, a small thermal printer, and a rechargeable battery.  The case itself is outfitted with back straps and a telescoping stand.  \"X.E.D.R.A.\" and \"HE weather station\" are engraved on the case."),
        mass_grams = 6000, color = "black",
    },
    {
        id = "robofac_mobile_weather_station", name = ccb.content.text("mobile HEW-NRE station"),
        description = ccb.content.text("A brown and white case housing equipment to measure atmospheric conditions in extremely hazardous environments.  It is equipped with several deployable sensors, a Hub 01 NRE recorder, a built-in analysis computer, a thermal printer, and a rechargeable battery.  The case itself is outfitted with back straps and a telescoping stand.  The Hub 01 logo is displayed proudly on the case lid."),
        mass_grams = 6230, color = "brown",
    },
} do
    options.volume_ml = 90000
    options.longest_side_mm = 600
    options.price_cents = 90000
    options.price_postapoc_cents = 4050
    options.symbol = "["
    options.looks_like = "briefcase"
    local station = ccb.content.Item(options)
    station:material("plastic", 1)
    station:material("aluminum", 1)
    for _, flag in ipairs { "BELTED", "ELECTRONIC", "WATERPROOF", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" } do
        station:flag(flag)
    end
    station:tool { charges_per_use = 1 }
    station:armor { warmth = 10, max_worn = 1 }
    station:armor_portion { covers = { "torso" }, sub_parts = { "torso_hanging_back" }, encumbrance = 30, coverage = 80 }
    station:ammo_pocket("battery", 1000)
    if options.id == "robofac_mobile_weather_station" then
        station:on_use("nre_print_data", ccb.content.text("Activate"), ccb.content.text("Print NRE data."))
    end
    ccb.content.add(station)
end

local significant = {
    mon_hound_tindalos = true, mon_darkman = true, mon_zombie_phase_shrike = true,
    mon_swarm_structure = true, mon_better_half = true, mon_hallucinator = true,
    mon_archunk_strong = true, mon_void_spider = true, mon_XEDRA_officer = true,
    mon_eigenspectre_3 = true, mon_eigenspectre_4 = true, mon_living_vector = true,
}

ccb.runtime.handler("nre_anomaly_kill", function(event)
    local character = event.actors.killer
    if not character or not M.has_recorder(character) then return end
    if significant[event.data.victim_type] then
        travel.set(character, "generic_nre_anomaly", travel.number(character, "generic_nre_anomaly") + 1)
        state.message(character, services.translate("The NRE recorder emits a sharp beep!"), "info")
    end
end)
ccb.runtime.on("game:character_kills_monster", "nre_anomaly_kill")

local function weather()
    return services.weather.current().weather.value
end

local function awake()
    local current = weather()
    return current == "portal_storm" or current == "distant_portal_storm" or current == "close_portal_storm"
end

local function schedule()
    ccb.tasks.after_avatar_turn(300, "nre_storm_record_due")
    persistent.set("nre_storm_record_timer", "scheduled")
end

local function wake()
    if persistent.get("nre_storm_record_timer") == "dormant" and awake() then schedule() end
end

ccb.runtime.handler("nre_storm_record_due", function(payload)
    local character = payload.character
    local current = weather()
    local eligible = current == "portal_storm"
        or (current == "distant_portal_storm" and services.random.native_int(0, 11) == 0)
        or current == "close_portal_storm"
    local recorded = eligible and M.has_recorder(character) and state.checked(services.creatures.snapshot(character)).outside
    if recorded then
        local count = travel.number(character, "portal_storm_record") + 1
        travel.set(character, "portal_storm_record", count)
        if count >= 25 then
            state.message(character, services.translate("The NRE recorder emits a three beep sequence!"), "info")
        elseif count >= 3 then
            state.message(character, services.translate("The NRE recorder emits a two beep sequence!"), "info")
        elseif count >= 1 then
            state.message(character, services.translate("The NRE recorder emits a sharp beep!"), "info")
        end
    end
    if recorded or awake() then schedule() else persistent.set("nre_storm_record_timer", "dormant") end
end)

ccb.runtime.handler("nre_storm_record_ready", function(event)
    if event.actors.character.subtype ~= "avatar" then return end
    if ccb.tasks.has_avatar_turn("nre_storm_record_due") then
        persistent.set("nre_storm_record_timer", "scheduled")
    elseif event.new_character then
        schedule()
    else
        persistent.set("nre_storm_record_timer", "dormant")
        wake()
    end
end)
ccb.runtime.on("character_ready", "nre_storm_record_ready")
ccb.runtime.handler("nre_storm_record_weather", wake)
ccb.runtime.hook("on_weather_changed", "nre_storm_record_weather")
ccb.runtime.handler("nre_storm_record_conditions", function(event)
    if event.actors.character.subtype == "avatar" then wake() end
end)
ccb.runtime.on("character_conditions_changed", "nre_storm_record_conditions")

return M
