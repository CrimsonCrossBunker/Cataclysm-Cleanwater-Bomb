local ccb = require("ccb")

ccb.content.define_spell {
    id = "hedge_raziel_amulet_protection",
    name = ccb.content.text("To Wrap Yourself in the Name"),
    description = ccb.content.text("Over wine and an egg and an apple or citrus fruit, inscribe a copper amulet with the names of angels and the hidden names of God to create a talisman that will protect you from harm."),
    message = ccb.content.text("You recite the names of seven angels over the wine, you engrave the sigil on the fruit and eat it, and you write the secret phrases on the egg before you set down and begin carving names on the copper necklace."),
    flags = { "VERBAL", "SOMATIC", "NO_FAIL", "PERMANENT", "PERMANENT_ALL_LEVELS" },
    magic_type = "xe_hedge_magick",
    valid_targets = { "self" },
    difficulty = 110,
    spell_class = "HEDGE_MAGIC",
    skill = "survival",
    effect = "spawn_item",
    effect_data = "item_hedge_raziel_amulet_protection",
    shape = "blast",
    components = "spell_components_hedge_raziel_amulet_protection",
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    base_casting_time = 1080000,
}
