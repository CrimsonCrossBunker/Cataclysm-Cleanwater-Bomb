local ccb = require("ccb")

-- delete security vest variants
-- Based on the exact model; https://www.tyrtactical.com/shop/tyr-tactical-male-epic-federal-outer-carrier/
ccb.content.define_item {
    id = "fbi_armor_vest",
    copy_from = "soft_3a_vest",
    name = ccb.content.plural_text("FBI ballistic vest", "FBI ballistic vests"),
    variants = {},
    description = ccb.content.text("A ranger green soft ballistic vest with MOLLE rigging used by federal law enforcement agencies.  Soft armor plates inside the vest provide solid defense against shrapnel and small-caliber rounds.  \"FBI\" is emblazoned across the front and back in large, yellow lettering, and it includes a pocket for storing evidence.  Use it to attach or detach pouches."),
    armor = {},
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}
