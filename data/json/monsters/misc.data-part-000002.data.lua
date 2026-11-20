local ccb = require("ccb")

-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_head",
    copy_from = "mon_debug_grabber",
    description = ccb.content.text_without_extraction("This grab testing monster has a strange fascination with your head."),
    attacks = {
        {
            id = "grab",
            cooldown = 0,
            move_cost = 0,
            body_part_types = { { id = "head", weight = 3 } },
        },
    },
}
