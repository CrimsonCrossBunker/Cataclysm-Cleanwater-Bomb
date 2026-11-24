local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_migoturret",
    name = ccb.content.plural_text("inactive brain blaster", "inactive brain blasters"),
    description = ccb.content.text("This is a horrifying monstrosity.  Using this item is cannibalism in all but taste and involves turning it on and placing it on the ground, where it will attach itself.  If reprogrammed and rewired successfully the turret will identify you as a friendly, and attack all enemies with its revolving laser cannons."),
    mass = "40750 g",
    volume = "30 L",
    price = "6 kUSD",
    accuracy = -3,
    materials = { "alien_resin" },
    symbol = ";",
    color = "green",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "afs_mon_migoturret",
            friendly_message = ccb.content.text("The brain blaster swivels towards you.  Hi new friend!"),
            hostile_message = ccb.content.text("The brain blaster swivels towards you.  You feel a buzzing in the air."),
            difficulty = 6,
            moves = 100,
            skills = { "cooking", "computer" },
        },
    },
}

-- cheating a bit with the volume due to lack of proper vehicle storage options
-- Milspec, clearly designed with little concern for collateral damage. What did you expect of a robo-tank?
ccb.content.define_item {
    id = "bot_tankbot",
    looks_like = "broken_tankbot",
    name = ccb.content.plural_text("inactive Regulator", "inactive Regulators"),
    description = ccb.content.text("This is an inactive Regulator.  Using this item involves placing it on the ground, loading the unit with 7.50mm rounds and 40x46mm grenades in your inventory and turning it on.  If reprogrammed and rewired successfully the drone will then identify you as a friendly, roam around or follow you, and attack all enemies with a built-in firearm and grenade launcher."),
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
            friendly_message = ccb.content.text("The Regulator rolls out and begins acquiring targets."),
            hostile_message = ccb.content.text("The Regulator swivels its turret and aims directly at you.  Don't brown your pants!"),
            difficulty = 10,
            moves = 500,
            skills = { "electronics", "computer" },
        },
    },
}

-- cheating a bit with the volume due to lack of proper vehicle storage options
-- Milspec, clearly designed with little concern for collateral damage.  What did you expect of a chicken walker?
ccb.content.define_item {
    id = "bot_chickenbot",
    looks_like = "broken_tripod",
    name = ccb.content.plural_text("inactive Pathfinder", "inactive Pathfinders"),
    description = ccb.content.text("This is an inactive Pathfinder.  Using this item involves placing it on the ground, loading the unit with 7.50mm rounds and 40x46mm grenades in your inventory and turning it on.  If reprogrammed and rewired successfully the drone will then identify you as a friendly, roam around or follow you, and attack all enemies with a built-in firearm and grenade launcher."),
    mass = "190000 g",
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
            monster = "mon_chickenbot",
            friendly_message = ccb.content.text("The Pathfinder rolls out and begins acquiring targets."),
            hostile_message = ccb.content.text("The Pathfinder swivels its turret and aims directly at you.  Don't brown your pants!"),
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
    description = ccb.content.text("This is an inactive Honda Crop King.  Using this item involves placing it on the ground, loading the unit with napalm in your inventory and turning it on.  If reprogrammed and rewired successfully the tribot will then identify you as an ally, roam around or follow you, and impale hostiles with its spiked cable weapons."),
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

-- NO_I18N
ccb.content.define_item {
    id = "bot_milbot_base",
    abstract = true,
    name = ccb.content.text_without_extraction("inactive military robot"),
    looks_like = "mon_secubot",
    materials = { "steel", "kevlar" },
    mass = "140 kg",
    volume = "62500 ml",
    price = "100 USD",
    survival_price = "100 USD",
    accuracy = -3,
    symbol = ";",
    color = "light_gray",
    flags = { "LEAK_DAM", "RADIOACTIVE", "TRADER_AVOID", "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
}

ccb.content.define_item {
    id = "bot_milbot_308",
    copy_from = "bot_milbot_base",
    name = ccb.content.plural_text("inactive military robot", "inactive military robots"),
    description = ccb.content.text("An unpowered military robot fitted with an integrated 7.62 firearm and electric prod.  Activate this item, with ammo in your inventory, to load and deploy the robot."),
    color = "green",
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_milbot_308",
            difficulty = 0,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "bot_skitterbot_base",
    abstract = true,
    name = ccb.content.text_without_extraction("inactive skitterbot"),
    looks_like = "broken_skitterbot",
    materials = { "steel", "plastic" },
    mass = "62650 g",
    volume = "30 L",
    price = "100 USD",
    survival_price = "100 USD",
    accuracy = -3,
    symbol = ";",
    color = "dark_gray",
    flags = { "TRADER_AVOID", "SINGLE_USE" },
    melee_damage = { bash = 6 },
    tool = {},
}

ccb.content.define_item {
    id = "bot_skitterbot_rat",
    copy_from = "bot_skitterbot_base",
    name = ccb.content.plural_text("inactive rat snatcher", "inactive rat snatchers"),
    description = ccb.content.text("A small hexapod drone designed to hold small pests, folded into a small cube for easy storage.  It's capable of hunting all sorts of small mammals with remarkable efficiency, but shouldn't be expected to handle anything much bigger than a rat."),
    color = "dark_gray",
    mass = "750 g",
    volume = "1 L",
    price = "200 USD",
    accuracy = -3,
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_skitterbot_rat",
            difficulty = 1,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}
