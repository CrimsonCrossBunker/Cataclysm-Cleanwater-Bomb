local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LILIN_BONUS_HEALING_ACTIVE",
    name = ccb.content.text("The Night's Caress"),
    description = ccb.content.text("Sometimes, you cannot passively wait for your ruach to heal your wounds, you need it to happen immediately.  You may activate this trait to greatly speed your healing at a continual cost of ruach."),
    points = 5,
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_BONUS_HEALING" },
    secondary_prerequisites = { "LILIN_ATTRIBUTE_BONUSES_STRENGTH" },
    categories = { "LILIN" },
    activation_message = "",
    on_activate = "lilin_bonus_healing_on",
    on_deactivate = "lilin_bonus_healing_off",
}
