local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_STONE_FORM_TRAITS",
    name = ccb.content.text("Earthen Form"),
    description = ccb.content.text("You are a mass of stone and earth.  You are incredibly resilient, but you are extremely slow."),
    points = 10,
    valid = false,
    enchantments = { "ench_ierde_stone_form" },
    appearance = { id = "mon_stonegolem", tile_category = "monster" },
    flags = {
        "ACID_IMMUNE", "BIO_IMMUNE", "COLD_IMMUNE", "STAB_IMMUNE", "BULLET_IMMUNE", "SUFFOCATION_IMMUNE",
        "INHALED_TOXIN_IMMUNE", "MYCUS_IMMUNE", "GILLS", "CANNOT_CONSUME_DRUGS",
    },
}

ccb.content.define_mutation {
    id = "IERDE_NO_BROKEN_BONES",
    name = ccb.content.text("Body of Adamant"),
    points = 12,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde is so infused with the power of stone they are approaching invincibility.  There is a small chance that attacks against them simply rebound off their rocky skin, and their limbs are so resilient that they will never break."),
    prerequisites = { "IERDE_STONE_FORM" },
    secondary_prerequisites = { "IERDE_STOP_BLEEDING" },
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_NO_BROKEN_BONES_0", "INLINE_ENCH_IERDE_NO_BROKEN_BONES_1" },
}
