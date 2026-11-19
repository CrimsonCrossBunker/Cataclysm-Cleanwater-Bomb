local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_bio_robofac_xmback_on",
    copy_from = "integrated_bio_robofac_xmback",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 BACK exoskeleton (on)", "Hub 01 BACK exoskeleton (on)"),
    revert_to = "integrated_bio_robofac_xmback",
    inheritance = { add = { flags = { "SPAWN_ACTIVE", "NO_TAKEOFF", "TRADER_AVOID" } } },
    subtype_order = { "armor", "tool", "artifact" },
    armor = { portions = { { encumbrance = 2, coverage = 5, covers = { "torso" } } } },
    tool = { power_draw = "37 W" },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You deactivate your Hub 01 XM-BACK system."),
            target = "integrated_bio_robofac_xmback",
        },
    },
}
