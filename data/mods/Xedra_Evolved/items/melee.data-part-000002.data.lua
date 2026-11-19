local ccb = require("ccb")

ccb.content.define_item {
    id = "redcap_club",
    name = ccb.content.plural_text("redcap club", "redcap clubs"),
    copy_from = "mace",
    description = ccb.content.text("A giant bloodstained club, barely human wieldable with two hands.  You see shadowy tendrils of blood whenever it connects with an enemy, sticking to whatever it hits and burning like acid."),
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE", "BELT_CLIP", "ALWAYS_TWOHAND" },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_redcap_club_0" } },
}
