local ccb = require("ccb")

ccb.content.define_item {
    id = "wolfsbane",
    copy_from = "pike",
    name = ccb.content.plural_text("Wolfsbane", "Wolfsbanes"),
    description = ccb.content.text("Wolfsbane pikes are generally antiques brought over from Europe.  Forged during the days when the Black Forest went from France to Transylvania, these spears targeted the Loup Garou that were weak against fire."),
    mass = "1854 g",
    materials = { "orichalcum_metal", "wood" },
    volume = "3250 ml",
    price = "2 kUSD",
    melee_damage = { bash = 10, cut = 35 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_wolfsbane_0" } },
    mounted_charge = { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 },
}
