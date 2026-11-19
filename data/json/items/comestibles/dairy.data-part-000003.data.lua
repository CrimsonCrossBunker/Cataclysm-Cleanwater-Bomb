local ccb = require("ccb")

-- 撤销 PR #85568 — 恢复黄油直接食用的快乐值
ccb.content.define_item {
    id = "butter",
    name = ccb.content.plural_text("butter", "butter"),
    mass = "14180 mg",
    color = "yellow",
    symbol = "%",
    default_container = "wrapper",
    description = ccb.content.text("A yellow stick of milkfat and milk solids, usually made from cow's milk."),
    display_type = "BY_WEIGHT",
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
        on_consume = "eat_butter",
    },
}
