local ccb = require("ccb")

ccb.content.define_item {
    id = "art_robe",
    copy_from = "robe",
    name = ccb.content.text("royal robe"),
    description = ccb.content.text("An ornately decorated robe with an unfamiliar royal symbol on it.  The humanoid figure on the seal has two pairs of eyes.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_cloak",
    copy_from = "cloak",
    name = ccb.content.text("ancient burial shroud"),
    description = ccb.content.text("A cloak of thin, faded cloth.  The faint silhouette of a long-dead humanoid is barely visible on it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

-- remove fur coat variants
ccb.content.define_item {
    id = "art_coat",
    copy_from = "coat_fur",
    name = ccb.content.text("ornate fur coat"),
    description = ccb.content.text("A heavy, finely crafted coat made of the fur of an unidentifiable creature.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    variants = {},
    armor = {},
}

ccb.content.define_item {
    id = "art_mask",
    category = "armor",
    name = ccb.content.text("ancient stone mask"),
    description = ccb.content.text("A sinister mask made of a smooth green stone.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    mass = "750 g",
    volume = "750 ml",
    price = "40 USD",
    survival_price = "10 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "stone" },
    symbol = "[",
    color = "green",
    flags = { "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "art_helm",
    copy_from = "helmet_bronze",
    name = ccb.content.text("ancient bronze helmet"),
    description = ccb.content.text("A helmet with an imposing face plate.  Though the corrosion has completely defaced the symbols written on the sides, it seems sturdy.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_gloves",
    copy_from = "gloves_leather",
    name = ccb.content.plural_text("ornate leather gloves (pair)", "ornate leather gloves (pair)"),
    description = ccb.content.text("A set of worn leather gloves embossed with gold.  The unidentifiable leather it is made from is oddly soft.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("ancient leather boots (pair)", "ancient leather boots (pair)"),
    description = ccb.content.text("A pair of ancient leather boots.  Though the flaps of leather are crudely sewn together, the red hue it is dyed with is striking.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_ring",
    copy_from = "gold_ring",
    name = ccb.content.text("amber ring"),
    description = ccb.content.text("A band of gold with a smooth piece of amber set into it.  A strange worm is encased in the amber, making a perfect spiral with its sealed body.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}
