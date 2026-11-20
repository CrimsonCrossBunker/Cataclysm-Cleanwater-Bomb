local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_laserturret",
    name = ccb.content.plural_text("inactive laser turret", "inactive laser turrets"),
    description = ccb.content.text("This is an inactive laser turret.  Using this item involves turning it on and placing it on the ground, where it will attach itself.  If reprogrammed and rewired successfully the turret will identify you as a friendly, and attack all enemies with its revolving laser cannons.  It requires sunlight in order to fire."),
    mass = "40750 g",
    volume = "30 L",
    price = "6 kUSD",
    survival_price = "120 USD",
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "white",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_laserturret",
            difficulty = 6,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}
