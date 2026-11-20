local ccb = require("ccb")

-- Milspec, but was deployed in active service implying a reliable IFF
ccb.content.define_item {
    id = "bot_chickenbot",
    name = ccb.content.plural_text("inactive chicken walker", "inactive chicken walkers"),
    description = ccb.content.text("This is an inactive chicken walker.  Using this item involves placing it on the ground, loading the unit with the factory-loaded 5.56 rounds and 40mm cartridge grenades in your inventory (if you wish to divide your ammunition, set aside whatever ammunition you do NOT want to give the robot) and turning it on.  If reprogrammed and rewired successfully the chicken walker will then identify you as a friendly, roam around or follow you, and attack all enemies with a built-in firearm and grenade launcher."),
    mass = "120000 g",
    volume = "92500 ml",
    price = "500 kUSD",
    accuracy = -3,
    materials = { "steel" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_chickenbot",
            friendly_message = ccb.content.text("The chicken walker rises to its feet, sways away from you and begins surveying the area."),
            hostile_message = ccb.content.text("The chicken walker whirrs and aims directly at you.  Take cover!"),
            difficulty = 9,
            moves = 250,
            skills = { "electronics", "computer" },
        },
    },
}

-- cheating a bit with the volume due to lack of proper vehicle storage options
-- Milspec, clearly designed with little concern for collateral damage. What did you expect of a robo-tank?
ccb.content.define_item {
    id = "bot_tankbot",
    looks_like = "broken_tankbot",
    name = ccb.content.plural_text("inactive tank drone", "inactive tank drones"),
    description = ccb.content.text("This is an inactive Beagle Mini-Tank UGV.  Using this item involves placing it on the ground, loading the unit with the factory-loaded 5.56 rounds and 40mm cartridge grenades in your inventory (if you wish to divide your ammunition, set aside whatever ammunition you do NOT want to give the robot) and turning it on.  If reprogrammed and rewired successfully the tank drone will then identify you as a friendly, roam around or follow you, and attack all enemies with a built-in firearm and grenade launcher."),
    mass = "200000 g",
    volume = "250 L",
    price = "1000 kUSD",
    accuracy = -3,
    materials = { "steel" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_tankbot",
            friendly_message = ccb.content.text("The tank drone rolls out and begins acquiring targets."),
            hostile_message = ccb.content.text("The tank drone swivels its turret and aims directly at you.  Don your brown pants!"),
            difficulty = 10,
            moves = 500,
            skills = { "electronics", "computer" },
        },
    },
}

-- Former volume: 1100 L. Adjusted to 1000L so it can actually be placed. TODO(?): Re-add old volume with some sort of flag
-- Milspec, clearly designed with little concern for collateral damage.  What did you expect of a chicken walker?
ccb.content.define_item {
    id = "broken_chickenbot",
    looks_like = "broken_tripod",
    symbol = ",",
    color = "green",
    name = ccb.content.plural_text("broken chickenbot", "broken chickenbots"),
    category = "other",
    description = ccb.content.text("A broken chicken walker.  Still looks intimidating despite being permanently inoperative, possibly due to the sheer size and mass.  Could be gutted for parts."),
    price = "10 USD",
    materials = { "steel", "plastic" },
    mass = "1023850 g",
    volume = "1000 L",
    accuracy = -3,
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 20, cut = 15 },
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_chickenbot",
            friendly_message = ccb.content.text("The chicken bot rolls out and begins acquiring targets."),
            hostile_message = ccb.content.text("The chicken bot swivels its turret and aims directly at you.  Don your brown pants!"),
            difficulty = 10,
            moves = 500,
            skills = { "electronics", "computer" },
        },
    },
}

-- No observed open deployment, likely a prototype or secret project
ccb.content.define_item {
    id = "bot_tripod",
    looks_like = "broken_tripod",
    name = ccb.content.plural_text("inactive tripod", "inactive tripods"),
    description = ccb.content.text("This is an inactive Honda Regnal.  Using this item involves placing it on the ground, wondering how it fuels its flamethrower and turning it on.  If reprogrammed and rewired successfully the tribot will then identify you as an ally, roam around or follow you, and impale hostiles with its spiked cable weapons."),
    mass = "120000 g",
    volume = "92500 ml",
    price = "1000 kUSD",
    accuracy = -3,
    materials = { "steel" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_tripod",
            friendly_message = ccb.content.text("The tribot rises to its feet and scans the area for contaminants."),
            hostile_message = ccb.content.text("The tribot glowers down at you and ignites its flamethrower.  Turns out you hate the smell of napalm."),
            difficulty = 15,
            moves = 500,
            skills = { "electronics", "computer" },
        },
    },
}
