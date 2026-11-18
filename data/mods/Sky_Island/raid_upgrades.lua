local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local install_upgrade = require("upgrade_mission")
local id = services.types.id

install_upgrade({
    id = "SKYISLAND_UPGRADE_challenge_mode",
    name = ccb.content.text("Unlock: Challenge Mode"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Eternal Obelisk from weapons and armor.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to enable a challenge mode for expeditions, applying a random modifier in exchange for increased rewards."),
    item = "upgradekey_challenge_mode",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to enable a challenge mode for expeditions, applying a random modifier in exchange for increased rewards.") end, function(character)
    state.set("challenge_mode_available", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_challenge_mode")))
    state.message(character, ccb.services.translate("You feel a burning sensation sweep through your body as your connection to the warpstream grows before splitting in two.  You can feel that there is another, more dangerous place that you can travel to.\n\nYou can now enable challenge mode for your expeditions.  A random modifier will be applied to the expedition in exchange for increased rewards."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_exit1",
    name = ccb.content.text("Unlock: Two Exits per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Escape Charm from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have two different locations you can exit from."),
    item = "upgradekey_exit1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have two different locations you can exit from.") end, function(character)
    state.set("bonusexits", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_exit1")))
    state.message(character, ccb.services.translate("You close your eyes and through the flow of turbulent warpstream, an invisible maze manifests.  A thousand potential passages brush smooth stone across your consciousness, and the meaning of this reality glimmers faintly, a dancing splinter of light in the distance.  You've been here before, you are here now, and you will be here again.\nWhen you open your eyes, you're back where you began.  You haven't moved, but it feels as though the world has.\n\nIn every future expedition, you will now be able to find two different locations you can exit from."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_exit2",
    name = ccb.content.text("Unlock: Three Exits per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Blindfold of Egress from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have three different locations you can exit from."),
    item = "upgradekey_exit2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have three different locations you can exit from.") end, function(character)
    state.set("bonusexits", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_exit2")))
    state.message(character, ccb.services.translate("Again you see in blindness, and before you stretches a vast invisible labyrinth beneath an empty sky.  You race forward, tracing paths spoken to you in dreams, and an origami spiderweb crumples and breathes out underfoot.  At last, at the seashell's center, lies the cornucopia's smallest door.\nWhen at last you open your eyes, you find yourself where you began, unmoved, yet changed.\n\nIn every future expedition, you will now be able to find three different locations you can exit from."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_exit3",
    name = ccb.content.text("Unlock: Four Exits per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Thrice-Sided Door from locks and doormats.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have four different locations you can exit from."),
    item = "upgradekey_exit3",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have four different locations you can exit from.") end, function(character)
    state.set("bonusexits", 3)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_exit3")))
    state.message(character, ccb.services.translate("Again you see in blindness, and before you stretches a vast invisible labyrinth beneath an empty sky.  You race forward, tracing paths spoken to you in dreams, and an origami spiderweb crumples and breathes out underfoot.  At last, at the seashell's center, lies the cornucopia's smallest door.\nWhen at last you open your eyes, you find yourself where you began, unmoved, yet changed.\n\nIn every future expedition, you will now be able to find four different locations you can exit from."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_exit4",
    name = ccb.content.text("Unlock: Five Exits per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Intangible Door Stopper from door hinges and breaching tools.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have four different locations you can exit from."),
    item = "upgradekey_exit4",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have four different locations you can exit from.") end, function(character)
    state.set("bonusexits", 4)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_exit4")))
    state.message(character, ccb.services.translate("Again you see in blindness, and before you stretches a vast invisible labyrinth beneath an empty sky.  You race forward, tracing paths spoken to you in dreams, and an origami spiderweb crumples and breathes out underfoot.  At last, at the seashell's center, lies the cornucopia's smallest door.\nWhen at last you open your eyes, you find yourself where you began, unmoved, yet changed.\n\nIn every future expedition, you will now be able to find five different locations you can exit from."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing1",
    name = ccb.content.text("Upgrade: Landing 1"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Landing Pad from common cushions and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a bit more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 70 seconds."),
    item = "upgradekey_landing1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a bit more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 70 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 4)
    state.set("invistime", 70)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing1")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 70 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing2",
    name = ccb.content.text("Upgrade: Landing 2"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Safety Net from common cushions and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 80 seconds."),
    item = "upgradekey_landing2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 80 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 8)
    state.set("invistime", 80)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing2")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 80 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing3",
    name = ccb.content.text("Upgrade: Landing 3"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Warped Parachute from advanced materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal even more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 90 seconds."),
    item = "upgradekey_landing3",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal even more of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 90 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 12)
    state.set("invistime", 90)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing3")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 90 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing4",
    name = ccb.content.text("Upgrade: Landing 4"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Ethereal Cushion from complex materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a lot of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 100 seconds."),
    item = "upgradekey_landing4",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a lot of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 100 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 16)
    state.set("invistime", 100)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing4")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 100 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing5",
    name = ccb.content.text("Upgrade: Landing 5"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Grace of the Island from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 120 seconds."),
    item = "upgradekey_landing5",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 120 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 24)
    state.set("invistime", 120)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing5")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 120 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing6",
    name = ccb.content.text("Upgrade: Landing 6"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Familiarity Gemstone from maps and flags.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 130 seconds."),
    item = "upgradekey_landing6",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 130 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 32)
    state.set("invistime", 130)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing6")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 130 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing7",
    name = ccb.content.text("Upgrade: Landing 7"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Warm Welcome from painkillers and winter clothes.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 140 seconds."),
    item = "upgradekey_landing7",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 140 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 40)
    state.set("invistime", 140)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing7")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 140 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing8",
    name = ccb.content.text("Upgrade: Landing 8"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Emissary's Herald from insignias and proofs of authority.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 150 seconds."),
    item = "upgradekey_landing8",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveal a huge section of the map around your landing point, and increase the warpcloak invisibility grace period at the start of each expedition to 150 seconds.") end, function(character)
    state.set("scoutingdistancelanding", 48)
    state.set("invistime", 150)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing8")))
    state.message(character, ccb.services.translate("Your focus tightens.  Landing points will reveal more of the map, and your warpcloak will last 150 seconds at the beginning of every expedition."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing_water_walking",
    name = ccb.content.text("Upgrade: Landing Boost: Waterwalking"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Cloaking Buoyancy from things from water and things that float.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: While under the effect of the warpcloak, you can walk on water."),
    item = "upgradekey_landing_waterwalking",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: While under the effect of the warpcloak, you can walk on water.") end, function(character)
    state.set("landing_waterwalk", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing_waterwalking")))
    state.message(character, ccb.services.translate("You feel the warp ripple around you.  While under the effect of the warpcloak, you can walk on water."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing_flight",
    name = ccb.content.text("Upgrade: Landing Boost: Flight"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Inverted Gravity Bubble from things that used to fly and things that could make someone fly.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: While under the effect of the warpcloak, you can fly."),
    item = "upgradekey_landing_flight",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: While under the effect of the warpcloak, you can fly.") end, function(character)
    state.set("landing_flight", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing_flight")))
    state.message(character, ccb.services.translate("You feel the warp ripple around you.  While under the effect of the warpcloak, you can fly."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_landing_phase",
    name = ccb.content.text("Upgrade: Landing Boost: Phasing"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Universal Access Pass from different tools granting access to restricted areas.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: While under the effect of the warpcloak, you can pass through non-thick walls."),
    item = "upgradekey_landing_phase",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: While under the effect of the warpcloak, you can pass through non-thick walls.") end, function(character)
    state.set("landing_phase", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_landing_phase")))
    state.message(character, ccb.services.translate("You feel the warp ripple around you.  While under the effect of the warpcloak, you can pass through non-thick walls."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_raidlength1",
    name = ccb.content.text("Unlock: Large Expeditions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Warped Hourglass from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to select Large Expeditions when leaving via the warp obelisk.  Large Expeditions last 2x as long, but mission targets and exit points are significantly farther away."),
    item = "upgradekey_raidlength1",
}, function() return ccb.services.translate("With some success under your belt, you feel ready to tackle more ambitious expeditions, and the island seems to know it.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to select Large Expeditions when leaving via the warp obelisk.  Large Expeditions last 2x as long, but mission targets and exit points are significantly farther away.") end, function(character)
    state.set("longerraids", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_raidlength1")))
    state.message(character, ccb.services.translate("You are ready for a longer haul.\nLarge Expeditions are now available at the warp obelisk.  Exits and missions will be farther away, but you will have twice as long to spend earthside.  Use this time wisely, and set your sights on bigger targets.  What will you do with your newfound time?"), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_raidlength2",
    name = ccb.content.text("Unlock: Extended Expeditions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Watch of Flowing Time from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to select Extended Expeditions when leaving via the warp obelisk.  Extended Expeditions last 3x as long, but mission targets and exit points are significantly farther away."),
    item = "upgradekey_raidlength2",
}, function() return ccb.services.translate("You've seen enough safe returns to know your way around an expedition.  Now if you could spend even more time earthside, you'd be able to tackle even bigger and more ambitious goals.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to select Extended Expeditions when leaving via the warp obelisk.  Extended Expeditions last 3x as long, but mission targets and exit points are much farther away.") end, function(character)
    state.set("longerraids", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_raidlength2")))
    state.message(character, ccb.services.translate("You're in it to win it, and are prepared to take a long time exploring the world below.\nExtended Expeditions are now available at the warp obelisk.  Exits and missions will be much farther away, but you will have three times as long to spend earthside.  Pack supplies for a day trip and be sure to bring plenty of storage space.  Where will you go with your newfound time?"), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_slaughter",
    name = ccb.content.text("Unlock: Slaughter Missions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Vengeance of the Island from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: One special slaughter mission will be assigned during each expedition, rewarding warp shards if you kill a certain number of specifically targeted enemies before returning home."),
    item = "upgradekey_slaughter",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: One special slaughter mission will be assigned during each expedition, rewarding warp shards if you kill a certain number of specifically targeted enemies before returning home.") end, function(character)
    state.set("slaughterunlocked", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_slaughter")))
    state.message(character, ccb.services.translate("Bloodthirst surges through you like electricity.  The clarity of the world and its natural flow pierces your mind.\nIn every future expedition, you will be tasked to find and extinguish living entities that have absorbed warp.  Do this and you will be rewarded."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_bonusmissions1",
    name = ccb.content.text("Unlock: Expedition Missions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Warped Decree from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition now offers a randomly assigned mission, which will reward you with valuable warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse."),
    item = "upgradekey_bonusmissions1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition now offers a randomly assigned mission, which will reward you with valuable warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse.") end, function(character)
    state.set("bonusmissions", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_bonusmissions1")))
    state.message(character, ccb.services.translate("The island speaks in your head using words you cannot translate yet already understand.  Its wishes are your commands.\nIn every future expedition, you will now be given a randomly generated mission, from which you can earn valuable warp shards."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_bonusmissions2",
    name = ccb.content.text("Unlock: Two Missions per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft Order's Blade from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have 2 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse."),
    item = "upgradekey_bonusmissions2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have 2 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse.") end, function(character)
    state.set("bonusmissions", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_bonusmissions2")))
    state.message(character, ccb.services.translate("Those who disturb the warpstream must be put down.  There is no cruelty in this.  It is the order of the Island, and it will be kept.\nIn every future expedition, you will now be given 2 random missions."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_bonusmissions3",
    name = ccb.content.text("Unlock: Three Missions per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Hand of the Island from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have 3 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse."),
    item = "upgradekey_bonusmissions3",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have 3 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse.") end, function(character)
    state.set("bonusmissions", 3)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_bonusmissions3")))
    state.message(character, ccb.services.translate("Your strength is an extension of the island's will.  Let order be maintained.\nIn every future expedition, you will now be given 3 random missions."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_bonusmissions4",
    name = ccb.content.text("Unlock: Four Missions per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Petrified Duty's Call from old money and a spiral stone.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have 4 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse."),
    item = "upgradekey_bonusmissions4",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have 4 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse.") end, function(character)
    state.set("bonusmissions", 4)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_bonusmissions4")))
    state.message(character, ccb.services.translate("Some disrupt the warpstream by their very existence, a problem you will solve through violence.\nIn every future expedition, you will now be given 4 random missions."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_bonusmissions5",
    name = ccb.content.text("Unlock: Five Missions per Expedition"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Oath of the Island's Enforcer from massive amounts of ink.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Every expedition will now have 53 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse."),
    item = "upgradekey_bonusmissions5",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Every expedition will now have 5 different randomly assigned missions, increasing the possibility for earning warp shards.  Completing a mission also extends the time left on current expedition by 1 warp pulse.") end, function(character)
    state.set("bonusmissions", 5)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_bonusmissions5")))
    state.message(character, ccb.services.translate("Your mind fills with many transgressors that the Island has marked or will mark for death.  Carrying the Island's sentences is your responsibility, a duty you've accepted in full.\nIn every future expedition, you will now be given 5 random missions."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_hardmissions1",
    name = ccb.content.text("Unlock: Harder Missions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Ordinator's Sigil from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: New and more challenging types of missions are available to be randomly assigned in every expedition.  Harder missions will reward many more warp shards."),
    item = "upgradekey_hardmissions1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: New and more challenging types of missions are available to be randomly assigned in every expedition.  Harder missions will reward many more warp shards.") end, function(character)
    state.set("hardmissions", 10)
    state.set("hardermissions", 5)
    state.set("target_forests_weight", state.number("hardmissions"))
    state.set("target_houses_weight", state.number("hardermissions"))
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_hardmissions1")))
    state.message(character, ccb.services.translate("Greater trespasses against the flow of the warpstream reveal themselves to you.  This interference cannot go unpunished.\nThe missions you are randomly assigned in each expedition are more varied, and can now pull from harder and more rewarding challenges."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_hardmissions2",
    name = ccb.content.text("Unlock: Hardest Missions"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Will of the Island from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: New and even more challenging types of missions are available to be randomly assigned in every expedition.  Harder missions will reward many more warp shards."),
    item = "upgradekey_hardmissions2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: New and even more challenging types of missions are available to be randomly assigned in every expedition.  Harder missions will reward many more warp shards.") end, function(character)
    state.set("hardmissions", 15)
    state.set("hardermissions", 15)
    state.set("hardestmissions", 10)
    state.set("target_forests_weight", state.number("hardmissions"))
    state.set("target_houses_weight", state.number("hardermissions"))
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_hardmissions2")))
    state.message(character, ccb.services.translate("The greatest trespasses against the island now glimmer in the dark, guiding your hand as a tool of order.  Return these chaotic energies to the tranquility of the warpstream.\nThe missions you are randomly assigned in each expedition are even more varied, and can now pull from the hardest and most rewarding challenges."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting1",
    name = ccb.content.text("Upgrade: Scouting 1"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Scouting Lens from high quality lenses and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals slightly more of the map around exit points and mission targets."),
    item = "upgradekey_scouting1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals slightly more of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting1")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will be scouted just a little better."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting2",
    name = ccb.content.text("Upgrade: Scouting 2"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Scouting Scope from a pair of binoculars and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a bit more of the map around exit points and mission targets."),
    item = "upgradekey_scouting2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a bit more of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting2")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide better map scouting."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting3",
    name = ccb.content.text("Upgrade: Scouting 3"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Vision Amplifier from high quality optics and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals even more of the map around exit points and mission targets."),
    item = "upgradekey_scouting3",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals even more of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 4)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting3")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide even better scouting on your map."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting4",
    name = ccb.content.text("Upgrade: Scouting 4"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Third Eye Charm from medical grade optics and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a lot of the map around exit points and mission targets."),
    item = "upgradekey_scouting4",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a lot of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 6)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting4")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will be provide exceptional scouting."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting5",
    name = ccb.content.text("Upgrade: Scouting 5"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Eye of the Island from experimental optics and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets."),
    item = "upgradekey_scouting5",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 10)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting5")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide a huge scouting radius."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting6",
    name = ccb.content.text("Upgrade: Scouting 6"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a warpforged telescope from sensors and telescopes.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets."),
    item = "upgradekey_scouting6",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 14)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting6")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide a huge scouting radius."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting7",
    name = ccb.content.text("Upgrade: Scouting 7"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Agglomerated Oculus from ocular enhancements and petrified eyes.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets."),
    item = "upgradekey_scouting7",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 18)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting7")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide a huge scouting radius."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scouting8",
    name = ccb.content.text("Upgrade: Scouting 8"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Other Eye of the Island from outworldly sensors and esoteric notes.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets."),
    item = "upgradekey_scouting8",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reveals a huge amount of the map around exit points and mission targets.") end, function(character)
    state.set("scoutingdistancetargets", 22)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scouting8")))
    state.message(character, ccb.services.translate("Your vision expands.  Future missions and exits will provide a huge scouting radius."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scoutingclairvoyance1",
    name = ccb.content.text("Upgrade: Scouting Clairvoyance 1"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Higher Viewpoint from notes on the psychic and things that belong to the dead.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: See everything near you for a short time when beginning a mission."),
    item = "upgradekey_scoutingclairvoyance1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: See everything near you for a short time when beginning a mission.") end, function(character)
    state.set("scoutingclairvoyancetime", 20)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scoutingclairvoyance1")))
    state.message(character, ccb.services.translate("Your vision expands.  You will see everything near you for a short time when beginning a mission."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_scoutingclairvoyance2",
    name = ccb.content.text("Upgrade: Scouting Clairvoyance 2"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the All-Seeing Effigy from the remains of the observers and detection tools.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: See everything near you at the start of a mission of a longer time."),
    item = "upgradekey_scoutingclairvoyance2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: See everything near you at the start of a mission of a longer time.") end, function(character)
    state.set("scoutingclairvoyancetime", 60)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_scoutingclairvoyance2")))
    state.message(character, ccb.services.translate("Your vision expands.  You will see everything near you for a longer time at the beginning of a mission."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability1",
    name = ccb.content.text("Upgrade: Stability 1"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Warped Tincture from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 9 pulses instead of the default 8, allowing you to stay out 12.5% longer before warpsickness takes over."),
    item = "upgradekey_stability1",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 9 pulses instead of the default 8, allowing you to stay out 12.5% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability1")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability2",
    name = ccb.content.text("Upgrade: Stability 2"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Surreal Shield from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 10 pulses instead of the default 8, allowing you to stay out 25% longer before warpsickness takes over."),
    item = "upgradekey_stability2",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 10 pulses instead of the default 8, allowing you to stay out 25% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability2")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability3",
    name = ccb.content.text("Upgrade: Stability 3"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft Warpstream Plating from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 11 pulses instead of the default 8, allowing you to stay out 37.5% longer before warpsickness takes over."),
    item = "upgradekey_stability3",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 11 pulses instead of the default 8, allowing you to stay out 37.5% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 3)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability3")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability4",
    name = ccb.content.text("Upgrade: Stability 4"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Fortitude of the Island from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 12 pulses instead of the default 8, allowing you to stay out 50% longer before warpsickness takes over."),
    item = "upgradekey_stability4",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 12 pulses instead of the default 8, allowing you to stay out 50% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 4)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability4")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability5",
    name = ccb.content.text("Upgrade: Stability 5"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Explorer's Ward from things helping to withstand harsh conditions.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 13 pulses instead of the default 8, allowing you to stay out 62.5% longer before warpsickness takes over."),
    item = "upgradekey_stability5",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 13 pulses instead of the default 8, allowing you to stay out 62.5% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 5)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability5")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability6",
    name = ccb.content.text("Upgrade: Stability 6"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Island-Bound Armor from various armors from this world and from others.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 14 pulses instead of the default 8, allowing you to stay out 75% longer before warpsickness takes over."),
    item = "upgradekey_stability6",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 14 pulses instead of the default 8, allowing you to stay out 75% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 6)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability6")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_stability7",
    name = ccb.content.text("Upgrade: Stability 7"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft the Triune Anchor from the corpse of a yugg and rare ressources.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will begin every expedition with the ability to withstand 15 pulses instead of the default 8, allowing you to stay out 87.5% longer before warpsickness takes over."),
    item = "upgradekey_stability7",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will begin every expedition with the ability to withstand 15 pulses instead of the default 8, allowing you to stay out 87.5% longer before warpsickness takes over.") end, function(character)
    state.set("bonuspulses", 7)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_stability7")))
    state.message(character, ccb.services.translate("Your resistance to the chaos of the warpstream increases.  In every future expedition, you will be able to endure an additional warp pulse and stay earthside longer."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_basementsunlock",
    name = ccb.content.text("Unlock Start Location: Basements"),
    description = ccb.content.text("Completing this mission will unlock a new possible location to begin future expeditions.\n\nCraft the Basement Locator from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to select random Basement starts when leaving via the warp obelisk."),
    item = "upgradekey_basementsunlock",
}, function() return ccb.services.translate("Being guaranteed to start in a town or city would cut down on your hikes through the wilderness.  But popping down in the middle of the street with no warning could really attract hordes.  Basements aren't always safe, but they're probably safer than walking down Main in broad daylight, and might be a good location to begin future expeditions.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to select random Basement starts when leaving via the warp obelisk.") end, function(character)
    state.set("basementsunlocked", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_basementsunlock")))
    state.message(character, ccb.services.translate("When leaving from the warp obelisk, you can now guarantee you will begin your expedition in a basement.  Not glamorous, but at least it ensures you won't be stranded out in some desolate field."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_roofsunlock",
    name = ccb.content.text("Unlock Start Location: Roofs"),
    description = ccb.content.text("Completing this mission will unlock a new possible location to begin future expeditions.\n\nCraft the Rooftop Locator from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to select random Rooftop starts when leaving via the warp obelisk."),
    item = "upgradekey_roofsunlock",
}, function() return ccb.services.translate("If basements aren't cutting it, there's always rooftops.  Starting one floor up will give you a good vantage and relative safety from the busy streets while still ensuring you begin your expedition in a town or city.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to select random Rooftop starts when leaving via the warp obelisk.  In case you need to make a quick descent, bear in mind that the warpcloak effect you have briefly at the start of each expedition prevents fall damage.") end, function(character)
    state.set("roofsunlocked", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_roofsunlock")))
    state.message(character, ccb.services.translate("When leaving from the warp obelisk, you can now guarantee you will begin your expedition on some rooftop.  Dangerous, perhaps, but it ensures proximity to points of interest, and besides, there are all kinds of buildings this might land you on."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_labsunlock",
    name = ccb.content.text("Unlock Start Location: Labs"),
    description = ccb.content.text("Completing this mission will unlock a new possible location to begin future expeditions.\n\nCraft the Laboratory Locator from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: You will be able to select random Labs starts when leaving via the warp obelisk."),
    item = "upgradekey_labsunlock",
}, function() return ccb.services.translate("Labs are rare and valuable finds, and clearing them out will take the better part of a long expedition.  It would be much so easier if you could start right outside one!\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: You will be able to select random Lab starts when leaving via the warp obelisk.  This expedition type is unique in that it will require a Labs Catalyst in your inventory when you select the expedition, which will then be consumed on leaving.") end, function(character)
    state.set("labsunlocked", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_labsunlock")))
    state.checked(services.recipes.learn(character, id("recipe", "warp_labs_catalyst")))
    state.message(character, ccb.services.translate("With this upgrade, you're guaranteed to begin your expedition at an underground lab.  Be aware that you will need to have a Labs Catalyst on you when activating the warp obelisk, and these will be consumed on leaving."), "mixed")
end)
