local ccb = require("ccb")

ccb.content.define_item {
    id = "roller_shoes_off",
    name = ccb.content.plural_text("heelys (off) (pair)", "heelys (off) (pair)"),
    description = ccb.content.text("A pair of sneakers with integrated wheels.  Currently the wheels are retracted, making these essentially normal lace-up athletic shoes."),
    mass = "840 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Extend wheels"),
            target = "roller_shoes_on",
            message = ccb.content.text("You pop the wheels out."),
            moves = 500,
        },
    },
}

ccb.content.define_item {
    id = "roller_shoes_on",
    name = ccb.content.plural_text("heelys (on) (pair)", "heelys (on) (pair)"),
    description = ccb.content.text("A pair of sneakers with integrated wheels, currently the wheels are out, allowing you to swiftly roll around on flat terrain.  You should probably pop them back in before you try fighting or going off-road."),
    mass = "840 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_blue",
    flags = { "VARSIZE", "ROLLER_ONE", "REQUIRES_BALANCE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1.0 },
                },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Retract wheels"),
            target = "roller_shoes_off",
            message = ccb.content.text("You pop the wheels back in."),
            moves = 500,
        },
    },
}
