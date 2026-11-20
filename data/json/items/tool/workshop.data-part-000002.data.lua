local ccb = require("ccb")

-- The multitool is a bit more of a toolkit than a knife.
ccb.content.define_item {
    id = "camping_multitool",
    name = ccb.content.plural_text("camping multitool", "camping multitools"),
    description = ccb.content.text("A 'Hideman' brand multi-tool.  This model includes extra options for outdoors use such as a firestarting rod, awl, rescue whistle and a hammering surface."),
    looks_like = "multitool",
    mass = "212 g",
    volume = "70 ml",
    length = "12 cm",
    price = "40 USD",
    survival_price = "7 USD",
    accuracy = { grip = "solid", length = "hand", surface = "point", balance = "neutral" },
    materials = { "steel" },
    symbol = ";",
    color = "light_gray",
    qualities = {
        { id = "CUT", level = 2 },
        { id = "SAW_W", level = 1 },
        { id = "SAW_M", level = 1 },
        { id = "WRENCH", level = 1 },
        { id = "SCREW", level = 1 },
        { id = "BUTCHER", level = 7 },
        { id = "HAMMER", level = 1 },
        { id = "LEATHER_AWL", level = 2 },
    },
    flags = { "SHEATH_KNIFE", "ALLOWS_BODY_BLOCK", "FIRESTARTER", "REQUIRES_TINDER" },
    melee_damage = { bash = 1, stab = 4 },
    weapon_categories = { "SHIVS" },
    tool = { initial_charges = 2000, max_charges = 2000, charges_per_use = 1 },
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 100,
            sound_message = ccb.content.text("FWEEEET!"),
            sound_id = "misc",
            sound_variant = "whistle",
            message = ccb.content.text("You blow the whistle."),
        },
        { kind = "firestarter", moves = 1000, slow_moves = 5000 },
    },
}
