local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- Values based roughly on a male human femur.
ccb.content.define_item {
    id = "bone",
    name = ccb.content.plural_text("bone", "bones"),
    description = ccb.content.text("A bone from some creature or other.  Could be used in cooking and crafting."),
    mass = "290 g",
    volume = "320 ml",
    length = "44 cm",
    symbol = "%",
    color = "white",
    materials = { "bone" },
    category = "spare_parts",
    price = "0 cent",
    survival_price = "10 cent",
    melee_damage = { bash = 3 },
    accuracy = { grip = "none", length = "short", surface = "any", balance = "uneven" },
    flags = { "RAW", "INEDIBLE", "LUPINE", "NO_TEMP", "PUNCTURE_VEHICLE_WHEELS" },
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        kind = "FOOD",
        calories = 171,
        vitamins = { { id = "calcium", amount = "25588 mg" }, { id = "meat_allergen", amount = 1 } },
    },
}
