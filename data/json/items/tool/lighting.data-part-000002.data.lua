local ccb = require("ccb")

-- dimensions from pool_cue as least heavy ingredient from all
ccb.content.define_item {
    id = "torch",
    name = ccb.content.plural_text("torch", "torches"),
    description = ccb.content.text("A large stick wrapped in rags that are soaked with flammable material.  When lit, it produces a fair amount of light.  You'll need a lighter or matches to light it."),
    mass = "623 g",
    volume = "1089 ml",
    length = "122 cm",
    price = "0 cent",
    survival_price = "50 cent",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    materials = {
        { id = "wood", portions = 14 },
        { id = "cotton", portions = 1 },
        { id = "gasoline", portions = 1 },
    },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "BURNOUT" },
    melee_damage = { bash = 8 },
    tool = { initial_charges = 20, max_charges = 20 },
    use_actions = {
        {
            kind = "transform",
            target = "torch_lit",
            message = ccb.content.text("You light the torch."),
            need_fire = 1,
            menu_text = ccb.content.text("Light", "verb"),
        },
    },
}
