local ccb = require("ccb")

-- sci-fantasy extradimensional gadget = pricey
-- because nobody would have that amount after the world ends, it's worth $1000 in barter
ccb.content.define_item {
    id = "afs_bag_of_holding",
    name = ccb.content.plural_text("bag of holding", "bags of holding"),
    description = ccb.content.text("A sleek, unfathomably-complicated machine covered in dozens of blinking lights, worn on the back by sturdy faux-leather straps.  An electrode dangles from the back, attaching to your forehead.  How it operates without annihilating spacetime isn't quite clear, but a localized portal allows things to be stored in an extradimensional space."),
    mass = "3401 g",
    volume = "3 L",
    price = "10000 kUSD",
    survival_price = "1 kUSD",
    materials = { "glass", "superalloy", "platinum" },
    symbol = "[",
    color = "cyan",
    looks_like = "molle_pack",
    pockets = { { kind = "CONTAINER", capacity = "100 L", mass_limit = "500 kg", moves = 300 } },
    flags = { "BELTED", "LEAK_DAM" },
    max_worn = 1,
    armor = {
        warmth = 5,
        thickness = 1,
        portions = { { encumbrance = { 5, 10 }, coverage = 30, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "afs_titanium_vest",
    name = ccb.content.text("titanium vest"),
    description = ccb.content.text("A lightweight armor vest made of pieces of titanium sewn together, with cloth padding for comfort.  Its not particularly effective in a real fight."),
    mass = "939 g",
    volume = "500 ml",
    price = "10 USD",
    accuracy = -3,
    materials = { "titanium", "cotton" },
    symbol = "[",
    looks_like = "armor_scrapsuit",
    color = "white",
    flags = { "STURDY", "OUTER" },
    armor = { thickness = 1, portions = { { encumbrance = 4, coverage = 80, covers = { "torso" } } } },
}
