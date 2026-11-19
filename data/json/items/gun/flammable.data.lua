local ccb = require("ccb")

-- It's not very advanced because it was made very quickly to provide working flamethrowers to a certain agency
ccb.content.define_item {
    id = "rm451_flamethrower",
    copy_from = "flamethrower",
    looks_like = "m79",
    name = ccb.content.text("DARPA flamethrower"),
    description = ccb.content.text("A modernized flamethrower, using alloy components and composite pressure tanks.  Despite having been replaced by the M202 FLASH, due to the questionable effectiveness of the flamethrower in modern combat, it appears that someone, somewhere, needed a flamethrower for the modern age, as the date code on many of the components is within the past five years.  While this resembles the Vietnam War era M9-7, the wand ignition system has been improved with a piezoelectric one, in addition to the material improvements of the system overall."),
    price = "9 kUSD 700 USD",
    survival_price = "100 USD",
    materials = { "aluminum", "carbonfiber" },
    inheritance = { scale = { mass = 0.66 } },
    gun = {
        range = 10,
        mod_locations = {
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}
