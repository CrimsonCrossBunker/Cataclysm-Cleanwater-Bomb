local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_geomagnetic_hover_wheel",
    category = "veh_parts",
    name = ccb.content.plural_text("geomagnetic-sensing hover wheel", "geomagnetic-sensing hover wheels"),
    description = ccb.content.text("A stress wheel, purported to exploit geomagnetic induction effects, enables a vehicle to hover in near-ground suspension at a height slightly above the ground.  As one of this century's latest commercialized levitation applications, it clearly cannot rival the rumored secret military project capable of levitating flight."),
    mass = "38250 g",
    volume = "27500 ml",
    length = "803 mm",
    price = "240 USD",
    survival_price = "2 kUSD 500 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "superalloy", "mc_steel" },
    symbol = "0",
    color = "light_gray",
    melee_damage = { bash = 8 },
    wheel = { diameter = 30, width = 12 },
}
