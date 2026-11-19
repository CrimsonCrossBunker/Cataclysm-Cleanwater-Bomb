local ccb = require("ccb")

-- High quality energy extracted by our advanced forbearers. Gives lasers extra damage and range. Don't think too much about how it works.
ccb.content.define_item {
    id = "afs_battery_plus",
    copy_from = "battery",
    category = "spare_parts",
    name = ccb.content.plural_text("electric charge", "electric charge"),
    symbol = "=",
    color = "blue",
    description = ccb.content.text("Electric charge collected and stored through methods now undecipherable.  Somehow increases the performance of laser weaponry."),
    ammunition = {
        type = "battery",
        damage = { type = "afs_laser", constant_damage_multiplier = 1.5, penetration = 30 },
        range_multiplier = 1.5,
    },
}
