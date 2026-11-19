local ccb = require("ccb")

ccb.content.define_item {
    id = "atomic_butter",
    name = ccb.content.plural_text("atomic butter", "atomic butter"),
    mass = "14180 mg",
    color = "yellow",
    symbol = "%",
    default_container = "wrapper",
    description = ccb.content.text("A yellow stick of milkfat and milk solids, made from cow's milk and the power of the atom.  All radiation levels are confirmed to be in line with background exposure and any cancers later in life have nothing to do with this butter or any products made with this butter.  By consuming this butter you indemnify and hold harmless the Rivtech Corporation, its parent company and subsidiaries and any agents, directors or officers of the Rivtech Corporation from any losses or damages that may occur as a result of consuming this butter in any form or fashion."),
    price = "9 cent",
    survival_price = "23 cent",
    materials = { "milk" },
    volume = "15 ml",
    flags = { "NO_AUTO_CONSUME" },
    comestible = {
        shelf_life = "14 days",
        kind = "FOOD",
        quench = -1,
        calories = 101,
        fun = -1,
        vitamins = { { id = "milk_allergen", amount = 1 } },
    },
}
