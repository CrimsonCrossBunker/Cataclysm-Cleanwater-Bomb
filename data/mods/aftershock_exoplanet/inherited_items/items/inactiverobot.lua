local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "bot_defbot_base",
        abstract = true,
        name = content.plural_text("inactive defense robot", "inactive defense robots"),
        looks_like = "mon_riotbot",
        mass_milligrams = 140000000,
        volume_ml = 62500,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_sentinel_lx",
        name = ccb.content.plural_text("inactive Sentinel-lx", "inactive Sentinels-lx"),
        description = ccb.content.text("Crouched and dead still, this armored luxurious robot resembles an ancient knight immersed in deep prayer.  If reprogrammed and rewired successfully the robot will identify you as a friendly, and will protect you from nearby foes."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 600000,
        melee_to_hit = -3,
        symbol = ";",
        color = "green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster { monster = "afs_mon_sentinel_lx", difficulty = 4, moves = 100, skills = { "computer" }, is_pet = true }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_wraitheon_kaburaya",
        name = ccb.content.plural_text("inactive Kabura-ya drone", "inactive Kabura-ya drones"),
        description = ccb.content.text("An inactive Kabura-ya hunter drone, folded for ease of storage.  If deployed, it will seek and fly to the closest enemy before detonating.  Unlike most robots, its activation depends on a successful throw, and not on your computer skill."),
        mass_milligrams = 550000,
        volume_ml = 250,
        price_cents = 5000,
        melee_to_hit = -3,
        symbol = ";",
        color = "green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_wraitheon_kaburaya",
        friendly_message = ccb.content.text("The Kabura-ya emits a short IFF chirp as you throw it."),
        hostile_message = ccb.content.text("The Kabura-ya emits an warning whine after your botched throw!"),
        difficulty = 1,
        moves = 100,
        skills = { "throw" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 0)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_bloodhound_drone",
        name = ccb.content.plural_text("inactive bloodhound drone", "inactive bloodhound drones"),
        description = ccb.content.text("This is an inactive bloodhound drone.  If successfully deployed, it will fly towards enemy targets and highlight them with a powerful spotlight."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 60000,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_bloodhound_drone",
        friendly_message = ccb.content.text("The bloodhound drone flies from your hand and surveys the area!"),
        hostile_message = ccb.content.text("You misprogram the bloodhound drone; it's hostile!"),
        difficulty = 4,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
        is_pet = true,
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
        id = "bot_utilibot_beehive",
        copy_from = "bot_utilibot_base",
        name = ccb.content.plural_text("inactive bee-bot", "inactive bee-bots"),
        description = ccb.content.text("A salvaged utility robot converted into an ambulatory bee hive that periodically removes and delivers segments of fresh honey comb.  Activate this item to deploy the robot."),
        color = "yellow",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_utilibot_beehive",
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
        is_pet = true,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_shock_mine",
        copy_from = "bot_hack_base",
        name = ccb.content.plural_text("inactive shock-mine", "inactive shock-mines"),
        description = ccb.content.text("A less-than-lethal mine that emits a powerful electrical shock when triggered.  Activate this item to deploy the mine, which will have a lifetime of 10 hours after activation."),
        color = "yellow",
        volume_ml = 1000,
        mass_milligrams = 1200000,
    }
    item:clear_use_actions()
    item:deploy_monster { monster = "mon_shock_mine", difficulty = 1, moves = 100, skills = { "traps", "computer" } }
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "bot_medibot_base",
        abstract = true,
        looks_like = "mon_tripod",
        name = content.plural_text("inactive medibot", "inactive medibots"),
        mass_milligrams = 70000000,
        volume_ml = 50000,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_medibot",
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
        is_pet = true,
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "bot_utilibot_base",
        abstract = true,
        name = content.plural_text("inactive utilibot", "inactive utilibots"),
        looks_like = "mon_cleanerbot",
        price_cents = 10000,
        price_postapoc_cents = 10000,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_hack_base",
        abstract = true,
        name = ccb.content.plural_text("inactive hack", "inactive hacks"),
        description = ccb.content.text("This is an inactive manhack.  Manhacks are fist-sized robots that fly through the air.  They are covered with whirring blades and attack by throwing themselves against their target.  Use this item to reprogram and activate the manhack.  Electronics and computer skill determines if the targeting matrix is reprogrammed successfully."),
        mass_milligrams = 5400000,
        volume_ml = 750,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_green",
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_light_hack",
        copy_from = "bot_hack_base",
        name = ccb.content.plural_text("inactive floating lantern", "inactive floating lanterns"),
        description = ccb.content.text("An inactive floating lantern, a fist-sized robot that flies through the air and illuminates its surroundings with bright LEDs.  The lantern is non aggressive and has no means of attack.  Activate this item to deploy the salvaged robot."),
        color = "yellow",
        looks_like = "bot_manhack",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_light_hack",
        friendly_message = ccb.content.text("The floating lantern flies from your hand and lights up the area!"),
        hostile_message = ccb.content.text("You misprogram the lantern."),
        difficulty = 1,
        moves = 60,
        place_randomly = true,
        skills = { "electronics", "computer" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_skitterbot_grab",
        copy_from = "bot_skitterbot_base",
        name = ccb.content.plural_text("inactive grab-bot", "inactive grab-bots"),
        description = ccb.content.text("A salvaged skitterbot repurposed to grab onto and immobilize enemies.  Activate this item to deploy the robot."),
        color = "green",
    }
    item:clear_use_actions()
    item:deploy_monster { monster = "mon_skitterbot_grab", difficulty = 1, moves = 100, skills = { "electronics", "computer" } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_skitterbot_hunter",
        copy_from = "bot_skitterbot_base",
        name = ccb.content.plural_text("inactive pest hunter", "inactive pest hunters"),
        description = ccb.content.text("A salvaged skitterbot refitted with an 8mm integrated firearm.  Activate this item, with ammo in your inventory, to load and deploy the robot."),
        color = "dark_gray",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_skitterbot_hunter",
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
        is_pet = true,
    }
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "bot_eyebot_base",
        abstract = true,
        name = content.plural_text("inactive eyebot", "inactive eyebots"),
        looks_like = "broken_afs_eyebot",
        price_cents = 10000,
        price_postapoc_cents = 10000,
        mass_milligrams = 62650000,
        volume_ml = 30000,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_eyebot_heater",
        copy_from = "bot_eyebot_base",
        name = ccb.content.plural_text("inactive floating heater", "inactive floating heaters"),
        description = ccb.content.text("A salvaged eyebot repurposed into a floating space heater.  It emits a constant jet of warm air to heat an enclosed space.  It is non-aggressive and has no weapons systems.  Activate this item to deploy the robot."),
        color = "pink",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_eyebot_heater",
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
        is_pet = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_laserturret_xray",
        name = ccb.content.plural_text("inactive x-ray laser turret", "inactive x-ray laser turrets"),
        description = ccb.content.text("This is an inactive laser turret.  Using this item involves turning it on and placing it on the ground, where it will attach itself.  If reprogrammed and rewired successfully the turret will identify you as a friendly, and attack all enemies with its revolving laser cannons.  It requires sunlight in order to fire."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 600000,
        price_postapoc_cents = 12000,
        melee_to_hit = -3,
        symbol = ";",
        color = "white",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_laserturret_xray",
        difficulty = 6,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_laserturret_interior",
        looks_like = "bot_rifleturret",
        name = ccb.content.plural_text("inactive SOL XII laser turret", "inactive SOL XII laser turrets"),
        description = ccb.content.text("This is an inactive laser turret.  Using this item involves turning it on and placing it on the ground, where it will attach itself.  If reprogrammed and rewired successfully the turret will identify you as a friendly, and attack all enemies with its revolving laser cannons.  It requires sunlight in order to fire."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 600000,
        price_postapoc_cents = 12000,
        melee_to_hit = -3,
        symbol = ";",
        color = "white",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_afs_commercial_laser_turret",
        difficulty = 6,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    -- Like most surveillance tech these likely have poor security. Secure the wifi!
    local item = content.Item {
        id = "afs_bot_eyebot",
        looks_like = "broken_afs_eyebot",
        name = ccb.content.plural_text("inactive eyebot", "inactive eyebots"),
        description = ccb.content.text("An inactive eyebot.  Using this item involves turning it on and launching the UAV.  If reprogrammed and rewired successfully, the eyebot will then keep watch for intruders."),
        mass_milligrams = 40750000,
        volume_ml = 30000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_afs_eyebot",
        friendly_message = ccb.content.text("The eyebot hums and takes to the sky."),
        hostile_message = ccb.content.text("The eyebot beeps disapprovingly and focuses its camera on your face.  Say cheese!"),
        difficulty = 1,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    -- Wheeled and must be easy-to-use for police deployment
    local item = content.Item {
        id = "afs_bot_copbot",
        looks_like = "broken_afs_copbot",
        name = ccb.content.plural_text("inactive police bot", "inactive police bots"),
        description = ccb.content.text("An inactive police robot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the police bot will then identify you as law enforcement, roam around or follow you, and attempt to detain lawbreakers."),
        mass_milligrams = 81500000,
        volume_ml = 62500,
        price_cents = 100000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_afs_copbot",
        friendly_message = ccb.content.text("The police bot rolls into action, ready to pursue criminals."),
        hostile_message = ccb.content.text("A siren howls and lights flash as the police bot prepares to arrest you!"),
        difficulty = 3,
        moves = 100,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    -- Pretty easy but you want to be careful with the gas
    local item = content.Item {
        id = "afs_bot_riotbot",
        looks_like = "broken_afs_riotbot",
        name = ccb.content.plural_text("inactive riot control bot", "inactive riot control bots"),
        description = ccb.content.text("An inactive riot control bot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the robot will bring order and peace to the horde."),
        mass_milligrams = 81500000,
        volume_ml = 62500,
        price_cents = 35000,
        price_postapoc_cents = 1500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_green",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_afs_riotbot",
        friendly_message = ccb.content.text("The riot control bot rolls into action."),
        hostile_message = ccb.content.text("The riot control bot gasses you and approaches with a pair of handcuffs!"),
        difficulty = 4,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end
