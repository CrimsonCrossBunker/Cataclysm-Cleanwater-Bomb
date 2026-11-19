local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_inventor_mana_kj_penalty_switch",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Cyberarcanic Interference Inverter", "Cyberarcanic Interference Inverters"),
    description = ccb.content.text("Mana and electricity interfere with each other while inside the same thing.  By thoroughly inverting the polarities you switched the interference, prioritizing your inner mana capacity instead of your electrical supply."),
    mass = "500 g",
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_inventor_calorie_storage",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Calorie Etherealization System", "Calorie Etherealization Systems"),
    description = ccb.content.text("The best place to store calories is inside your own body.  Unfortunately, caloric oversaturation causes issues that impede this perfect storage.  Thanks to magnets, orbital trajectories and your own ingenuity, your calories are now close to you and will be consumed as needed without penalties.  The process is imperfect and the orbit can't be maintained without power, but nothing preserves calories this well."),
    mass = "500 g",
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_inventor_creative_fuel",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Creative-Electric Converter", "Creative-Electric Converters"),
    description = ccb.content.text("Blood is fuel?  More like everything is fuel.  This device drains your very creativity to produce power for your bionics.  It's somehow simultaneously among your best and worst ideas."),
    mass = "500 g",
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_inventor_book_burn_boost",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Book Burner's Buddy", "Book Burner's Buddies"),
    description = ccb.content.text("Probably the most selfish thing you ever made, constantly burning countless pieces of written media for fleeting knowledge.  You might think it is worth the price, but the false knowledge this so-called buddy fills you with will leave little room to learn anything else, coercing you to burn books further and forevermore for a simulacrum of smarts."),
    mass = "500 g",
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
    bionic = { difficulty = 8 },
}
