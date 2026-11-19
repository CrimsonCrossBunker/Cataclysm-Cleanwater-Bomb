local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_frond",
    copy_from = "meat_tainted",
    name = ccb.content.plural_text("alien fronds", "alien fronds"),
    description = ccb.content.text("The fleshy fronds harvested from an alien plant.  Eating these membranous leaves and gut-like stems is likely a terrible idea, and yet they have a paradoxically pleasant and inviting sweet smell.  Might be non-vegan."),
    comestible = {
        fun = 15,
        stimulation = 3,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 8 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "leech_flower",
    name = ccb.content.plural_text("leech flower", "leech flowers"),
    color = "blue",
    mass = "10 g",
    volume = "250 ml",
    symbol = "%",
    description = ccb.content.text("The alien beauty of this indigo flower is betrayed by its disgustingly fleshy composition.  What from afar appear to be petals are but layered membranes of transparent veiny flesh, given color by a covering of blue iridescent ichor.  Even if it is certainly poisonous, it has a pleasant medicinal smell to it."),
    survival_price = "10 cent",
    stackable = true,
    comestible = { kind = "MED", shelf_life = "30 days", stimulation = 30, healthy = -10, fun = 15 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("Even a close smell of this alien flower feels deeply intoxicating."),
            effects = {
                { id = "pkill3", duration = 360 },
                { id = "pkill2", duration = 810 },
                { id = "foodpoison", duration = 810 },
                { id = "badpoison", duration = 3600 },
                { id = "shakes", duration = 810 },
            },
        },
    },
}
