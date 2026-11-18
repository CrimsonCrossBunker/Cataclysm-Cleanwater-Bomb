local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local island_map = require("island_map")
local island = require("island_memory")
local install_upgrade = require("upgrade_mission")
local id = services.types.id
local M = {}

local function update_at(location, update)
    island_map.update(state.point(location), update)
end

local function room(location, update)
    return function()
        update_at(location, update)
    end
end

function M.base1(character)
    island.remember(character)
    update_at("OM_island_center", "surface_entrance")
    update_at("OM_island_subcenter", "base1")
end

function M.bigroom1()
    update_at("OM_island_subcenter", "a1")
    update_at("OM_island_center", "skylight")
end

M.bigroom2 = room("OM_island_subcenter", "a2")
M.bigroom3 = room("OM_island_subcenter", "a3")
M.bigroom4 = room("OM_island_subcenter", "a4")

M.westroom1 = room("OM_island_subw", "w1")
M.westroom2 = room("OM_island_subw", "w2")
M.westroom3 = room("OM_island_subw", "w3")
M.westroom4 = room("OM_island_subw", "w4")
M.west_side_rooms = room("OM_island_subw", "w_sides")

M.eastroom1 = room("OM_island_sube", "e1")
M.eastroom2 = room("OM_island_sube", "e2")
M.eastroom3 = room("OM_island_sube", "e3")
M.eastroom4 = room("OM_island_sube", "e4")
M.east_side_rooms = room("OM_island_sube", "e_sides")

M.northroom1 = room("OM_island_subn", "n1")
M.northroom2 = room("OM_island_subn", "n2")
M.northroom3 = room("OM_island_subn", "n3")
M.northroom4 = room("OM_island_subn", "n4")
M.north_side_rooms = room("OM_island_subn", "n_sides")

M.centralskylight2 = room("OM_island_center", "skylight2")
M.centralskylight3 = room("OM_island_center", "skylight3")
M.centralskylight4 = room("OM_island_center", "skylight4")

function M.climatecontrol(character)
    state.add_trait(character, "mut_skyisland_temperature_adaptation")
end

function M.greenhouse1(character)
    island.remember(character)
    update_at("OM_island_subcenter", "base2")
    update_at("OM_island_subs", "s1")
end

M.greenhouse2 = room("OM_island_subs", "s2")
M.greenhouse3 = room("OM_island_subs", "s3")
M.greenhouse4 = room("OM_island_subs", "s4")
M.greenhouse_skylight1 = room("OM_island_s", "greenhouse_skylight1")
M.greenhouse_skylight2 = room("OM_island_s", "greenhouse_skylight2")
function M.merchant_stall()
    island_map.merchant_stall(state.point("OM_island_n"))
end

local function finish_stall(character)
    state.checked(services.recipes.learn(character, id("recipe", "item_merchant_attractor")))
    M.merchant_stall(character)
end

local function install_project(options, progress, level, build, intro, done)
    local item = options.item
    install_upgrade(options, intro, function(character)
        state.set(progress, level)
        state.checked(services.recipes.forget(character, id("recipe", item)))
        build(character)
        state.message(character, done(), "neutral", true)
    end)
end

install_project({
    id = "SKYISLAND_BUILD_base1",
    name = ccb.content.text("Construct: Bunker Entrance"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft the Mouth of the Island from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Bunker Entrance.  A simple concrete entrance leading down into the lower levels of the island, including a small subterranean chamber."),
    item = "buildkey_base1",
}, "skyisland_build_base", 1, M.base1,
    function() return ccb.services.translate("The island seems to be a suitable safe haven for staging future expeditions, but while there's no threat of monsters, it's still harshly exposed to the elements.  Having even minimal covered shelter would go a long way towards helping you rest and recuperate between expeditions.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Bunker Entrance.  A simple concrete entrance leading down into the lower levels of the island, including a small subterranean chamber.") end,
    function() return ccb.services.translate("It is done.  A small bunker has been carved into the foundations of this island.  You will find the stairs nearby.\nThis is only the beginning.") end)

install_project({
    id = "SKYISLAND_BUILD_bigroom1",
    name = ccb.content.text("Construct: Main Room 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Miner's Cameo from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Main Room 1.  A hollow chamber beneath the island's center to serve as a multipurpose space, with tons of room to expand."),
    item = "buildkey_bigroom1",
}, "skyisland_build_bigroom", 1, M.bigroom1,
    function() return ccb.services.translate("Now that work on the island bunker has begun, a large central room would be ideal.  With all the loot you'll be scavenging on expeditions, it could make a useful storeroom and crafting center.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Main Room 1.  A hollow chamber beneath the island's center to serve as a multipurpose space, with tons of room to expand.") end,
    function() return ccb.services.translate("Construction complete.  A central room has been dug out in the bunker beneath the island.") end)

install_project({
    id = "SKYISLAND_BUILD_bigroom2",
    name = ccb.content.text("Construct: Main Room 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Hollow Carver from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Main Room 2.  Expand the central room to fit more loot, furniture, or anything else you may need."),
    item = "buildkey_bigroom2",
}, "skyisland_build_bigroom", 2, M.bigroom2,
    function() return ccb.services.translate("The central room would be a lot more useful if it were larger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Main Room 2.  Expand the central room to fit more loot, furniture, or anything else you may need.") end,
    function() return ccb.services.translate("Construction complete.  The central room has grown.") end)

install_project({
    id = "SKYISLAND_BUILD_bigroom3",
    name = ccb.content.text("Construct: Main Room 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Warped Reinforcement from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Main Room 3.  Expand the central room to very generous dimensions."),
    item = "buildkey_bigroom3",
}, "skyisland_build_bigroom", 3, M.bigroom3,
    function() return ccb.services.translate("The central room is a good start, but it could be much bigger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Main Room 3.  Expand the central room to very generous dimensions.") end,
    function() return ccb.services.translate("Construction complete.  The central room has grown even further.") end)

install_project({
    id = "SKYISLAND_BUILD_bigroom4",
    name = ccb.content.text("Construct: Main Room 4"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Cavernous Soul from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Main Room 4.  Expand the central room to its maximum size."),
    item = "buildkey_bigroom4",
}, "skyisland_build_bigroom", 4, M.bigroom4,
    function() return ccb.services.translate("The central room is big.  But not yet big enough.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Main Room 4.  Expand the central room to its maximum size.") end,
    function() return ccb.services.translate("Construction complete.  The central room is now at its maximum size.") end)

install_project({
    id = "SKYISLAND_BUILD_centralskylight2",
    name = ccb.content.text("Construct: Central Skylight 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Glass Figurine from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Central Skylight 2.  A larger skylight above your main room, allowing more light to enter in."),
    item = "buildkey_centralskylight2",
}, "skyisland_build_centralskylight", 1, M.centralskylight2,
    function() return ccb.services.translate("Now that you have a bunker under the island, you have a place to live.  But the small glass roof doesn't let in a lot of light; a larger skylight would be ideal.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Central Skylight 2.  A larger skylight over the main room.") end,
    function() return ccb.services.translate("Construction complete.  The skylight above the central room has expanded.") end)

install_project({
    id = "SKYISLAND_BUILD_centralskylight3",
    name = ccb.content.text("Construct: Central Skylight 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Crystalline Mirror from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Central Skylight 3.  Expand the central room's skylight to allow even more light."),
    item = "buildkey_centralskylight3",
}, "skyisland_build_centralskylight", 2, M.centralskylight3,
    function() return ccb.services.translate("The central room could use even more natural light.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Central Skylight 3.  Expand the skylight over the central room.") end,
    function() return ccb.services.translate("Construction complete.  The skylight over the central room has grown.") end)

install_project({
    id = "SKYISLAND_BUILD_centralskylight4",
    name = ccb.content.text("Construct: Central Skylight 4"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Transparent Cube from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: Central Skylight 4.  Expand the central skylight to very generous dimensions."),
    item = "buildkey_centralskylight4",
}, "skyisland_build_centralskylight", 3, M.centralskylight4,
    function() return ccb.services.translate("The central skylight should be enormous to allow in as much light as possible.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: Central Skaylight 4.  Expand the central skylight to very generous dimensions.") end,
    function() return ccb.services.translate("Construction complete.  The central skylight has grown even further.") end)

install_project({
    id = "SKYISLAND_BUILD_eastroom1",
    name = ccb.content.text("Construct: East Room 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Miner's Cameo from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: East Room 1.  A hollow chamber east of the island's center to serve as a multipurpose space, with tons of room to expand."),
    item = "buildkey_eastroom1",
}, "skyisland_build_eastroom", 1, M.eastroom1,
    function() return ccb.services.translate("Now that you have corridors snaking beneath your island, you could build rooms in various areas.  The eastern quadrant might be a good place for another room.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: East Room 1.  A hollow chamber to the east of the island's center to serve as a multipurpose space, with tons of room to expand.") end,
    function() return ccb.services.translate("Construction complete.  A room has been dug out to the east of the central area in the bunker beneath the island.") end)

install_project({
    id = "SKYISLAND_BUILD_eastroom2",
    name = ccb.content.text("Construct: East Room 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Hollow Carver from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: East Room 2.  Expand the eastern room to fit more loot, furniture, or anything else you may need."),
    item = "buildkey_eastroom2",
}, "skyisland_build_eastroom", 2, M.eastroom2,
    function() return ccb.services.translate("The eastern room would be a lot more useful if it were larger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: East Room 2.  Expand the eastern room to fit more loot, furniture, or anything else you may need.") end,
    function() return ccb.services.translate("Construction complete.  The eastern room has grown.") end)

install_project({
    id = "SKYISLAND_BUILD_eastroom3",
    name = ccb.content.text("Construct: East Room 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Warped Reinforcement from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: East Room 3.  Expand the eastern room to very generous dimensions."),
    item = "buildkey_eastroom3",
}, "skyisland_build_eastroom", 3, M.eastroom3,
    function() return ccb.services.translate("The eastern room is a good start, but it could be much bigger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: East Room 3.  Expand the eastern room to very generous dimensions.") end,
    function() return ccb.services.translate("Construction complete.  The eastern room has grown even further.") end)

install_project({
    id = "SKYISLAND_BUILD_eastroom4",
    name = ccb.content.text("Construct: East Room Gallery"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Crystalline Glass from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: East Room Gallery.  Add an enclosed gallery to the eastern room to allow viewing off the side of the island."),
    item = "buildkey_eastroom4",
}, "skyisland_build_eastroom", 4, M.eastroom4,
    function() return ccb.services.translate("The eastern room is a nice size, but you're on a floating island.  What if you had a place where you could admire the beautiful view without having to worry about the blowing winds?  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: East Room Gallery.  Add an enclosed gallery to the eastern room to allow viewing off the side of the island.") end,
    function() return ccb.services.translate("Construction complete.  The eastern room has now has a viewing gallery.") end)

install_project({
    id = "SKYISLAND_BUILD_east_side_rooms",
    name = ccb.content.text("Construct: East Side Rooms"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft an Inverted Cube from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: East Side Rooms.  Add two rooms on either side of the corridor leading to the eastern room."),
    item = "buildkey_east_side_rooms",
}, "skyisland_build_east_side_rooms", 1, M.east_side_rooms,
    function() return ccb.services.translate("The eastern room is a nice size, but it's just one room.  You could use a bit of separation between activities, and maybe a place to store some materials that you won't use as often.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: East Side Rooms.  Add two side rooms in the east for additional storage.") end,
    function() return ccb.services.translate("Construction complete.  The east now has two side rooms for additional storage.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse1",
    name = ccb.content.text("Construct: South Greenhouse 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Miner's Cameo from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse 1.  Add two rooms to the south of the bunker entrance for eventual greenhouses."),
    item = "buildkey_south_greenhouse_1",
}, "skyisland_build_greenhouse", 1, M.greenhouse1,
    function() return ccb.services.translate("There is a lot of space to the south of your bunker.  Perhaps you can build some greenhouses there?  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse 1.  Add two rooms to the south of the bunker entrance for eventual greenhouses.") end,
    function() return ccb.services.translate("Construction complete.  There is a new set of rooms to the south, to be turned into greenhouses eventually.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse2",
    name = ccb.content.text("Construct: South Greenhouse 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Hollow Carver from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse 2.  Add two more rooms to the south of the bunker entrance for eventual greenhouses."),
    item = "buildkey_south_greenhouse_2",
}, "skyisland_build_greenhouse", 2, M.greenhouse2,
    function() return ccb.services.translate("There is more space next to the first two rooms you dug out to the south.  You can fit two more greenhouses there.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse 2.  Add two more rooms to the south of the bunker entrance for eventual greenhouses.") end,
    function() return ccb.services.translate("Construction complete.  There are two more rooms to the south, to be turned into greenhouses eventually.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse3",
    name = ccb.content.text("Construct: South Greenhouse 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Warped Reinforcement from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse 3.  Upgrade the first set of dirt rooms into full greenhouses."),
    item = "buildkey_south_greenhouse_3",
}, "skyisland_build_greenhouse", 3, M.greenhouse3,
    function() return ccb.services.translate("You can finally construct greenhouses now that you have climate control in the bunker.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse 3.  Upgrade the first set of dirt rooms into full greenhouses.") end,
    function() return ccb.services.translate("Construction complete.  Two of the rooms to the south have been converted into greenhouses.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse4",
    name = ccb.content.text("Construct: South Greenhouse 4"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Cavernous Soul from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse 4.  Upgrade the second set of dirt rooms into full greenhouses."),
    item = "buildkey_south_greenhouse_4",
}, "skyisland_build_greenhouse", 4, M.greenhouse4,
    function() return ccb.services.translate("The first set of greenhouses was a success, now to build the last two.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse 4.  Upgrade the second set of dirt rooms into full greenhouses.") end,
    function() return ccb.services.translate("Construction complete.  The last two rooms to the south have been converted into greenhouses.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse_skylight1",
    name = ccb.content.text("Construct: South Greenhouse Skylight 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Glass Figurine from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse Skylight 1.  Build a set of skylights for the first set of southern rooms."),
    item = "buildkey_south_greenhouse_skylight_1",
}, "skyisland_build_greenhouse_skylight", 1, M.greenhouse_skylight1,
    function() return ccb.services.translate("You dug out two dirt rooms to plant in, now you need to let the sunlight in.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse Skylight 1.  Build a set of skylights for the first set of southern rooms.") end,
    function() return ccb.services.translate("Construction complete.  The first set of southern rooms now have skylights.") end)

install_project({
    id = "SKYISLAND_BUILD_south_greenhouse_skylight2",
    name = ccb.content.text("Construct: South Greenhouse Skylight 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Crystalline Mirror from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: South Greenhouse Skylight 2.  Build a set of skylights for the second set of southern rooms."),
    item = "buildkey_south_greenhouse_skylight_2",
}, "skyisland_build_greenhouse_skylight", 2, M.greenhouse_skylight2,
    function() return ccb.services.translate("The skylights in the first set of rooms work great, now you need to build the second set of sky lights.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: South Greenhouse Skylight 2.  Build a set of skylights for the second set of southern rooms.") end,
    function() return ccb.services.translate("Construction complete.  The second set of southern rooms now have skylights.") end)

install_project({
    id = "SKYISLAND_merchant_stall",
    name = ccb.content.text("Construct: Merchant Stall"),
    description = ccb.content.text("Completing this mission will instantly enhance your home island.\n\nCraft a Jangling Pouch from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Infrastructure: Merchant Stall.  Build a structure where merchants from…somewhere…can come to your island and offer their wares to you."),
    item = "buildkey_merchant_stall",
}, "skyisland_merchant_stall", 1, finish_stall,
    function() return ccb.services.translate("You can't be the only person this is happening to, right?  Maybe there's a way to let others visit you, take time away from their islands to trade supplies or gear.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Infrastructure: Merchant Stall.  Build a structure where merchants from…elsewhere…can come to your island and offer their wares to you.") end,
    function() return ccb.services.translate("Construction complete.  Merchants can now visit your island.") end)

install_project({
    id = "SKYISLAND_bunker_temperature_adaptation",
    name = ccb.content.text("Construct: Climate Control"),
    description = ccb.content.text("Completing this mission will instantly enhance the bunker on your home island.\n\nCraft a Lukewarm Sphere from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Infrastructure: Climate Control.  Control the climate within the bunker so it's not too warm in the summer or too cold in the winter."),
    item = "buildkey_climatecontrol",
}, "skyisland_bunker_temperature_adaptation", 1, M.climatecontrol,
    function() return ccb.services.translate("The bunker is expansive, but it's too hot in summer and much too cold in winter.  A climate control system would make it a more comfortable place to rest when not on raids.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Infrastructure: Climate Control.  Control the climate within the bunker so it's not too warm in the summer or too cold in the winter.") end,
    function() return ccb.services.translate("Construction complete.  The bunker's temperature is now controlled.") end)

install_project({
    id = "SKYISLAND_BUILD_northroom1",
    name = ccb.content.text("Construct: North Room 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Miner's Cameo from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: North Room 1.  A hollow chamber north of the island's center to serve as a multipurpose space, with tons of room to expand."),
    item = "buildkey_northroom1",
}, "skyisland_build_northroom", 1, M.northroom1,
    function() return ccb.services.translate("Now that you have corridors snaking beneath your island, you could build rooms in various areas.  The northern quadrant might be a good place for another room.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: North Room 1.  A hollow chamber to the north of the island's center with one wall a long window to look down on the world, with tons of room to expand.") end,
    function() return ccb.services.translate("Construction complete.  A room has been dug out to the north of the central area in the bunker beneath the island.") end)

install_project({
    id = "SKYISLAND_BUILD_northroom2",
    name = ccb.content.text("Construct: North Room 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Hollow Carver from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: North Room 2.  Expand the northern room to fit more loot, furniture, or anything else you may need."),
    item = "buildkey_northroom2",
}, "skyisland_build_northroom", 2, M.northroom2,
    function() return ccb.services.translate("The northern room would be a lot more useful if it were larger and had a bigger window.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: North Room 2.  Expand the northern room to fit more loot, furniture, or anything else you may need.") end,
    function() return ccb.services.translate("Construction complete.  The northern room has grown.") end)

install_project({
    id = "SKYISLAND_BUILD_northroom3",
    name = ccb.content.text("Construct: north Room 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Warped Reinforcement from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: North Room 3.  Expand the northern room to very generous dimensions."),
    item = "buildkey_northroom3",
}, "skyisland_build_northroom", 3, M.northroom3,
    function() return ccb.services.translate("The northern room is a good start, but it could be much bigger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: North Room 3.  Expand the northern room to very generous dimensions.") end,
    function() return ccb.services.translate("Construction complete.  The northern room has grown even further.") end)

install_project({
    id = "SKYISLAND_BUILD_northroom4",
    name = ccb.content.text("Construct: North Room Gallery"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Cavernous Soul from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: North Room Gallery.  Add an enclosed gallery to the northern room to allow viewing off the side of the island."),
    item = "buildkey_northroom4",
}, "skyisland_build_northroom", 4, M.northroom4,
    function() return ccb.services.translate("The northern room is a nice size, but you're on a floating island.  What if you had a place where you could admire the beautiful view without having to worry about the blowing winds?  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: North Room 4.  Expand the northern room to its maximum size.") end,
    function() return ccb.services.translate("Construction complete.  The northern room is now larger.") end)

install_project({
    id = "SKYISLAND_BUILD_north_side_rooms",
    name = ccb.content.text("Construct: North Side Rooms"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft an Inverted Cube from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: North Side Rooms.  Add two rooms on either side of the corridor leading to the northern room."),
    item = "buildkey_north_side_rooms",
}, "skyisland_build_north_side_rooms", 1, M.north_side_rooms,
    function() return ccb.services.translate("The northern room is a nice size, but it's just one room.  You could use a bit of separation between activities, and maybe a place to store some materials that you won't use as often.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: North Side Rooms.  Add two side rooms in the north for additional storage.") end,
    function() return ccb.services.translate("Construction complete.  The north now has two side rooms for additional storage.") end)

install_project({
    id = "SKYISLAND_BUILD_westroom1",
    name = ccb.content.text("Construct: West Room 1"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Miner's Cameo from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: West Room 1.  A hollow chamber west of the island's center to serve as a multipurpose space, with tons of room to expand."),
    item = "buildkey_westroom1",
}, "skyisland_build_westroom", 1, M.westroom1,
    function() return ccb.services.translate("Now that you have corridors snaking beneath your island, you could build rooms in various areas.  The western quadrant might be a good place for another room.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: West Room 1.  A hollow chamber to the west of the island's center to serve as a multipurpose space, with tons of room to expand.") end,
    function() return ccb.services.translate("Construction complete.  A room has been dug out to the west of the central area in the bunker beneath the island.") end)

install_project({
    id = "SKYISLAND_BUILD_westroom2",
    name = ccb.content.text("Construct: West Room 2"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Hollow Carver from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: West Room 2.  Expand the western room to fit more loot, furniture, or anything else you may need."),
    item = "buildkey_westroom2",
}, "skyisland_build_westroom", 2, M.westroom2,
    function() return ccb.services.translate("The western room would be a lot more useful if it were larger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: West Room 2.  Expand the western room to fit more loot, furniture, or anything else you may need.") end,
    function() return ccb.services.translate("Construction complete.  The western room has grown.") end)

install_project({
    id = "SKYISLAND_BUILD_westroom3",
    name = ccb.content.text("Construct: West Room 3"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Warped Reinforcement from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: West Room 3.  Expand the western room to very generous dimensions."),
    item = "buildkey_westroom3",
}, "skyisland_build_westroom", 3, M.westroom3,
    function() return ccb.services.translate("The western room is a good start, but it could be much bigger.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: West Room 3.  Expand the western room to very generous dimensions.") end,
    function() return ccb.services.translate("Construction complete.  The western room has grown even further.") end)

install_project({
    id = "SKYISLAND_BUILD_westroom4",
    name = ccb.content.text("Construct: West Room Gallery"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft a Crystalline Glass from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: West Room Gallery.  Add an enclosed gallery to the western room to allow viewing off the side of the island."),
    item = "buildkey_westroom4",
}, "skyisland_build_westroom", 4, M.westroom4,
    function() return ccb.services.translate("The western room is a nice size, but you're on a floating island.  What if you had a place where you could admire the beautiful view without having to worry about the blowing winds?  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: West Room Gallery.  Add an enclosed gallery to the western room to allow viewing off the side of the island.") end,
    function() return ccb.services.translate("Construction complete.  The western room has now has a viewing gallery.") end)

install_project({
    id = "SKYISLAND_BUILD_west_side_rooms",
    name = ccb.content.text("Construct: West Side Rooms"),
    description = ccb.content.text("Completing this mission will instantly build a new structure on your home island.\n\nCraft an Inverted Cube from simple tools and common building materials.  The Heart of the Island has already placed the recipe inside your mind.\n\nNew Structure: West Side Rooms.  Add two rooms on either side of the corridor leading to the western room."),
    item = "buildkey_west_side_rooms",
}, "skyisland_build_west_side_rooms", 1, M.west_side_rooms,
    function() return ccb.services.translate("The western room is a nice size, but it's just one room.  You could use a bit of separation between activities, and maybe a place to store some materials that you won't use as often.  Time to get to work.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nNew Structure: West Side Rooms.  Add two side rooms in the west for additional storage.") end,
    function() return ccb.services.translate("Construction complete.  The west now has two side rooms for additional storage.") end)

return M
