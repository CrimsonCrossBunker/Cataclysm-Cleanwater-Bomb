local ccb = require("ccb")

ccb.content.define_item {
    id = "shoulder_strap_simple",
    copy_from = "shoulder_strap_simple",
    name = ccb.content.plural_text("two point sling", "two point slings"),
    gunmod = {
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("smartgun", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "shoulder_strap",
    copy_from = "shoulder_strap",
    name = ccb.content.plural_text("adjustable sling", "adjustable slings"),
    gunmod = {
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("smartgun", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "shoulder_strap_front",
    copy_from = "shoulder_strap_front",
    name = ccb.content.plural_text("adjustable sling (front)", "adjustable slings (front)"),
    gunmod = {
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("smartgun", "gun_type_type"),
        },
    },
}
