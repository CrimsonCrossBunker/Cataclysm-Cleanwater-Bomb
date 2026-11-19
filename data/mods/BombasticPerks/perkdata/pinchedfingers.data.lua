local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_hand_pinchedfingers",
    category = "armor",
    name = ccb.content.plural_text("callused hands", "callused hands"),
    description = ccb.content.text("You've dealt so many blows your hands are rough with calluses.  The tips of your fingers can pinch firmly enough to pry nails or turn small bolts."),
    copy_from = "integrated_hand_openpalm",
    qualities = {
        { id = "PRY", level = 1 },
        { id = "PRYING_NAIL", level = 1 },
        { id = "WRENCH", level = 1 },
        { id = "WRENCH_FINE", level = 1 },
    },
    melee_damage = { stab = 4 },
    armor = {},
}
