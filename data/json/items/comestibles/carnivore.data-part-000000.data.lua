local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- NO_I18N
ccb.content.define_item {
    id = "flesh",
    abstract = true,
    name = ccb.content.text_without_extraction("meat/fish", "meat/fish"),
    materials = { "flesh" },
    symbol = "%",
    color = "red",
    flags = { "RAW" },
    stackable = true,
    comestible = { kind = "FOOD", parasites = 32, vitamins = { { id = "meat_allergen", amount = 1 } } },
}
