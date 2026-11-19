local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_skunk_tail",
    category = "armor",
    name = ccb.content.plural_text("skunk tail", "skunk tails"),
    description = ccb.content.text("Thick black and white striped tail."),
    mass = "300 g",
    volume = "300 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mut_fur" },
    symbol = "x",
    color = "white",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {},
    use_actions = { "MACE" },
}

ccb.content.define_item {
    id = "internal_mp3_fruit",
    copy_from = "fake_item",
    name = ccb.content.plural_text("The fruit's song", "The fruit's songs"),
    description = ccb.content.text("The song contained in the fruit is now struck in your head until it goes away.  Fortunately this song is enjoyable, increasing your mood while it lasts."),
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "USES_BIONIC_POWER",
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 0 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            target = "internal_mp3_fruit_on",
            menu_text = ccb.content.text("Hear the song"),
            message = ccb.content.text("The fruit's melody fills your mind."),
            need_charges = 0,
            need_charges_message = ccb.content.text("Something is preventing this fruit from working.  Please report it on GitHub."),
        },
    },
}

ccb.content.define_item {
    id = "internal_mp3_fruit_on",
    copy_from = "fake_item",
    name = ccb.content.plural_text("The fruit's song", "The fruit's songs"),
    description = ccb.content.text("The song contained in the fruit is now struck in your head until it goes away.  Fortunately this song is enjoyable, increasing your mood while it lasts."),
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "SPAWN_ACTIVE",
    },
    revert_to = "corpse_ash",
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 0, power_draw = "0 W" },
    armor = {},
    tick_actions = { "MP3_ON" },
}
