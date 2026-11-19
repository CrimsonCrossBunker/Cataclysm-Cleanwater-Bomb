local ccb = require("ccb")

-- The stone blade isn't fully solid, and the idea is it gets AOE techniques and reach attacks from that (besides actually being quite long), should normally be inferior DPS wise vs a katana or nodachi.
ccb.content.define_item {
    id = "jade_nagamaki",
    copy_from = "qt_katana",
    name = ccb.content.plural_text("jade nagamaki", "jade nagamaki"),
    description = ccb.content.text("A master smith painstakingly flaked its flowing blade from meteoric sea-green stone.  The hilt's cordage is speckled by gold flakes from the tumultuous waters where the blade was whet, and the chosen tsuba depicts an all-devouring snake."),
    mass = "3258 g",
    volume = "3250 ml",
    length = "140 cm",
    materials = { "monolith" },
    flags = { "SPEAR", "REACH_ATTACK", "UNBREAKABLE_MELEE", "SHEATH_SWORD", "NONCONDUCTIVE" },
    techniques = { "WBLOCK_1", "WIDE", "SPIN", "MOUNTED_CHARGE" },
    accuracy = { grip = "weapon", length = "long", surface = "line", balance = "uneven" },
    melee_damage = { bash = 10, cut = 32 },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "ITEM_ENCH_dda_jade_nagamaki_0" } },
    mounted_charge = { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 },
}
