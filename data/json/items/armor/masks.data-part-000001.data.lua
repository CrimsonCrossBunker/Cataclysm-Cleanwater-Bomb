local ccb = require("ccb")

ccb.content.define_item {
    id = "bandana",
    category = "clothing",
    name = ccb.content.plural_text("bandana", "bandanas"),
    description = ccb.content.text("A cotton bandana, worn over the mouth for warmth and minor protection from dust and other contaminants."),
    mass = "35 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "blue",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 2,
        portions = { { encumbrance = 1, coverage = 95, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You adjust the bandana to cover your head."),
            target = "bandana_head",
            menu_text = ccb.content.text("Cover head"),
        },
    },
}

ccb.content.define_item {
    id = "bondage_mask",
    name = ccb.content.plural_text("bondage mask", "bondage masks"),
    description = ccb.content.text("A tight mask made of black leather.  The eyes and mouth can be closed using zippers."),
    mass = "210 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "balclava",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.5,
        environmental_protection = 1,
        portions = { { encumbrance = 30, coverage = 100, covers = { "head", "eyes", "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Zip up"),
            target = "bondage_mask_zipped",
            message = ccb.content.text("You zip the eyes and mouth of the bondage mask closed."),
        },
    },
}

ccb.content.define_item {
    id = "bondage_mask_zipped",
    copy_from = "bondage_mask",
    name = ccb.content.plural_text("bondage mask (zipped)", "bondage masks (zipped)"),
    description = ccb.content.text("A tight mask made of black leather.  The eyes and mouth have been zipped closed."),
    looks_like = "bondage_mask",
    flags = { "VARSIZE", "SKINTIGHT", "BLIND" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unzip"),
            target = "bondage_mask",
            message = ccb.content.text("You unzip the eyes and mouth of the bondage mask."),
        },
    },
}
