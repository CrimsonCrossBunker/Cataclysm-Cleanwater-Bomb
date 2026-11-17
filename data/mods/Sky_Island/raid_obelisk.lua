local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local teleport = require("raid_teleport")
local id = services.types.id

local menus = {
    length = {
        title = function() return services.translate("Select Expedition Length.\nNPCs: <global_val:si_npcs_will_join_raid_warning> join expeditions.\nChallenge Mode: <global_val:challenge_mode_warning>") end,
        entries = {
            { id = "quick", label = function() return services.translate("Quick Expedition") end, hotkey = "1",
                description = function() return services.translate("A simple, brief expedition at the normal time limit.  Missions and exits will be close together.  A good chance to quickly gather supplies and experience.") end },
            { id = "large", label = function() return services.translate("Large Expedition") end, hotkey = "2",
                description = function() return services.translate("A longer expedition that offers twice the time.  Missions and exits will be scattered over a wider area.  You will have more opportunity to dig deeper into surrounding points of interest, but also need more time to travel.  Missions offer extra warp shards as rewards.") end },
            { id = "extended", label = function() return services.translate("Extended Expedition") end, hotkey = "3",
                description = function() return services.translate("A very long expedition that triples the time limit.  Missions and exits will be very far away.  You will have time for extended activities, but a good deal of your time will be spent trying to reach objectives over potentially dangerous terrain.  Missions offer even more warp shards as rewards.") end },
            { id = "npcs", label = function() return services.translate("Toggle NPC Mode") end, hotkey = "4",
                description = function() return services.translate("Toggles NPC Mode, changing whether NPCs will join you on a raid or not.") end },
            { id = "challenge", label = function() return services.translate("Toggle Challenge Mode") end, hotkey = "5",
                description = function() return services.translate("Toggles Challenge Mode, granting more rewards at the cost of harder expeditions.  A random difficulty modifier will be applied.") end },
            { id = "cancel", label = function() return services.translate("Cancel") end, hotkey = "6",
                description = function() return services.translate("Stay on the island for now.") end },
        },
    },
    destination = {
        title = function() return services.translate("Select a starting location") end,
        entries = {
            { id = "field", label = function() return services.translate("Target: Field") end, hotkey = "1",
                description = function() return services.translate("Arrive in a barren field.  This usually means landing in the open wilderness, but there's always the chance you'll find yourself at an empty lot in town.") end },
            { id = "basement", label = function() return services.translate("Target: Basement") end, hotkey = "2",
                description = function() return services.translate("Arrive inside an underground basement.  This will tend to put you somewhere in suburbia, but there are always exceptions.") end },
            { id = "roof", label = function() return services.translate("Target: Rooftop") end, hotkey = "3",
                description = function() return services.translate("Arrive on a building roof someplace.  Usually this means houses, but you never know for sure.  This will always be one story off the ground.") end },
            { id = "labs", label = function() return services.translate("Target: Lab") end, hotkey = "4",
                description = function() return services.translate("Arrive somewhere in a hidden government lab.  This is a highly dangerous method.  Due to the dimensional shielding these labs project, this expedition will cost 1 Labs Catalyst to begin.\nBE WARNED!  You will begin inside a sealed lab, so make sure you have the means to get out!  A second card, to unlock the surface exit, is one option.  You may also consider a homeward mote or a warp skyward beacon.") end },
            { id = "cancel", label = function() return services.translate("Cancel") end, hotkey = "5",
                description = function() return services.translate("Stay on the island for now.") end },
        },
    },
    labs = {
        title = function() return services.translate("Select a starting location") end,
        entries = {
            { id = "science", label = function() return services.translate("Target: Science Lab") end, hotkey = "1",
                description = function() return services.translate("Arrive in subterranean science lab.\nBE WARNED!  You will begin inside a sealed lab, so make sure you have the means to get out!  A second card, to unlock the surface exit, is one option.  You may also consider a homeward mote or a warp skyward beacon.") end },
            { id = "microlab", label = function() return services.translate("Target: Large Science Lab") end, hotkey = "2",
                description = function() return services.translate("Arrive in a sprawling lab built around a hallway.\nBE WARNED!  You will begin inside a sealed lab, so make sure you have the means to get out!  A second card, to unlock the surface exit, is one option.  You may also consider a homeward mote or a warp skyward beacon.") end },
            { id = "research", label = function() return services.translate("Target: Research Facility") end, hotkey = "3",
                description = function() return services.translate("Arrive in an above-ground research facility.\nBE WARNED!  The facility was extremely damaged by the Cataclysm and the environment is filled with hostiles.  Be prepared when you undertake this mission.") end },
            { id = "tcl", label = function() return services.translate("Target: Tran-Coastal Logistics") end, hotkey = "4",
                description = function() return services.translate("Arrive in a lab within a shipping facility.\nBE WARNED!  You will begin inside a sealed facility, so make sure you have the means to get out!  You may also consider a homeward mote or a warp skyward beacon.") end },
            { id = "cancel", label = function() return services.translate("Cancel") end, hotkey = "5",
                description = function() return services.translate("Stay on the island for now.") end },
        },
    },
    backrooms = {
        title = function() return services.translate("Select a starting location") end,
        entries = {
            { id = "level_zero", label = function() return services.translate("Target: Level 0") end, hotkey = "1",
                description = function() return services.translate("Arrive in the boundless monotone yellow space of level 0.") end },
            { id = "cancel", label = function() return services.translate("Cancel") end, hotkey = "2",
                description = function() return services.translate("Stay on the island for now.") end },
        },
    },
}

local function labs_available(character)
    return state.number("labsunlocked") == 1
        and state.checked(services.inventory.has_items(character, id("item", "warp_labs_catalyst"), 1, 0))
end

local function available(character, key)
    if key == "large" then return state.number("longerraids") >= 1 end
    if key == "extended" then return state.number("longerraids") >= 2 end
    if key == "challenge" then return state.number("challenge_mode_available") > 0 end
    if key == "basement" then return state.number("basementsunlocked") == 1 end
    if key == "roof" then return state.number("roofsunlocked") == 1 end
    if key == "labs" or key == "science" or key == "microlab" or key == "research" or key == "tcl" then
        return labs_available(character)
    end
    return true
end

local function choose(character, menu)
    local entries = {}
    for _, row in ipairs(menu.entries) do
        entries[#entries + 1] = { id = row.id, label = state.text(character, row.label()),
            description = state.text(character, row.description()), hotkey = row.hotkey,
            enabled = available(character, row.id) }
    end
    return services.interaction.choose(entries, { title = state.text(character, menu.title()),
        allow_cancel = false, highlight_disabled = false, show_descriptions = true }).id
end

local function cancel(character)
    state.message(character, services.translate("You decide not to go out just yet."))
end

local locations = {
    field = { terrain = "field", z = 0, range = 200, minimum = 0, match = "contains" },
    basement = { terrain = "basement", z = -1, range = 200, minimum = 0, match = "contains", local_terrain = "t_thconc_floor" },
    roof = { terrain = "roof", z = 1, range = 200, minimum = 0, match = "contains", local_terrain = "t_gutter" },
    science = { terrain = "microlab_generic_edge", z = -2, range = 200, minimum = 0, match = "contains", local_terrain = "t_thconc_floor", lab = true },
    microlab = { terrain = "microlab_generic_hallway", z = -2, range = 1200, minimum = 200, match = "contains", local_terrain = "t_carpet_concrete_red", lab = true },
    research = { terrain = "lab_surface_parking_blockC1", z = 0, range = 1200, minimum = 200, local_terrain = "t_pavement", lab = true },
    tcl = { terrain = "lab_CORE_2x1_SED_ground", z = 0, range = 1200, minimum = 200, match = "contains", local_terrain = "t_thconc_floor", lab = true },
    level_zero = { terrain = "backfloorchamber", z = 0, range = 200, minimum = 0 },
}

local function depart(character, key)
    local location = locations[key]
    local research_override = key == "research" and services.gameplay.mods.is_loaded("mindovermatter")
    if key == "level_zero" then state.set("sky_island_target_region_settings", "backrooms_level_0") end
    if not research_override then teleport.dimension_shift(character) end
    state.find_location(character, research_override and "psi_phavian_lab_blockC1" or location.terrain,
        location.match, { search_range = location.range, min_distance = location.minimum,
            z = location.z, random = true }, state.number("scoutingdistancelanding"), location.local_terrain)
    if location.lab then state.set("goingtolabs", 1) end
    teleport.arrive(character)
end

local raid_ranges = {
    { { 30, 5, 35, 5 }, { 10, 5, 12, 5 } },
    { { 60, 20, 90, 30 }, { 20, 10, 30, 10 } },
    { { 80, 30, 160, 50 }, { 30, 15, 50, 20 } },
}

local function expedition(character, length)
    state.set("lengthofthisraid", length)
    state.set("currentpulselength", state.number("sicknessintervals") * (length + 1))
    local backrooms = services.gameplay.mods.is_loaded("backrooms")
    local ranges = raid_ranges[length + 1][backrooms and 2 or 1]
    for index, key in ipairs { "missiondistancemax", "missiondistancemin", "exfildistancemax", "exfildistancemin" } do
        state.set(key, ranges[index])
    end
    local selection = choose(character, backrooms and menus.backrooms or menus.destination)
    if selection == "labs" then selection = choose(character, menus.labs) end
    if selection == "cancel" then cancel(character)
    elseif selection then depart(character, selection) end
end

ccb.runtime.handler("sky_raid_obelisk", function(payload)
    local character = payload.character
    while true do
        state.set("challenge_mode_warning", state.number("challenge_mode_active") == 1
            and "<color_red>Enabled</color>" or "<color_dark_gray>Disabled</color>")
        state.set("si_npcs_will_join_raid_warning", state.number("si_npcs_will_join_raid") == 1
            and "<color_green>Will</color>" or "<color_red>Will not</color>")
        local selection = choose(character, menus.length)
        if selection == "npcs" then
            local enabled = state.number("si_npcs_will_join_raid") ~= 1
            state.set("si_npcs_will_join_raid", enabled and 1 or 0)
            state.message(character, enabled and services.translate("NPCs <color_green>will</color> join you on expeditions.")
                or services.translate("NPCs <color_red>will not</color> join you on expeditions."), "neutral", true)
        elseif selection == "challenge" then
            local enabled = state.number("challenge_mode_active") ~= 1
            state.set("challenge_mode_active", enabled and 1 or 0)
            state.message(character, enabled and services.translate("Challenge Mode has been activated.")
                or services.translate("Challenge Mode has been deactivated."), "neutral", true)
        else
            if selection == "cancel" then cancel(character)
            elseif selection then expedition(character, ({ quick = 0, large = 1, extended = 2 })[selection]) end
            return
        end
    end
end)

local obelisk = ccb.content.Furniture {
    id = "f_exitportal",
    name = ccb.content.text("Warp Obelisk"),
    description = ccb.content.text("This strange, towering monolith is the only lifeline you have to the outside world.  Despite its massive size, it's surprisingly easy to move around the island.\n\nIt seems you can interact with it."),
    color = "dark_gray", symbol = "S", looks_like = "f_statue",
    move_cost_mod = -1, required_str = 1, coverage = 0, mass_grams = 1000000,
    crafting_pseudo_item = "fakeitem_statue", transparent = true,
}
obelisk:flag("NOCOLLIDE")
obelisk:flag("NO_PICKUP_ON_EXAMINE")
obelisk:flag("TRANSPARENT")
obelisk:on_examine("sky_raid_obelisk")
ccb.content.add(obelisk)
