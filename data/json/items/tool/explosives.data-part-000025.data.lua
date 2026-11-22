local ccb = require("ccb")

ccb.content.define_item {
    id = "military_explosive_half_barrel_bomb_act",
    copy_from = "military_explosive_half_barrel_bomb",
    looks_like = "half_barrel_bomb_act",
    description = ccb.content.text("A metal keg filled with military explosives.  It has been activated and will soon explode, delivering its entire destructive power to everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 100000, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}

ccb.content.define_item {
    id = "military_explosive_half_barrel_bomb",
    copy_from = "half_barrel_bomb",
    name = "military explosive 50 L barrel bomb",
    description = "A metal keg filled with military explosives.  Once it has been activated, it will explode after 100 seconds, raining fire and steel on everything in sight.",
    mass = "135 kg",
    blast = {
        power = 100000,
        shrapnel = { casing_mass = 12600, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_half_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}
