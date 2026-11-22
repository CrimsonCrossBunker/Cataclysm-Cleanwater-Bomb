local ccb = require("ccb")

ccb.content.define_item {
    id = "redcap_club",
    name = ccb.content.plural_text("redcap club", "redcap clubs"),
    copy_from = "mace",
    description = ccb.content.text("A giant bloodstained club, barely human wieldable with two hands.  You see shadowy tendrils of blood whenever it connects with an enemy, sticking to whatever it hits and burning like acid."),
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE", "BELT_CLIP", "ALWAYS_TWOHAND" },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_redcap_club_0" } },
}

ccb.content.define_item {
    id = "wild_huntsman_hunting_blade",
    copy_from = "ch_arming_sword",
    name = "witchwood sword",
    description = "This sword is made all of a single piece of wood and so black any details are lost.  Some kind of shimmering leather is wrapped around the grip.",
    looks_like = "bokken",
    price = "1 kUSD 350 USD",
    survival_price = "500 USD",
    materials = {
        { id = "wood", portions = 1 },
    },
    artifact = {
        enchantments = {
            "ITEM_ENCH_Xedra_Evolved_wild_huntsman_hunting_blade_0",
        },
    },
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR", "RELIC_PINK" },
        },
        remove = { flags = "CONDUCTIVE" },
        scale = {
            melee_damage = { stab = 0.9 },
        },
        offset = {
            melee_damage = { biological = 5 },
        },
    },
}
