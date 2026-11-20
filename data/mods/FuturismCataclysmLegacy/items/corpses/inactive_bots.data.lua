local ccb = require("ccb")

-- Like most surveillance tech these likely have poor security. Secure the wifi!
ccb.content.define_item {
    id = "fcl_bot_eyebot",
    looks_like = "broken_eyebot",
    name = ccb.content.plural_text("inactive eyebot", "inactive eyebots"),
    description = ccb.content.text("An inactive eyebot.  Using this item involves turning it on and launching the UAV.  If reprogrammed and rewired successfully, the eyebot will then keep watch for intruders."),
    mass = "40750 g",
    volume = "30 L",
    price = "100 USD",
    survival_price = "5 USD",
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
            monster = "mon_fcl_eyebot",
            friendly_message = ccb.content.text("The eyebot hums and takes to the sky."),
            hostile_message = ccb.content.text("The eyebot beeps disapprovingly and focuses its camera on your face.  Say cheese!"),
            difficulty = 1,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

-- Wheeled and must be easy-to-use for police deployment
ccb.content.define_item {
    id = "fcl_bot_copbot",
    looks_like = "broken_copbot",
    name = ccb.content.plural_text("inactive police bot", "inactive police bots"),
    description = ccb.content.text("An inactive police robot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the police bot will then identify you as law enforcement, roam around or follow you, and attempt to detain lawbreakers."),
    mass = "81500 g",
    volume = "62500 ml",
    price = "1 kUSD",
    survival_price = "5 USD",
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
            monster = "mon_fcl_copbot",
            friendly_message = ccb.content.text("The police bot rolls into action, ready to pursue criminals."),
            hostile_message = ccb.content.text("A siren howls and lights flash as the police bot prepares to arrest you!"),
            difficulty = 3,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

-- Digging parameters need special attention but no (intentional) lethal weapons
ccb.content.define_item {
    id = "fcl_bot_molebot",
    looks_like = "broken_molebot",
    name = ccb.content.plural_text("inactive miner bot", "inactive miner bots"),
    description = ccb.content.text("An inactive mining robot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the miner bot will respond to future commands."),
    mass = "81500 g",
    volume = "62500 ml",
    price = "250 USD",
    survival_price = "10 USD",
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
            monster = "mon_fcl_molebot",
            friendly_message = ccb.content.text("The miner bot whirrs and tunnels into the ground."),
            hostile_message = ccb.content.text("The miner bot spins out of control and lunges at you.  Make way!"),
            difficulty = 3,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

-- Pretty easy but you want to be careful with the gas
ccb.content.define_item {
    id = "fcl_bot_riotbot",
    looks_like = "broken_riotbot",
    name = ccb.content.plural_text("inactive riot control bot", "inactive riot control bots"),
    description = ccb.content.text("An inactive riot control bot.  Using this item involves placing it on the ground and turning it on.  If reprogrammed and rewired successfully, the robot will bring order and peace to the horde."),
    mass = "81500 g",
    volume = "62500 ml",
    price = "350 USD",
    survival_price = "15 USD",
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
            monster = "mon_fcl_riotbot",
            friendly_message = ccb.content.text("The riot control bot rolls into action."),
            hostile_message = ccb.content.text("The riot control bot gasses you and approaches with a pair of handcuffs!"),
            difficulty = 4,
            moves = 150,
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

ccb.content.define_item {
    id = "bot_skitterbot_rat",
    looks_like = "broken_skitterbot",
    name = ccb.content.plural_text("inactive rat snatcher", "inactive rat snatchers"),
    description = ccb.content.text("A small hexapod drone designed to hold small pests, folded into a small cube for easy storage.  It's capable of hunting all sorts of small mammals with remarkable efficiency, but shouldn't be expected to handle anything much bigger than a rat."),
    materials = { "steel", "plastic" },
    mass = "750 g",
    volume = "1 L",
    price = "200 USD",
    survival_price = "100 USD",
    accuracy = -3,
    symbol = ";",
    color = "dark_gray",
    flags = { "TRADER_AVOID", "SINGLE_USE" },
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
            monster = "fcl_mon_migoturret",
            friendly_message = ccb.content.text("The brain blaster swivels towards you.  Hi new friend!"),
            hostile_message = ccb.content.text("The brain blaster swivels towards you.  You feel a buzzing in the air."),
            difficulty = 6,
            moves = 100,
            skills = { "cooking", "computer" },
        },
    },
}
