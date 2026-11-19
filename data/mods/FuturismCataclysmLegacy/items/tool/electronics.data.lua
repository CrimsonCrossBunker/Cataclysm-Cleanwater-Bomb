local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_atomic_smartphone_flashlight",
    copy_from = "fcl_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone - Flashlight", "atomic smartphones - Flashlight"),
    revert_to = "fcl_atomic_smartphone",
    light = 25,
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "transform",
            target = "fcl_atomic_smartphone",
            message = ccb.content.text("You deactivate the flashlight app."),
            menu_text = ccb.content.text("Turn off flashlight"),
        },
    },
}
