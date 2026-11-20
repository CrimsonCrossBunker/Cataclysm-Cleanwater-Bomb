local ccb = require("ccb")

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "torch_lit",
    name = ccb.content.plural_text("torch", "torches"),
    description = ccb.content.text("A large stick wrapped in rags that are soaked with flammable material.  It is burning, producing plenty of light."),
    mass = "623 g",
    volume = "1089 ml",
    length = "122 cm",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    materials = {
        { id = "wood", portions = 14 },
        { id = "cotton", portions = 1 },
        { id = "gasoline", portions = 1 },
    },
    symbol = "/",
    color = "brown",
    revert_to = "torch_done",
    techniques = { "WBLOCK_1" },
    light = 60,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "BURNOUT",
        "SPAWN_ACTIVE",
    },
    melee_damage = { bash = 8 },
    tool = { initial_charges = 20, max_charges = 20, turns_per_charge = 60, crafting_subtype = "fire" },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "torch",
            message = ccb.content.text("The torch is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}
