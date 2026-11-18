local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local number = state.number

local function has_active_mission(character, name)
    local offset = 0
    while true do
        local page = services.missions.active(character, { offset = offset, limit = 256 })
        for _, mission in ipairs(page.items) do
            if mission.selected and mission.id.value == name then return true end
        end
        if not page.has_more then return false end
        offset = offset + page.returned
    end
end

local function offer(response, mission, unlocked)
    response.condition = function(context)
        local character = context:speaker()
        return not has_active_mission(character, mission) and unlocked(character)
    end
    response.on_action = function(context)
        state.assign_mission(context:speaker(), mission)
    end
    return response
end

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADE",
    dynamic_line = "Here you may spend your treasures on upgrades.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Unlock: RANK UP 1", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "SKYISLAND_UPGRADE_rankup1", function()
            return number("islandrank") == 1
        end),
        offer({
            text = "Unlock: RANK UP 2", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "SKYISLAND_UPGRADE_rankup2", function()
            return number("islandrank") == 3
        end),
        { text = "Empower the warp obelisk.", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS" },
        { text = "Make the island more hospitable.", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM" },
        { text = "Upgrade expeditions.", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES" },
        { text = "Construction options.", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE" },
        { text = "Crafting options.", text_translation = {}, topic = "SKYISLAND_UPGRADES_ITEM_CRAFTING" },
        { text = "I need your services.", text_translation = {}, topic = "SKYISLAND_SERVICES" },
        { text = "I have some questions.", text_translation = {}, topic = "SKYISLAND_QUESTIONS" },
        { text = "Another time.  Goodbye.", text_translation = {}, topic = "TALK_DONE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADES_RAIDS",
    dynamic_line = "By empowering the warp obelisk, you can expand the quality and variety of available expeditions.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Unlock: Large Expeditions", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_raidlength1", function()
            return number("longerraids") == 0
                and number("islandrank") >= 2
        end),
        offer({
            text = "Unlock: Extended Expeditions", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_raidlength2", function()
            return number("longerraids") == 1
                and number("islandrank") >= 4
        end),
        offer({
            text = "Unlock Start Location: Basements", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_basementsunlock", function()
            return number("basementsunlocked") == 0
                and not ccb.content.is_mod_active("backrooms")
        end),
        offer({
            text = "Unlock Start Location: Rooftops", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_roofsunlock", function()
            return number("roofsunlocked") == 0
                and number("islandrank") >= 2
                and not ccb.content.is_mod_active("backrooms")
        end),
        offer({
            text = "Unlock Start Location: Labs", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_labsunlock", function()
            return number("labsunlocked") == 0
                and number("islandrank") >= 4
                and not ccb.content.is_mod_active("backrooms")
        end),
        offer({
            text = "Security Alpha", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_security1", function()
            return number("securitylevel") == 0
        end),
        offer({
            text = "Security Beta", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_security2", function()
            return number("securitylevel") == 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Security Gamma", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_security3", function()
            return number("securitylevel") == 2
                and number("islandrank") >= 4
        end),
        offer({
            text = "Security Epsilon", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_security4", function()
            return number("securitylevel") == 3
                and number("islandrank") >= 4
        end),
        offer({
            text = "Security Kappa", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_security5", function()
            return number("securitylevel") == 4
                and number("islandrank") >= 4
        end),
        -- Requires hardest missions unlocked, all bonus missions unlocked and at least stability 6 upgrade
        offer({
            text = "Challenge Mode", text_translation = {}, topic = "SKYISLAND_UPGRADES_RAIDS",
        }, "SKYISLAND_UPGRADE_challenge_mode", function()
            return number("bonusmissions") >= 5
                and number("hardestmissions") > 0
                and number("bonuspulses") >= 6
                and number("islandrank") >= 4
                and not ccb.content.is_mod_active("backrooms")
        end),
        { text = "Nevermind.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADES_TERRAFORM",
    dynamic_line = "There are many ways that the island could be made more hospitable for you.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Unlock: Personal Sunblock", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM",
        }, "SKYISLAND_UPGRADE_sunblock", function(character)
            return not state.has_trait(character, "mut_skyisland_sunblock")
        end),
        offer({
            text = "Unlock: Personal Radiation Shield", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM",
        }, "SKYISLAND_UPGRADE_radblock", function(character)
            return not state.has_trait(character, "mut_skyisland_radblock")
        end),
        offer({
            text = "Unlock: Personal Windblocker", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM",
        }, "SKYISLAND_UPGRADE_windblock", function(character)
            return not state.has_trait(character, "mut_skyisland_windblock")
        end),
        offer({
            text = "Unlock: Island-Side Resilience", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM",
        }, "SKYISLAND_UPGRADE_island_steady", function(character)
            return not state.has_trait(character, "mut_skyisland_island_steady")
        end),
        offer({
            text = "Unlock: Personal Temperature Adjustement", text_translation = {}, topic = "SKYISLAND_UPGRADES_TERRAFORM",
        }, "SKYISLAND_UPGRADE_personal_temperature_adaptation", function()
            return number("skyisland_bunker_temperature_adaptation") == 1
                and number("skyisland_personal_temperature_adaptation") == 0
        end),
        { text = "Nevermind.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADES_FEATURES",
    dynamic_line = "There are many abilities to learn that will help you on your expeditions.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Upgrade: Stability 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability1", function()
            return number("bonuspulses") == 0
        end),
        offer({
            text = "Upgrade: Stability 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability2", function()
            return number("bonuspulses") == 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Upgrade: Stability 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability3", function()
            return number("bonuspulses") == 2
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Stability 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability4", function()
            return number("bonuspulses") == 3
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Stability 5", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability5", function()
            return number("bonuspulses") == 4
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Stability 6", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability6", function()
            return number("bonuspulses") == 5
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Stability 7", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_stability7", function()
            return number("bonuspulses") == 6
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Scouting 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting1", function()
            return number("scoutingdistancetargets") == 0
        end),
        offer({
            text = "Upgrade: Scouting 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting2", function()
            return number("scoutingdistancetargets") == 1
        end),
        offer({
            text = "Upgrade: Scouting 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting3", function()
            return number("scoutingdistancetargets") == 2
                and number("islandrank") >= 2
        end),
        offer({
            text = "Upgrade: Scouting 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting4", function()
            return number("scoutingdistancetargets") == 4
        end),
        offer({
            text = "Upgrade: Scouting 5", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting5", function()
            return number("scoutingdistancetargets") == 6
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Scouting 6", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting6", function()
            return number("scoutingdistancetargets") == 10
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Scouting 7", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting7", function()
            return number("scoutingdistancetargets") == 14
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Scouting 8", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scouting8", function()
            return number("scoutingdistancetargets") == 18
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Scouting Clairvoyance 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scoutingclairvoyance1", function()
            return number("scoutingdistancetargets") == 4
                and number("scoutingclairvoyancetime") < 10
        end),
        offer({
            text = "Upgrade: Scouting Clairvoyance 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_scoutingclairvoyance2", function()
            return number("scouting_clairvoyance") == 1
                and number("scoutingclairvoyancetime") == 20
        end),
        offer({
            text = "Upgrade: Landing 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing1", function()
            return number("scoutingdistancelanding") == 0
        end),
        offer({
            text = "Upgrade: Landing 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing2", function()
            return number("scoutingdistancelanding") == 4
        end),
        offer({
            text = "Upgrade: Landing 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing3", function()
            return number("scoutingdistancelanding") == 8
                and number("islandrank") >= 2
        end),
        offer({
            text = "Upgrade: Landing 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing4", function()
            return number("scoutingdistancelanding") == 12
        end),
        offer({
            text = "Upgrade: Landing 5", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing5", function()
            return number("scoutingdistancelanding") == 16
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Landing 6", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing6", function()
            return number("scoutingdistancelanding") == 24
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Landing 7", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing7", function()
            return number("scoutingdistancelanding") == 32
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Landing 8", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing8", function()
            return number("scoutingdistancelanding") == 40
                and number("islandrank") >= 4
        end),
        offer({
            text = "Upgrade: Landing Water-Walking", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing_water_walking", function()
            return number("landing_waterwalk") == 0
                and number("scoutingdistancelanding") >= 16
        end),
        offer({
            text = "Upgrade: Landing Flight", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing_flight", function()
            return number("landing_flight") == 0
                and number("scoutingdistancelanding") >= 20
        end),
        offer({
            text = "Upgrade: Landing Phasing", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_landing_phase", function()
            return number("landing_phase") == 0
                and number("scoutingdistancelanding") >= 20
        end),
        offer({
            text = "Unlock: Slaughter Missions", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_slaughter", function()
            return number("slaughterunlocked") == 0
        end),
        offer({
            text = "Unlock: Two Exits per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_exit1", function()
            return number("bonusexits") == 0
        end),
        offer({
            text = "Unlock: Three Exits per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_exit2", function()
            return number("bonusexits") == 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Unlock: Four Exits per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_exit3", function()
            return number("bonusexits") == 2
                and number("islandrank") >= 3
        end),
        offer({
            text = "Unlock: Five Exits per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_exit4", function()
            return number("bonusexits") == 3
                and number("islandrank") >= 4
        end),
        offer({
            text = "Unlock: Expedition Missions", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_bonusmissions1", function()
            return number("bonusmissions") == 0
        end),
        offer({
            text = "Unlock: Two Missions per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_bonusmissions2", function()
            return number("bonusmissions") == 1
        end),
        offer({
            text = "Unlock: Three Missions per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_bonusmissions3", function()
            return number("bonusmissions") == 2
                and number("islandrank") >= 2
        end),
        offer({
            text = "Unlock: Four Missions per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_bonusmissions4", function()
            return number("bonusmissions") == 3
                and number("islandrank") >= 3
        end),
        offer({
            text = "Unlock: Five Missions per Expedition", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_bonusmissions5", function()
            return number("bonusmissions") == 4
                and number("islandrank") >= 4
        end),
        offer({
            text = "Unlock: Harder Missions", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_hardmissions1", function()
            return number("hardmissions") == 0
                and number("islandrank") >= 2
        end),
        offer({
            text = "Unlock: Hardest Missions", text_translation = {}, topic = "SKYISLAND_UPGRADES_FEATURES",
        }, "SKYISLAND_UPGRADE_hardmissions2", function()
            return number("hardmissions") == 10
                and number("islandrank") >= 4
        end),
        { text = "Nevermind…", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
    dynamic_line = "The Island is your home now.  It will be prudent to make it livable.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Construct: Bunker Entrance", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_base1", function()
            return number("skyisland_build_base") == 0
        end),
        offer({
            text = "Construct: Main Room 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_bigroom1", function()
            return number("skyisland_build_bigroom") == 0
                and number("skyisland_build_base") == 1
        end),
        offer({
            text = "Construct: Main Room 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_bigroom2", function()
            return number("skyisland_build_bigroom") == 1
        end),
        offer({
            text = "Construct: Main Room 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_bigroom3", function()
            return number("skyisland_build_bigroom") == 2
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: Main Room 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_bigroom4", function()
            return number("skyisland_build_bigroom") == 3
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: West Room 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_westroom1", function()
            return number("skyisland_build_bigroom") >= 1
                and number("skyisland_build_westroom") == 0
        end),
        offer({
            text = "Construct: West Room 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_westroom2", function()
            return number("skyisland_build_westroom") == 1
                and number("skyisland_build_bigroom") >= 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: West Room 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_westroom3", function()
            return number("skyisland_build_westroom") == 2
                and number("skyisland_build_bigroom") >= 2
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: West Room Gallery", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_westroom4", function()
            return number("skyisland_build_westroom") == 3
                and number("skyisland_build_bigroom") >= 3
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: West Side Rooms", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_west_side_rooms", function()
            return number("skyisland_build_westroom") >= 3
                and number("skyisland_build_bigroom") >= 3
                and number("skyisland_build_west_side_rooms") == 0
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: East Room 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_eastroom1", function()
            return number("skyisland_build_bigroom") >= 1
                and number("skyisland_build_eastroom") == 0
        end),
        offer({
            text = "Construct: East Room 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_eastroom2", function()
            return number("skyisland_build_eastroom") == 1
                and number("skyisland_build_bigroom") >= 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: East Room 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_eastroom3", function()
            return number("skyisland_build_eastroom") == 2
                and number("skyisland_build_bigroom") >= 2
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: East Room Gallery", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_eastroom4", function()
            return number("skyisland_build_eastroom") == 3
                and number("skyisland_build_bigroom") >= 3
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: East Side Rooms", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_east_side_rooms", function()
            return number("skyisland_build_eastroom") >= 3
                and number("skyisland_build_bigroom") >= 3
                and number("skyisland_build_east_side_rooms") == 0
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: North Room 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_northroom1", function()
            return number("skyisland_build_bigroom") >= 1
                and number("skyisland_build_northroom") == 0
        end),
        offer({
            text = "Construct: North Room 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_northroom2", function()
            return number("skyisland_build_northroom") == 1
                and number("skyisland_build_bigroom") >= 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: North Room 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_northroom3", function()
            return number("skyisland_build_northroom") == 2
                and number("skyisland_build_bigroom") >= 2
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: North Room 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_northroom4", function()
            return number("skyisland_build_northroom") == 3
                and number("skyisland_build_bigroom") >= 3
                and number("islandrank") >= 3
        end),
        offer({
            text = "Construct: North Side Rooms", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_north_side_rooms", function()
            return number("skyisland_build_northroom") >= 3
                and number("skyisland_build_bigroom") >= 3
                and number("skyisland_build_north_side_rooms") == 0
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: Central Skylight 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_centralskylight2", function()
            return number("skyisland_build_bigroom") >= 2
                and number("skyisland_build_centralskylight") == 0
        end),
        offer({
            text = "Construct: Central Skylight 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_centralskylight3", function()
            return number("skyisland_build_bigroom") >= 3
                and number("skyisland_build_centralskylight") == 1
        end),
        offer({
            text = "Construct: Central Skylight 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_centralskylight4", function()
            return number("skyisland_build_bigroom") >= 4
                and number("skyisland_build_centralskylight") == 2
        end),
        offer({
            text = "Construct: Climate Control", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_bunker_temperature_adaptation", function()
            return number("skyisland_build_bigroom") >= 2
                and number("islandrank") >= 3
                and number("skyisland_bunker_temperature_adaptation") == 0
        end),
        offer({
            text = "Construct: Merchant Stall", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_merchant_stall", function()
            return number("skyisland_merchant_stall") ~= 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: South Room 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse1", function()
            return number("skyisland_build_greenhouse") == 0
                and number("skyisland_build_base") == 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: South Room 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse2", function()
            return number("skyisland_build_greenhouse") == 1
                and number("islandrank") >= 2
        end),
        offer({
            text = "Construct: South Room 3", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse3", function()
            return number("skyisland_build_greenhouse") == 2
                and number("skyisland_bunker_temperature_adaptation") >= 1
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: South Room 4", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse4", function()
            return number("skyisland_build_greenhouse") == 3
                and number("skyisland_bunker_temperature_adaptation") >= 1
                and number("islandrank") >= 4
        end),
        offer({
            text = "Construct: South Skylight 1", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse_skylight1", function()
            return number("skyisland_build_greenhouse") >= 1
                and number("skyisland_build_greenhouse_skylight") == 0
        end),
        offer({
            text = "Construct: South Skylight 2", text_translation = {}, topic = "SKYISLAND_UPGRADES_INFRASTRUCTURE",
        }, "SKYISLAND_BUILD_south_greenhouse_skylight2", function()
            return number("skyisland_build_greenhouse") >= 2
                and number("skyisland_build_greenhouse_skylight") == 1
        end),
        {
            text = "One of my bunker constructions had an error.  Could you help me fix it?", text_translation = {}, topic = "SKYISLAND_FIX_CONSTRUCTIONS",
            condition = function()
                return number("skyisland_build_base") >= 1
            end,
        },
        { text = "Nevermind.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
    },
}

ccb.dialogue.register_topic {
    id = "SKYISLAND_UPGRADES_ITEM_CRAFTING",
    dynamic_line = "There is much to learn from the Heart of the Island.",
    dynamic_line_translation = {},
    responses = {
        offer({
            text = "Learn: warped hauler's harness mk II", text_translation = {}, topic = "SKYISLAND_UPGRADES_ITEM_CRAFTING",
        }, "SKYISLAND_UPGRADE_WARPED_HARNESS_TIER_2", function()
            return number("skyisland_warped_harness_upgrade") == 0
                and number("islandrank") >= 2
        end),
        offer({
            text = "Learn: warped hauler's harness mk III", text_translation = {}, topic = "SKYISLAND_UPGRADES_ITEM_CRAFTING",
        }, "SKYISLAND_UPGRADE_WARPED_HARNESS_TIER_3", function()
            return number("skyisland_warped_harness_upgrade") == 1
                and number("islandrank") >= 4
        end),
        { text = "Nevermind.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
    },
}

ccb.runtime.handler("sky_island_heart", function(payload)
    state.checked(services.characters.open_topic(payload.character, "SKYISLAND_UPGRADE"))
end)

local heart = ccb.content.Furniture {
    id = "f_islandstatue",
    name = ccb.content.text("Island's Heart"),
    description = ccb.content.text("A swirling, surreal statue of organic shapes carved from dark stone.  In your head, a voice speaks faintly.  Despite its massive size, it's surprisingly easy to move around the island.\n\nIt seems you can interact with it."),
    symbol = "S", color = "dark_gray", looks_like = "f_statue",
    move_cost_mod = -1, coverage = 0, required_str = 1, mass_grams = 1000000,
    crafting_pseudo_item = "fakeitem_statue", transparent = true,
}
heart:flag("NOCOLLIDE")
heart:flag("NO_PICKUP_ON_EXAMINE")
heart:flag("TRANSPARENT")
heart:on_examine("sky_island_heart")
ccb.content.add(heart)
