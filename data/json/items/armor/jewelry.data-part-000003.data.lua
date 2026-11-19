local ccb = require("ccb")

ccb.content.define_item {
    id = "bracelet_friendship",
    name = ccb.content.text("friendship bracelet"),
    description = ccb.content.text("A homemade bracelet crafted from colorful knickknacks.  It's not very expensive, but it's the effort that makes it special."),
    looks_like = "copper_bracelet",
    mass = "8 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood", "plastic" },
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 30,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bronze_medal",
    name = ccb.content.text("bronze medal"),
    description = ccb.content.text("A medal awarded for achieving third place in some event.  It might be worth something if it was made of bronze; this one is made from brass."),
    mass = "25 g",
    volume = "10 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "brass" },
    symbol = "[",
    looks_like = "copper_locket",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_bracelet",
    copy_from = "bead_bracelet",
    name = ccb.content.text("cowrie bracelet"),
    description = ccb.content.text("A bracelet made of cowrie shells, valued in many African cultures such as the Yoruba.  If you want, you could meditate with this."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_hair_beads",
    copy_from = "wooden_hair_beads",
    name = ccb.content.plural_text("cowrie hair beads", "sets of cowrie hair beads"),
    description = ccb.content.text("An assortment of cowrie shells used to decorate locs or braids."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_necklace",
    copy_from = "bead_necklace",
    name = ccb.content.text("cowrie necklace"),
    description = ccb.content.text("A necklace made of cowrie shells, valued in many African cultures such as the Yoruba.  If you want, you could meditate with this."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_dental_grill",
    name = ccb.content.text("diamond dental grill"),
    description = ccb.content.text("Fake teeth inlaid with diamonds, worn over the teeth.  Fits horribly, but looks very shiny.  For that high-class gangsta rap look."),
    mass = "35 g",
    volume = "5 ml",
    price = "500 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    looks_like = "gold_dental_grill",
    color = "yellow",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 3, cut = 3 },
    armor = { portions = { { encumbrance = 10, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "garnet_dental_grill",
    name = ccb.content.text("garnet dental grill"),
    description = ccb.content.text("Fake teeth inlaid with garnets, worn over the teeth.  It looks very shiny."),
    mass = "35 g",
    volume = "5 ml",
    price = "300 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    symbol = "[",
    looks_like = "gold_dental_grill",
    color = "red",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 3, cut = 3 },
    armor = { portions = { { encumbrance = 10, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "amethyst_dental_grill",
    name = ccb.content.text("amethyst dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with amethysts, worn over the teeth.  It looks very shiny."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_dental_grill",
    name = ccb.content.text("aquamarine dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with aquamarines, worn over the teeth.  It looks very shiny."),
    color = "cyan",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_dental_grill",
    name = ccb.content.text("emerald dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with emeralds, worn over the teeth.  It looks very shiny."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_dental_grill",
    name = ccb.content.text("alexandrite dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with alexandrites, worn over the teeth.  It looks very shiny."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_dental_grill",
    name = ccb.content.text("ruby dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with rubies, worn over the teeth.  It looks very shiny."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_dental_grill",
    name = ccb.content.text("peridot dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with peridots, worn over the teeth.  It looks very shiny."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_dental_grill",
    name = ccb.content.text("sapphire dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with sapphires, worn over the teeth.  It looks very shiny."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_dental_grill",
    name = ccb.content.text("tourmaline dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with tourmaline, worn over the teeth.  It looks very shiny."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_dental_grill",
    name = ccb.content.text("citrine dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with citrines, worn over the teeth.  It looks very shiny."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "barrette",
    name = ccb.content.text("barrette"),
    description = ccb.content.text("A barrette with lots of ornaments."),
    mass = "5 g",
    volume = "50 ml",
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "pink",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_dental_grill",
    name = ccb.content.text("blue topaz dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with blue topaz, worn over the teeth.  It looks very shiny."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_ring",
    name = ccb.content.text("diamond and gold ring"),
    description = ccb.content.text("A gold ring with a sparkling diamond mounted on top of it.  Back in the old days, this could have been worth a fortune."),
    mass = "12 g",
    volume = "1 ml",
    price = "1 kUSD 900 USD",
    survival_price = "1 USD",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    symbol = "[",
    looks_like = "ring_engagement",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}
