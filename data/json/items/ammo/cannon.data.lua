local ccb = require("ccb")

-- 4 pound cannonball weighs 28000 grains,shot at 1215 ft/s by a 3in ordnance rifle, equals 124459 joules of muzzle energy according to Shooters Calculator, round down from square root 352.78
-- Recoil currently copied from 50 bmg ball as game_balance.md does not state a method for calculating recoil
ccb.content.define_item {
    id = "cannon_shot",
    name = ccb.content.plural_text("cannon round shot", "cannon round shot"),
    description = ccb.content.text("A bundle of wadding, black gunpowder, and a cannonball, ready to be loaded into a cannon."),
    ascii_picture = "cannon_shot",
    mass = "2350 g",
    volume = "1000 ml",
    price = "11 USD",
    survival_price = "12 USD",
    materials = { "steel", "powder" },
    symbol = "=",
    color = "white",
    stack_size = 1,
    ammunition = {
        count = 1,
        type = "cannon",
        range = 50,
        damage = { type = "bullet", amount = 352 },
        dispersion = 620,
        recoil = 26250,
        loudness = 900,
        effects = { "COOKOFF", "MUZZLE_SMOKE", "BLACKPOWDER", "RECYCLED", "EXCESS_PEN" },
    },
}
