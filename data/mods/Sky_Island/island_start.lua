local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = require("raid_state")
local difficulty = require("raid_services")

ccb.runtime.handler("sky_island_start", function(payload)
    -- Native scenario effects are queued for the Character's turn, after placement.
    ccb.tasks.after_character_turn(payload.character, 0, "sky_island_start_due")
end)

ccb.runtime.handler("sky_island_start_due", function(payload)
    local character = payload.character
    state.message(character, services.translate("Welcome to Sky Islands.\n\nSpeak to the Heart of the Island to get your bearings, accept missions, manage upgrades, change your difficulty settings, and more."), "neutral", true)
    state.set("OM_HQ_origin", state.position(character))
    difficulty.defaults(character)
    state.set("currentpulselength", state.number("sicknessintervals"))
    for _, setting in ipairs {
        { "timeawayfromhome", 0 },
        { "raidstotal", 0 },
        { "raidswon", 0 },
        { "raidslost", 0 },
        { "islandrank", 0 },
        { "missionswon", 0 },
        { "slaughterswon", 0 },
        { "hardmissions", 0 },
        { "hardermissions", 0 },
        { "hardestmissions", 0 },
        { "scoutingdistancetargets", 0 },
        { "scoutingdistancelanding", 0 },
        { "missiondistancemax", 30 },
        { "missiondistancemin", 5 },
        { "exfildistancemax", 35 },
        { "exfildistancemin", 10 },
        { "invistime", 60 },
        { "bonusexits", 0 },
        { "versionupdate", 1 },
        { "slaughterunlocked", 0 },
        { "bonusmissions", 0 },
        { "bonuspulses", 0 },
        { "longerraids", 0 },
        { "basementsunlocked", 0 },
        { "roofsunlocked", 0 },
        { "labsunlocked", 0 },
        { "goingtolabs", 0 },
        { "skyisland_build_base", 0 },
        { "skyisland_build_bigroom", 0 },
        { "skyisland_warped_harness_upgrade", 0 },
    } do
        state.set(setting[1], setting[2])
    end
end)

local location = content.StartLocation { id = "sloc_skyisland", name = content.text("Sky Island") }
location:terrain("sky_island_core")
content.add(location)

content.add(content.Scenario {
    id = "scenario_warper",
    name = content.text("Warper", "scenario_male"),
    female_name = content.text("Warper", "scenario_female"),
    description = content.text("As if the world ending wasn't enough, it seems some kind of extradimensional powers that be have taken an interest in you.  You have been placed on a floating island high above the Earth, safe but isolated.  Only by using the reality-bending powers of warp technology can you visit the world below in brief, randomly-targeted excursions.  Venture down, gather supplies, and return with only what you can carry to upgrade your home base and your stash over time.  The powers of the warp make you unable to ever truly die, so on failing such an expedition, you will simply lose all items and equipment you were carrying and be swiftly returned home at low health.", "scen_desc_male"),
    female_description = content.text("As if the world ending wasn't enough, it seems some kind of extradimensional powers that be have taken an interest in you.  You have been placed on a floating island high above the Earth, safe but isolated.  Only by using the reality-bending powers of warp technology can you visit the world below in brief, randomly-targeted excursions.  Venture down, gather supplies, and return with only what you can carry to upgrade your home base and your stash over time.  The powers of the warp make you unable to ever truly die, so on failing such an expedition, you will simply lose all items and equipment you were carrying and be swiftly returned home at low health.", "scen_desc_female"),
    start_name = content.text("Warper", "start_name"),
    points = 0, locations = { "sloc_skyisland" },
    flags = { "LONE_START", "CHALLENGE" },
    on_start = "sky_island_start",
})

local whitelist = content.Blacklist { kind = "scenario", whitelist = true }
whitelist:entry("scenario_warper")
if content.is_mod_active("xedra_evolved") then
    whitelist:entry(require("mod_interactions.xedra_evolved.scenarios"))
end
content.add(whitelist)
