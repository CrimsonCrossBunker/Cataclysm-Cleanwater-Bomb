local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_transporter_remote_broken",
    name = ccb.content.plural_text("transporter remote (burned out)", "transporter remote (burned out)"),
    description = ccb.content.text("A blocky item, like an old feature cellphone crossed with a radio.  A matrix channeling array was sticking out of the side like an antenna, but it's now cracked and probably useless.  There is a small screen on the front, obviously burned out.  Parts of the plastic casing are warped as though the plastic had frozen and cracked."),
    copy_from = "psionic_transporter_remote",
    pockets = {},
    flags = { "TRADER_AVOID" },
    tool = {},
    use_actions = {},
}
