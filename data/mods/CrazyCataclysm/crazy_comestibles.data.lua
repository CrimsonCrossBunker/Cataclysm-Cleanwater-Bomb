local ccb = require("ccb")

ccb.content.define_item {
    id = "sporeos",
    copy_from = "cookies",
    name = ccb.content.plural_text("SpOreos", "SpOreos"),
    color = "dark_gray",
    symbol = "%",
    description = ccb.content.text("The hit cookie from Mycus Industries!  Now comes in addicting flavors such as Marloss, Chanterelle, and The Encroaching, Unavoidable Death of Human Civilization."),
    price = "1 cent",
    materials = { "wheat", "fruit" },
    flags = { "MYCUS_OK", "FUNGAL_VECTOR" },
    volume = "12 ml",
    comestible = {
        shelf_life = 0,
        quench = 25,
        calories = 217,
        fun = 10,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "fruit_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "powerthirst1",
    copy_from = "energy_drink",
    default_container = "rocket_can_drink",
    name = ccb.content.plural_text("Powerthirst - Manana Flavor", "Powerthirst - Manana Flavor"),
    description = ccb.content.text("POWERTHIRST in new Manana flavor.  Contains preposterous amounts of testosterone.  PREPOSTERONE.  It's like crystal meth in a can.  It's crystal meth in a can.  Powerthirst is crystal meth."),
    comestible = {
        kind = "DRINK",
        addiction_potential = 50,
        addiction = "amphetamine",
        stimulation = 40,
        vitamins = {
            { id = "mutagen", amount = 2000 },
            { id = "mutagen_chimera", amount = 800 },
            { id = "mutagen_raptor", amount = 800 },
        },
    },
}

ccb.content.define_item {
    id = "powerthirst2",
    copy_from = "powerthirst1",
    default_container = "rocket_can_drink",
    name = ccb.content.plural_text("Powerthirst - Fizzbitch Flavor", "Powerthirst - Fizzbitch Flavor"),
    description = ccb.content.text("POWERTHIRST in new Fizzbitch flavor.  Contains preposterous amounts of testosterone.  PREPOSTERONE.  It's like crystal meth in a can.  It's crystal meth in a can.  Powerthirst is crystal meth."),
    comestible = {
        kind = "DRINK",
        addiction_potential = 55,
        addiction = "amphetamine",
        stimulation = 30,
        vitamins = {
            { id = "mutagen", amount = 2000 },
            { id = "mutagen_chimera", amount = 1000 },
            { id = "mutagen_raptor", amount = 1000 },
        },
    },
}

ccb.content.define_item {
    id = "powerthirst3",
    copy_from = "powerthirst1",
    name = ccb.content.plural_text("Powerthirst - Gun Flavor", "Powerthirst - Gun Flavor"),
    description = ccb.content.text("POWERTHIRST in new Gun flavor.  Contains preposterous amounts of testosterone.  PREPOSTERONE.  It's like crystal meth in a can.  It's crystal meth in a can.  Powerthirst is crystal meth."),
    comestible = {
        kind = "DRINK",
        addiction_potential = 60,
        addiction = "amphetamine",
        stimulation = 20,
        vitamins = {
            { id = "mutagen", amount = 2000 },
            { id = "mutagen_chimera", amount = 1200 },
            { id = "mutagen_raptor", amount = 1200 },
        },
    },
}
