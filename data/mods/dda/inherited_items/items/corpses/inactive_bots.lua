local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bot_EMP_hack",
        name = ccb.content.plural_text("inactive EMP hack", "inactive EMP hacks"),
        description = ccb.content.text("An inactive EMP hack.  Manhacks are fist-sized robots that fly through the air.  This one contains an EMP grenade and attacks by flying at its target and detonating.  Use this item to reprogram and release the EMP hack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 2000000,
        volume_ml = 750,
        price_cents = 64500,
        price_postapoc_cents = 3000,
        melee_to_hit = -6,
        symbol = ",",
        color = "cyan",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_EMP_hack",
        friendly_message = ccb.content.text("The EMP hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the EMP hack; take cover!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_c4_hack",
        name = ccb.content.plural_text("inactive C-4 hack", "inactive C-4 hacks"),
        description = ccb.content.text("An inactive C-4 hack.  Manhacks are fist-sized robots that fly through the air.  This one contains a C-4 demolition charge and attacks by flying at its target and detonating.  Use this item to reprogram and activate the C-4 hack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 3750000,
        volume_ml = 250,
        price_cents = 67500,
        price_postapoc_cents = 3000,
        melee_to_hit = -6,
        symbol = ",",
        color = "light_gray",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_c4_hack",
        friendly_message = ccb.content.text("The C-4 hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the C-4 hack; take cover!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_flashbang_hack",
        name = ccb.content.plural_text("inactive flashbang hack", "inactive flashbang hacks"),
        description = ccb.content.text("An inactive flashbang hack.  Manhacks are fist-sized robots that fly through the air.  This one contains a flashbang and attacks by flying at its target and detonating.  Use this item to reprogram and activate the flashbang hack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 1750000,
        volume_ml = 750,
        price_cents = 59500,
        price_postapoc_cents = 500,
        melee_to_hit = -6,
        symbol = ",",
        color = "dark_gray",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_flashbang_hack",
        friendly_message = ccb.content.text("The flashbang hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the flashbang hack; take cover!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_gasbomb_hack",
        name = ccb.content.plural_text("inactive tear gas hack", "inactive tear gas hacks"),
        description = ccb.content.text("An inactive tear gas hack.  Manhacks are fist-sized robots that fly through the air.  This one contains a tear gas canister and attacks by flying at its target and releasing the gas.  Use this item to reprogram and activate the tear gas hack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 3000000,
        volume_ml = 750,
        price_cents = 60500,
        price_postapoc_cents = 500,
        melee_to_hit = -6,
        symbol = ",",
        color = "dark_gray",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_gasbomb_hack",
        friendly_message = ccb.content.text("The tear gas hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the tear gas hack; take cover!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_grenade_hack",
        name = ccb.content.plural_text("inactive grenade hack", "inactive grenade hacks"),
        description = ccb.content.text("An inactive grenade hack.  Manhacks are fist-sized robots that fly through the air.  This one contains a grenade and attacks by flying at its target and detonating.  Use this item to reprogram and activate the grenade hack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 2000000,
        volume_ml = 250,
        price_cents = 60000,
        price_postapoc_cents = 1000,
        melee_to_hit = -6,
        symbol = ",",
        color = "green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_grenade_hack",
        friendly_message = ccb.content.text("The grenade hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the grenade hack; take cover!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_manhack",
        name = ccb.content.plural_text("inactive manhack", "inactive manhacks"),
        description = ccb.content.text("An inactive manhack, a fist-sized robot that flies through the air.  This one is covered with whirring blades and attacks by throwing itself against its target.  Use this item to reprogram and activate the manhack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 1500000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 500,
        melee_to_hit = -6,
        symbol = ",",
        color = "light_green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_manhack",
        friendly_message = ccb.content.text("The manhack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the manhack; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:flag("ROBOFAC_ROBOT_SMALL")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_crows_m240",
        name = ccb.content.plural_text("inactive autonomous M240 CROWS II", "inactive autonomous M240 CROWS II turrets"),
        description = ccb.content.text("An inactive turret.  Using this item involves loading the unit with the factory-loaded 7.62x51mm rounds in your inventory (if you wish to divide your ammunition, set aside whatever 7.62x51mm rounds you do NOT want to give the turret), turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully, the turret will then identify you as a friendly, and attack all enemies with its M240."),
        mass_milligrams = 172000000,
        volume_ml = 30000,
        price_cents = 500000,
        price_postapoc_cents = 6000,
        symbol = ";",
        color = "green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster { monster = "mon_crows_m240", difficulty = 6, moves = 100, skills = { "electronics", "computer" } }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_turret_riot",
        name = ccb.content.plural_text("inactive riot control turret", "inactive riot control turrets"),
        description = ccb.content.text("An inactive riot control turret.  Using this item involves loading the unit with the 40x46mm M1006 sponge rounds in your inventory (if you wish to divide your ammunition, set aside whatever beanbag rounds you do NOT want to give the turret), turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully, the turret will then identify you as a friendly, and attack all enemies with its riot control gun."),
        mass_milligrams = 125000000,
        volume_ml = 60000,
        price_cents = 200500,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "red",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster { monster = "mon_turret_riot", difficulty = 6, moves = 100, skills = { "electronics", "computer" } }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_secubot_liberty",
        name = ccb.content.plural_text("inactive TALON UGV Liberty Edition", "inactive TALON UGVs Liberty Edition"),
        description = ccb.content.text("This bot has had tubes welded above the original guns that allow it to shoot fireworks in order to blind and stun attackers.  With fireworks being harder to come by then the ammo for the original weapons, the best option would be to convert it back to it's original guns.  It should be easy enough to give it back the use of the original M16A4."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 750000,
        price_postapoc_cents = 2500,
        symbol = "F",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_secubot_america_refurbished",
        friendly_message = ccb.content.text("The security bot beeps affirmatively and begins scanning for hostiles."),
        hostile_message = ccb.content.text("You misprogram the security bot and it trains its gun on you.  RUN!"),
        difficulty = 6,
        moves = 150,
        skills = { "electronics", "computer", "fabrication" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_nursebot",
        name = ccb.content.plural_text("inactive nurse bot", "inactive nurse bots"),
        description = ccb.content.text("An inactive nurse bot.  Using this item involves placing it on the ground and reactivating its mechanical body.  If reprogrammed and rewired successfully, the nurse bot will then identify you as a friendly, roam around or follow you, and assist you in surgeries."),
        volume_ml = 62500,
        mass_milligrams = 81500000,
        price_cents = 750000,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "light_blue",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_nursebot",
        friendly_message = ccb.content.text("The nurse bot beeps affirmatively and awaits orders."),
        hostile_message = ccb.content.text("You misprogram the nurse bot.  It's looking at you funny."),
        difficulty = 6,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_grocerybot",
        name = ccb.content.plural_text("inactive grocery bot", "inactive grocery bots"),
        description = ccb.content.text("An inactive grocery bot.  Using this item involves placing it on the ground and reactivating its mechanical body.  If reprogrammed and rewired successfully, the grocery bot will then identify you as a friendly, roam around or follow you."),
        volume_ml = 62500,
        mass_milligrams = 81500000,
        price_cents = 750000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "white",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_grocerybot",
        friendly_message = ccb.content.text("The grocery bot beeps affirmatively and awaits orders."),
        hostile_message = ccb.content.text("You misprogram the grocery bot.  It's looking at you funny."),
        difficulty = 6,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_grocerybot_busted",
        name = ccb.content.plural_text("inactive busted grocery bot", "inactive busted grocery bots"),
        description = ccb.content.text("An inactive grocery bot.  Using this item involves placing it on the ground and reactivating its mechanical body.  If reprogrammed and rewired successfully, the grocery bot will then identify you as a friendly, roam around or follow you."),
        volume_ml = 62500,
        mass_milligrams = 81500000,
        price_cents = 750000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "white",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_grocerybot_busted",
        friendly_message = ccb.content.text("The grocery bot beeps affirmatively and awaits orders."),
        hostile_message = ccb.content.text("You misprogram the grocery bot.  It's looking at you funny."),
        difficulty = 4,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- It is a disgusting mass of rotting flesh and jagged metal pieces, no one will buy it.
    -- Very difficult due to organic interference and failed components
    local item = content.Item {
        id = "bot_broken_cyborg",
        name = ccb.content.plural_text("inactive broken cyborg", "inactive broken cyborgs"),
        description = ccb.content.text("A deactivated broken cyborg, the last shreds of its humanity still rotting away.  Using this item involves placing it on the ground and reactivating its mechanical body.  If reprogrammed and rewired successfully, the cyborg will then follow you and attack enemies.  You monster."),
        mass_milligrams = 81500000,
        volume_ml = 62500,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("flesh", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_broken_cyborg",
        friendly_message = ccb.content.text("The broken cyborg rises to the sound of screeching metal and peers around for hostiles."),
        hostile_message = ccb.content.text("The broken cyborg lets out a howl of agony and attacks you!"),
        difficulty = 9,
        moves = 250,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- It is an affront to humanity, no one will buy it.
    -- Very difficult due to organic interference and failed components
    local item = content.Item {
        id = "bot_prototype_cyborg",
        name = ccb.content.plural_text("inactive prototype cyborg", "inactive prototype cyborgs"),
        description = ccb.content.text("A deactivated prototype cyborg, glimpses of humanity can still be seen in its empty eyes.  Using this item involves placing it on the ground and reactivating its mechanical body.  If reprogrammed and rewired successfully, the cyborg will then follow you and attack enemies.  You monster."),
        mass_milligrams = 81500000,
        volume_ml = 62500,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("flesh", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_prototype_cyborg",
        friendly_message = ccb.content.text("The prototype cyborg rises to the sound of screeching metal and peers around for hostiles."),
        hostile_message = ccb.content.text("The prototype cyborg lets out a howl of agony and attacks you!"),
        difficulty = 9,
        moves = 250,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- Currently has no higher functions
    local item = content.Item {
        id = "bot_hazmatbot",
        name = ccb.content.plural_text("inactive cleaner bot", "inactive cleaner bots"),
        description = ccb.content.text("An inactive cleaner bot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the cleaner bot will respond to future commands."),
        mass_milligrams = 81500000,
        volume_ml = 62500,
        price_cents = 10000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_hazmatbot",
        friendly_message = ccb.content.text("The cleaner bot emits a friendly beep and starts scrubbing."),
        hostile_message = ccb.content.text("The cleaner bot plays an error sound, but starts cleaning anyway."),
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- Volume and weight based on Boston Dynamics Spot.
    -- Same as hacks
    local item = content.Item {
        id = "bot_skitterbot",
        looks_like = "broken_skitterbot",
        name = ccb.content.plural_text("inactive skitterbot", "inactive skitterbots"),
        description = ccb.content.text("An inactive skitterbot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the robot will race towards enemies and shock them."),
        mass_milligrams = 32700000,
        volume_ml = 105000,
        price_cents = 80000,
        price_postapoc_cents = 10000,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_skitterbot",
        friendly_message = ccb.content.text("The skitterbot gives a quick bow and scurries away."),
        hostile_message = ccb.content.text("The skitterbot darts around you and menacingly clicks its tasers."),
        difficulty = 4,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("ROBOFAC_ROBOT_MEDIUM")
    item:tool()
    content.add(item)
end

do
    -- Volume and weight based on Boston Dynamics Spot.
    -- Hub tries to make this easy.
    local item = content.Item {
        id = "bot_robofac_skittergun",
        looks_like = "broken_skitterbot",
        name = ccb.content.plural_text("inactive exterminatron", "inactive exterminatrons"),
        description = ccb.content.text("An inactive Hub 01 exterminatron.  If programmed and reloaded successfully, the robot will track you while providing fire-support.  Activate it while carrying 7.62x51mm NATO M80 to turn it on and reload it."),
        volume_ml = 125000,
        mass_milligrams = 36000000,
        price_cents = 80000,
        price_postapoc_cents = 25000,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_robofac_skittergun",
        friendly_message = ccb.content.text("The exterminatron gives a quick bow and starts scanning the horizon for threats."),
        hostile_message = ccb.content.text("You misprogram the exterminatron and it trains its gun on you.  RUN!"),
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("ROBOFAC_ROBOT_MEDIUM")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_robofac_hound",
        looks_like = "broken_skitterbot",
        name = ccb.content.plural_text("inactive Hub 01 HOUND", "inactive Hub 01 HOUNDs"),
        description = ccb.content.text("A Hub 01 Hostile Overstimulation & Unmanned Neutralization Drone.  If programmed successfully, this quadrupedal robot will closely track you, using a taser and noise-generator to distract, disorient, and ultimately neutralize nearby enemies.  Activate it to turn it on."),
        mass_milligrams = 32700000,
        volume_ml = 105000,
        price_cents = 80000,
        price_postapoc_cents = 60000,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_robofac_hound",
        friendly_message = ccb.content.text("The HOUND gives a quick bow and falls in at your side."),
        hostile_message = ccb.content.text("The HOUND darts around you and menacingly clicks its tasers.  RUN!"),
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
        is_pet = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("ROBOFAC_ROBOT_MEDIUM")
    item:tool()
    content.add(item)
end

do
    -- Not as lethal as a secubot but far more fiddly and complex with its implied assembly and sub-deployment systems
    local item = content.Item {
        id = "bot_science_bot",
        looks_like = "broken_science_bot",
        name = ccb.content.plural_text("inactive lab defense bot", "inactive lab defense bots"),
        description = ccb.content.text("An inactive experimental robot plundered from a science lab.  It resembles a human-sized spider and was designed to deploy manhacks.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the robot will race towards enemies and deploy a variety of experimental devices."),
        mass_milligrams = 100000000,
        volume_ml = 65000,
        price_cents = 80000,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_science_bot",
        friendly_message = ccb.content.text("The lab defense bot shudders briefly and skitters away."),
        hostile_message = ccb.content.text("The lab defense bot raises its front legs and shines a multitude of colored lights in your face!"),
        difficulty = 6,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- Milspec but immobile and no lethal weaponry
    local item = content.Item {
        id = "bot_turret_searchlight",
        name = ccb.content.plural_text("inactive milspec searchlight", "inactive milspec searchlights"),
        description = ccb.content.text("An inactive military-grade automated searchlight.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the searchlight will then identify you as an ally, survey the area, and illuminate approaching hostiles.  Seems to have an unhealthy fascination with you."),
        mass_milligrams = 120000000,
        volume_ml = 92500,
        price_cents = 500000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_turret_searchlight",
        friendly_message = ccb.content.text("The searchlight flares up and establishes a perimeter."),
        hostile_message = ccb.content.text("A bright light blinds you as the searchlight refuses to turn away from you."),
        difficulty = 4,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_dispatch",
        name = ccb.content.plural_text("inactive dispatch", "inactive dispatches"),
        description = ccb.content.text("An inactive Northrop Dispatch, guard model, serving as a mobile assembler and deployer of kamikaze manhacks for defense.  Activate it to place it onto the ground; due to a one-way switch triggered during deactivation, however, it will be nonaggressive, and serves only as a distraction."),
        volume_ml = 95000,
        mass_milligrams = 250000000,
        price_cents = 10000000,
        price_postapoc_cents = 10000,
        symbol = ";",
        color = "yellow",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_dispatch",
        friendly_message = ccb.content.text("The dispatch whirs onto its legs and searches for a target."),
        hostile_message = ccb.content.text("The dispatch turns on you, whacking at you with its arms!"),
        difficulty = 1,
        moves = 300,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_dispatch_military",
        name = ccb.content.plural_text("inactive military dispatch", "inactive military dispatches"),
        description = ccb.content.text("An inactive Northrop Dispatch, military model, serving as a mobile assembler and deployer of lethal manhacks for combat situations.  Activate it to place it onto the ground; due to a one-way switch triggered during deactivation, however, it will be nonaggressive, and serves only as a distraction."),
        volume_ml = 95000,
        mass_milligrams = 300000000,
        price_cents = 100000000,
        price_postapoc_cents = 25000,
        symbol = ";",
        color = "green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_dispatch_military",
        friendly_message = ccb.content.text("The dispatch whirs onto its legs and searches for a target."),
        hostile_message = ccb.content.text("The dispatch turns on you, slashing at you with its arms!"),
        difficulty = 1,
        moves = 300,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_turret_speaker",
        name = ccb.content.plural_text("inactive loudspeaker", "inactive loudspeakers"),
        description = ccb.content.text("An inactive automated loudspeaker.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the loudspeaker will continuously shout pre-recorded messages."),
        mass_milligrams = 100000000,
        volume_ml = 50500,
        price_cents = 500000,
        price_postapoc_cents = 10000,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_turret_speaker",
        friendly_message = ccb.content.text("The loudspeaker activates and begins its nonstop shouts."),
        hostile_message = ccb.content.text("The loudspeaker activates and begins its nonstop shouts."),
        difficulty = 2,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_tazer_hack",
        name = ccb.content.plural_text("inactive taser hack", "inactive taser hacks"),
        description = ccb.content.text("An inactive taser hack.  Manhacks are fist-sized robots that fly through the air.  This one has a taser and attacks by flying at its target and delivering an electric shock.  Use this item to reprogram and release the taser hack.  Electronics and computer skills determine if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 1600000,
        volume_ml = 750,
        price_cents = 64500,
        price_postapoc_cents = 3000,
        melee_to_hit = -6,
        symbol = ",",
        color = "cyan",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_tazer_hack",
        friendly_message = ccb.content.text("The taser hack flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the taser hack; run!"),
        difficulty = 3,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("ROBOFAC_ROBOT_SMALL")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_yrax_trifacet",
        name = ccb.content.plural_text("inactive trifacet", "inactive trifacets"),
        description = ccb.content.text("A featureless quartz pyramid that, although obviously artificial, shows no real indication of ever having been an advanced robot.  Perhaps you could try reactivating it?"),
        mass_milligrams = 30000000,
        volume_ml = 50000,
        price_cents = 64500,
        price_postapoc_cents = 3000,
        symbol = ",",
        color = "cyan",
    }
    item:material("steel", 1)
    item:material("ceramic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_yrax_trifacet",
        difficulty = -1,
        hostile_message = ccb.content.text("The hostile trifacet violently unfolds just clear of your hand!"),
        place_randomly = true,
        moves = 1,
        is_pet = false,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_yrax_triakis",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("inactive triakis", "inactive triakis"),
        category = "other",
        description = ccb.content.text("You know this artfully craved piece of gold hued ceramics to be a robot of some kind, but it seems impossible to interact with it."),
        price_cents = 1000,
        volume_ml = 119000,
        mass_milligrams = 221000000,
    }
    item:material("steel", 1)
    item:material("yrax_quartz", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_yrax_triakis",
        difficulty = -1,
        hostile_message = ccb.content.text("The hostile triakis violently unfolds just clear of your hand!"),
        place_randomly = true,
        moves = 1,
        is_pet = false,
    }
    item:tool()
    content.add(item)
end

do
    -- A lot of gold in this bad boy.
    local item = content.Item {
        id = "bot_golden_monolith",
        symbol = "I",
        name = ccb.content.plural_text("inactive golden monolith", "inactive golden monoliths"),
        description = ccb.content.text("A large golden monolith.  Carefully carved asymmetric edges betray its artificial origin."),
        volume_ml = 930000,
        mass_milligrams = 8282000000,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        color = "yellow",
    }
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_golden_monolith",
        difficulty = -1,
        hostile_message = ccb.content.text("You notice a brief lull in the ambient noise around you, but its otherwise impossible to know if you allowed something to happen."),
        place_randomly = true,
        moves = 1,
        is_pet = false,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_yrax_delta",
        symbol = ",",
        name = ccb.content.plural_text("inactive delta", "inactive deltas"),
        description = ccb.content.text("A small piece of inscrutable alloy shaped like an arrow's broadhead.  It looks like a robot boomerang."),
        mass_milligrams = 374000,
        volume_ml = 500,
        longest_side_mm = 200,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        melee_to_hit = -3,
        weapon_categories = { "SHIVS" },
        color = "yellow",
        techniques = { "RAPID" },
        replace_qualities = true,
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 23)
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("SHEATH_KNIFE")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_yrax_delta",
        difficulty = -1,
        hostile_message = ccb.content.text("The hostile delta starts flying just as you release it!"),
        place_randomly = true,
        moves = 1,
        is_pet = false,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_GR",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "light_green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_GR",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_GM",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "light_green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_GM",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_YM",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "yellow",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_YM",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_BM",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "blue",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_BM",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_BM2",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "cyan",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_BM2",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_lab_security_drone_BS",
        name = ccb.content.plural_text("inactive security drone", "inactive security drones"),
        description = ccb.content.text("An inactive security drone.  They are fist-sized robots that fly through the air.  They have a scanner, lens and speaker.  Use this item to reprogram and activate the security drone.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        price_postapoc_cents = 800,
        melee_to_hit = -6,
        symbol = ",",
        color = "dark_gray",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_lab_security_drone_BS",
        friendly_message = ccb.content.text("The security drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_robofac_camspy",
        looks_like = "broken_robofac_camspy",
        name = ccb.content.plural_text("inactive camspy", "inactive camspies"),
        description = ccb.content.text("An inactive camspy.  Using this item involves turning it on and launching it.  If reprogrammed and rewired successfully, the camspy will then keep watch for intruders."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_robofac_camspy",
        friendly_message = ccb.content.text("The camspy hums and takes to the sky."),
        hostile_message = ccb.content.text("The camspy hums and appears to reconnect to whoever was piloting it before."),
        difficulty = 3,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
