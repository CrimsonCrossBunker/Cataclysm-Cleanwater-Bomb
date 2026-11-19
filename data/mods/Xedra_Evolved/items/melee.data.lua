local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamforged_glaive_healing",
    copy_from = "dreamforged_glaive",
    name = ccb.content.plural_text("glaive of life", "glaives of life"),
    description = ccb.content.text("A two-handed glaive, forged entirely from dreamdross.  It can steal life from creatures it attacks, healing you a bit."),
    artifact = { enchantments = { "ENCHANTMENT_VAMPIRISM" } },
}

ccb.content.define_item {
    id = "dreamforged_tsurugi_speed",
    copy_from = "dreamforged_broadsword",
    name = ccb.content.plural_text("tsurugi of speed", "tsurugi of speed"),
    description = ccb.content.text("A classic Japanese tsurugi sword with a razor sharp blade.  You start to think you need to move faster, and the effect intensifies when you are surrounded."),
    artifact = { enchantments = { "MON_NEARBY_SPEED" } },
}

ccb.content.define_item {
    id = "dreamforged_q_staff_exp",
    copy_from = "dreamforged_q_staff",
    name = ccb.content.plural_text("bō of practice", "bō of practice"),
    description = ccb.content.text("A long, straight stick.  A simple weapon empowered by your experience in fighting against dreadful creatures."),
    artifact = { enchantments = { "EXP_BASH" } },
}

ccb.content.define_item {
    id = "heartvine_whip",
    category = "weapons",
    looks_like = "bullwhip_razor",
    name = ccb.content.plural_text("heartvine whip", "heartvine whips"),
    description = ccb.content.text("A lengthy vine, growing out of your arm and wrapping around your wrist.  It has a series of long, sharp thorns on the parts away from your body."),
    mass = "216 g",
    volume = "360 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "dry_plant" },
    symbol = ",",
    color = "light_green",
    techniques = { "WHIP_DISARM" },
    flags = {
        "WOODEN_WEAPON", "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "MAGIC_FOCUS", "TRADER_AVOID",
        "NO_REPAIR", "NO_SALVAGE", "UNRESTRICTED", "REACH_ATTACK", "REACH3", "WHIP",
    },
    accuracy = { grip = "weapon", length = "long", surface = "line", balance = "good" },
    melee_damage = { cut = 13 },
    weapon_categories = { "WHIPS" },
    artifact = { enchantments = { "BLOODTHORNE_DRUID_HEARTWHIP" } },
}
