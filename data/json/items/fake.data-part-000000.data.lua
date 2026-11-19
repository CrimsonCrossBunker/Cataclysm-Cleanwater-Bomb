local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Include ZERO_WEIGHT flag to avoid errors when instantiating pseudo items.
ccb.content.define_item {
    id = "fake_item",
    abstract = true,
    name = ccb.content.text_without_extraction("fake item"),
    description = ccb.content.text_without_extraction("Dummy item.  If you see this description, it is a bug."),
    flags = { "ZERO_WEIGHT", "TRADER_AVOID", "DEBUG_ONLY" },
    mass = "1 g",
    volume = "1 ml",
    symbol = "@",
    color = "red",
}

ccb.content.define_item {
    id = "internal_mp3_music",
    copy_from = "fake_item",
    name = ccb.content.plural_text("WearMan Music", "WearMan Musics"),
    description = ccb.content.text("A set of speakers implanted into your skull, that can receive local radiowaves and play downloaded music at a concert hall quality.  It is currently playing \"Rubik's Mickse\"."),
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "internal_mp3_radio",
    copy_from = "fake_item",
    name = ccb.content.plural_text("WearMan Radio", "WearMan Radios"),
    description = ccb.content.text("A set of speakers implanted into your skull, that can receive local radiowaves and play downloaded music at a concert hall quality.  It is currently listening to the radio."),
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = { "RADIO_ON" },
    tick_actions = { "RADIO_TICK" },
}
