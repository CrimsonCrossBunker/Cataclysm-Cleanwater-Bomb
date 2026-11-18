local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local healing = require("raid_healing")
local id = services.types.id
local M = {}

local menus = {
    pulse = {
        title = function() return ccb.services.translate("Select a Difficulty") end,
        entries = {
            { id = "1", hotkey = "1",
                label = function() return ccb.services.translate("Casual") end,
                description = function() return ccb.services.translate("In Casual difficulty, time limits are more relaxed.\nWarp pulses occur every 30 minutes.  This means warp sickness sets in after 4 hours of being earthside, and disintegration at 6 hours.  You will have more time for activities and reaching the extract should generally not be a problem.") end },
            { id = "2", hotkey = "2",
                label = function() return ccb.services.translate("Normal") end,
                description = function() return ccb.services.translate("In Normal Difficulty, pulses occur every 15 minutes.  This means on every expedition, you will have 2 hours to explore, fight, loot, and find the exit before warp sickness sets in, and 3 hours total before disintegration begins.\nThis is the intended way to play.  Getting to the exit is not a cakewalk, but you should have time to explore while earthside.") end },
            { id = "3", hotkey = "3",
                label = function() return ccb.services.translate("Hard") end,
                description = function() return ccb.services.translate("In Hard difficulty, time limits are strict.\nWarp pulses occur every 10 minutes.  This means warp sickness sets in after only 1 hour 20 minutes of being earthside, and disintegration at 2 hours.  You will have much less time to spare and must make getting to the exit your immediate priority.") end },
            { id = "4", hotkey = "4",
                label = function() return ccb.services.translate("Impossible") end,
                description = function() return ccb.services.translate("In Impossible difficulty, time limits are extremely tight.\nWarp pulses occur every 5 minutes.  This means warp sickness sets in after only 40 minutes of being earthside, and disintegration at 1 hour.  Reaching the extract alive will take all the time you can spare, and warp sickness will be common.  You will not be given mercy!") end },
        },
    },
    return_mode = {
        title = function() return ccb.services.translate("Adjust Return Obelisk Behavior") end,
        entries = {
            { id = "1", hotkey = "1",
                label = function() return ccb.services.translate("Whole Room") end,
                description = function() return ccb.services.translate("Set the behavior of the return obelisk.\nWith this option, everything in the room with you will return to your sky island.  Getting resources will generally not be a problem as long as you make it to the extraction point.") end },
            { id = "2", hotkey = "2",
                label = function() return ccb.services.translate("Whole Room for a Cost") end,
                description = function() return ccb.services.translate("Set the behavior of the return obelisk.\nWith this option, if you have a warp vortex token with you, everything in the room with you will return to your sky island.  Otherwise, only what you are carrying on your person will return with you.  You may have to make difficult choices about what to bring back.") end },
            { id = "3", hotkey = "3",
                label = function() return ccb.services.translate("Self Only") end,
                description = function() return ccb.services.translate("Set the behavior of the return obelisk.\nWith this option, only what you are carrying on your person will return with you.  You will always have to make difficult choices about what to bring back.") end },
        },
    },
    emergency = {
        title = function() return ccb.services.translate("Select Emergency Return Options") end,
        entries = {
            { id = "1", hotkey = "1",
                label = function() return ccb.services.translate("Get the Warp Home spell") end,
                description = function() return ccb.services.translate("Set the possibility of returning home without the extraction point.\nWith this option, you will receive a spell that will return you home at any time for no cost.  It takes one minute to cast.  Using this will remove most of the challenge of the mod.") end },
            { id = "2", hotkey = "2",
                label = function() return ccb.services.translate("Get the Warped Return spell") end,
                description = function() return ccb.services.translate("Set the possibility of returning home without the extraction point.\nWith this option, you will receive a spell that will return you home at any time by paying 1 warp shard.  It takes one minute to cast.  You may not be near any enemies when the spell is successfully cast or it will have no effect.") end },
            { id = "3", hotkey = "3",
                label = function() return ccb.services.translate("Get the Warped Skyward Beacon recipe") end,
                description = function() return ccb.services.translate("Set the possibility of returning home without the extraction point.\nWith this option, you will receive a recipe to craft a Warped Skyward Beacon.  This costs 5 warp shards and when used, casts the Warped Return spell.") end },
            { id = "4", hotkey = "4",
                label = function() return ccb.services.translate("Get nothing") end,
                description = function() return ccb.services.translate("Set the possibility of returning home without the extraction point.\nWith this option, your only choice is to find the extraction point.  Good luck!") end },
        },
    },
}

local pulse_messages = {
    function() return ccb.services.translate("Difficulty set to Casual.  You can speak to the Heart of the Island to change this at any time.") end,
    function() return ccb.services.translate("Difficulty set to Normal.  You can speak to the Heart of the Island to change this at any time.") end,
    function() return ccb.services.translate("Difficulty set to Hard.  You can speak to the Heart of the Island to change this at any time.") end,
    function() return ccb.services.translate("Difficulty set to Impossible.  You can speak to the Heart of the Island to change this at any time.") end,
}

local return_messages = {
    function() return ccb.services.translate("Warp home behavior set to whole room.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
    function() return ccb.services.translate("Warp home behavior set to whole room at a cost.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
    function() return ccb.services.translate("Warp home behavior set to self only.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
}

local emergency_messages = {
    function() return ccb.services.translate("Warp Home spell granted.  You may find it in your spellcasting menu.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
    function() return ccb.services.translate("Warped Return spell granted.  You may find it in your spellcasting menu.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
    function() return ccb.services.translate("Warped Skyward Beacon recipe granted.  You may find it in the Warp crafting menu.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
    function() return ccb.services.translate("All additional returning options removed.  You can use the Difficulty Adjuster if you wish to change your setting at any time.") end,
}

local function choose(character, menu)
    local entries = {}
    for _, row in ipairs(menu.entries) do
        entries[#entries + 1] = { id = row.id, hotkey = row.hotkey,
            label = state.text(character, row.label()), description = state.text(character, row.description()) }
    end
    return services.interaction.choose(entries, { title = state.text(character, menu.title()),
        allow_cancel = false, highlight_disabled = false, show_descriptions = true }).index
end

local function spell_level(character, name, level)
    state.checked(services.spells.set_level(character, id("spell", name), level))
end

local function recipe(character, name, learn)
    if learn then
        state.checked(services.recipes.learn(character, id("recipe", name)))
    else
        state.checked(services.recipes.forget(character, id("recipe", name)))
    end
end

function M.defaults(character)
    state.message(character, ccb.services.translate("All difficulty settings set to default.  You can speak to the Heart of the Island to change these at any time."))
    state.set("sicknessintervals", 15 * 60)
    state.set("roomteleportselector", 1)
    spell_level(character, "warp_home", -1)
    spell_level(character, "warped_return", -1)
    recipe(character, "warp_skyward_beacon", true)
    state.set("has_set_difficulty", 1)
end

function M.configure(character)
    local pulse = choose(character, menus.pulse)
    if not pulse then return end
    state.message(character, pulse_messages[pulse]())
    state.set("sicknessintervals", ({ 30, 15, 10, 5 })[pulse] * 60)

    local return_mode = choose(character, menus.return_mode)
    if not return_mode then return end
    state.message(character, return_messages[return_mode]())
    state.set("roomteleportselector", return_mode - 1)
    recipe(character, "warp_vortex_token", return_mode == 2)

    local emergency = choose(character, menus.emergency)
    if not emergency then return end
    state.message(character, emergency_messages[emergency]())
    if emergency == 1 then
        spell_level(character, "warped_return", -1)
        recipe(character, "warp_skyward_beacon", false)
        spell_level(character, "warp_home", 0)
        state.checked(services.spells.set_experience(character, id("spell", "warp_home"), 0))
    elseif emergency == 2 then
        spell_level(character, "warp_home", -1)
        recipe(character, "warp_skyward_beacon", false)
        spell_level(character, "warped_return", 0)
        state.checked(services.spells.set_experience(character, id("spell", "warped_return"), 0))
    elseif emergency == 3 then
        spell_level(character, "warp_home", -1)
        spell_level(character, "warped_return", -1)
        recipe(character, "warp_skyward_beacon", true)
    else
        spell_level(character, "warp_home", -1)
        recipe(character, "warp_skyward_beacon", false)
        spell_level(character, "warped_return", -1)
    end
    state.set("has_set_difficulty", 1)
end

function M.statistics(character)
    state.set("readablepulselimit", 8 + state.number("bonuspulses"))
    state.set("readabledisintegrationlimit", 12 + state.number("bonuspulses"))
    state.message(character, ccb.services.translate("Total expeditions: <global_val:raidstotal>\nWins: <global_val:raidswon>\nLosses: <global_val:raidslost>\nMissions complete: <u_val:missionswon>\nSlaughter missions complete: <global_val:slaughterswon>\n\nCurrent difficulty settings:\nWarpsickness at: <global_val:readablepulselimit> pulses.\nDisintegration at: <global_val:readabledisintegrationlimit> pulses.\nDefault pulse length: <global_val:readablesicknessintervals> minutes."), "neutral", true)
end

function M.progress(character)
    local rank = state.number("islandrank")
    if rank >= 0 then state.set("islandrank_readable", rank >= 4 and 2 or rank >= 2 and 1 or 0) end
    local missions = state.number("hardmissions")
    if missions >= 0 then state.set("hardmissions_readable", missions >= 15 and 3 or missions >= 10 and 2 or 1) end
    state.set("totalstarts", 1 + state.number("basementsunlocked") + state.number("roofsunlocked") + state.number("labsunlocked"))
    state.set("totalexits", 1 + state.number("bonusexits"))
    state.message(character, ccb.services.translate("Island Rank: <global_val:islandrank_readable> of 2\nExpedition Lengths: <global_val:longerraids> of 2\nExpedition Starts: <global_val:totalstarts> of 4\nBonus Pulses: <global_val:bonuspulses> of 7\nTarget reveal distance: <global_val:scoutingdistancetargets> of 22\nLanding reveal distance: <global_val:scoutingdistancelanding> of 48\nWarpcloak duration in seconds: <global_val:invistime> of 150\nSlaughter missions unlocked: <global_val:slaughterunlocked> of 1\nExits per expedition: <global_val:totalexits> of 5\nMissions per expedition: <global_val:bonusmissions> of 5\nMission tiers unlocked: <global_val:hardmissions_readable> of 3"), "neutral", true)
end

function M.construction(character)
    state.message(character, ccb.services.translate("Entrance: <global_val:skyisland_build_base> of 1\nMain Room: <global_val:skyisland_build_bigroom> of 4"), "neutral", true)
end

ccb.dialogue.register_topic {
    id = "SKYISLAND_SERVICES", dynamic_line = "How may I help?", dynamic_line_translation = {},
    responses = {
        {
            text = "Heal me.  (Free)", text_translation = {}, topic = "SKYISLAND_SERVICES",
            condition = function() return state.number("islandrank") == 0 end,
            on_action = function(context) healing.at_heart(context:speaker()) end,
        },
        {
            text = "Heal me.  (Costs 4 Warp Shards)", text_translation = {}, topic = "SKYISLAND_SERVICES",
            condition = function() return state.number("islandrank") ~= 0 end,
            on_action = function(context) healing.at_heart(context:speaker()) end,
        },
        {
            text = "End an active portal storm.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context)
                local character = context:speaker()
                ccb.runtime.call_character("portal_storm_cancel", character)
                state.message(character, ccb.services.translate("The air crackles with static electricity, then stabilizes."), "neutral", true)
            end,
        },
        {
            text = "Save me from danger.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context)
                local character = context:speaker()
                spell_level(character, "island_hostile_eviction", 1)
                spell_level(character, "island_close_tear_and_portal", 1)
                state.message(character, ccb.services.translate("You now have the power to close holes in existence and banish hostiles from the island until your next expedition."), "neutral", true)
            end,
        },
        {
            text = "View my expedition stats.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context) M.statistics(context:speaker()) end,
        },
        {
            text = "View my upgrade stats.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context) M.progress(context:speaker()) end,
        },
        {
            text = "View my construction stats.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context) M.construction(context:speaker()) end,
        },
        {
            text = "Change my difficulty settings.", text_translation = {}, topic = "SKYISLAND_SERVICES",
            on_action = function(context) M.configure(context:speaker()) end,
        },
        { text = "Let's return to discussing upgrades.", text_translation = {}, topic = "SKYISLAND_UPGRADE" },
        { text = "That's all.  Goodbye.", text_translation = {}, topic = "TALK_DONE" },
    },
}

return M
