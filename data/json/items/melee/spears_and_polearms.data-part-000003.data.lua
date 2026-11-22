local ccb = require("ccb")

ccb.content.define_item {
    id = "qt_spear_steel",
    copy_from = "spear_steel",
    name = "tempered steel spear",
    description = "A stout wooden pole tipped with a hand-forged tempered steel spearhead.  Masterfully tempered and quenched, the bluish steel coalesces in a needle-fine point.  The shaft has been lined with a spiraling leather riser, improving control during deadly thrusts.  The king of all weapons.",
    looks_like = "spear_steel",
    replace_materials = { mc_steel = "qt_steel" },
    inheritance = {
        add = {
            materials = { "leather" },
        },
        scale = { price = 1.2, survival_price = 1.2 },
        offset = {
            melee_damage = { stab = 5, bash = 2 },
        },
    },
}
