local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_antimateriel",
    name = ccb.content.plural_text("inactive M2HB autonomous CROWS II", "inactive M2HB autonomous CROWS II turrets"),
    description = ccb.content.text("An inactive turret.  Using this item involves loading the unit with the factory-loaded .50 BMG rounds in your inventory (if you wish to divide your ammunition, set aside whatever .50 BMG rounds you do NOT want to give the turret), turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully, the turret will then identify you as a friendly, and attack all enemies with its M2HB."),
    mass = "172 kg",
    volume = "30 L",
    price = "5 kUSD 5 USD",
    survival_price = "80 USD",
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "red",
    flags = { "SINGLE_USE", "NO_SALVAGE" },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_turret_bmg",
            difficulty = 6,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

ccb.content.define_item {
    id = "bot_rifleturret",
    name = ccb.content.plural_text("inactive autonomous M249 CROWS II", "inactive autonomous M249 CROWS II turrets"),
    description = ccb.content.text("An inactive turret.  Using this item involves loading the unit with the factory-loaded 5.56x45mm rounds in your inventory (if you wish to divide your ammunition, set aside whatever 5.56x45mm rounds you do NOT want to give the turret), turning it on, and placing it on the ground, where it will attach itself.  If programmed successfully, the turret will then identify you as a friendly, and attack all enemies with its M249."),
    mass = "172 kg",
    volume = "30 L",
    price = "5 kUSD",
    survival_price = "50 USD",
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "green",
    flags = { "SINGLE_USE", "NO_SALVAGE" },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_turret_rifle",
            difficulty = 6,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

ccb.content.define_item {
    id = "bot_turret",
    name = ccb.content.plural_text("inactive turret", "inactive turrets"),
    description = ccb.content.text("An inactive turret.  Using this item involves loading the unit with the factory-loaded 9x19mm rounds in your inventory (if you wish to divide your ammunition, set aside whatever 9x19mm you do NOT want to give the turret), turning it on, and placing it on the ground.  If reprogrammed and rewired successfully, the turret will then identify you as a friendly, and attack all enemies with its SMG."),
    mass = "40750 g",
    volume = "30 L",
    price = "4 kUSD",
    survival_price = "30 USD",
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_turret",
            difficulty = 6,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}

ccb.content.define_item {
    id = "bot_secubot",
    name = ccb.content.plural_text("inactive TALON UGV", "inactive TALON UGVs"),
    description = ccb.content.text("An inactive TALON UGV equipped with an M16A4.  Using this item involves loading the unit with the factory-loaded 5.56x45mm rounds in your inventory (if you wish to divide your ammunition, set aside whatever 5.56x45mm you do NOT want to give the robot), turning it on, and placing it on the ground.  If reprogrammed and rewired successfully, the security bot will then identify you as a friendly, roam around or follow you, and attack all enemies with its rifle."),
    mass = "40750 g",
    volume = "30 L",
    price = "7 kUSD 500 USD",
    survival_price = "40 USD",
    materials = { "steel" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_secubot",
            friendly_message = ccb.content.text("The security bot beeps affirmatively and begins scanning for hostiles."),
            hostile_message = ccb.content.text("You misprogram the security bot and it trains its gun on you.  RUN!"),
            difficulty = 6,
            moves = 150,
            skills = { "electronics", "computer" },
        },
    },
}

ccb.content.define_item {
    id = "bot_talon_m202a1",
    name = ccb.content.plural_text("inactive M202A1 TALON UGV", "inactive M202A1 TALON UGVs"),
    description = ccb.content.text("An inactive TALON UGV equipped with an M202A1.  Using this item involves loading the unit with the M235 rockets in your inventory (if you wish to divide your ammunition, set aside whatever M235 rockets you do NOT want to give the robot), turning it on, and placing it on the ground.  If reprogrammed and rewired successfully, the security bot will then identify you as a friendly, roam around or follow you, and attack all enemies with its M202A1."),
    mass = "40750 g",
    volume = "30 L",
    price = "7 kUSD 500 USD",
    survival_price = "30 USD",
    materials = { "steel" },
    symbol = ";",
    color = "light_green",
    flags = { "SINGLE_USE" },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_talon_m202a1",
            friendly_message = ccb.content.text("The security bot beeps affirmatively and begins scanning for hostiles."),
            hostile_message = ccb.content.text("You misprogram the security bot and it trains its gun on you.  RUN!"),
            difficulty = 6,
            moves = 150,
            skills = { "electronics", "computer" },
        },
    },
}
