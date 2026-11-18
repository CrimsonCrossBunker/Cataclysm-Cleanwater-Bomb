local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local install_upgrade = require("upgrade_mission")
local id = services.types.id

install_upgrade({
    id = "SKYISLAND_UPGRADE_sunblock",
    name = ccb.content.text("Upgrade: Personal sunblock"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Solar Refractor from sunglasses, glass and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: The sun's rays cannot affect you while on the island."),
    item = "upgradekey_sunblock",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: The sun's rays cannot affect you while on the island.") end, function(character)
    state.add_trait(character, "mut_skyisland_sunblock")
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_sunblock")))
    state.message(character, ccb.services.translate("The sun's rays shift a little.  As long as you are on the island, any harm they could do to you will be negated."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_radblock",
    name = ccb.content.text("Upgrade: Personal Radiation Shield"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Focused Scrubber from janitor supplies.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Radiation cannot affect you while on the island."),
    item = "upgradekey_radblock",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Radiation cannot affect you while on the island.") end, function(character)
    state.add_trait(character, "mut_skyisland_radblock")
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_radblock")))
    state.message(character, ccb.services.translate("The light shifts a little.  As long as you are on the island, radiation won't hurt you."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_windblock",
    name = ccb.content.text("Upgrade: Personal windblock"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Wind Redirector from wind-blocking clothes and creams.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: The winds cannot affect you while on the island."),
    item = "upgradekey_windblock",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: The winds cannot affect you while on the island.") end, function(character)
    state.add_trait(character, "mut_skyisland_windblock")
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_windblock")))
    state.set("windblock", 1)
    state.message(character, ccb.services.translate("The winds shift a little.  As long as you are on the island, they will not touch you."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_island_steady",
    name = ccb.content.text("Upgrade: Island-Side Resilience"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft an Unyielding Sinew from fibers and cables.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Your speed cannot be below its default while on the island."),
    item = "upgradekey_island_steady",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Your speed cannot be below its default while on the island.") end, function(character)
    state.add_trait(character, "mut_skyisland_island_steady")
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_island_steady")))
    state.message(character, ccb.services.translate("Your sinews tingle for a second.  As long as you are on the island, your speed won't be lower than its default."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_personal_temperature_adaptation",
    name = ccb.content.text("Upgrade: Personal temperature adjustement"),
    description = ccb.content.text("Completing this mission will unlock a permanent upgrade for all future expeditions.\n\nCraft a Climate Self-Injector from temperature-controlling devices and various parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Temperature cannot affect you while on the island."),
    item = "upgradekey_temperature_control",
}, function() return ccb.services.translate("Somehow, you understand the statue is calling out for something that can strengthen its power.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Temperature cannot affect you while on the island.") end, function(character)
    state.add_trait(character, "mut_skyisland_personal_temperature_adaptation")
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_temperature_control")))
    state.set("skyisland_personal_temperature_adaptation", 1)
    state.message(character, ccb.services.translate("Your skin shimmer for a second.  As long as you are on the island, you won't be affected by temperature."), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_rankup1",
    name = ccb.content.text("Island Rank Up 1"),
    description = ccb.content.text("Completing this mission ascends you to a new rank.\n\nCraft the Proof of Determination from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reach Rank 1.  Some upgrades and unlocks will not be available until you have ranked up.  You will also instantly learn several new warp-related crafting recipes."),
    item = "upgradekey_rankup1",
}, function() return ccb.services.translate("You are ready to ascend to a higher tier of strength and ability.  Complete this trial and prove yourself, and you will discover new powers for yourself and the island.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reach Rank 1.  Some upgrades and unlocks will not be available until you have ranked up.  You will also instantly learn several new warp-related crafting recipes.") end, function(character)
    state.set("islandrank", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_rankup1")))
    state.checked(services.recipes.learn(character, id("recipe", "warp_carrier")))
    state.checked(services.recipes.learn(character, id("recipe", "recipe_craft_random_artifact")))
    state.checked(services.recipes.learn(character, id("recipe", "warp_vortex_token")))
    state.checked(services.recipes.learn(character, id("recipe", "warp_healing_salve")))
    state.checked(services.recipes.learn(character, id("recipe", "warphaulbag")))
    state.checked(services.recipes.learn(character, id("recipe", "sky_island_warped_pond")))
    state.message(character, ccb.services.translate("You have proved your ability to survive to the island, to the warpstream, and to yourself.\nMore unlockable upgrades will be available as you progress."), "mixed")
    state.message(character, ccb.services.translate("Your mind expands.  You have learned to craft:\nMaterialize random artifact\nVortex token\nWarped hauler's harness\nWarped animal carrier"), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_rankup2",
    name = ccb.content.text("Island Rank Up 2"),
    description = ccb.content.text("Completing this mission ascends you to a new rank.\n\nCraft the Proof of Determination from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Reach Rank 2.  Some upgrades and unlocks will not be available until you have ranked up.  You will also instantly learn several new warp-related crafting recipes."),
    item = "upgradekey_rankup2",
}, function() return ccb.services.translate("You are ready to ascend to a higher tier of strength and ability.  Complete this trial and prove yourself, and you will discover new powers for yourself and the island.\nA new recipe has been learned.  Craft this artifact to permanently upgrade the island.\n\nEFFECT: Reach Rank 2.  Some upgrades and unlocks will not be available until you have ranked up.  You will also instantly learn several new warp-related crafting recipes.") end, function(character)
    state.set("islandrank", 4)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_rankup2")))
    state.checked(services.recipes.learn(character, id("recipe", "warphome")))
    state.checked(services.recipes.learn(character, id("recipe", "warp_autodoc_inert")))
    state.message(character, ccb.services.translate("That you are still here, fighting on, makes your determination clear.  This new existence is strange and unpredictable, but you can adapt.  It's how you made it this far, and you're not about to stop now.\nMore unlockable upgrades will be available as you progress."), "mixed")
    state.message(character, ccb.services.translate("Your mind expands.  You have learned to craft:\nHomeward mote\nAutodoc copyplate\n"), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_security1",
    name = ccb.content.text("Upgrade: Security Alpha"),
    description = ccb.content.text("You have been granted the recipe to craft an Alpha Secure Container.  This little miracle defies the very laws of physics and insists upon its own permanence.  In short, it will give you an integrated pocket you can always access.  The contents of this pocket are completely secure and will not be lost, even if you die and are returned to the island.\n\nYou can only ever equip one secure container."),
    item = "secure_container_1",
}, function() return ccb.services.translate("You have been granted the recipe to craft an Alpha Secure Container.  This little miracle defies the very laws of physics and insists upon its own permanence.  In short, it will give you an integrated pocket you can always access.  The contents of this pocket are completely secure and will not be lost, even if you die and are returned to the island.\n\nYou can only ever equip one secure container.") end, function(character)
    state.set("securitylevel", 1)
    state.checked(services.recipes.forget(character, id("recipe", "secure_container_1")))
    state.add_trait(character, "mut_secure_container_1")
    state.message(character, ccb.services.translate("The strange metaphysical container suddenly snaps inward, clinging to the very core of your being.  Anything stored here will not be lost on death."), "neutral", true)
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_security2",
    name = ccb.content.text("Upgrade: Security Beta"),
    description = ccb.content.text("With the supplied recipe, you will be able to expand the capacity of your secure container."),
    item = "secure_container_2",
}, function() return ccb.services.translate("With the supplied recipe, you will be able to expand the capacity of your secure container.") end, function(character)
    state.set("securitylevel", 2)
    state.checked(services.recipes.forget(character, id("recipe", "secure_container_2")))
    state.checked(services.mutations.erase(character, id("mutation", "mut_secure_container_1")))
    state.add_trait(character, "mut_secure_container_2")
    state.message(character, ccb.services.translate("The strange metaphysical container churns inward with violent force, grinding loudly before suddenly expanding.  Your secure container can now carry more."), "neutral", true)
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_security3",
    name = ccb.content.text("Upgrade: Security Gamma"),
    description = ccb.content.text("With the supplied recipe, you will be able to expand the capacity of your secure container."),
    item = "secure_container_3",
}, function() return ccb.services.translate("With the supplied recipe, you will be able to expand the capacity of your secure container.") end, function(character)
    state.set("securitylevel", 3)
    state.checked(services.recipes.forget(character, id("recipe", "secure_container_3")))
    state.checked(services.mutations.erase(character, id("mutation", "mut_secure_container_2")))
    state.add_trait(character, "mut_secure_container_3")
    state.message(character, ccb.services.translate("The strange metaphysical container churns inward with violent force, grinding loudly before suddenly expanding.  Your secure container can now carry more."), "neutral", true)
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_security4",
    name = ccb.content.text("Upgrade: Security Epsilon"),
    description = ccb.content.text("With the supplied recipe, you will be able to expand the capacity of your secure container."),
    item = "secure_container_4",
}, function() return ccb.services.translate("With the supplied recipe, you will be able to expand the capacity of your secure container.") end, function(character)
    state.set("securitylevel", 4)
    state.checked(services.recipes.forget(character, id("recipe", "secure_container_4")))
    state.checked(services.mutations.erase(character, id("mutation", "mut_secure_container_3")))
    state.add_trait(character, "mut_secure_container_4")
    state.message(character, ccb.services.translate("The strange metaphysical container churns inward with violent force, grinding loudly before suddenly expanding.  Your secure container can now carry more."), "neutral", true)
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_security5",
    name = ccb.content.text("Upgrade: Security Kappa"),
    description = ccb.content.text("With the supplied recipe, you will be able to expand the capacity of your secure container to its maximum size."),
    item = "secure_container_5",
}, function() return ccb.services.translate("With the supplied recipe, you will be able to expand the capacity of your secure container to its maximum size.") end, function(character)
    state.set("securitylevel", 5)
    state.checked(services.recipes.forget(character, id("recipe", "secure_container_5")))
    state.checked(services.mutations.erase(character, id("mutation", "mut_secure_container_4")))
    state.add_trait(character, "mut_secure_container_5")
    state.message(character, ccb.services.translate("The strange metaphysical container churns inward with violent force, grinding loudly before suddenly expanding.  Your secure container can now carry more."), "neutral", true)
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_WARPED_HARNESS_TIER_2",
    name = ccb.content.text("Craft: Warped Hauler's Harness Mk II"),
    description = ccb.content.text("Completing this mission unlocks a new item crafting recipe.\n\nCraft the Ideal of Exercise from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Unlock ability to craft an upgraded warped hauler's harness mk II."),
    item = "upgradekey_warped_harness1",
}, function() return ccb.services.translate("You find that your harness is lacking and desire to carry heavier things in it.\nA new recipe has been learned.  Craft this artifact to permanently unlock a new item recipe.\n\nEFFECT: Unlock ability to craft an upgraded warped hauler's harness mk II.") end, function(character)
    state.set("skyisland_warped_harness_upgrade", 1)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_warped_harness1")))
    state.checked(services.recipes.learn(character, id("recipe", "warphaulbag_tier2")))
    state.message(character, ccb.services.translate("You have demonstrated your ability and desire to pick up heavy things."), "mixed")
    state.message(character, ccb.services.translate("Your mind expands.  You have learned to craft:\nwarped hauler's harness mk II"), "mixed")
end)

install_upgrade({
    id = "SKYISLAND_UPGRADE_WARPED_HARNESS_TIER_3",
    name = ccb.content.text("Craft: Warped Hauler's Harness Mk III"),
    description = ccb.content.text("Completing this mission unlocks a new item crafting recipe.\n\nCraft the Testament of Hoisting from experimental materials and miscellaneous parts.  The Heart of the Island has already placed the recipe inside your mind.\n\nEFFECT: Unlock ability to craft an upgraded warped hauler's harness mk III."),
    item = "upgradekey_warped_harness2",
}, function() return ccb.services.translate("You find that your harness is lacking and desire to carry heavier things in it.\nA new recipe has been learned.  Craft this artifact to permanently unlock a new item recipe.\n\nEFFECT: Unlock ability to craft an upgraded warped hauler's harness mk III.") end, function(character)
    state.set("skyisland_warped_harness_upgrade", 2)
    state.checked(services.recipes.forget(character, id("recipe", "upgradekey_warped_harness2")))
    state.checked(services.recipes.learn(character, id("recipe", "warphaulbag_tier3")))
    state.message(character, ccb.services.translate("You have demonstrated your ability and desire to pick up heavy things."), "mixed")
    state.message(character, ccb.services.translate("Your mind expands.  You have learned to craft:\nwarped hauler's harness mk III"), "mixed")
end)
