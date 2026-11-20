local ccb = require("ccb")

-- The moves action cost should always be at least 100 (one full second) so that the molotov can properly know who's throwing it. See iuse::molotov_lit() for more details.
ccb.content.define_item {
    id = "molotov",
    category = "weapons",
    name = ccb.content.plural_text("Molotov cocktail", "Molotov cocktails"),
    description = ccb.content.text("A bottle of flammable liquid with a rag inserted.  Use this item to light the rag.  You will, of course, need a lighter or matches in your inventory to do this.  After lighting it, throw it to cause fires."),
    mass = "889 g",
    volume = "1085 ml",
    length = "29 cm",
    price = "0 USD",
    survival_price = "4 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "glass", "cotton" },
    symbol = "*",
    color = "light_gray",
    flags = { "NPC_ACTIVATE", "NO_REPAIR", "CYLINDER_GRENADE" },
    melee_damage = { bash = 5 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "molotov_lit",
            message = ccb.content.text("You light the Molotov cocktail!"),
            moves = 250,
            need_fire = 1,
            menu_text = ccb.content.text("Light rag"),
        },
    },
}
