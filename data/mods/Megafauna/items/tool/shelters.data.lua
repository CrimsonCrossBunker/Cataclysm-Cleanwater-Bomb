local ccb = require("ccb")

ccb.content.define_item {
    id = "mammoth_shelter_kit",
    name = "mammoth shelter kit",
    description = "This is a small shelter, made of large bones, mammoth tusks, and skins.  Use it to place.",
    symbol = ";",
    color = "brown",
    mass = "1360 g",
    volume = "7500 ml",
    length = "90 cm",
    price = "65 USD",
    survival_price = "5 USD",
    materials = { "bone", "leather" },
    melee_damage = { bash = 4 },
    use_actions = {
        {
            kind = "deploy_tent",
            radius = 1,
            broken_type = "damaged_shelter_kit",
            wall = "f_skin_wall",
            floor = "f_skin_groundsheet",
            door_opened = "f_skin_door_o",
            door_closed = "f_skin_door",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "large_mammoth_shelter_kit",
    name = "large mammoth shelter kit",
    description = "This is a big shelter, made of large bones, mammoth tusks, and skins.  Use it to place.",
    symbol = ";",
    color = "brown",
    mass = "4080 g",
    volume = "22500 ml",
    length = "240 cm",
    price = "125 USD",
    survival_price = "10 USD",
    materials = { "bone", "leather" },
    melee_damage = { bash = 4 },
    use_actions = {
        {
            kind = "deploy_tent",
            radius = 2,
            broken_type = "damaged_shelter_kit",
            wall = "f_skin_wall",
            floor = "f_skin_groundsheet",
            door_opened = "f_skin_door_o",
            door_closed = "f_skin_door",
        },
    },
    tool = {},
}
