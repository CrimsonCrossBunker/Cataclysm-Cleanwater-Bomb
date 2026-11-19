local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_hand_closedfist",
    category = "armor",
    name = ccb.content.plural_text("callused hands", "callused hands"),
    description = ccb.content.text("You've dealt so many blows your hands are rough with calluses.  The bottoms of your hand can deal blows hard enough to hammer or finely crush objects."),
    copy_from = "integrated_hand_openpalm",
    qualities = {
        { id = "HAMMER", level = 2 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "FINE_GRIND", level = 1 },
    },
    melee_damage = { bash = 4, cut = 0 },
    armor = {},
}
