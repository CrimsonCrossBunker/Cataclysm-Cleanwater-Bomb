local ccb = require("ccb")

ccb.content.define_item {
    id = "badge_cardboard",
    copy_from = "badge_abstract",
    name = ccb.content.text("cardboard badge"),
    description = ccb.content.text("An honorable badge identifying the owner as a \"Knight Errant\" of \"House Da\".  The large letters slowly dwindle in size as the badge runs out of space, leaving out the last two letters of Dino Dave's name."),
    flags = { "WATER_DISSOLVE", "FRAGILE_MELEE", "NO_WEAR_EFFECT", "FRAGILE" },
    armor = {},
}
