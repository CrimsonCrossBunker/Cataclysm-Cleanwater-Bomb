local ccb = require("ccb")

ccb.content.define_item {
    id = "smart_phone_hunvre",
    copy_from = "smart_phone",
    name = ccb.content.plural_text("helminth smartphone", "helminth smartphones"),
    description = ccb.content.text("This otherwise regular smartphone allows you to interact with the ship using sets of preprogrammed functions."),
    flags = { "CONTRABAND" },
    tool = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        {
            kind = "mp3",
            target = "smartphone_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "smart_phone_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
            menu_text = ccb.content.text("Turn on flashlight"),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
}
