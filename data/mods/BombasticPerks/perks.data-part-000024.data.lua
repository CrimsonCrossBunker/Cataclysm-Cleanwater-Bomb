local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_secret_closet_storage",
    name = "Closetland",
    description = "When you were little you remember thinking that your closet was a portal to a secret realm and if you just knew the way to open the path, you could find your way through to another world.  Well, you've found the way.\n\nWhen in a closet (walls on all sides except for one closed door), activate this perk to transport you to a secret realm.  Deactivate this perk to transport you back to your entrance point.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_a528f34cf943",
    on_deactivate = "w16b_mut_deactivate_bombasticperks_f5e8854074ae",
    on_process = "w16b_mut_process_bombasticperks_cbe683736288",
}

ccb.content.define_mutation {
    id = "perk_secret_closet_teleporter_paths",
    name = "Closetland Paths",
    description = "Your experience with Closetland has grown and you think you can find your way back to other places you've been, not just the most recent place you left from\n\nWhen in a closet, you can memorize it and, when in Closetland, return there instead of the place you left from.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_ce72a600ecd9",
}
