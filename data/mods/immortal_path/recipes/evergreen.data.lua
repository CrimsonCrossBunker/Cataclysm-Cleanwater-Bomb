local ccb = require("ccb")

-- Verdant Wood-Spirit Pill
-- Verdant Wood-Spirit Pills
-- 葳蕤经配套的基础疗伤丹：以木行生气炼草木而成，服之愈合外伤。做成 MED 类 comestible（同 aspirin：一枚一剂、不用 charges/stack_size）。activity_level 是 recipe 的必填字段、不是物品的。本物品 + 其配方共同演示「功法自带配方、学会功法即掌握」（配方由 EOC_immortal_path_bind_art_traits 的木行分支用 u_learn_recipe 授予）。数值保守，待平衡。/ The Sutra of Verdant Flourishing's basic healing pill, modeled as a MED comestible like aspirin (one item = one dose, no charges/stack_size). activity_level is mandatory on the recipe, not the item. Demonstrates art-bundled recipes.
-- A jade-green pill carrying the fresh scent of herbs. Refined with living Wood-qi; taking it speeds the healing of wounds.
ccb.content.define_item {
    id = "immortal_path_evergreen_pill",
    category = "drugs",
    name = ccb.content.plural_text("葳蕤木灵丹", "葳蕤木灵丹"),
    description = ccb.content.text("一枚青碧色的丹丸，透着草木清香。以木行生气温养炼成，服之可加速愈合外伤。"),
    mass = "8 g",
    volume = "5 ml",
    price = "0 USD",
    survival_price = "5 USD",
    materials = { "junk" },
    symbol = "*",
    color = "light_green",
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", limb_power = 6, moves = 1500 } },
}
