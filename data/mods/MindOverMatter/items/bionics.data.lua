local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_dangersight_eyes_non_fifth_sun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Strange Eye CBM", "Strange Eye CBMs"),
    description = ccb.content.text("You can tell this CBM is meant to be installed around your eyes, but what exactly it will do, you have no idea."),
    price = "7 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_dangersight_eyes_standard",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Ohuicatlachiyaliztimeh CBM", "Ohuicatlachiyaliztimeh CBMs"),
    description = ccb.content.text("A set of Ohuicatlachiyaliztimeh, this CBM uses matrix technology to detect hostility from nearby targets, acting as an infallible IFF."),
    price = "7 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_power_storage_fifth_sun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Ikpitikayotecontli System CBM", "Ikpitikayotecontli System CBMs"),
    description = ccb.content.text("An extremely-efficent form of bionic power storage, using integral matrix dust to increase the efficiency of possible storage multiple times."),
    price = "8 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_metabolics_fifth_sun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Tlacuallichicahualiztli Transformer CBM", "Tlacuallichicahualiztli Transformer CBMs"),
    description = ccb.content.text("A connection between the user's metabolism and their power storage allows this CBM to convert burned calories into bionic energy."),
    price = "4 kUSD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_physical_buffs_fifth_sun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Teōchicāhualiztli Booster CBM", "Teōchicāhualiztli Booster CBMs"),
    description = ccb.content.text("A series of implants along the skeleton and in major muscle groups allow a dramatic increase in the user's strength and agility."),
    price = "10 kUSD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_cameleoflage_fifth_sun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Tapayaxitilmàtli CBM", "Tapayaxitilmàtli CBMs"),
    description = ccb.content.text("Implants under the skin throughout the body that bend light when activated, making it much harder to spot the user from a distance."),
    price = "9 kUSD",
    bionic = { difficulty = 9 },
}
