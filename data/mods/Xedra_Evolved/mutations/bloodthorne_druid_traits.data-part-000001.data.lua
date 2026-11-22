local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
    name = ccb.content.text("Heartwhip"),
    points = 2,
    description = ccb.content.text("You can cause a sudden outgrowth of your Heartvine into a living whip-like weapon, ready to scourge the undead."),
    purifiable = false,
    valid = false,
    active = true,
    activation_message = ccb.content.text("A vine erupts from your arm and wraps around your wrist before snugly fitting itself into your hand."),
    activation_setup_only = true,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP_0" },
    on_activate = "bloodthorne_summon_heartwhip",
    on_deactivate = "bloodthorne_unsummon_heartwhip",
}
