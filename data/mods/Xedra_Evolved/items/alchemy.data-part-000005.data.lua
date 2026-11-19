local ccb = require("ccb")

ccb.content.define_item {
    id = "charm_of_marzanna",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.plural_text("charm of Marzanna", "charms of Marzanna"),
    description = ccb.content.text("A tiny effigy of a woman with singed extremities and a waterlogged face."),
    color = "light_blue",
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_control_marzanna" } },
}

ccb.content.define_item {
    id = "feline_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("feline periapta", "feline periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a cat with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_feline" } },
}

ccb.content.define_item {
    id = "lupine_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("lupine periapta", "lupine periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a wolf with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_lupine" } },
}

ccb.content.define_item {
    id = "cephalopod_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("cephalopod periapta", "cephalopod periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of an octopus with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_cephalopod" } },
}

ccb.content.define_item {
    id = "plant_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("tree periapta", "tree periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a tree with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_plant" } },
}

ccb.content.define_item {
    id = "scorpion_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("scorpion periapta", "scorpion periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a scorpion with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_scorpion" } },
}

ccb.content.define_item {
    id = "butterfly_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("butterfly periapta", "butterfly periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a butterfly with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_butterfly" } },
}

ccb.content.define_item {
    id = "spider_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("spider periapta", "spider periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a spider with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_spider" } },
}
