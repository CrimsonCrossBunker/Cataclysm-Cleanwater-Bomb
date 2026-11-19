local ccb = require("ccb")

ccb.content.define_item {
    id = "military_papr_mask_asr_scba_on",
    category = "clothing",
    name = ccb.content.plural_text("military respirator mask (SCBA) (on)", "military respirator masks (SCBA) (on)"),
    looks_like = "mask_gas",
    description = ccb.content.text("A black, full-face military respirator made from a silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  This mask is configured for two modes: negative-pressure, using standard CBRN gas mask filter canisters; and positive-pressure, with built-in hardware to accommodate either a powered air-purifying respirator (PAPR) or a self-contained breathing apparatus (SCBA).  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  It is currently in positive-pressure SCBA mode, so will only function with an external air source.  It is currently being fed air.  Activate it to turn it off."),
    copy_from = "military_papr_mask",
    flags = { "VARSIZE", "PADDED", "SCBA_ON", "SPAWN_ACTIVE" },
    revert_to = "military_papr_mask_asr",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn off the regulator."),
            menu_text = ccb.content.text("Turn off the regulator"),
            target = "military_papr_mask_asr",
        },
    },
    tick_actions = { "SCBA_MASK" },
}
