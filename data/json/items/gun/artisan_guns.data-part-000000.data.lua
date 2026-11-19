local ccb = require("ccb")

-- remove mosin variants
-- 20cm barrel length, 15cm remaining stock.
-- should be very inaccurate and hard to aim by comparison.  Setting handling to that of pistols
ccb.content.define_item {
    id = "obrez",
    copy_from = "mosin91_30",
    name = ccb.content.plural_text("the Obrez", "the Obrez"),
    description = ccb.content.text("A cut-down, modified Mosin-Nagant.  It has a short barrel and the stock has been cut down and fitted with a mace head, with new low profile front and rear sights added.  The sides of the firearm have been reinforced with metal to withstand a beating."),
    variants = {},
    mass = "3000 g",
    volume = "2220 ml",
    length = "35 cm",
    price = "230 USD",
    survival_price = "30 USD",
    accuracy = { grip = "solid", length = "short", surface = "any", balance = "uneven" },
    qualities = { { id = "HAMMER", level = 1 } },
    weapon_categories = { "MACES" },
    melee_damage = { bash = 30 },
    inheritance = { add = { flags = { "DURABLE_MELEE" } }, offset = { barrel_volume = "-500 ml" } },
    gun = {
        barrel_length = "200 mm",
        handling = 10,
        range = -30,
        damage = { type = "bullet", amount = -17 },
        dispersion = 180,
        mod_locations = {
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
