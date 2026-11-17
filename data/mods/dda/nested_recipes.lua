local ccb = require("ccb")
local content = ccb.content

local function add_group(options, recipes, optional_recipes)
    local group = content.NestedRecipeCategory(options)
    for _, recipe_id in ipairs(recipes) do
        group:recipe(recipe_id)
    end
    if optional_recipes then
        for _, recipe_id in ipairs(optional_recipes) do
            group:recipe(recipe_id, true)
        end
    end
    content.add(group)
end

add_group({
    id = "nested_bows",
    name = ccb.content.text("bows"),
    description = ccb.content.text("Recipes related to constructing bows to launch arrows with."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    activity_level = 2,
}, {
    "selfbow",
    "shortbow",
    "reflexbow",
    "longbow",
    "compositebow",
    "compgreatbow",
    "woodgreatbow",
})

add_group({
    id = "nested_flintlock_arms",
    name = ccb.content.text("flintlock arms"),
    description = ccb.content.text("Recipes related to constructing flintlock rifles, pistols and shotguns."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    activity_level = 2,
}, {
    "rifle_flintlock",
    "longrifle_flintlock",
    "carbine_flintlock",
    "pistol_flintlock",
    "carbine_flintlock_double",
    "carbine_flintlock_double_from_antiques",
    "blunderbuss",
})

add_group({
    id = "nested_pipe_rifles",
    name = ccb.content.text("pipe rifles"),
    description = ccb.content.text("Recipes related to constructing pistol-caliber rifles using pipes."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    activity_level = 2,
}, {
    "rifle_22",
    "rifle_38",
    "rifle_44",
    "rifle_45_410",
})

add_group({
    id = "nested_staffs",
    name = ccb.content.text("staffs"),
    description = ccb.content.text("Recipes related to constructing different types of staffs."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "q_staff",
    "i_staff",
    "i_staff_with sheet metal",
    "shock_staff",
    "bo_from long stick",
    "bo_from quarterstaff",
    "staff_pipe",
    "nested_steelshod",
})

add_group({
    id = "nested_steelshod",
    name = ccb.content.text("steelshod quarterstaves"),
    description = ccb.content.text("Recipes related to constructing different qualities of steelshod quarterstaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_steel_staff",
    "mc_steel_staff",
    "hc_steel_staff",
    "ch_steel_staff",
    "qt_steel_staff",
})

add_group({
    id = "nested_graded_steel_maces",
    name = ccb.content.text("graded steel maces"),
    description = ccb.content.text("Recipes related to constructing different qualities of steel maces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_mace",
    "mace",
    "hc_mace",
    "ch_mace",
    "qt_mace",
})

add_group({
    id = "nested_maces",
    name = ccb.content.text("maces"),
    description = ccb.content.text("Recipes related to constructing different types of maces."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "mace",
    "mace_bronze",
    "mace_trench",
    "mace_trench_from simple version",
    "mace_pipe",
    "mace_pipe_large",
    "mace_simple",
    "morningstar",
    "nested_graded_steel_maces",
})

add_group({
    id = "nested_holsters",
    name = ccb.content.text("holsters"),
    description = ccb.content.text("Recipes related to constructing holsters for small, regular and large firearms."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    activity_level = 2,
}, {
    "XL_holster",
    "XL_nylon_holster",
    "baldric_holster",
    "back_holster",
    "bholster",
    "bbholster",
    "bootstrap",
    "holster",
    "nylon_holster",
    "western_holster",
    "shoulder_holster",
    "tactical_holster",
    "XS_holster",
    "XS_nylon_holster",
    "sholster",
    "suspenders_holster",
    "FB_double_holster",
    "FB_nylon_double_holster",
    "side_double_holster",
    "side_nylon_double_holster",
})

add_group({
    id = "nested_bandoliers",
    name = ccb.content.text("bandoliers"),
    description = ccb.content.text("Recipes related to constructing different types of bandoliers."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    activity_level = 2,
}, {
    "bandolier_pistol",
    "bandolier_rifle",
    "bandolier_shotgun",
    "torso_bandolier_shotgun",
    "torso_bandolier_grenade",
    "bandolier_wrist",
    "bandolier_pipebomb",
    "bandolier_pipebomb_xs",
    "bandolier_pipebomb_xl",
})

add_group({
    id = "nested_vehicle_battery",
    name = ccb.content.text("vehicle batteries"),
    description = ccb.content.text("Recipes related to constructing batteries used in vehicles."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "battery_car",
    "battery_motorbike",
})

add_group({
    id = "nested_standard_battery",
    name = ccb.content.text("standard batteries"),
    description = ccb.content.text("Recipes related to constructing standard rechargeable batteries."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "UPS_OFF",
    "heavy_battery_cell",
    "heavy_plus_battery_cell",
}, {
    "medium_battery_cell",
})

add_group({
    id = "nested_storage_battery",
    name = ccb.content.text("storage batteries"),
    description = ccb.content.text("Recipes related to constructing storage batteries used in vehicles or in buildings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "storage_battery",
    "storage_battery_from_medium",
    "medium_storage_battery",
    "large_storage_battery",
})

add_group({
    id = "nested_all_battery",
    name = ccb.content.text("batteries"),
    description = ccb.content.text("Recipes related to constructing all kinds of batteries."),
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    activity_level = 2,
}, {
    "nested_standard_battery",
    "nested_storage_battery",
    "nested_vehicle_battery",
}, {
    "nested_atomic_battery",
    "nested_dry_battery",
})

add_group({
    id = "nested_crossbows",
    name = ccb.content.text("crossbows"),
    description = ccb.content.text("Recipes related to constructing crossbows to shoot bolts with."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    activity_level = 2,
}, {
    "bullet_crossbow",
    "compositecrossbow",
    "huge_crossbow",
    "hand_crossbow",
    "rep_crossbow",
    "crossbow",
})

add_group({
    id = "nested_cocktails_mixdrinks",
    name = ccb.content.text("cocktails and mixed drinks"),
    description = ccb.content.text("Recipes related to mixing alcohol with other beverages."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 6,
}, {
    "drink_pinitacolada",
    "drink_shirleytemple",
    "drink_royrogers",
    "drink_virgin_mary",
    "drink_queenmary",
    "drink_karsk",
    "drink_gunfire",
    "drink_gintonic",
    "drink_pinacolada",
    "drink_tequilasunrise",
    "irish_coffee",
    "long_island",
    "drink_screwdriver",
    "drink_wild_apple",
    "drink_rumcola",
    "drink_grog",
    "drink_beeknees",
    "drink_wsour",
    "drink_martini",
    "drink_kalimotxo",
    "drink_hobo",
    "eggnog_spiked",
    "drink_bloody_mary",
    "drink_bloody_mary_blood",
})

add_group({
    id = "nested_tea",
    name = ccb.content.text("teas"),
    description = ccb.content.text("Recipes related to steeping organic solids in boiling water."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 6,
}, {
    "tea_willowbark",
    "tea_wild_sarsaparilla",
    "tea",
    "tea_green",
    "pine_tea",
    "dandelion_tea",
    "dandelionburdock_tea",
    "chamomile_tea",
    "lotus_tea",
    "spurge_tea",
    "tea_bark",
    "milk_tea",
    "chai_tea",
    "bee_balm_tea",
    "milk_tea_sweetened",
    "herbal_tea",
    "tea_sweetened",
    "tea_fruit",
    "herbal_tea_from_tea_bag",
    "dandelion_tea_from_tea_bag",
    "chamomile_tea_from_tea_bag",
})

add_group({
    id = "nested_refined_cannabis",
    name = ccb.content.text("refined cannabis"),
    description = ccb.content.text("Recipes related to refining cannabis into more potent forms."),
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    activity_level = 2,
}, {
    "hi_q_wax",
    "hi_q_wax_improvised_extraction",
    "hi_q_shatter",
    "hi_q_shatter_improvised_extraction",
    "hi_q_distillate",
    "hi_q_distillate_improvised_extraction",
    "hi_q_distillate_large_extraction",
    "hi_q_distillate_crude_extraction",
})

add_group({
    id = "nested_cotton_duster",
    name = ccb.content.text("canvas dusters"),
    description = ccb.content.text("Recipes related to tailoring long coats from cotton, known as dusters."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "duster",
    "xs_duster",
    "xl_duster",
    "sleeveless_duster",
    "sleeveless_duster_from_duster",
})

add_group({
    id = "nested_fur_duster",
    name = ccb.content.text("fur dusters"),
    description = ccb.content.text("Recipes related to tailoring long coats from fur, known as dusters."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "duster_fur",
    "xs_duster_fur",
    "xl_duster_fur",
    "sleeveless_duster_fur",
    "sleeveless_duster_fur_from_duster_fur",
})

add_group({
    id = "nested_leather_duster",
    name = ccb.content.text("leather dusters"),
    description = ccb.content.text("Recipes related to tailoring sturdy long coats from leather, known as dusters."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "duster_leather",
    "xs_duster_leather",
    "xl_duster_leather",
    "sleeveless_duster_leather",
    "sleeveless_duster_leather_from_duster_leather",
})

add_group({
    id = "nested_faux_fur_duster",
    name = ccb.content.text("faux fur dusters"),
    description = ccb.content.text("Recipes related to tailoring long coats from faux fur, known as dusters."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "duster_faux_fur",
    "xs_duster_faux_fur",
    "xl_duster_faux_fur",
    "sleeveless_duster_faux_fur",
    "sleeveless_duster_faux_fur_from_duster_faux_fur",
})

add_group({
    id = "nested_all_duster",
    name = ccb.content.text("dusters"),
    description = ccb.content.text("Recipes related to tailoring long coats, known as dusters."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_cotton_duster",
    "nested_fur_duster",
    "nested_leather_duster",
    "nested_faux_fur_duster",
})

add_group({
    id = "nested_cotton_trenchcoat",
    name = ccb.content.text("canvas trenchcoats"),
    description = ccb.content.text("Recipes related to tailoring long coats from cotton, known as trenchcoats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "trenchcoat",
    "sleeveless_trenchcoat",
    "sleeveless_trenchcoat_from_trenchcoat",
})

add_group({
    id = "nested_fur_trenchcoat",
    name = ccb.content.text("fur trenchcoats"),
    description = ccb.content.text("Recipes related to tailoring long coats from fur, known as trenchcoats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "trenchcoat_fur",
    "sleeveless_trenchcoat_fur",
    "sleeveless_trenchcoat_fur_from_trenchcoat_fur",
})

add_group({
    id = "nested_leather_trenchcoat",
    name = ccb.content.text("leather trenchcoats"),
    description = ccb.content.text("Recipes related to tailoring long coats from leather, known as trenchcoats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "trenchcoat_leather",
    "sleeveless_trenchcoat_leather",
    "sleeveless_trenchcoat_leather_from_trenchcoat_leather",
})

add_group({
    id = "nested_faux_fur_trenchcoat",
    name = ccb.content.text("faux fur trenchcoats"),
    description = ccb.content.text("Recipes related to tailoring long coats from cotton, known as trenchcoats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "trenchcoat_faux_fur",
    "sleeveless_trenchcoat_faux_fur",
    "sleeveless_trenchcoat_faux_fur_from_trenchcoat_faux_fur",
})

add_group({
    id = "nested_trenchcoats",
    name = ccb.content.text("trenchcoats"),
    description = ccb.content.text("Recipes related to tailoring long coats, known as trenchcoats."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_cotton_trenchcoat",
    "nested_fur_trenchcoat",
    "nested_leather_trenchcoat",
    "nested_faux_fur_trenchcoat",
})

add_group({
    id = "nested_chitin_helmets",
    name = ccb.content.text("chitinous helmets"),
    description = ccb.content.text("Recipes related to constructing durable helmets from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "helmet_acidchitin",
    "helmet_acidchitin_xs",
    "xl_helmet_acidchitin",
    "helmet_chitin",
    "helmet_chitin_xs",
    "xl_helmet_chitin",
})

add_group({
    id = "nested_chitin_bodyarmor",
    name = ccb.content.text("chitinous armor"),
    description = ccb.content.text("Recipes related to constructing durable armor from chitin that covers the body."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 2,
}, {
    "armor_acidchitin",
    "armor_acidchitin_xs",
    "xl_armor_acidchitin",
    "armor_chitin",
    "armor_chitin_xs",
    "xl_armor_chitin",
})

add_group({
    id = "nested_chitin_armguards",
    name = ccb.content.text("chitinous arm guards"),
    description = ccb.content.text("Recipes related to constructing durable armguards from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "armguard_chitin",
    "xs_armguard_chitin",
    "xl_armguard_chitin",
    "armguard_acidchitin",
    "xs_armguard_acidchitin",
    "xl_armguard_acidchitin",
})

add_group({
    id = "nested_chitin_legguards",
    name = ccb.content.text("chitinous leg guards"),
    description = ccb.content.text("Recipes related to constructing durable leg guards from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "legguard_chitin",
    "xs_legguard_chitin",
    "xl_legguard_chitin",
    "legguard_acidchitin",
    "xs_legguard_acidchitin",
    "xl_legguard_acidchitin",
})

add_group({
    id = "nested_chitin_gauntlets",
    name = ccb.content.text("chitinous gauntlets"),
    description = ccb.content.text("Recipes related to constructing durable gauntlets from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "gauntlets_chitin",
    "xs_gauntlets_chitin",
    "xl_gauntlets_chitin",
    "gauntlets_acidchitin",
    "xs_gauntlets_acidchitin",
    "xl_gauntlets_acidchitin",
})

add_group({
    id = "nested_chitinous_boots",
    name = ccb.content.text("chitinous boots"),
    description = ccb.content.text("Recipes related to constructing durable boots from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    activity_level = 2,
}, {
    "boots_chitin",
    "xs_boots_chitin",
    "xl_boots_chitin",
    "boots_acidchitin",
    "xs_boots_acidchitin",
    "xl_boots_acidchitin",
})

add_group({
    id = "nested_chitin_vests",
    name = ccb.content.text("chitinous vests"),
    description = ccb.content.text("Recipes related to constructing durable vests from chitin."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "armor_chitin_vest",
    "xs_armor_chitin_vest",
    "xl_armor_chitin_vest",
})

add_group({
    id = "nested_lc_light_chestplate",
    name = ccb.content.text("mild steel light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplate from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_light_chestplate",
    "xl_armor_lc_light_chestplate",
})

add_group({
    id = "nested_mc_light_chestplate",
    name = ccb.content.text("medium steel light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplates from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_light_chestplate",
    "xl_armor_mc_light_chestplate",
})

add_group({
    id = "nested_hc_light_chestplate",
    name = ccb.content.text("high steel light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplates from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_light_chestplate",
    "xl_armor_hc_light_chestplate",
})

add_group({
    id = "nested_ch_light_chestplate",
    name = ccb.content.text("hardened steel light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplates from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_light_chestplate",
    "xl_armor_ch_light_chestplate",
})

add_group({
    id = "nested_qt_light_chestplate",
    name = ccb.content.text("tempered steel light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplates from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_light_chestplate",
    "xl_armor_qt_light_chestplate",
})

add_group({
    id = "nested_all_light_chestplate",
    name = ccb.content.text("light chestplates"),
    description = ccb.content.text("Recipes related to constructing light chestplates from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_light_chestplate",
    "nested_mc_light_chestplate",
    "nested_hc_light_chestplate",
    "nested_ch_light_chestplate",
    "nested_qt_light_chestplate",
})

add_group({
    id = "nested_armor_lc_chestplate",
    name = ccb.content.text("mild steel chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_lc_chestplate",
    "armor_lc_chestplate",
})

add_group({
    id = "nested_armor_mc_chestplate",
    name = ccb.content.text("medium steel chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_mc_chestplate",
    "armor_mc_chestplate",
})

add_group({
    id = "nested_armor_hc_chestplate",
    name = ccb.content.text("high steel chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_hc_chestplate",
    "armor_hc_chestplate",
})

add_group({
    id = "nested_armor_ch_chestplate",
    name = ccb.content.text("hardened steel chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_ch_chestplate",
    "armor_ch_chestplate",
})

add_group({
    id = "nested_armor_qt_chestplate",
    name = ccb.content.text("tempered steel chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_qt_chestplate",
    "armor_qt_chestplate",
})

add_group({
    id = "nested_armor_all_chestplate",
    name = ccb.content.text("standard chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from different qualities of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_armor_lc_chestplate",
    "nested_armor_mc_chestplate",
    "nested_armor_hc_chestplate",
    "nested_armor_ch_chestplate",
    "nested_armor_qt_chestplate",
})

add_group({
    id = "nested_armor_lc_heavy_chestplate",
    name = ccb.content.text("mild steel heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_lc_heavy_chestplate",
    "armor_lc_heavy_chestplate",
})

add_group({
    id = "nested_armor_mc_heavy_chestplate",
    name = ccb.content.text("medium steel heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_mc_heavy_chestplate",
    "armor_mc_heavy_chestplate",
})

add_group({
    id = "nested_armor_hc_heavy_chestplate",
    name = ccb.content.text("high steel heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_hc_heavy_chestplate",
    "armor_hc_heavy_chestplate",
})

add_group({
    id = "nested_armor_ch_heavy_chestplate",
    name = ccb.content.text("hardened steel heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_ch_heavy_chestplate",
    "armor_ch_heavy_chestplate",
})

add_group({
    id = "nested_armor_qt_heavy_chestplate",
    name = ccb.content.text("tempered steel heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_qt_heavy_chestplate",
    "armor_qt_heavy_chestplate",
})

add_group({
    id = "nested_armor_all_heavy_chestplate",
    name = ccb.content.text("heavy chestplates"),
    description = ccb.content.text("Recipes related to constructing steel chestplates from different qualities of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_armor_lc_heavy_chestplate",
    "nested_armor_mc_heavy_chestplate",
    "nested_armor_hc_heavy_chestplate",
    "nested_armor_ch_heavy_chestplate",
    "nested_armor_qt_heavy_chestplate",
})

add_group({
    id = "nested_armor_every_chestplate",
    name = ccb.content.text("steel chestplates"),
    description = ccb.content.text("Recipes related to constructing different thicknesses of steel chestplates from different qualities of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 4,
}, {
    "nested_all_light_chestplate",
    "nested_armor_all_chestplate",
    "nested_armor_all_heavy_chestplate",
})

add_group({
    id = "nested_armor_lc_lightplate",
    name = ccb.content.text("mild steel light plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_lc_lightplate",
    "armor_lc_lightplate",
    "xl_armor_lc_lightplate_assembly",
    "armor_lc_lightplate_assembly",
})

add_group({
    id = "nested_armor_mc_lightplate",
    name = ccb.content.text("medium steel light plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_mc_lightplate",
    "armor_mc_lightplate",
    "xl_armor_mc_lightplate_assembly",
    "armor_mc_lightplate_assembly",
})

add_group({
    id = "nested_armor_hc_lightplate",
    name = ccb.content.text("high steel light plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_hc_lightplate",
    "armor_hc_lightplate",
    "xl_armor_hc_lightplate_assembly",
    "armor_hc_lightplate_assembly",
})

add_group({
    id = "nested_armor_ch_lightplate",
    name = ccb.content.text("hardened steel light plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_ch_lightplate",
    "armor_ch_lightplate",
    "xl_armor_ch_lightplate_assembly",
    "armor_ch_lightplate_assembly",
})

add_group({
    id = "nested_armor_qt_lightplate",
    name = ccb.content.text("tempered steel light plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_qt_lightplate",
    "armor_qt_lightplate",
    "xl_armor_qt_lightplate_assembly",
    "armor_qt_lightplate_assembly",
})

add_group({
    id = "nested_armor_all_lightplate",
    name = ccb.content.text("light plate armors"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from different qualities of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_armor_lc_lightplate",
    "nested_armor_mc_lightplate",
    "nested_armor_hc_lightplate",
    "nested_armor_ch_lightplate",
    "nested_armor_qt_lightplate",
})

add_group({
    id = "nested_armor_lc_plate",
    name = ccb.content.text("mild steel plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_lc_plate",
    "armor_lc_plate",
    "xl_armor_lc_plate_assembly",
    "armor_lc_plate_assembly",
})

add_group({
    id = "nested_armor_mc_plate",
    name = ccb.content.text("medium steel plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_mc_plate",
    "armor_mc_plate",
    "xl_armor_mc_plate_assembly",
    "armor_mc_plate_assembly",
})

add_group({
    id = "nested_armor_hc_plate",
    name = ccb.content.text("high steel plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_hc_plate",
    "armor_hc_plate",
    "xl_armor_hc_plate_assembly",
    "armor_hc_plate_assembly",
})

add_group({
    id = "nested_armor_ch_plate",
    name = ccb.content.text("hardened steel plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_ch_plate",
    "armor_ch_plate",
    "xl_armor_ch_plate_assembly",
    "armor_ch_plate_assembly",
})

add_group({
    id = "nested_armor_qt_plate",
    name = ccb.content.text("tempered steel plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_qt_plate",
    "armor_qt_plate",
    "xl_armor_qt_plate_assembly",
    "armor_qt_plate_assembly",
})

add_group({
    id = "nested_armor_all_plate",
    name = ccb.content.text("plate armors"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from different qualities of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_armor_lc_plate",
    "nested_armor_mc_plate",
    "nested_armor_hc_plate",
    "nested_armor_ch_plate",
    "nested_armor_qt_plate",
})

add_group({
    id = "nested_armor_lc_heavyplate",
    name = ccb.content.text("mild steel heavy plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_lc_heavyplate",
    "armor_lc_heavyplate",
    "xl_armor_lc_heavyplate_assembly",
    "armor_lc_heavyplate_assembly",
})

add_group({
    id = "nested_armor_mc_heavyplate",
    name = ccb.content.text("medium steel heavy plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_mc_heavyplate",
    "armor_mc_heavyplate",
    "xl_armor_mc_heavyplate_assembly",
    "armor_mc_heavyplate_assembly",
})

add_group({
    id = "nested_armor_hc_heavyplate",
    name = ccb.content.text("high steel heavy plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_hc_heavyplate",
    "armor_hc_heavyplate",
    "xl_armor_hc_heavyplate_assembly",
    "armor_hc_heavyplate_assembly",
})

add_group({
    id = "nested_armor_ch_heavyplate",
    name = ccb.content.text("hardened steel heavy plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_ch_heavyplate",
    "armor_ch_heavyplate",
    "xl_armor_ch_heavyplate_assembly",
    "armor_ch_heavyplate_assembly",
})

add_group({
    id = "nested_armor_qt_heavyplate",
    name = ccb.content.text("tempered steel heavy plate armor"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_armor_qt_heavyplate",
    "armor_qt_heavyplate",
    "xl_armor_qt_heavyplate_assembly",
    "armor_qt_heavyplate_assembly",
})

add_group({
    id = "nested_armor_all_heavyplate",
    name = ccb.content.text("heavy plate armors"),
    description = ccb.content.text("Recipes related to constructing steel plate armor from different qualities of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_armor_lc_heavyplate",
    "nested_armor_mc_heavyplate",
    "nested_armor_hc_heavyplate",
    "nested_armor_ch_heavyplate",
    "nested_armor_qt_heavyplate",
})

add_group({
    id = "nested_armor_all_platearmors",
    name = ccb.content.text("steel plate armors"),
    description = ccb.content.text("Recipes related to constructing different thicknesses of steel plate armor from different qualities of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 6,
}, {
    "nested_armor_all_heavyplate",
    "nested_armor_all_plate",
    "nested_armor_all_lightplate",
})

add_group({
    id = "nested_lc_demi_gaunt",
    name = ccb.content.text("mild steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_lc_demi_gaunt",
    "lc_demi_gaunt",
})

add_group({
    id = "nested_mc_demi_gaunt",
    name = ccb.content.text("medium steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_mc_demi_gaunt",
    "mc_demi_gaunt",
})

add_group({
    id = "nested_hc_demi_gaunt",
    name = ccb.content.text("high steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_hc_demi_gaunt",
    "hc_demi_gaunt",
})

add_group({
    id = "nested_ch_demi_gaunt",
    name = ccb.content.text("hardened steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_ch_demi_gaunt",
    "ch_demi_gaunt",
})

add_group({
    id = "nested_qt_demi_gaunt",
    name = ccb.content.text("tempered steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_qt_demi_gaunt",
    "qt_demi_gaunt",
})

add_group({
    id = "nested_all_demi_gaunt",
    name = ccb.content.text("steel demi-gauntlets"),
    description = ccb.content.text("Recipes related to constructing demi-gauntlets from different types of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 4,
}, {
    "nested_lc_demi_gaunt",
    "nested_mc_demi_gaunt",
    "nested_hc_demi_gaunt",
    "nested_ch_demi_gaunt",
    "nested_qt_demi_gaunt",
})

add_group({
    id = "nested_lc_mitten_gaunt",
    name = ccb.content.text("mild steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_lc_mitten_gaunt",
    "lc_mitten_gaunt",
})

add_group({
    id = "nested_mc_mitten_gaunt",
    name = ccb.content.text("medium steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_mc_mitten_gaunt",
    "mc_mitten_gaunt",
})

add_group({
    id = "nested_hc_mitten_gaunt",
    name = ccb.content.text("high steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_hc_mitten_gaunt",
    "hc_mitten_gaunt",
})

add_group({
    id = "nested_ch_mitten_gaunt",
    name = ccb.content.text("hardened steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_ch_mitten_gaunt",
    "ch_mitten_gaunt",
})

add_group({
    id = "nested_qt_mitten_gaunt",
    name = ccb.content.text("tempered steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_qt_mitten_gaunt",
    "qt_mitten_gaunt",
})

add_group({
    id = "nested_all_mitten_gaunt",
    name = ccb.content.text("steel mitten gauntlets"),
    description = ccb.content.text("Recipes related to constructing mitten gauntlets from different types of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 4,
}, {
    "nested_lc_mitten_gaunt",
    "nested_mc_mitten_gaunt",
    "nested_hc_mitten_gaunt",
    "nested_ch_mitten_gaunt",
    "nested_qt_mitten_gaunt",
})

add_group({
    id = "nested_lc_lightarmguards",
    name = ccb.content.text("mild steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_lightarmguard",
    "xl_armor_lc_lightarmguard",
})

add_group({
    id = "nested_mc_lightarmguards",
    name = ccb.content.text("medium steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_lightarmguard",
    "xl_armor_mc_lightarmguard",
})

add_group({
    id = "nested_hc_lightarmguards",
    name = ccb.content.text("high steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_lightarmguard",
    "xl_armor_hc_lightarmguard",
})

add_group({
    id = "nested_ch_lightarmguards",
    name = ccb.content.text("hardened steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 6,
}, {
    "armor_ch_lightarmguard",
    "xl_armor_ch_lightarmguard",
})

add_group({
    id = "nested_qt_lightarmguards",
    name = ccb.content.text("tempered steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_lightarmguard",
    "xl_armor_qt_lightarmguard",
})

add_group({
    id = "nested_all_lightarmguards",
    name = ccb.content.text("steel light arm guards"),
    description = ccb.content.text("Recipes related to constructing light arm guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_lightarmguards",
    "nested_mc_lightarmguards",
    "nested_hc_lightarmguards",
    "nested_ch_lightarmguards",
    "nested_qt_lightarmguards",
})

add_group({
    id = "nested_lc_armguards",
    name = ccb.content.text("mild steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_armguard",
    "xl_armor_lc_armguard",
})

add_group({
    id = "nested_mc_armguards",
    name = ccb.content.text("medium steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_armguard",
    "xl_armor_mc_armguard",
})

add_group({
    id = "nested_hc_armguards",
    name = ccb.content.text("high steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_armguard",
    "xl_armor_hc_armguard",
})

add_group({
    id = "nested_ch_armguards",
    name = ccb.content.text("hardened steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_armguard",
    "xl_armor_ch_armguard",
})

add_group({
    id = "nested_qt_armguards",
    name = ccb.content.text("tempered steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_armguard",
    "xl_armor_qt_armguard",
})

add_group({
    id = "nested_all_armguards",
    name = ccb.content.text("steel arm guards"),
    description = ccb.content.text("Recipes related to constructing arm guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_armguards",
    "nested_mc_armguards",
    "nested_hc_armguards",
    "nested_ch_armguards",
    "nested_qt_armguards",
})

add_group({
    id = "nested_lc_heavyarmguards",
    name = ccb.content.text("mild steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_heavyarmguard",
    "xl_armor_lc_heavyarmguard",
})

add_group({
    id = "nested_mc_heavyarmguards",
    name = ccb.content.text("medium steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_heavyarmguard",
    "xl_armor_mc_heavyarmguard",
})

add_group({
    id = "nested_hc_heavyarmguards",
    name = ccb.content.text("high steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_heavyarmguard",
    "xl_armor_hc_heavyarmguard",
})

add_group({
    id = "nested_ch_heavyarmguards",
    name = ccb.content.text("hardened steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_heavyarmguard",
    "xl_armor_ch_heavyarmguard",
})

add_group({
    id = "nested_qt_heavyarmguards",
    name = ccb.content.text("tempered steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_heavyarmguard",
    "xl_armor_qt_heavyarmguard",
})

add_group({
    id = "nested_all_heavyarmguards",
    name = ccb.content.text("steel heavy arm guards"),
    description = ccb.content.text("Recipes related to constructing heavy arm guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_heavyarmguards",
    "nested_mc_heavyarmguards",
    "nested_hc_heavyarmguards",
    "nested_ch_heavyarmguards",
    "nested_qt_heavyarmguards",
})

add_group({
    id = "nested_all_steel_armguards",
    name = ccb.content.text("steel arm guards"),
    description = ccb.content.text("Recipes related to constructing different thicknesses of arm guards from various types of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 4,
}, {
    "nested_all_heavyarmguards",
    "nested_all_armguards",
    "nested_all_lightarmguards",
})

add_group({
    id = "nested_lc_chainmail_hauberk",
    name = ccb.content.text("mild steel chain hauberks"),
    description = ccb.content.text("Recipes related to constructing chainmail hauberks in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_chainmail_hauberk",
    "lc_chainmail_hauberk_xs",
    "xl_lc_chainmail_hauberk",
})

add_group({
    id = "nested_mc_chainmail_hauberk",
    name = ccb.content.text("medium steel chain hauberks"),
    description = ccb.content.text("Recipes related to constructing chainmail hauberks in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_chainmail_hauberk",
    "mc_chainmail_hauberk_xs",
    "xl_mc_chainmail_hauberk",
})

add_group({
    id = "nested_hc_chainmail_hauberk",
    name = ccb.content.text("high steel chain hauberks"),
    description = ccb.content.text("Recipes related to constructing chainmail hauberks in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_chainmail_hauberk",
    "hc_chainmail_hauberk_xs",
    "xl_hc_chainmail_hauberk",
})

add_group({
    id = "nested_ch_chainmail_hauberk",
    name = ccb.content.text("hardened steel chain hauberks"),
    description = ccb.content.text("Recipes related to constructing chainmail hauberks in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_chainmail_hauberk",
    "ch_chainmail_hauberk_xs",
    "xl_ch_chainmail_hauberk",
})

add_group({
    id = "nested_qt_chainmail_hauberk",
    name = ccb.content.text("tempered steel chain hauberks"),
    description = ccb.content.text("Recipes related to constructing chainmail hauberks in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_chainmail_hauberk",
    "qt_chainmail_hauberk_xs",
    "xl_qt_chainmail_hauberk",
})

add_group({
    id = "nested_all_chainmail_hauberk",
    name = ccb.content.text("steel chain hauberks"),
    description = ccb.content.text("Recipes related to fitting together chainmail armor to make chainmail hauberks in various types and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 4,
}, {
    "nested_lc_chainmail_hauberk",
    "nested_mc_chainmail_hauberk",
    "nested_hc_chainmail_hauberk",
    "nested_ch_chainmail_hauberk",
    "nested_qt_chainmail_hauberk",
})

add_group({
    id = "nested_lc_chainmail_sjumpsuit",
    name = ccb.content.text("mild steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail sleeveless jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_chainmail_sjumpsuit",
    "lc_chainmail_sjumpsuit_xs",
    "xl_lc_chainmail_sjumpsuit",
})

add_group({
    id = "nested_mc_chainmail_sjumpsuit",
    name = ccb.content.text("medium steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail sleeveless jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_chainmail_sjumpsuit",
    "mc_chainmail_sjumpsuit_xs",
    "xl_mc_chainmail_sjumpsuit",
})

add_group({
    id = "nested_hc_chainmail_sjumpsuit",
    name = ccb.content.text("high steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail sleeveless jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_chainmail_sjumpsuit",
    "hc_chainmail_sjumpsuit_xs",
    "xl_hc_chainmail_sjumpsuit",
})

add_group({
    id = "nested_ch_chainmail_sjumpsuit",
    name = ccb.content.text("hardened steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail sleeveless jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_chainmail_sjumpsuit",
    "ch_chainmail_sjumpsuit_xs",
    "xl_ch_chainmail_sjumpsuit",
})

add_group({
    id = "nested_qt_chainmail_sjumpsuit",
    name = ccb.content.text("tempered steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail sleeveless jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_chainmail_sjumpsuit",
    "qt_chainmail_sjumpsuit_xs",
    "xl_qt_chainmail_sjumpsuit",
})

add_group({
    id = "nested_all_chainmail_sjumpsuit",
    name = ccb.content.text("steel chain sleeveless jumpsuits"),
    description = ccb.content.text("Recipes related to fitting together chainmail armor to make chainmail sleeveless jumpsuits in various types and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 4,
}, {
    "nested_lc_chainmail_sjumpsuit",
    "nested_mc_chainmail_sjumpsuit",
    "nested_hc_chainmail_sjumpsuit",
    "nested_ch_chainmail_sjumpsuit",
    "nested_qt_chainmail_sjumpsuit",
})

add_group({
    id = "nested_lc_chainmail_jumpsuit",
    name = ccb.content.text("mild steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_chainmail_jumpsuit",
    "lc_chainmail_jumpsuit_xs",
    "xl_lc_chainmail_jumpsuit",
    "lc_chainmail_jumpsuit_hauberk",
    "lc_chainmail_jumpsuit_xs_hauberk",
    "xl_lc_chainmail_jumpsuit_hauberk",
})

add_group({
    id = "nested_mc_chainmail_jumpsuit",
    name = ccb.content.text("medium steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_chainmail_jumpsuit",
    "mc_chainmail_jumpsuit_xs",
    "xl_mc_chainmail_jumpsuit",
    "mc_chainmail_jumpsuit_hauberk",
    "mc_chainmail_jumpsuit_xs_hauberk",
    "xl_mc_chainmail_jumpsuit_hauberk",
})

add_group({
    id = "nested_hc_chainmail_jumpsuit",
    name = ccb.content.text("high steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_chainmail_jumpsuit",
    "hc_chainmail_jumpsuit_xs",
    "xl_hc_chainmail_jumpsuit",
    "hc_chainmail_jumpsuit_hauberk",
    "hc_chainmail_jumpsuit_xs_hauberk",
    "xl_hc_chainmail_jumpsuit_hauberk",
})

add_group({
    id = "nested_ch_chainmail_jumpsuit",
    name = ccb.content.text("hardened steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_chainmail_jumpsuit",
    "ch_chainmail_jumpsuit_xs",
    "xl_ch_chainmail_jumpsuit",
    "ch_chainmail_jumpsuit_hauberk",
    "ch_chainmail_jumpsuit_xs_hauberk",
    "xl_ch_chainmail_jumpsuit_hauberk",
})

add_group({
    id = "nested_qt_chainmail_jumpsuit",
    name = ccb.content.text("tempered steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_chainmail_jumpsuit",
    "qt_chainmail_jumpsuit_xs",
    "xl_qt_chainmail_jumpsuit",
    "qt_chainmail_jumpsuit_hauberk",
    "qt_chainmail_jumpsuit_xs_hauberk",
    "xl_qt_chainmail_jumpsuit_hauberk",
})

add_group({
    id = "nested_all_chainmail_jumpsuit",
    name = ccb.content.text("steel chain jumpsuits"),
    description = ccb.content.text("Recipes related to constructing chainmail jumpsuits in various types and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 4,
}, {
    "nested_lc_chainmail_jumpsuit",
    "nested_mc_chainmail_jumpsuit",
    "nested_hc_chainmail_jumpsuit",
    "nested_ch_chainmail_jumpsuit",
    "nested_qt_chainmail_jumpsuit",
})

add_group({
    id = "nested_lc_chainmail_suit",
    name = ccb.content.text("mild steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_chainmail_suit",
    "lc_chainmail_suit_xs",
    "xl_lc_chainmail_suit",
})

add_group({
    id = "nested_mc_chainmail_suit",
    name = ccb.content.text("medium steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_chainmail_suit",
    "mc_chainmail_suit_xs",
    "xl_mc_chainmail_suit",
})

add_group({
    id = "nested_hc_chainmail_suit",
    name = ccb.content.text("high steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_chainmail_suit",
    "hc_chainmail_suit_xs",
    "xl_hc_chainmail_suit",
})

add_group({
    id = "nested_ch_chainmail_suit",
    name = ccb.content.text("hardened steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_chainmail_suit",
    "ch_chainmail_suit_xs",
    "xl_ch_chainmail_suit",
})

add_group({
    id = "nested_qt_chainmail_suit",
    name = ccb.content.text("tempered steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_chainmail_suit",
    "qt_chainmail_suit_xs",
    "xl_qt_chainmail_suit",
})

add_group({
    id = "nested_chainmail_suit_faraday",
    name = ccb.content.text("faraday chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits that resist electricity."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "chainmail_suit_faraday",
    "chainmail_suit_faraday_xs",
    "xl_chainmail_suit_faraday",
})

add_group({
    id = "nested_all_chainmail_suit",
    name = ccb.content.text("steel chain suits"),
    description = ccb.content.text("Recipes related to constructing chainmail suits in various types and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 4,
}, {
    "nested_lc_chainmail_suit",
    "nested_mc_chainmail_suit",
    "nested_hc_chainmail_suit",
    "nested_ch_chainmail_suit",
    "nested_chainmail_suit_faraday",
    "nested_qt_chainmail_suit",
})

add_group({
    id = "nested_scrap_cuirass",
    name = ccb.content.text("scrap cuirasses"),
    description = ccb.content.text("Recipes related to constructing scrap cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "cuirass_scrap",
    "xs_cuirass_scrap",
    "xl_cuirass_scrap",
})

add_group({
    id = "nested_cuirass_tire",
    name = ccb.content.text("tire cuirasses"),
    description = ccb.content.text("Recipes related to constructing tire cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "cuirass_tire",
    "xs_cuirass_tire",
    "xl_cuirass_tire",
})

add_group({
    id = "nested_cuirass_bronze",
    name = ccb.content.text("bronze cuirasses"),
    description = ccb.content.text("Recipes related to constructing bronze cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 6,
}, {
    "cuirass_bronze",
    "xs_cuirass_bronze",
    "xl_cuirass_bronze",
})

add_group({
    id = "nested_armor_lamellar",
    name = ccb.content.text("leather lamellar cuirasses"),
    description = ccb.content.text("Recipes related to constructing leather lamellar cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_lamellar",
    "xs_armor_lamellar",
    "xl_armor_lamellar",
})

add_group({
    id = "nested_armor_lamellar_steel",
    name = ccb.content.text("steel lamellar cuirasses"),
    description = ccb.content.text("Recipes related to constructing steel lamellar cuirasses in various shapes and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "armor_lamellar_lc",
    "armor_lamellar_ch",
    "xs_armor_lamellar_lc",
    "xs_armor_lamellar_ch",
    "xl_armor_lamellar_lc",
    "xl_armor_lamellar_ch",
})

add_group({
    id = "nested_armor_lamellar_steel_repair",
    name = ccb.content.text("steel lamellar repair"),
    description = ccb.content.text("Recipes related to repairing steel lamellar armor in various shapes and sizes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "armor_lamellar_lc_repair",
    "armor_lamellar_ch_repair",
    "xs_armor_lamellar_lc_repair",
    "xs_armor_lamellar_ch_repair",
    "xl_armor_lamellar_lc_repair",
    "xl_armor_lamellar_ch_repair",
})

add_group({
    id = "nested_armor_cuirass",
    name = ccb.content.text("bell cuirasses"),
    description = ccb.content.text("Recipes related to constructing Greek cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 6,
}, {
    "armor_cuirass",
    "xs_armor_cuirass",
    "xl_armor_cuirass",
})

add_group({
    id = "nested_cuirass_lightplate",
    name = ccb.content.text("plate cuirasses"),
    description = ccb.content.text("Recipes related to constructing plate cuirasses in various shapes and sizes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 6,
}, {
    "cuirass_lightplate",
    "xs_cuirass_lightplate",
    "xl_cuirass_lightplate",
})

add_group({
    id = "nested_cuirasses",
    name = ccb.content.text("cuirasses"),
    description = ccb.content.text("Recipes related to constructing different kinds of cuirasses."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 6,
}, {
    "nested_scrap_cuirass",
    "nested_cuirass_tire",
    "nested_cuirass_bronze",
    "nested_armor_lamellar",
    "nested_armor_cuirass",
    "nested_cuirass_lightplate",
})

add_group({
    id = "nested_lc_light_leg_guards",
    name = ccb.content.text("mild steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_light_leg_guard",
    "xl_armor_lc_light_leg_guard",
})

add_group({
    id = "nested_mc_light_leg_guards",
    name = ccb.content.text("medium steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_light_leg_guard",
    "xl_armor_mc_light_leg_guard",
})

add_group({
    id = "nested_hc_light_leg_guards",
    name = ccb.content.text("high steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_light_leg_guard",
    "xl_armor_hc_light_leg_guard",
})

add_group({
    id = "nested_ch_light_leg_guards",
    name = ccb.content.text("hardened steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_light_leg_guard",
    "xl_armor_ch_light_leg_guard",
})

add_group({
    id = "nested_qt_light_leg_guards",
    name = ccb.content.text("tempered steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_light_leg_guard",
    "xl_armor_qt_light_leg_guard",
})

add_group({
    id = "nested_all_light_leg_guards",
    name = ccb.content.text("steel light leg guards"),
    description = ccb.content.text("Recipes related to constructing light leg guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_light_leg_guards",
    "nested_mc_light_leg_guards",
    "nested_hc_light_leg_guards",
    "nested_ch_light_leg_guards",
    "nested_qt_light_leg_guards",
})

add_group({
    id = "nested_lc_leg_guards",
    name = ccb.content.text("mild steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_leg_guard",
    "xl_armor_lc_leg_guard",
})

add_group({
    id = "nested_mc_leg_guards",
    name = ccb.content.text("medium steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_leg_guard",
    "xl_armor_mc_leg_guard",
})

add_group({
    id = "nested_hc_leg_guards",
    name = ccb.content.text("high steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_leg_guard",
    "xl_armor_hc_leg_guard",
})

add_group({
    id = "nested_ch_leg_guards",
    name = ccb.content.text("hardened steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_leg_guard",
    "xl_armor_ch_leg_guard",
})

add_group({
    id = "nested_qt_leg_guards",
    name = ccb.content.text("tempered steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_leg_guard",
    "xl_armor_qt_leg_guard",
})

add_group({
    id = "nested_all_leg_guards",
    name = ccb.content.text("steel leg guards"),
    description = ccb.content.text("Recipes related to constructing leg guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_leg_guards",
    "nested_mc_leg_guards",
    "nested_hc_leg_guards",
    "nested_ch_leg_guards",
    "nested_qt_leg_guards",
})

add_group({
    id = "nested_lc_heavy_leg_guards",
    name = ccb.content.text("mild steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_lc_heavy_leg_guard",
    "xl_armor_lc_heavy_leg_guard",
})

add_group({
    id = "nested_mc_heavy_leg_guards",
    name = ccb.content.text("medium steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_mc_heavy_leg_guard",
    "xl_armor_mc_heavy_leg_guard",
})

add_group({
    id = "nested_hc_heavy_leg_guards",
    name = ccb.content.text("high steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_hc_heavy_leg_guard",
    "xl_armor_hc_heavy_leg_guard",
})

add_group({
    id = "nested_ch_heavy_leg_guards",
    name = ccb.content.text("hardened steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_ch_heavy_leg_guard",
    "xl_armor_ch_heavy_leg_guard",
})

add_group({
    id = "nested_qt_heavy_leg_guards",
    name = ccb.content.text("tempered steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "armor_qt_heavy_leg_guard",
    "xl_armor_qt_heavy_leg_guard",
})

add_group({
    id = "nested_all_heavy_leg_guards",
    name = ccb.content.text("steel heavy leg guards"),
    description = ccb.content.text("Recipes related to constructing heavy leg guards from various types of steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_heavy_leg_guards",
    "nested_mc_heavy_leg_guards",
    "nested_hc_heavy_leg_guards",
    "nested_ch_heavy_leg_guards",
    "nested_qt_heavy_leg_guards",
})

add_group({
    id = "nested_all_steel_leg_guards",
    name = ccb.content.text("steel leg guards"),
    description = ccb.content.text("Recipes related to constructing different thicknesses of leg guards from various types of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 4,
}, {
    "nested_all_heavy_leg_guards",
    "nested_all_leg_guards",
    "nested_all_light_leg_guards",
})

add_group({
    id = "nested_arm_splint",
    name = ccb.content.text("arm splints"),
    description = ccb.content.text("Recipes related to constructing various shapes and sizes of arm splints."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "arm_splint",
    "arm_xlsplint",
    "arm_xs_splint",
})

add_group({
    id = "nested_leg_splint",
    name = ccb.content.text("leg splints"),
    description = ccb.content.text("Recipes related to constructing various shapes and sizes of leg splints."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "leg_splint",
    "leg_xlsplint",
    "leg_xs_splint",
})

add_group({
    id = "nested_splints",
    name = ccb.content.text("splints"),
    description = ccb.content.text("Recipes related to constructing various shapes and sizes of splints."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    activity_level = 4,
}, {
    "nested_arm_splint",
    "nested_leg_splint",
})

add_group({
    id = "nested_bandages",
    name = ccb.content.text("bandages"),
    description = ccb.content.text("Recipes related to crafting variations of bandages."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "bandages",
    "bandages_makeshift",
    "bandages_makeshift_with_tool",
    "bandages_makeshift_bleached",
    "bandages_makeshift_boiled",
    "adhesive_bandages",
})

add_group({
    id = "nested_tourniquets",
    name = ccb.content.text("tourniquets"),
    description = ccb.content.text("Recipes related to crafting different kinds of tourniquets."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "tourniquet_upper",
})

add_group({
    id = "nested_hemostatic",
    name = ccb.content.text("hemostatic compounds"),
    description = ccb.content.text("Recipes related to creating different hemostatic compounds."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "quikclot",
    "quikclot_from_alder",
})

add_group({
    id = "nested_bleedcontrol",
    name = ccb.content.text("bleeding control"),
    description = ccb.content.text("Recipes that create items used to stop or slow blood loss."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    activity_level = 4,
}, {
    "nested_bandages",
    "nested_tourniquets",
    "nested_hemostatic",
})

add_group({
    id = "nested_antiseptics",
    name = ccb.content.text("antiseptics"),
    description = ccb.content.text("Recipes related to crafting different kinds of antiseptics."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    activity_level = 4,
}, {
    "disinfectant_makeshift",
    "wintergreen_oil",
    "thyme_oil",
    "disinrag",
    "disincotton_ball",
    "cattail_jelly",
})

add_group({
    id = "nested_deflated_tires",
    name = ccb.content.text("deflated tires"),
    description = ccb.content.text("Recipes related to taking the air out of tires."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    activity_level = 4,
}, {
    "deflated_wheel",
    "deflated_wheel_slick",
    "deflated_wheel_motorbike",
    "deflated_wheel_motorbike_or",
    "deflated_wheel_wide",
    "deflated_wheel_wide_or",
    "deflated_wheel_bicycle",
    "deflated_wheel_bicycle_or",
})

add_group({
    id = "nested_filled_tires",
    name = ccb.content.text("inflated tires"),
    description = ccb.content.text("Recipes related to inflating tires."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    activity_level = 4,
}, {
    "wheel",
    "wheel_slick",
    "wheel_motorbike",
    "wheel_motorbike_or",
    "wheel_wide",
    "wheel_wide_or",
    "wheel_bicycle",
    "wheel_bicycle_or",
})

add_group({
    id = "nested_survivor_jumpsuits",
    name = ccb.content.text("handmade combat suits"),
    description = ccb.content.text("Recipes related to constructing custom-made jumpsuits meant to keep the wearer safe from harm."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "survivor_jumpsuit",
    "xssurvivor_jumpsuit",
    "xlsurvivor_jumpsuit",
})

add_group({
    id = "nested_light_survivor_jumpsuits",
    name = ccb.content.text("handmade summer suits"),
    description = ccb.content.text("Recipes related to constructing custom-made jumpsuits meant to keep the wearer safe from harm while still being flexible."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lsurvivor_jumpsuit",
    "xs_lsurvivor_jumpsuit",
    "xl_lsurvivor_jumpsuit",
})

add_group({
    id = "nested_heavy_survivor_jumpsuits",
    name = ccb.content.text("handmade hazard suits"),
    description = ccb.content.text("Recipes related to constructing custom-made jumpsuits meant for both harm and chemical hazards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hsurvivor_jumpsuit",
    "xs_hsurvivor_jumpsuit",
    "xl_hsurvivor_jumpsuit",
})

add_group({
    id = "nested_winter_survivor_jumpsuits",
    name = ccb.content.text("handmade winter suits"),
    description = ccb.content.text("Recipes related to constructing custom-made jumpsuits meant to keep the wearer safe from harm and freezing cold temperatures."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "wsurvivor_jumpsuit_nofur",
    "xs_wsurvivor_jumpsuit_nofur",
    "xl_wsurvivor_jumpsuit_nofur",
    "wsurvivor_jumpsuit",
    "xs_wsurvivor_jumpsuit",
    "xl_wsurvivor_jumpsuit",
})

add_group({
    id = "nested_all_survivor_jumpsuits",
    name = ccb.content.text("handmade reinforced jumpsuits"),
    description = ccb.content.text("Recipes related to constructing custom-made jumpsuits meant to keep the wearer safe from various types of harm."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "nested_survivor_jumpsuits",
    "nested_light_survivor_jumpsuits",
    "nested_heavy_survivor_jumpsuits",
    "nested_winter_survivor_jumpsuits",
    "nested_nomadjumpsuits",
})

add_group({
    id = "nested_quivers",
    name = ccb.content.text("quivers"),
    description = ccb.content.text("Recipes related to constructing different kinds of quivers to hold arrows."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    activity_level = 2,
}, {
    "quiver_takedown_bow",
    "quiver",
    "quiver_birchbark",
    "quiver_large",
    "quiver_large_birchbark",
    "nylon_quiver",
    "pipe_quiver",
    "pipe_quiver_large",
    "quiver_simple_cloth",
})

add_group({
    id = "nested_steel_wires",
    name = ccb.content.text("steel wires"),
    description = ccb.content.text("Recipes related to constructing different qualities of steel wires."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "lc_wire",
    "lc_wire_wire_draw_machine",
    "mc_wire",
    "mc_wire_wire_draw_machine",
    "hc_wire",
    "hc_wire_wire_draw_machine",
    "ch_wire",
    "ch_wire_wire_draw_machine",
    "qt_wire",
    "qt_wire_wire_draw_machine",
})

add_group({
    id = "nested_frames",
    name = ccb.content.text("vehicle frames"),
    description = ccb.content.text("Recipes related to constructing different kinds of vehicle frames."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    activity_level = 2,
}, {
    "foldxlframe",
    "foldwoodframe",
    "xlframe",
    "foldframe",
    "hdframe",
    "frame",
    "frame_wood",
    "frame_wood_light",
})

add_group({
    id = "nested_flours",
    name = ccb.content.text("flours"),
    description = ccb.content.text("Recipes related to grinding down ingredients to make different kinds of flour."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    activity_level = 2,
}, {
    "flour",
    "flour_with_from_food_processor",
    "flour_mortar",
    "flour_wheat_free",
    "flour_wheat_free_with_from_food_processor",
    "flour_wheat_free_mortar",
    "bread_flour",
    "bread_flour_with_from_food_processor",
})

add_group({
    id = "nested_steel_lump",
    name = ccb.content.text("lumps of steel"),
    description = ccb.content.text("Recipes related to forging steel into different quality lumps."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "steel_lump",
    "steel_lump_from_other_steel",
    "budget_steel_lump",
    "budget_steel_lump_from_scrap",
    "lc_steel_lump",
    "mc_steel_lump",
    "hc_steel_lump",
})

add_group({
    id = "nested_steel_chunk",
    name = ccb.content.text("chunks of steel"),
    description = ccb.content.text("Recipes related to forging steel into different quality chunks."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "steel_chunk",
    "mc_steel_chunk_primitive",
    "ch_steel_chunk_primitive",
    "qt_steel_chunk_primitive",
    "steel_chunk_primitive_decarburizing",
    "steel_chunk_primitive_scrap_refining",
    "budget_steel_chunk",
})

add_group({
    id = "nested_metal_bars",
    name = ccb.content.text("metal bars"),
    description = ccb.content.text("Recipes related to processing bar stock into smaller sizes."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 1,
}, {
    "small_aluminum_bar_round",
    "small_lc_steel_bar_round",
    "small_mc_steel_bar_round",
    "small_hc_steel_bar_round",
})

add_group({
    id = "nested_lc_sabatons",
    name = ccb.content.text("mild steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_lc_sabaton",
    "lc_sabaton",
})

add_group({
    id = "nested_mc_sabatons",
    name = ccb.content.text("medium steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_mc_sabaton",
    "mc_sabaton",
})

add_group({
    id = "nested_hc_sabatons",
    name = ccb.content.text("high steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_hc_sabaton",
    "hc_sabaton",
})

add_group({
    id = "nested_ch_sabatons",
    name = ccb.content.text("hardened steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_ch_sabaton",
    "ch_sabaton",
})

add_group({
    id = "nested_qt_sabatons",
    name = ccb.content.text("tempered steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "xl_qt_sabaton",
    "qt_sabaton",
})

add_group({
    id = "nested_all_sabatons",
    name = ccb.content.text("steel sabatons"),
    description = ccb.content.text("Recipes related to constructing sabatons from different qualities of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    activity_level = 4,
}, {
    "nested_lc_sabatons",
    "nested_mc_sabatons",
    "nested_hc_sabatons",
    "nested_ch_sabatons",
    "nested_qt_sabatons",
})

add_group({
    id = "nested_compact_currency",
    name = ccb.content.text("bundled currency"),
    description = ccb.content.text("Recipes related to creating fat stacks of currency."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    activity_level = 1,
}, {
    "money_strap_one",
    "money_strap_two",
    "money_strap_five",
    "money_strap_ten",
    "money_strap_twenty",
    "money_strap_fifty",
    "money_strap_hundred",
    "money_strap_FMCNote",
    "money_bundle_one",
    "money_bundle_two",
    "money_bundle_five",
    "money_bundle_ten",
    "money_bundle_twenty",
    "money_bundle_fifty",
    "money_bundle_hundred",
    "money_bundle_FMCNote",
})

add_group({
    id = "nested_hood_wsurvivor",
    name = ccb.content.text("handmade winter hoods"),
    description = ccb.content.text("Recipes related to constructing various sizes of specialized hoods designed to protect the wearer and keep them warm in freezing temperatures."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hood_wsurvivor_nofur",
    "xs_hood_wsurvivor_nofur",
    "xl_hood_wsurvivor_nofur",
    "hood_wsurvivor",
    "xs_hood_wsurvivor",
    "xl_hood_wsurvivor",
})

add_group({
    id = "nested_hood_survivor",
    name = ccb.content.text("handmade traveler hoods"),
    description = ccb.content.text("Recipes related to constructing various sizes of specialized hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hood_survivor",
    "hood_xssurvivor",
    "hood_xlsurvivor",
})

add_group({
    id = "nested_all_hood_survivor",
    name = ccb.content.text("handmade reinforced hoods"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of specialized hoods designed to protect the wearer."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_hood_survivor",
    "nested_hood_wsurvivor",
})

add_group({
    id = "nested_lc_chainmail_hood",
    name = ccb.content.text("mild steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_hood",
    "xl_lc_chainmail_hood",
    "xs_lc_chainmail_hood",
})

add_group({
    id = "nested_mc_chainmail_hood",
    name = ccb.content.text("medium steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_hood",
    "xl_mc_chainmail_hood",
    "xs_mc_chainmail_hood",
})

add_group({
    id = "nested_hc_chainmail_hood",
    name = ccb.content.text("high steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_hood",
    "xl_hc_chainmail_hood",
    "xs_hc_chainmail_hood",
})

add_group({
    id = "nested_ch_chainmail_hood",
    name = ccb.content.text("hardened steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_hood",
    "xl_ch_chainmail_hood",
    "xs_ch_chainmail_hood",
})

add_group({
    id = "nested_qt_chainmail_hood",
    name = ccb.content.text("tempered steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_hood",
    "xl_qt_chainmail_hood",
    "xs_qt_chainmail_hood",
})

add_group({
    id = "nested_all_chainmail_hood",
    name = ccb.content.text("steel chain coifs"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of chainmail hoods designed to protect the wearer."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_chainmail_hood",
    "nested_mc_chainmail_hood",
    "nested_hc_chainmail_hood",
    "nested_ch_chainmail_hood",
    "nested_qt_chainmail_hood",
})

add_group({
    id = "nested_mask_gas",
    name = ccb.content.text("gas masks"),
    description = ccb.content.text("Recipes related to constructing various shapes and sizes of gas masks."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "mask_gas",
    "mask_gas_xl",
    "mask_gas_xl_expand-existing",
    "mask_gas_xs",
    "mask_gas_xs_shrink-existing",
})

add_group({
    id = "nested_rebreather",
    name = ccb.content.text("rebreathers"),
    description = ccb.content.text("Recipes related to constructing various shapes and sizes of rebreathers."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "rebreather",
    "rebreather_xl",
    "rebreather_xl_mod_existing",
    "rebreather_xs",
    "rebreather_xs_mod_existing",
})

add_group({
    id = "nested_mask_survivor",
    name = ccb.content.text("handmade basic gas masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of standard handmade gas masks."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mask_survivor",
    "mask_survivorxs",
    "mask_survivorxl",
})

add_group({
    id = "nested_mask_fsurvivor",
    name = ccb.content.text("handmade firemasks"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade gas masks designed to withstand heavy smoke and fires."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mask_fsurvivor",
    "mask_fsurvivorxs",
    "mask_fsurvivorxl",
})

add_group({
    id = "nested_mask_h20survivor",
    name = ccb.content.text("handmade divemasks"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade divemasks designed to protect the wearer and allow them to breath underwater."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mask_h20survivor",
    "mask_h20survivorxs",
    "mask_h20survivorxl",
})

add_group({
    id = "nested_mask_hsurvivor",
    name = ccb.content.text("handmade reinforced gas masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of heavy handmade gas masks."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mask_hsurvivor",
    "mask_hsurvivorxl",
    "mask_hsurvivorxs",
})

add_group({
    id = "nested_mask_lsurvivor",
    name = ccb.content.text("handmade half gas masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade half gas masks that do not cover the eyes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mask_lsurvivor",
    "mask_lsurvivorxl",
    "mask_lsurvivorxs",
})

add_group({
    id = "nested_all_mask_survivor",
    name = ccb.content.text("handmade gas masks"),
    description = ccb.content.text("Recipes related to constructing various kinds of handmade gas masks."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_mask_survivor",
    "nested_mask_fsurvivor",
    "nested_mask_hsurvivor",
    "nested_mask_lsurvivor",
    "nested_mask_h20survivor",
})

add_group({
    id = "nested_lc_chainmail_vest",
    name = ccb.content.text("mild steel chain vest"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_vest",
    "xs_lc_chainmail_vest",
    "xl_lc_chainmail_vest",
})

add_group({
    id = "nested_mc_chainmail_vest",
    name = ccb.content.text("medium steel chain vest"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_vest",
    "xs_mc_chainmail_vest",
    "xl_mc_chainmail_vest",
})

add_group({
    id = "nested_hc_chainmail_vest",
    name = ccb.content.text("high steel chain vest"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_vest",
    "xs_hc_chainmail_vest",
    "xl_hc_chainmail_vest",
})

add_group({
    id = "nested_ch_chainmail_vest",
    name = ccb.content.text("hardened steel chain vest"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_vest",
    "xs_ch_chainmail_vest",
    "xl_ch_chainmail_vest",
})

add_group({
    id = "nested_qt_chainmail_vest",
    name = ccb.content.text("tempered steel chain vest"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_vest",
    "xs_qt_chainmail_vest",
    "xl_qt_chainmail_vest",
})

add_group({
    id = "nested_all_chainmail_vest",
    name = ccb.content.text("steel chain vests"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail vests."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_chainmail_vest",
    "nested_mc_chainmail_vest",
    "nested_hc_chainmail_vest",
    "nested_ch_chainmail_vest",
    "nested_qt_chainmail_vest",
})

add_group({
    id = "nested_gambeson_full",
    name = ccb.content.text("full padded gambesons"),
    description = ccb.content.text("Recipes related to constructing gambesons that cover the torso and arms."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "gambeson",
    "gambeson_xs",
    "xl_gambeson",
})

add_group({
    id = "nested_gambeson_vest",
    name = ccb.content.text("gambeson vests"),
    description = ccb.content.text("Recipes related to constructing padded gambesons without sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "gambeson_vest",
    "gambeson_vest_xs",
    "xl_gambeson_vest",
})

add_group({
    id = "nested_all_gambeson",
    name = ccb.content.text("padded gambesons"),
    description = ccb.content.text("Recipes related to constructing padded gambesons."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_gambeson_full",
    "nested_gambeson_vest",
})

add_group({
    id = "nested_all_arming_pants",
    name = ccb.content.text("padded arming pants"),
    description = ccb.content.text("Recipes related to constructing padded arming pants."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "gambeson_pants",
    "xl_gambeson_pants",
    "gambeson_pants_xs",
})

add_group({
    id = "nested_all_gambeson_hoods",
    name = ccb.content.text("padded gambeson hoods"),
    description = ccb.content.text("Recipes related to constructing padded gambeson hoods."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "gambeson_hood",
    "xl_gambeson_hood",
    "xs_gambeson_hood",
})

add_group({
    id = "nested_gloves_wsurvivor",
    name = ccb.content.text("handmade winter gauntlets"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade winter gauntlets."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "gloves_wsurvivor_nofur",
    "xs_gloves_wsurvivor_nofur",
    "xl_gloves_wsurvivor_nofur",
    "gloves_wsurvivor",
    "xs_gloves_wsurvivor",
    "xl_gloves_wsurvivor",
})

add_group({
    id = "nested_gloves_survivor",
    name = ccb.content.text("handmade hazard gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade hazard gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "gloves_survivor",
    "xs_gloves_survivor",
    "xl_gloves_survivor",
})

add_group({
    id = "nested_all_gloves_survivor",
    name = ccb.content.text("handmade protective gloves"),
    description = ccb.content.text("Recipes related to various sizes and types of durable gloves specialized for tasks like acid resistance or cold weather."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "nested_gloves_survivor",
    "nested_gloves_wsurvivor",
})

add_group({
    id = "nested_lc_chainmail_hands",
    name = ccb.content.text("mild steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_hands",
    "xs_lc_chainmail_hands",
    "xl_lc_chainmail_hands",
})

add_group({
    id = "nested_mc_chainmail_hands",
    name = ccb.content.text("medium steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_hands",
    "xs_mc_chainmail_hands",
    "xl_mc_chainmail_hands",
})

add_group({
    id = "nested_hc_chainmail_hands",
    name = ccb.content.text("high steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_hands",
    "xs_hc_chainmail_hands",
    "xl_hc_chainmail_hands",
})

add_group({
    id = "nested_ch_chainmail_hands",
    name = ccb.content.text("hardened steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_hands",
    "xs_ch_chainmail_hands",
    "xl_ch_chainmail_hands",
})

add_group({
    id = "nested_qt_chainmail_hands",
    name = ccb.content.text("tempered steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_hands",
    "xs_qt_chainmail_hands",
    "xl_qt_chainmail_hands",
})

add_group({
    id = "nested_all_chainmail_hands",
    name = ccb.content.text("steel chain gloves"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of chain gloves."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "nested_lc_chainmail_hands",
    "nested_mc_chainmail_hands",
    "nested_hc_chainmail_hands",
    "nested_ch_chainmail_hands",
    "nested_qt_chainmail_hands",
})

add_group({
    id = "nested_lc_chainmail_arms",
    name = ccb.content.text("mild steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_arms",
    "xs_lc_chainmail_arms",
    "xl_lc_chainmail_arms",
})

add_group({
    id = "nested_mc_chainmail_arms",
    name = ccb.content.text("medium steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_arms",
    "xs_mc_chainmail_arms",
    "xl_mc_chainmail_arms",
})

add_group({
    id = "nested_hc_chainmail_arms",
    name = ccb.content.text("high steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_arms",
    "xs_hc_chainmail_arms",
    "xl_hc_chainmail_arms",
})

add_group({
    id = "nested_ch_chainmail_arms",
    name = ccb.content.text("hardened steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_arms",
    "xs_ch_chainmail_arms",
    "xl_ch_chainmail_arms",
})

add_group({
    id = "nested_qt_chainmail_arms",
    name = ccb.content.text("tempered steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_arms",
    "xs_qt_chainmail_arms",
    "xl_qt_chainmail_arms",
})

add_group({
    id = "nested_all_chainmail_arms",
    name = ccb.content.text("steel chain sleeves"),
    description = ccb.content.text("Recipes related to constructing various sizes of chain sleeves."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "nested_lc_chainmail_arms",
    "nested_mc_chainmail_arms",
    "nested_hc_chainmail_arms",
    "nested_ch_chainmail_arms",
    "nested_qt_chainmail_arms",
})

add_group({
    id = "nested_lc_chainmail_legs",
    name = ccb.content.text("mild steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_legs",
    "xs_lc_chainmail_legs",
    "xl_lc_chainmail_legs",
})

add_group({
    id = "nested_mc_chainmail_legs",
    name = ccb.content.text("medium steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_legs",
    "xs_mc_chainmail_legs",
    "xl_mc_chainmail_legs",
})

add_group({
    id = "nested_hc_chainmail_legs",
    name = ccb.content.text("high steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_legs",
    "xs_hc_chainmail_legs",
    "xl_hc_chainmail_legs",
})

add_group({
    id = "nested_ch_chainmail_legs",
    name = ccb.content.text("hardened steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_legs",
    "xs_ch_chainmail_legs",
    "xl_ch_chainmail_legs",
})

add_group({
    id = "nested_qt_chainmail_legs",
    name = ccb.content.text("tempered steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_legs",
    "xs_qt_chainmail_legs",
    "xl_qt_chainmail_legs",
})

add_group({
    id = "nested_all_chainmail_legs",
    name = ccb.content.text("steel chain legs"),
    description = ccb.content.text("Recipes related to constructing various sizes and types of chainmail leggings."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "nested_lc_chainmail_legs",
    "nested_mc_chainmail_legs",
    "nested_hc_chainmail_legs",
    "nested_ch_chainmail_legs",
    "nested_qt_chainmail_legs",
})

add_group({
    id = "nested_lc_chainmail_half_legs",
    name = ccb.content.text("mild steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of partial chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_half_legs",
    "xs_lc_chainmail_half_legs",
    "xl_lc_chainmail_half_legs",
})

add_group({
    id = "nested_mc_chainmail_half_legs",
    name = ccb.content.text("medium steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of partial chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_half_legs",
    "xs_mc_chainmail_half_legs",
    "xl_mc_chainmail_half_legs",
})

add_group({
    id = "nested_hc_chainmail_half_legs",
    name = ccb.content.text("high steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of partial chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_half_legs",
    "xs_hc_chainmail_half_legs",
    "xl_hc_chainmail_half_legs",
})

add_group({
    id = "nested_ch_chainmail_half_legs",
    name = ccb.content.text("hardened steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of partial chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_half_legs",
    "xs_ch_chainmail_half_legs",
    "xl_ch_chainmail_half_legs",
})

add_group({
    id = "nested_qt_chainmail_half_legs",
    name = ccb.content.text("tempered steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes of partial chainmail leggings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_half_legs",
    "xs_qt_chainmail_half_legs",
    "xl_qt_chainmail_half_legs",
})

add_group({
    id = "nested_all_chainmail_half_legs",
    name = ccb.content.text("steel chain half-legs"),
    description = ccb.content.text("Recipes related to constructing various sizes and types of partial chainmail leggings."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "nested_lc_chainmail_half_legs",
    "nested_mc_chainmail_half_legs",
    "nested_hc_chainmail_half_legs",
    "nested_ch_chainmail_half_legs",
    "nested_qt_chainmail_half_legs",
})

add_group({
    id = "nested_boots_wsurvivor",
    name = ccb.content.text("handmade winter hazard boots"),
    description = ccb.content.text("Recipes related to constructing various sizes of handmade winterized hazard boots."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "boots_wsurvivor_nofur",
    "xs_boots_wsurvivor_nofur",
    "xl_boots_wsurvivor_nofur",
    "boots_wsurvivor",
    "xs_boots_wsurvivor",
    "xl_boots_wsurvivor",
})

add_group({
    id = "nested_boots_survivor",
    name = ccb.content.text("handmade standard hazard boots"),
    description = ccb.content.text("Recipes related to constructing various sizes of non-winterized handmade hazard boots."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "boots_survivor",
    "boots_xssurvivor",
    "boots_xlsurvivor",
    "boots_survivor_hoof",
})

add_group({
    id = "nested_all_boots_survivor",
    name = ccb.content.text("handmade hazard boots"),
    description = ccb.content.text("Recipes related to constructing various sizes and variations of handmade hazard boots made with acid protection in mind."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    activity_level = 2,
}, {
    "nested_boots_survivor",
    "nested_boots_wsurvivor",
})

add_group({
    id = "nested_lc_chainmail_feet",
    name = ccb.content.text("mild steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail chausses."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_feet",
    "xs_lc_chainmail_feet",
    "xl_lc_chainmail_feet",
})

add_group({
    id = "nested_mc_chainmail_feet",
    name = ccb.content.text("medium steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail chausses."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_feet",
    "xs_mc_chainmail_feet",
    "xl_mc_chainmail_feet",
})

add_group({
    id = "nested_hc_chainmail_feet",
    name = ccb.content.text("high steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail chausses."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_feet",
    "xs_hc_chainmail_feet",
    "xl_hc_chainmail_feet",
})

add_group({
    id = "nested_ch_chainmail_feet",
    name = ccb.content.text("hardened steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail chausses."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_feet",
    "xs_ch_chainmail_feet",
    "xl_ch_chainmail_feet",
})

add_group({
    id = "nested_qt_chainmail_feet",
    name = ccb.content.text("tempered steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail chausses."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_feet",
    "xs_qt_chainmail_feet",
    "xl_qt_chainmail_feet",
})

add_group({
    id = "nested_all_chainmail_feet",
    name = ccb.content.text("steel chain chausses"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of chainmail chausses."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    activity_level = 2,
}, {
    "nested_lc_chainmail_feet",
    "nested_mc_chainmail_feet",
    "nested_hc_chainmail_feet",
    "nested_ch_chainmail_feet",
    "nested_qt_chainmail_feet",
})

add_group({
    id = "nested_sling_ready_explosives",
    name = ccb.content.text("sling-ready explosives"),
    description = ccb.content.text("Recipes related to modifying explosives to be usable in a staff sling."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    activity_level = 4,
}, {
    "sling-ready_molotov",
    "sling-ready_grenade",
    "sling-ready_homemade_grenade",
    "sling-ready_homemade_grenade_2",
    "sling-ready_small_homemade_grenade",
    "sling-ready_small_homemade_grenade_2",
})

add_group({
    id = "nested_bundle_of_items",
    name = ccb.content.text("bundle of items"),
    description = ccb.content.text("Recipes related to tying items into compact bundles for transport or storage."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "seaweed_pile",
    "dry_seaweed_pile",
}, {
    "bundle_rag",
    "bundle_cotton",
    "bundle_leather",
    "bundle_wool",
    "bundle_nylon",
    "bundle_plank",
    "bundle_rebar",
    "bundle_pipe",
    "bundle_copper_pipe",
    "bundle_branch",
    "bundle_branch_long",
    "bundle_javelin",
})

add_group({
    id = "nested_cardboard_boxes",
    name = ccb.content.text("cardboard boxes"),
    description = ccb.content.text("Recipes related to constructing cardboard boxes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "box_small_crafted",
    "box_medium_crafted",
    "box_large_crafted",
    "box_large_reinforced",
    "box_oversize_crafted",
    "box_oversize_reinforced",
})

add_group({
    id = "nested_cardboard_boxes_assembly",
    name = ccb.content.text("assembled cardboard boxes"),
    description = ccb.content.text("Recipes related to assembling cardboard boxes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "box_small_assembly",
    "box_medium_assembly",
    "box_large_assembly",
    "box_oversize_assembly",
})

add_group({
    id = "nested_wooden_boxes",
    name = ccb.content.text("wooden boxes"),
    description = ccb.content.text("Recipes related to constructing wooden boxes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "box_small_wood",
    "box_medium_wood",
    "box_large_wood",
    "box_oversize_wood",
})

add_group({
    id = "nested_metal_boxes",
    name = ccb.content.text("metal boxes"),
    description = ccb.content.text("Recipes related to constructing metal boxes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "box_small_metal",
    "box_medium_metal",
    "box_large_metal",
    "box_oversize_metal",
})

add_group({
    id = "nested_all_boxes",
    name = ccb.content.text("boxes"),
    description = ccb.content.text("Recipes related to constructing boxes."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    activity_level = 2,
}, {
    "nested_cardboard_boxes",
    "nested_cardboard_boxes_assembly",
    "nested_wooden_boxes",
    "nested_metal_boxes",
})

add_group({
    id = "nested_can_food",
    name = ccb.content.text("cans"),
    description = ccb.content.text("Recipes related to creating tin cans for conserving food."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    activity_level = 4,
}, {
    "can_medium",
    "can_food_big",
    "can_food",
})

add_group({
    id = "nested_sheet_patchwork",
    name = ccb.content.text("patchwork fabrics"),
    description = ccb.content.text("Recipes related to sewing together patchwork fabrics."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "sheet_cotton_patchwork",
    "sheet_faux_fur_patchwork",
    "sheet_fur_patchwork",
    "sheet_leather_patchwork",
    "sheet_felt_patchwork",
    "sheet_neoprene_patchwork",
    "sheet_nomex_patchwork",
    "sheet_lycra_patchwork",
    "sheet_nylon_patchwork",
    "sheet_denim_patchwork",
    "sheet_canvas_patchwork",
})

add_group({
    id = "nested_shelled_nuts",
    name = ccb.content.text("shelled nuts"),
    description = ccb.content.text("Recipes related to shelling nuts."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "peanut_shelled",
    "hickory_nut_shelled",
    "walnut_shelled",
    "butternut_shelled",
    "hazelnut_shelled",
    "chestnut_shelled",
    "pecan_shelled",
    "almond_shelled",
    "pistachio_shelled",
})

add_group({
    id = "nested_short_string",
    name = ccb.content.text("short strings"),
    description = ccb.content.text("Recipes related to constructing short strings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "string_6",
    "string_6_spinwheel",
    "string_6_electric_spinwheel",
})

add_group({
    id = "nested_short_rope",
    name = ccb.content.text("short ropes"),
    description = ccb.content.text("Recipes related to constructing short ropes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "rope_6_spinwheel_string",
    "rope_6_electric_spinwheel_string",
    "rope_6_from_filament",
    "rope_6_spinwheel_filament",
    "rope_6_electric_spinwheel_filament",
    "rope_6_from_cloth",
    "rope_6_spinwheel_cloth",
    "rope_6_electric_spinwheel_cloth",
    "rope_6_from_string",
})

add_group({
    id = "nested_long_string",
    name = ccb.content.text("long strings"),
    description = ccb.content.text("Recipes related to constructing long strings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "string_36",
    "string_36_spinwheel",
    "string_36_electric_spinwheel",
})

add_group({
    id = "nested_long_rope",
    name = ccb.content.text("long ropes"),
    description = ccb.content.text("Recipes related to constructing long ropes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "rope_30",
    "rope_30_spinwheel_ropes",
    "rope_30_electric_spinwheel_ropes",
    "rope_30_from_cloth",
    "rope_30_spinwheel_cloth",
    "rope_30_electric_spinwheel_cloth",
    "rope_30_from_string",
    "rope_30_spinwheel_string",
    "rope_30_electric_spinwheel_string",
    "rope_30_from_filament",
    "rope_30_spinwheel_filament",
    "rope_30_electric_spinwheel_filament",
})

add_group({
    id = "nested_short_cordage_piece",
    name = ccb.content.text("short cordage pieces"),
    description = ccb.content.text("Recipes related to constructing short cordage pieces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "cordage_6",
    "cordage_6_spinwheel_plant",
    "cordage_6_electric_spinwheel_plant",
})

add_group({
    id = "nested_long_cordage_piece",
    name = ccb.content.text("long cordage pieces"),
    description = ccb.content.text("Recipes related to constructing long cordage pieces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "cordage_36",
    "cordage_36_spinwheel_plant",
    "cordage_36_from_cordage_6",
    "cordage_36_spinwheel_ropes",
    "cordage_36_electric_spinwheel_ropes",
    "cordage_36_electric_spinwheel_plant",
})

add_group({
    id = "nested_leather_lace",
    name = ccb.content.text("leather laces"),
    description = ccb.content.text("Recipes related to constructing leather laces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "cordage_6_leather",
    "cordage_36_leather",
})

add_group({
    id = "nested_short_cordage_rope",
    name = ccb.content.text("short cordage ropes"),
    description = ccb.content.text("Recipes related to constructing short cordage ropes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "rope_makeshift_6",
    "rope_makeshift_6_spinwheel_cordages",
    "rope_makeshift_6_electric_spinwheel_cordages",
})

add_group({
    id = "nested_long_cordage_rope",
    name = ccb.content.text("long cordage ropes"),
    description = ccb.content.text("Recipes related to constructing long cordage ropes."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "rope_makeshift_30_spinwheel_cordages",
    "rope_makeshift_30_electric_spinwheel_cordages",
    "rope_makeshift_30_from_rope_makeshift_6",
    "rope_makeshift_30_spinwheel_ropes",
    "rope_makeshift_30_electric_spinwheel_ropes",
    "rope_makeshift_30_from_cordage",
})

add_group({
    id = "nested_rope_and_cord",
    name = ccb.content.text("ropes and cordage"),
    description = ccb.content.text("Recipes related to constructing ropes and cordage."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "nested_short_string",
    "nested_short_rope",
    "nested_long_string",
    "nested_long_rope",
    "nested_short_cordage_piece",
    "nested_long_cordage_piece",
    "nested_leather_lace",
    "nested_short_cordage_rope",
    "nested_long_cordage_rope",
})

add_group({
    id = "nested_ammo_flamethrower",
    name = ccb.content.text("flamethrower fuels"),
    description = ccb.content.text("Recipes related to creating flammable liquids suitable for loading into a flamethrower."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    activity_level = 4,
}, {
    "napalm",
    "flamethrower_fuel",
    "gelled_gasoline_from_lye_and_rosin",
    "gelled_gasoline_from_lye_alcohol_tallow",
    "gelled_gasoline_from_lye_alcohol_tallow_substitute",
    "gelled_gasoline_from_alcohol_soap",
    "gelled_gasoline_from_wax",
    "gelled_gasoline_from_blood",
    "gelled_gasoline_from_styrofoam",
})

add_group({
    id = "nested_ammo_chemthrower",
    name = ccb.content.text("sprayable chemicals"),
    description = ccb.content.text("Recipes related to creating chemicals suitable for spraying in combat."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    activity_level = 4,
}, {
    "gas_chloramine",
    "gas_insecticidal",
    "gas_fungicidal",
})

add_group({
    id = "nested_ammo_pebbles",
    name = ccb.content.text("slingshot ammunition"),
    description = ccb.content.text("Recipes related to creating pebbles, pellets, and other small objects for use in slings and slingshots."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    activity_level = 4,
}, {
    "marble",
    "bearing",
    "pebble_clay",
    "pebble",
})

add_group({
    id = "nested_ammo_rockets",
    name = ccb.content.text("homemade rockets"),
    description = ccb.content.text("Recipes related to creating inaccurate, but powerful homemade rockets."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    activity_level = 4,
}, {
    "spiked_rocket",
    "incendiary_hm_rocket",
    "explosive_hm_rocket",
})

add_group({
    id = "nested_adjustable_wrenches",
    name = ccb.content.text("adjustable wrenches"),
    description = ccb.content.text("Recipes related to creating adjustable wrenches."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    activity_level = 6,
}, {
    "wrench",
    "wrench_large",
    "wrench_small",
})

add_group({
    id = "nested_funnels",
    name = ccb.content.text("funnels"),
    description = ccb.content.text("Recipes related to creating funnels for catching rainwater."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    activity_level = 6,
}, {
    "birchbark_funnel",
    "makeshift_funnel",
    "leather_funnel",
    "funnel",
    "metal_funnel",
})

add_group({
    id = "nested_sewing_tools",
    name = ccb.content.text("sewing tools"),
    description = ccb.content.text("Recipes related to creating sewing tools."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    activity_level = 4,
}, {
    "needle_bone",
    "needle_steel",
    "needle_wood",
    "needle_curved",
    "tailors_kit",
    "sewing_kit",
    "awl_bone",
    "awl_steel",
    "awl_steel_using_file",
})

add_group({
    id = "nested_belts",
    name = ccb.content.text("belts"),
    description = ccb.content.text("Recipes related to creating items that help keep your pants around your waist."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    activity_level = 4,
}, {
    "survivor_belt_notools",
    "webbing_belt",
    "fireman_belt",
    "police_belt",
    "tool_belt",
    "santa_belt",
    "leather_belt",
})

add_group({
    id = "nested_every_helm_close",
    name = ccb.content.text("steel close helms"),
    description = ccb.content.text("Recipes related to constructing different thicknesses of steel close helms from different qualities of steel."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 4,
}, {
    "nested_lighthelm_close",
    "nested_helm_close",
    "nested_heavyhelm_close",
})

add_group({
    id = "nested_lighthelm_close",
    name = ccb.content.text("light close helms"),
    description = ccb.content.text("Recipes related to creating light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_lighthelm_close",
    "nested_mc_lighthelm_close",
    "nested_hc_lighthelm_close",
    "nested_ch_lighthelm_close",
    "nested_qt_lighthelm_close",
})

add_group({
    id = "nested_lc_lighthelm_close",
    name = ccb.content.text("mild steel light close helms"),
    description = ccb.content.text("Recipes related to creating mild steel light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_lighthelm_close",
    "xl_lc_lighthelm_close",
})

add_group({
    id = "nested_mc_lighthelm_close",
    name = ccb.content.text("medium steel light close helms"),
    description = ccb.content.text("Recipes related to creating light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_lighthelm_close",
    "xl_mc_lighthelm_close",
})

add_group({
    id = "nested_hc_lighthelm_close",
    name = ccb.content.text("high steel light close helms"),
    description = ccb.content.text("Recipes related to creating light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_lighthelm_close",
    "xl_hc_lighthelm_close",
})

add_group({
    id = "nested_ch_lighthelm_close",
    name = ccb.content.text("hardened steel light close helms"),
    description = ccb.content.text("Recipes related to creating light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_lighthelm_close",
    "xl_ch_lighthelm_close",
})

add_group({
    id = "nested_qt_lighthelm_close",
    name = ccb.content.text("tempered steel light close helms"),
    description = ccb.content.text("Recipes related to creating light close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_lighthelm_close",
    "xl_qt_lighthelm_close",
})

add_group({
    id = "nested_helm_close",
    name = ccb.content.text("close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_helm_close",
    "nested_mc_helm_close",
    "nested_hc_helm_close",
    "nested_ch_helm_close",
    "nested_qt_helm_close",
})

add_group({
    id = "nested_lc_helm_close",
    name = ccb.content.text("mild steel close helms"),
    description = ccb.content.text("Recipes related to creating mild steel close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_helm_close",
    "xl_lc_helm_close",
})

add_group({
    id = "nested_mc_helm_close",
    name = ccb.content.text("medium steel close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_helm_close",
    "xl_mc_helm_close",
})

add_group({
    id = "nested_hc_helm_close",
    name = ccb.content.text("high steel close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_helm_close",
    "xl_hc_helm_close",
})

add_group({
    id = "nested_ch_helm_close",
    name = ccb.content.text("hardened steel close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_helm_close",
    "xl_ch_helm_close",
})

add_group({
    id = "nested_qt_helm_close",
    name = ccb.content.text("tempered steel close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_helm_close",
    "xl_qt_helm_close",
})

add_group({
    id = "nested_heavyhelm_close",
    name = ccb.content.text("heavy close helms"),
    description = ccb.content.text("Recipes related to creating heavy close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "nested_lc_heavyhelm_close",
    "nested_mc_heavyhelm_close",
    "nested_hc_heavyhelm_close",
    "nested_ch_heavyhelm_close",
    "nested_qt_heavyhelm_close",
})

add_group({
    id = "nested_lc_heavyhelm_close",
    name = ccb.content.text("mild steel heavy close helms"),
    description = ccb.content.text("Recipes related to creating mild steel close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_heavyhelm_close",
    "xl_lc_heavyhelm_close",
})

add_group({
    id = "nested_mc_heavyhelm_close",
    name = ccb.content.text("medium steel heavy close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "mc_heavyhelm_close",
    "xl_mc_heavyhelm_close",
})

add_group({
    id = "nested_hc_heavyhelm_close",
    name = ccb.content.text("high steel heavy close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "hc_heavyhelm_close",
    "xl_hc_heavyhelm_close",
})

add_group({
    id = "nested_ch_heavyhelm_close",
    name = ccb.content.text("hardened steel heavy close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "ch_heavyhelm_close",
    "xl_ch_heavyhelm_close",
})

add_group({
    id = "nested_qt_heavyhelm_close",
    name = ccb.content.text("tempered steel heavy close helms"),
    description = ccb.content.text("Recipes related to creating close helms to protect the head."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "qt_heavyhelm_close",
    "xl_qt_heavyhelm_close",
})

add_group({
    id = "nested_primers",
    name = ccb.content.text("firearm primers"),
    description = ccb.content.text("Recipes related to constructing primers, the impact explosives used to initiate the combustion of gunpowder to launch bullets from firearms."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    activity_level = 2,
}, {
    "lgpistol_primer",
    "lgrifle_primer",
    "shotgun_primer",
    "smpistol_primer",
    "smrifle_primer",
})

add_group({
    id = "nested_casings",
    name = ccb.content.text("ammunition casings"),
    description = ccb.content.text("Recipes related to constructing casings for ammunition."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    activity_level = 2,
}, {
    "unprimed_123ln_casing",
    "unprimed_270win_casing",
    "unprimed_300blk_casing",
    "unprimed_357sig_casing",
    "unprimed_380_casing",
    "unprimed_38_casing",
    "unprimed_40_casing",
    "unprimed_45_casing",
    "unprimed_45colt_casing",
    "unprimed_50ae_casing",
})

add_group({
    id = "nested_gun_mounts",
    name = ccb.content.text("attachment mounts"),
    description = ccb.content.text("Recipes related to making mounts for attachments on older or makeshift guns."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    activity_level = 4,
}, {
    "rail_bayonet_lug",
})

add_group({
    id = "nested_bionic_practice",
    name = ccb.content.text("bionic weaponry"),
    description = ccb.content.text("Recipes for practice with bionic weaponry for combat."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_cutting_beg_bionics",
    "prac_cutting_int_bionics",
    "prac_cutting_beg_bionic_sword",
    "prac_cutting_int_bionic_sword",
})

add_group({
    id = "nested_axes_practice",
    name = ccb.content.text("axes"),
    description = ccb.content.text("Recipes for combat practice with axes."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_cutting_beg_great_axe",
    "prac_cutting_int_great_axe",
    "prac_cutting_beg_hand_axe",
    "prac_cutting_int_hand_axe",
})

add_group({
    id = "nested_cutting_swords_practice",
    name = ccb.content.text("cutting swords"),
    description = ccb.content.text("Recipes for combat practice of slashing swords of all sizes."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_cutting_beg_short_sword",
    "prac_cutting_int_short_sword",
    "prac_cutting_beg_med_sword",
    "prac_cutting_int_med_sword",
    "prac_cutting_beg_long_sword",
    "prac_cutting_int_long_sword",
    "prac_cutting_beg_great_sword",
    "prac_cutting_int_great_sword",
})

add_group({
    id = "nested_stabbing_swords_practice",
    name = ccb.content.text("stabbing swords"),
    description = ccb.content.text("Recipes for combat practice of thrusting swords, which require a different training from just slashing with your sword."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_stabbing_beg_fencing",
    "prac_stabbing_int_fencing",
    "prac_stabbing_beg_thrust",
    "prac_stabbing_int_thrust",
})

add_group({
    id = "nested_spears_polearms_practice",
    name = ccb.content.text("spears and polearms"),
    description = ccb.content.text("Recipes for combat practice with long pointed objects, like spears and polearms."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_stabbing_beg_spear",
    "prac_stabbing_int_spear",
    "prac_stabbing_beg_polearm",
    "prac_stabbing_int_polearm",
})

add_group({
    id = "nested_knives_shivs_practice",
    name = ccb.content.text("knives and shivs"),
    description = ccb.content.text("Recipes for combat practice with small pointed objects, like knives and shivs."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_stabbing_beg_knife",
    "prac_stabbing_int_knife",
    "prac_stabbing_beg_shiv",
    "prac_stabbing_int_shiv",
})

add_group({
    id = "nested_batons_and_staffs_practice",
    name = ccb.content.text("batons and quarterstaves"),
    description = ccb.content.text("Recipes for combat practice with thin, stick-like bludgeons like batons and quarterstaves."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_bashing_beg_baton",
    "prac_bashing_int_baton",
    "prac_bashing_beg_staff",
    "prac_bashing_int_staff",
})

add_group({
    id = "nested_maces_and_hammers_practice",
    name = ccb.content.text("maces and great hammers"),
    description = ccb.content.text("Recipes for combat practice with weighty, smashing bludgeons, like maces and great hammers."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_bashing_beg_mace",
    "prac_bashing_int_mace",
    "prac_bashing_beg_great_hammer",
    "prac_bashing_int_great_hammer",
})

add_group({
    id = "nested_firearm_cqc_practice",
    name = ccb.content.text("firearms CQC"),
    description = ccb.content.text("Recipes for CQC practice with firearms."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    activity_level = 4,
}, {
    "prac_bashing_beg_rifle",
    "prac_bashing_int_rifle",
    "prac_bashing_beg_pistol",
    "prac_bashing_int_pistol",
})

add_group({
    id = "nested_lathe_practice",
    name = ccb.content.text("lathe turning"),
    description = ccb.content.text("Recipes for practicing with a manual lathe/mill."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    activity_level = 1,
}, {
    "prac_machining_lathe_aluminum",
    "prac_machining_lathe_steel",
    "prac_machining_mill_aluminum",
    "prac_machining_mill_steel",
})

add_group({
    id = "nested_arming_sword",
    name = ccb.content.text("arming swords"),
    description = ccb.content.text("Recipes for making arming swords."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_arming_sword",
    "mc_arming_sword",
    "hc_arming_sword",
    "ch_arming_sword",
    "qt_arming_sword",
})

add_group({
    id = "nested_broadsword",
    name = ccb.content.text("broadswords"),
    description = ccb.content.text("Recipes for making broadswords."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_broadsword",
    "broadsword",
    "hc_broadsword",
    "ch_broadsword",
    "qt_broadsword",
})

add_group({
    id = "nested_cavalry_sabre",
    name = ccb.content.text("cavalry sabers"),
    description = ccb.content.text("Recipes for making cavalry sabers."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_cavalry_sabre",
    "mc_cavalry_sabre",
    "hc_cavalry_sabre",
    "ch_cavalry_sabre",
    "qt_cavalry_sabre",
})

add_group({
    id = "nested_cutlass",
    name = ccb.content.text("cutlasses"),
    description = ccb.content.text("Recipes for making cutlasses."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "cutlass",
    "lc_cutlass",
    "mc_cutlass",
    "hc_cutlass",
    "ch_cutlass",
    "qt_cutlass",
})

add_group({
    id = "nested_estoc",
    name = ccb.content.text("estocs"),
    description = ccb.content.text("Recipes for making estocs."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    activity_level = 4,
}, {
    "lc_estoc",
    "mc_estoc",
    "hc_estoc",
    "ch_estoc",
    "qt_estoc",
})

add_group({
    id = "nested_falx",
    name = ccb.content.text("falxes"),
    description = ccb.content.text("Recipes for making falxes."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_falx",
    "mc_falx",
    "hc_falx",
    "ch_falx",
    "qt_falx",
})

add_group({
    id = "nested_jian",
    name = ccb.content.text("jian"),
    description = ccb.content.text("Recipes for making jian."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_jian",
    "mc_jian",
    "hc_jian",
    "ch_jian",
    "qt_jian",
})

add_group({
    id = "nested_katana",
    name = ccb.content.text("katana"),
    description = ccb.content.text("Recipes for making katana."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_katana",
    "mc_katana",
    "hc_katana",
    "ch_katana",
    "qt_katana",
})

add_group({
    id = "nested_kriegsmesser",
    name = ccb.content.text("kriegsmessers"),
    description = ccb.content.text("Recipes for making kriegsmessers."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_kriegsmesser",
    "mc_kriegsmesser",
    "hc_kriegsmesser",
    "ch_kriegsmesser",
    "qt_kriegsmesser",
})

add_group({
    id = "nested_longsword",
    name = ccb.content.text("longswords"),
    description = ccb.content.text("Recipes for making longswords."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_longsword",
    "mc_longsword",
    "hc_longsword",
    "ch_longsword",
    "qt_longsword",
})

add_group({
    id = "nested_nodachi",
    name = ccb.content.text("nodachi"),
    description = ccb.content.text("Recipes for making nodachi."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_nodachi",
    "mc_nodachi",
    "hc_nodachi",
    "ch_nodachi",
    "qt_nodachi",
})

add_group({
    id = "nested_rapier",
    name = ccb.content.text("rapiers"),
    description = ccb.content.text("Recipes for making rapiers."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    activity_level = 4,
}, {
    "lc_rapier",
    "rapier",
    "hc_rapier",
    "ch_rapier",
    "qt_rapier",
})

add_group({
    id = "nested_scimitar",
    name = ccb.content.text("shamshirs"),
    description = ccb.content.text("Recipes for making shamshirs."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_scimitar",
    "mc_scimitar",
    "hc_scimitar",
    "ch_scimitar",
    "qt_scimitar",
})

add_group({
    id = "nested_talwar",
    name = ccb.content.text("talwars"),
    description = ccb.content.text("Recipes for making talwars."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_talwar",
    "mc_talwar",
    "hc_talwar",
    "ch_talwar",
    "qt_talwar",
})

add_group({
    id = "nested_kilij",
    name = ccb.content.text("kilijes"),
    description = ccb.content.text("Recipes for making kilijes."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_kilij",
    "mc_kilij",
    "hc_kilij",
    "ch_kilij",
    "qt_kilij",
})

add_group({
    id = "nested_rambo",
    name = ccb.content.text("survival knives"),
    description = ccb.content.text("Recipes for making survival knives."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    activity_level = 4,
}, {
    "lc_knife_rambo",
    "knife_rambo",
    "hc_knife_rambo",
    "ch_knife_rambo",
    "qt_knife_rambo",
})

add_group({
    id = "nested_trench",
    name = ccb.content.text("trench knives"),
    description = ccb.content.text("Recipes for making trench knives."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    activity_level = 4,
}, {
    "lc_knife_trench",
    "knife_trench",
    "hc_knife_trench",
    "ch_knife_trench",
    "qt_knife_trench",
})

add_group({
    id = "nested_kukri",
    name = ccb.content.text("kukris"),
    description = ccb.content.text("Recipes for making kukris."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "kukri",
    "lc_kukri",
    "hc_kukri",
    "ch_kukri",
    "qt_kukri",
})

add_group({
    id = "nested_wakizashi",
    name = ccb.content.text("wakizashi"),
    description = ccb.content.text("Recipes for making wakizashi."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_wakizashi",
    "mc_wakizashi",
    "hc_wakizashi",
    "ch_wakizashi",
    "qt_wakizashi",
})

add_group({
    id = "nested_zweihander",
    name = ccb.content.text("zweihänders"),
    description = ccb.content.text("Recipes for making zweihänders."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "lc_zweihander",
    "mc_zweihander",
    "hc_zweihander",
    "ch_zweihander",
    "qt_zweihander",
})

add_group({
    id = "nested_battleaxe",
    name = ccb.content.text("battle axes"),
    description = ccb.content.text("Recipes for making battle axes."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 4,
}, {
    "battleaxe",
    "lc_battleaxe",
    "mc_battleaxe",
    "hc_battleaxe",
    "ch_battleaxe",
    "qt_battleaxe",
    "ax_sheets_welded",
})

add_group({
    id = "nested_aztec_sword",
    name = ccb.content.text("macuahuitls"),
    description = ccb.content.text("Recipes for making macuahuitls."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 4,
}, {
    "glass_macuahuitl",
    "teeth_macuahuitl",
    "aztec_sword_scrap",
    "aztec_sword_stone",
    "nested_steel_aztec_sword",
})

add_group({
    id = "nested_steel_aztec_sword",
    name = ccb.content.text("steel bladed macuahuitls"),
    description = ccb.content.text("Recipes related to constructing different qualities of steel bladed macuahuitls."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_aztec_sword",
    "mc_aztec_sword",
    "hc_aztec_sword",
    "ch_aztec_sword",
    "qt_aztec_sword",
})

add_group({
    id = "nested_aztec_spear",
    name = ccb.content.text("tepoztopilis"),
    description = ccb.content.text("Recipes for making tepoztopilis."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 4,
}, {
    "aztec_spear_glass",
    "aztec_spear_scrap",
    "aztec_spear_stone",
    "nested_steel_aztec_spear",
})

add_group({
    id = "nested_steel_aztec_spear",
    name = ccb.content.text("steel bladed tepoztopilis"),
    description = ccb.content.text("Recipes related to constructing different qualities of steel bladed tepoztopilis."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "lc_aztec_spear",
    "mc_aztec_spear",
    "hc_aztec_spear",
    "ch_aztec_spear",
    "qt_aztec_spear",
})

add_group({
    id = "nested_atlatl_spear",
    name = ccb.content.text("atlatl spears"),
    description = ccb.content.text("Recipes for making atlatl spears."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    activity_level = 4,
}, {
    "wood_atlatl_spear",
    "bronze_atlatl_spear",
    "steel_atlatl_spear",
})

add_group({
    id = "nested_methanol_tank",
    name = ccb.content.text("methanol fuel cartridges"),
    description = ccb.content.text("Recipes related to refilling methanol fuel cartridges."),
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    activity_level = 2,
}, {
    "5l_methanol_tank",
    "10l_methanol_tank",
    "28l_methanol_tank",
    "60l_methanol_tank",
})

add_group({
    id = "nested_aluminum_scrap",
    name = ccb.content.text("scrap aluminum"),
    description = ccb.content.text("Recipes related to creating scrap aluminum."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 1,
}, {
    "scrap_aluminum_melted_foil",
    "scrap_aluminum_assorted_scrap",
})

add_group({
    id = "nested_aketon_canvas",
    name = ccb.content.text("canvas aketons"),
    description = ccb.content.text("Recipes related to canvas cloth armor meant to be worn under other armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "aketon_canvas",
    "xl_aketon_canvas",
    "xs_aketon_canvas",
    "aketon_canvas_vest",
    "xl_aketon_canvas_vest",
    "xs_aketon_canvas_vest",
})

add_group({
    id = "nested_gambeson_canvas",
    name = ccb.content.text("canvas gambesons"),
    description = ccb.content.text("Recipes related to thicker canvas cloth armor meant to be worn standalone."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "gambeson_canvas",
    "xl_gambeson_canvas",
    "xs_gambeson_canvas",
    "gambeson_canvas_thinsleeved",
    "xl_gambeson_canvas_thinsleeved",
    "xs_gambeson_canvas_thinsleeved",
    "gambeson_canvas_vest",
    "xl_gambeson_canvas_vest",
    "xs_gambeson_canvas_vest",
})

add_group({
    id = "nested_armingpants_canvas",
    name = ccb.content.text("canvas arming pants"),
    description = ccb.content.text("Recipes related to armored cloth pants made of canvas."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "aketon_pants_canvas",
    "xl_aketon_pants_canvas",
    "xs_aketon_pants_canvas",
    "gambeson_pants_canvas",
    "xl_gambeson_pants_canvas",
    "xs_gambeson_pants_canvas",
})

add_group({
    id = "nested_arminggloves_canvas",
    name = ccb.content.text("canvas arming gloves"),
    description = ccb.content.text("Recipes related to armored cloth gloves made of canvas."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "aketon_gloves_canvas",
    "xl_aketon_gloves_canvas",
    "xs_aketon_gloves_canvas",
    "gambeson_gloves_canvas",
    "xl_gambeson_gloves_canvas",
    "xs_gambeson_gloves_canvas",
})

add_group({
    id = "nested_hoods_canvas",
    name = ccb.content.text("canvas coifs"),
    description = ccb.content.text("Recipes related to armored cloth hoods made of canvas."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "aketon_hood_canvas",
    "xl_aketon_hood_canvas",
    "xs_aketon_hood_canvas",
})

add_group({
    id = "nested_aketon_nylon",
    name = ccb.content.text("nylon aketons"),
    description = ccb.content.text("Recipes related to synthetic fabric armor meant to be worn under other armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "aketon_nylon",
    "xl_aketon_nylon",
    "xs_aketon_nylon",
    "aketon_nylon_vest",
    "xl_aketon_nylon_vest",
    "xs_aketon_nylon_vest",
})

add_group({
    id = "nested_gambeson_nylon",
    name = ccb.content.text("nylon gambesons"),
    description = ccb.content.text("Recipes related to thicker synthetic fabric armor meant to be worn standalone."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "gambeson_nylon",
    "xl_gambeson_nylon",
    "xs_gambeson_nylon",
    "gambeson_nylon_thinsleeved",
    "xl_gambeson_nylon_thinsleeved",
    "xs_gambeson_nylon_thinsleeved",
    "gambeson_nylon_vest",
    "xl_gambeson_nylon_vest",
    "xs_gambeson_nylon_vest",
})

add_group({
    id = "nested_armingpants_nylon",
    name = ccb.content.text("nylon arming pants"),
    description = ccb.content.text("Recipes related to armored cloth pants made of synthetic fabric."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "aketon_pants_nylon",
    "xl_aketon_pants_nylon",
    "xs_aketon_pants_nylon",
    "gambeson_pants_nylon",
    "xl_gambeson_pants_nylon",
    "xs_gambeson_pants_nylon",
})

add_group({
    id = "nested_arminggloves_nylon",
    name = ccb.content.text("nylon arming gloves"),
    description = ccb.content.text("Recipes related to armored cloth gloves made of synthetic fabric."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "aketon_gloves_nylon",
    "xl_aketon_gloves_nylon",
    "xs_aketon_gloves_nylon",
    "gambeson_gloves_nylon",
    "xl_gambeson_gloves_nylon",
    "xs_gambeson_gloves_nylon",
})

add_group({
    id = "nested_hoods_nylon",
    name = ccb.content.text("nylon coifs"),
    description = ccb.content.text("Recipes related to armored cloth hoods made of synthetic fabric."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "aketon_hood_nylon",
    "xl_aketon_hood_nylon",
    "xs_aketon_hood_nylon",
})

add_group({
    id = "nested_aketon_wool",
    name = ccb.content.text("wool aketons"),
    description = ccb.content.text("Recipes related to wool armor meant to be worn under other armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "aketon_wool",
    "xl_aketon_wool",
    "xs_aketon_wool",
    "aketon_wool_vest",
    "xl_aketon_wool_vest",
    "xs_aketon_wool_vest",
})

add_group({
    id = "nested_gambeson_wool",
    name = ccb.content.text("wool gambesons"),
    description = ccb.content.text("Recipes related to thicker wool armor meant to be worn standalone."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "gambeson_wool",
    "xl_gambeson_wool",
    "xs_gambeson_wool",
    "gambeson_wool_thinsleeved",
    "xl_gambeson_wool_thinsleeved",
    "xs_gambeson_wool_thinsleeved",
    "gambeson_wool_vest",
    "xl_gambeson_wool_vest",
    "xs_gambeson_wool_vest",
})

add_group({
    id = "nested_armingpants_wool",
    name = ccb.content.text("wool arming pants"),
    description = ccb.content.text("Recipes related to armored cloth pants made of wool."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "aketon_pants_wool",
    "xl_aketon_pants_wool",
    "xs_aketon_pants_wool",
    "gambeson_pants_wool",
    "xl_gambeson_pants_wool",
    "xs_gambeson_pants_wool",
})

add_group({
    id = "nested_arminggloves_wool",
    name = ccb.content.text("wool arming gloves"),
    description = ccb.content.text("Recipes related to armored cloth gloves made of wool."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "aketon_gloves_wool",
    "xl_aketon_gloves_wool",
    "xs_aketon_gloves_wool",
    "gambeson_gloves_wool",
    "xl_gambeson_gloves_wool",
    "xs_gambeson_gloves_wool",
})

add_group({
    id = "nested_hoods_wool",
    name = ccb.content.text("wool coifs"),
    description = ccb.content.text("Recipes related to armored cloth hoods made of wool."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "aketon_hood_wool",
    "xl_aketon_hood_wool",
    "xs_aketon_hood_wool",
})

add_group({
    id = "nested_pemmican",
    name = ccb.content.text("pemmican"),
    description = ccb.content.text("Recipes related to making pemmican."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "pemmican",
    "pemmican_veggy",
    "pemmican_meat",
})

add_group({
    id = "nested_chairs",
    name = ccb.content.text("chairs"),
    description = ccb.content.text("Recipes related to constructing chairs."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    activity_level = 4,
}, {
    "deck_chair",
    "chair_wood",
    "chair_wood_black",
    "chair_wood_white",
})

add_group({
    id = "nested_stools",
    name = ccb.content.text("stools"),
    description = ccb.content.text("Recipes related to constructing stools."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    activity_level = 4,
}, {
    "stool_wood",
    "stool_log",
})

add_group({
    id = "nested_planks_normal",
    name = ccb.content.text("planks"),
    description = ccb.content.text("Recipes related to constructing 4 ft planks."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "2x4_from long planks by hand",
    "2x4_from long planks with powertools",
    "2x4_from logs with powertools",
})

add_group({
    id = "nested_planks_short",
    name = ccb.content.text("short planks"),
    description = ccb.content.text("Recipes related to constructing 2 ft planks."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "plank_short_from long planks by hand",
    "plank_short_from long planks with powertools",
    "plank_short_from planks by hand",
    "plank_short_from planks with powertools",
})

add_group({
    id = "nested_posts_normal",
    name = ccb.content.text("wooden posts"),
    description = ccb.content.text("Recipes related to constructing 4 ft wooden posts."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "wooden_post_from long posts by hand",
    "wooden_post_from long posts with powertools",
})

add_group({
    id = "nested_posts_short",
    name = ccb.content.text("short wooden posts"),
    description = ccb.content.text("Recipes related to constructing 2 ft wooden posts."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 4,
}, {
    "wooden_post_short_from long posts by hand",
    "wooden_post_short_from long posts with powertools",
    "wooden_post_short_from posts by hand",
    "wooden_post_short_from posts with powertools",
})

add_group({
    id = "nested_posts_all",
    name = ccb.content.text("wooden posts"),
    description = ccb.content.text("Recipes related to constructing all wooden posts."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 4,
}, {
    "nested_posts_short",
    "nested_posts_normal",
    "wooden_post_long",
})

add_group({
    id = "nested_bots",
    name = ccb.content.text("inactive bots"),
    description = ccb.content.text("Recipes related to constructing deployable robots."),
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    activity_level = 2,
}, {
    "bot_crows_m240",
    "bot_rifleturret",
    "bot_c4_hack",
    "bot_hazmatbot",
    "bot_EMP_hack",
    "bot_flashbang_hack",
    "bot_grenade_hack",
    "bot_grocerybot",
    "bot_science_bot",
    "bot_talon_m202a1",
    "bot_antimateriel",
    "bot_dispatch",
    "bot_dispatch_military",
    "bot_turret_searchlight",
    "bot_nursebot",
    "bot_skitterbot",
    "bot_secubot",
    "bot_tazer_hack",
    "bot_gasbomb_hack",
    "bot_turret",
})

add_group({
    id = "nested_planks_all",
    name = ccb.content.text("planks"),
    description = ccb.content.text("Recipes related to constructing all planks."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 4,
}, {
    "nested_planks_short",
    "nested_planks_normal",
    "plank_long",
})

add_group({
    id = "nested_lc_brigandine_arms",
    name = ccb.content.text("mild steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armguard_lc_brigandine",
    "armguard_lc_brigandine_xs",
    "xl_armguard_lc_brigandine",
})

add_group({
    id = "nested_mc_brigandine_arms",
    name = ccb.content.text("medium steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armguard_mc_brigandine",
    "armguard_mc_brigandine_xs",
    "xl_armguard_mc_brigandine",
})

add_group({
    id = "nested_hc_brigandine_arms",
    name = ccb.content.text("high steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armguard_hc_brigandine",
    "armguard_hc_brigandine_xs",
    "xl_armguard_hc_brigandine",
})

add_group({
    id = "nested_ch_brigandine_arms",
    name = ccb.content.text("hardened steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armguard_ch_brigandine",
    "armguard_ch_brigandine_xs",
    "xl_armguard_ch_brigandine",
})

add_group({
    id = "nested_qt_brigandine_arms",
    name = ccb.content.text("tempered steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armguard_qt_brigandine",
    "armguard_qt_brigandine_xs",
    "xl_armguard_qt_brigandine",
})

add_group({
    id = "nested_all_brigandine_arms",
    name = ccb.content.text("steel splint arm guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint arm guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "nested_lc_brigandine_arms",
    "nested_mc_brigandine_arms",
    "nested_hc_brigandine_arms",
    "nested_ch_brigandine_arms",
    "nested_qt_brigandine_arms",
})

add_group({
    id = "nested_lc_elbow_guards",
    name = ccb.content.text("mild steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_elbow_guards",
    "lc_elbow_guards_xs",
    "xl_lc_elbow_guards",
})

add_group({
    id = "nested_mc_elbow_guards",
    name = ccb.content.text("medium steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_elbow_guards",
    "mc_elbow_guards_xs",
    "xl_mc_elbow_guards",
})

add_group({
    id = "nested_hc_elbow_guards",
    name = ccb.content.text("high steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_elbow_guards",
    "hc_elbow_guards_xs",
    "xl_hc_elbow_guards",
})

add_group({
    id = "nested_ch_elbow_guards",
    name = ccb.content.text("hardened steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_elbow_guards",
    "ch_elbow_guards_xs",
    "xl_ch_elbow_guards",
})

add_group({
    id = "nested_qt_elbow_guards",
    name = ccb.content.text("tempered steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_elbow_guards",
    "qt_elbow_guards_xs",
    "xl_qt_elbow_guards",
})

add_group({
    id = "nested_all_elbow_guards",
    name = ccb.content.text("steel elbow guards"),
    description = ccb.content.text("Recipes related to forging various sizes of elbow guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "nested_lc_elbow_guards",
    "nested_mc_elbow_guards",
    "nested_hc_elbow_guards",
    "nested_ch_elbow_guards",
    "nested_qt_elbow_guards",
})

add_group({
    id = "nested_lc_vambrace_brigandine",
    name = ccb.content.text("mild steel splint vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_vambrace_brigandine",
    "xl_lc_vambrace_brigandine",
    "xs_lc_vambrace_brigandine",
})

add_group({
    id = "nested_mc_vambrace_brigandine",
    name = ccb.content.text("medium steel splint mail vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_vambrace_brigandine",
    "xl_mc_vambrace_brigandine",
    "xs_mc_vambrace_brigandine",
})

add_group({
    id = "nested_hc_vambrace_brigandine",
    name = ccb.content.text("high steel splint mail vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_vambrace_brigandine",
    "xl_hc_vambrace_brigandine",
    "xs_hc_vambrace_brigandine",
})

add_group({
    id = "nested_ch_vambrace_brigandine",
    name = ccb.content.text("hardened steel splint mail vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_vambrace_brigandine",
    "xl_ch_vambrace_brigandine",
    "xs_ch_vambrace_brigandine",
})

add_group({
    id = "nested_qt_vambrace_brigandine",
    name = ccb.content.text("tempered steel splint mail vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_vambrace_brigandine",
    "xl_qt_vambrace_brigandine",
    "xs_qt_vambrace_brigandine",
})

add_group({
    id = "nested_all_vambrace_brigandine",
    name = ccb.content.text("splint mail vambraces"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail vambraces."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "nested_lc_vambrace_brigandine",
    "nested_mc_vambrace_brigandine",
    "nested_hc_vambrace_brigandine",
    "nested_ch_vambrace_brigandine",
    "nested_qt_vambrace_brigandine",
})

add_group({
    id = "nested_lc_greaves_brigandine",
    name = ccb.content.text("mild steel splint greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint greaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_greaves_brigandine",
    "xl_lc_greaves_brigandine",
    "xs_lc_greaves_brigandine",
})

add_group({
    id = "nested_mc_greaves_brigandine",
    name = ccb.content.text("medium steel splint greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint greaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_greaves_brigandine",
    "xl_mc_greaves_brigandine",
    "xs_mc_greaves_brigandine",
})

add_group({
    id = "nested_hc_greaves_brigandine",
    name = ccb.content.text("high steel splint greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint greaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_greaves_brigandine",
    "xl_hc_greaves_brigandine",
    "xs_hc_greaves_brigandine",
})

add_group({
    id = "nested_ch_greaves_brigandine",
    name = ccb.content.text("hardened steel splint greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint greaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_greaves_brigandine",
    "xl_ch_greaves_brigandine",
    "xs_ch_greaves_brigandine",
})

add_group({
    id = "nested_qt_greaves_brigandine",
    name = ccb.content.text("tempered steel splint greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint greaves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_greaves_brigandine",
    "xl_qt_greaves_brigandine",
    "xs_qt_greaves_brigandine",
})

add_group({
    id = "nested_all_greaves_brigandine",
    name = ccb.content.text("splint mail greaves"),
    description = ccb.content.text("Recipes related to forging various sizes of splint mail greaves."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "nested_lc_greaves_brigandine",
    "nested_mc_greaves_brigandine",
    "nested_hc_greaves_brigandine",
    "nested_ch_greaves_brigandine",
    "nested_qt_greaves_brigandine",
})

add_group({
    id = "nested_lc_brigandine_legs",
    name = ccb.content.text("mild steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "legguard_lc_brigandine",
    "legguard_lc_brigandine_xs",
    "xl_legguard_lc_brigandine",
})

add_group({
    id = "nested_mc_brigandine_legs",
    name = ccb.content.text("medium steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "legguard_mc_brigandine",
    "legguard_mc_brigandine_xs",
    "xl_legguard_mc_brigandine",
})

add_group({
    id = "nested_hc_brigandine_legs",
    name = ccb.content.text("high steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "legguard_hc_brigandine",
    "legguard_hc_brigandine_xs",
    "xl_legguard_hc_brigandine",
})

add_group({
    id = "nested_ch_brigandine_legs",
    name = ccb.content.text("hardened steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "legguard_ch_brigandine",
    "legguard_ch_brigandine_xs",
    "xl_legguard_ch_brigandine",
})

add_group({
    id = "nested_qt_brigandine_legs",
    name = ccb.content.text("tempered steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "legguard_qt_brigandine",
    "legguard_qt_brigandine_xs",
    "xl_legguard_qt_brigandine",
})

add_group({
    id = "nested_all_brigandine_legs",
    name = ccb.content.text("steel splint leg guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of splint leg guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "nested_lc_brigandine_legs",
    "nested_mc_brigandine_legs",
    "nested_hc_brigandine_legs",
    "nested_ch_brigandine_legs",
    "nested_qt_brigandine_legs",
})

add_group({
    id = "nested_lc_knee_guards",
    name = ccb.content.text("mild steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_knee_guards",
    "lc_knee_guards_xs",
    "xl_lc_knee_guards",
})

add_group({
    id = "nested_mc_knee_guards",
    name = ccb.content.text("medium steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_knee_guards",
    "mc_knee_guards_xs",
    "xl_mc_knee_guards",
})

add_group({
    id = "nested_hc_knee_guards",
    name = ccb.content.text("high steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_knee_guards",
    "hc_knee_guards_xs",
    "xl_hc_knee_guards",
})

add_group({
    id = "nested_ch_knee_guards",
    name = ccb.content.text("hardened steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_knee_guards",
    "ch_knee_guards_xs",
    "xl_ch_knee_guards",
})

add_group({
    id = "nested_qt_knee_guards",
    name = ccb.content.text("tempered steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_knee_guards",
    "qt_knee_guards_xs",
    "xl_qt_knee_guards",
})

add_group({
    id = "nested_all_knee_guards",
    name = ccb.content.text("steel knee guards"),
    description = ccb.content.text("Recipes related to forging various sizes of knee guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "nested_lc_knee_guards",
    "nested_mc_knee_guards",
    "nested_hc_knee_guards",
    "nested_ch_knee_guards",
    "nested_qt_knee_guards",
})

add_group({
    id = "nested_lc_brigandine_vest",
    name = ccb.content.text("mild steel brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_lc_brigandine",
    "armor_lc_brigandine_xs",
    "xl_armor_lc_brigandine",
})

add_group({
    id = "nested_mc_brigandine_vest",
    name = ccb.content.text("medium steel brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_mc_brigandine",
    "armor_mc_brigandine_xs",
    "xl_armor_mc_brigandine",
})

add_group({
    id = "nested_hc_brigandine_vest",
    name = ccb.content.text("high steel brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_hc_brigandine",
    "armor_hc_brigandine_xs",
    "xl_armor_hc_brigandine",
})

add_group({
    id = "nested_ch_brigandine_vest",
    name = ccb.content.text("hardened steel brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_ch_brigandine",
    "armor_ch_brigandine_xs",
    "xl_armor_ch_brigandine",
})

add_group({
    id = "nested_qt_brigandine_vest",
    name = ccb.content.text("tempered steel brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_qt_brigandine",
    "armor_qt_brigandine_xs",
    "xl_armor_qt_brigandine",
})

add_group({
    id = "nested_all_brigandine_vest",
    name = ccb.content.text("brigandines"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_brigandine_vest",
    "nested_mc_brigandine_vest",
    "nested_hc_brigandine_vest",
    "nested_ch_brigandine_vest",
    "nested_qt_brigandine_vest",
})

add_group({
    id = "nested_lc_brigandine_coat",
    name = ccb.content.text("mild steel brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_lc_coat_brigandine",
    "armor_lc_coat_brigandine_xs",
    "xl_armor_lc_coat_brigandine",
})

add_group({
    id = "nested_mc_brigandine_coat",
    name = ccb.content.text("medium steel brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_mc_coat_brigandine",
    "armor_mc_coat_brigandine_xs",
    "xl_armor_mc_coat_brigandine",
})

add_group({
    id = "nested_hc_brigandine_coat",
    name = ccb.content.text("high steel brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_hc_coat_brigandine",
    "armor_hc_coat_brigandine_xs",
    "xl_armor_hc_coat_brigandine",
})

add_group({
    id = "nested_ch_brigandine_coat",
    name = ccb.content.text("hardened steel brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_ch_coat_brigandine",
    "armor_ch_coat_brigandine_xs",
    "xl_armor_ch_coat_brigandine",
})

add_group({
    id = "nested_qt_brigandine_coat",
    name = ccb.content.text("tempered steel brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_qt_coat_brigandine",
    "armor_qt_coat_brigandine_xs",
    "xl_armor_qt_coat_brigandine",
})

add_group({
    id = "nested_all_brigandine_coat",
    name = ccb.content.text("brigandine coats"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_brigandine_coat",
    "nested_mc_brigandine_coat",
    "nested_hc_brigandine_coat",
    "nested_ch_brigandine_coat",
    "nested_qt_brigandine_coat",
})

add_group({
    id = "nested_lc_brigandine_shoulders",
    name = ccb.content.text("mild steel brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_lc_brigandine_shoulders",
    "armor_lc_brigandine_shoulders_xs",
    "xl_armor_lc_brigandine_shoulders",
})

add_group({
    id = "nested_mc_brigandine_shoulders",
    name = ccb.content.text("medium steel brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_mc_brigandine_shoulders",
    "armor_mc_brigandine_shoulders_xs",
    "xl_armor_mc_brigandine_shoulders",
})

add_group({
    id = "nested_hc_brigandine_shoulders",
    name = ccb.content.text("high steel brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_hc_brigandine_shoulders",
    "armor_hc_brigandine_shoulders_xs",
    "xl_armor_hc_brigandine_shoulders",
})

add_group({
    id = "nested_ch_brigandine_shoulders",
    name = ccb.content.text("hardened steel brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_ch_brigandine_shoulders",
    "armor_ch_brigandine_shoulders_xs",
    "xl_armor_ch_brigandine_shoulders",
})

add_group({
    id = "nested_qt_brigandine_shoulders",
    name = ccb.content.text("tempered steel brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_qt_brigandine_shoulders",
    "armor_qt_brigandine_shoulders_xs",
    "xl_armor_qt_brigandine_shoulders",
})

add_group({
    id = "nested_all_brigandin_shoulders",
    name = ccb.content.text("brigandines with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandines with shoulder guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_brigandine_shoulders",
    "nested_mc_brigandine_shoulders",
    "nested_hc_brigandine_shoulders",
    "nested_ch_brigandine_shoulders",
    "nested_qt_brigandine_shoulders",
})

add_group({
    id = "nested_lc_brigandine_coat_shoulders",
    name = ccb.content.text("mild steel brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_lc_coat_brigandine_shoulders",
    "armor_lc_coat_brigandine_shoulders_xs",
    "xl_armor_lc_coat_brigandine_shoulders",
})

add_group({
    id = "nested_mc_brigandine_coat_shoulders",
    name = ccb.content.text("medium steel brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_mc_coat_brigandine_shoulders",
    "armor_mc_coat_brigandine_shoulders_xs",
    "xl_armor_mc_coat_brigandine_shoulders",
})

add_group({
    id = "nested_hc_brigandine_coat_shoulders",
    name = ccb.content.text("high steel brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_hc_coat_brigandine_shoulders",
    "armor_hc_coat_brigandine_shoulders_xs",
    "xl_armor_hc_coat_brigandine_shoulders",
})

add_group({
    id = "nested_ch_brigandine_coat_shoulders",
    name = ccb.content.text("hardened steel brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_ch_coat_brigandine_shoulders",
    "armor_ch_coat_brigandine_shoulders_xs",
    "xl_armor_ch_coat_brigandine_shoulders",
})

add_group({
    id = "nested_qt_brigandine_coat_shoulders",
    name = ccb.content.text("tempered steel brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "armor_qt_coat_brigandine_shoulders",
    "armor_qt_coat_brigandine_shoulders_xs",
    "xl_armor_qt_coat_brigandine_shoulders",
})

add_group({
    id = "nested_all_brigandin_coat_shoulders",
    name = ccb.content.text("brigandine coats with shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine coats with shoulder guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_brigandine_coat_shoulders",
    "nested_mc_brigandine_coat_shoulders",
    "nested_hc_brigandine_coat_shoulders",
    "nested_ch_brigandine_coat_shoulders",
    "nested_qt_brigandine_coat_shoulders",
})

add_group({
    id = "nested_lc_brigandine_shoulderguards",
    name = ccb.content.text("mild steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_shoulder_guards",
    "lc_shoulder_guards_xs",
    "xl_lc_shoulder_guards",
})

add_group({
    id = "nested_mc_brigandine_shoulderguards",
    name = ccb.content.text("medium steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_shoulder_guards",
    "mc_shoulder_guards_xs",
    "xl_mc_shoulder_guards",
})

add_group({
    id = "nested_hc_brigandine_shoulderguards",
    name = ccb.content.text("high steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_shoulder_guards",
    "hc_shoulder_guards_xs",
    "xl_hc_shoulder_guards",
})

add_group({
    id = "nested_ch_brigandine_shoulderguards",
    name = ccb.content.text("hardened steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_shoulder_guards",
    "ch_shoulder_guards_xs",
    "xl_ch_shoulder_guards",
})

add_group({
    id = "nested_qt_brigandine_shoulderguards",
    name = ccb.content.text("tempered steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_shoulder_guards",
    "qt_shoulder_guards_xs",
    "xl_qt_shoulder_guards",
})

add_group({
    id = "nested_all_brigandin_shoulderguards",
    name = ccb.content.text("steel shoulder guards"),
    description = ccb.content.text("Recipes related to constructing various sizes of shoulder guards."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_brigandine_shoulderguards",
    "nested_mc_brigandine_shoulderguards",
    "nested_hc_brigandine_shoulderguards",
    "nested_ch_brigandine_shoulderguards",
    "nested_qt_brigandine_shoulderguards",
})

add_group({
    id = "nested_all_brigandin_hands",
    name = ccb.content.text("steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    activity_level = 2,
}, {
    "nested_lc_brigandine_hands",
    "nested_mc_brigandine_hands",
    "nested_hc_brigandine_hands",
    "nested_ch_brigandine_hands",
    "nested_qt_brigandine_hands",
})

add_group({
    id = "nested_lc_brigandine_hands",
    name = ccb.content.text("mild steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_brigandine_hands",
    "lc_brigandine_hands_xs",
    "xl_lc_brigandine_hands",
})

add_group({
    id = "nested_mc_brigandine_hands",
    name = ccb.content.text("medium steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_brigandine_hands",
    "mc_brigandine_hands_xs",
    "xl_mc_brigandine_hands",
})

add_group({
    id = "nested_hc_brigandine_hands",
    name = ccb.content.text("high steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_brigandine_hands",
    "hc_brigandine_hands_xs",
    "xl_hc_brigandine_hands",
})

add_group({
    id = "nested_ch_brigandine_hands",
    name = ccb.content.text("hardened steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_brigandine_hands",
    "ch_brigandine_hands_xs",
    "xl_ch_brigandine_hands",
})

add_group({
    id = "nested_qt_brigandine_hands",
    name = ccb.content.text("tempered steel brigandine gloves"),
    description = ccb.content.text("Recipes related to constructing various sizes of brigandine gloves."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_brigandine_hands",
    "qt_brigandine_hands_xs",
    "xl_qt_brigandine_hands",
})

add_group({
    id = "nested_lc_chainmail_face",
    name = ccb.content.text("mild steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_face",
    "xl_lc_chainmail_face",
    "xs_lc_chainmail_face",
})

add_group({
    id = "nested_mc_chainmail_face",
    name = ccb.content.text("medium steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_face",
    "xl_mc_chainmail_face",
    "xs_mc_chainmail_face",
})

add_group({
    id = "nested_hc_chainmail_face",
    name = ccb.content.text("high steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_face",
    "xl_hc_chainmail_face",
    "xs_hc_chainmail_face",
})

add_group({
    id = "nested_ch_chainmail_face",
    name = ccb.content.text("hardened steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_face",
    "xl_ch_chainmail_face",
    "xs_ch_chainmail_face",
})

add_group({
    id = "nested_qt_chainmail_face",
    name = ccb.content.text("tempered steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_face",
    "xl_qt_chainmail_face",
    "xs_qt_chainmail_face",
})

add_group({
    id = "nested_all_chainmail_face",
    name = ccb.content.text("steel chain partial aventails"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of chainmail partial aventails designed to attach to a metal cap and provide extra face and neck protection."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_chainmail_face",
    "nested_mc_chainmail_face",
    "nested_hc_chainmail_face",
    "nested_ch_chainmail_face",
    "nested_qt_chainmail_face",
})

add_group({
    id = "nested_lc_chainmail_aventail",
    name = ccb.content.text("mild steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_chainmail_aventail",
    "xl_lc_chainmail_aventail",
    "xs_lc_chainmail_aventail",
})

add_group({
    id = "nested_mc_chainmail_aventail",
    name = ccb.content.text("medium steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_chainmail_aventail",
    "xl_mc_chainmail_aventail",
    "xs_mc_chainmail_aventail",
})

add_group({
    id = "nested_hc_chainmail_aventail",
    name = ccb.content.text("high steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_chainmail_aventail",
    "xl_hc_chainmail_aventail",
    "xs_hc_chainmail_aventail",
})

add_group({
    id = "nested_ch_chainmail_aventail",
    name = ccb.content.text("hardened steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_chainmail_aventail",
    "xl_ch_chainmail_aventail",
    "xs_ch_chainmail_aventail",
})

add_group({
    id = "nested_qt_chainmail_aventail",
    name = ccb.content.text("tempered steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_chainmail_aventail",
    "xl_qt_chainmail_aventail",
    "xs_qt_chainmail_aventail",
})

add_group({
    id = "nested_all_chainmail_aventail",
    name = ccb.content.text("steel chain aventails"),
    description = ccb.content.text("Recipes related to constructing various types and sizes of chainmail aventails designed to attach to a metal cap and provide extra face, neck and shoulder protection."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_chainmail_aventail",
    "nested_mc_chainmail_aventail",
    "nested_hc_chainmail_aventail",
    "nested_ch_chainmail_aventail",
    "nested_qt_chainmail_aventail",
})

add_group({
    id = "nested_lc_helmet_nasal",
    name = ccb.content.text("mild steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets out of mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_helmet_nasal",
    "xl_lc_helmet_nasal",
    "xs_lc_helmet_nasal",
})

add_group({
    id = "nested_mc_helmet_nasal",
    name = ccb.content.text("medium steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets out of medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_helmet_nasal",
    "xl_mc_helmet_nasal",
    "xs_mc_helmet_nasal",
})

add_group({
    id = "nested_hc_helmet_nasal",
    name = ccb.content.text("high steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets out of high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_helmet_nasal",
    "xl_hc_helmet_nasal",
    "xs_hc_helmet_nasal",
})

add_group({
    id = "nested_ch_helmet_nasal",
    name = ccb.content.text("hardened steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets out of hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_helmet_nasal",
    "xl_ch_helmet_nasal",
    "xs_ch_helmet_nasal",
})

add_group({
    id = "nested_qt_helmet_nasal",
    name = ccb.content.text("tempered steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets out of tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_helmet_nasal",
    "xl_qt_helmet_nasal",
    "xs_qt_helmet_nasal",
})

add_group({
    id = "nested_all_helmet_nasal",
    name = ccb.content.text("steel nasal helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Viking style nasal helmets."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_helmet_nasal",
    "nested_mc_helmet_nasal",
    "nested_hc_helmet_nasal",
    "nested_ch_helmet_nasal",
    "nested_qt_helmet_nasal",
})

add_group({
    id = "nested_lc_helmet_turban",
    name = ccb.content.text("mild steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets out of mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_helmet_turban",
    "xl_lc_helmet_turban",
    "xs_lc_helmet_turban",
})

add_group({
    id = "nested_mc_helmet_turban",
    name = ccb.content.text("medium steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets out of medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_helmet_turban",
    "xl_mc_helmet_turban",
    "xs_mc_helmet_turban",
})

add_group({
    id = "nested_hc_helmet_turban",
    name = ccb.content.text("high steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets out of high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_helmet_turban",
    "xl_hc_helmet_turban",
    "xs_hc_helmet_turban",
})

add_group({
    id = "nested_ch_helmet_turban",
    name = ccb.content.text("hardened steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets out of hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_helmet_turban",
    "xl_ch_helmet_turban",
    "xs_ch_helmet_turban",
})

add_group({
    id = "nested_qt_helmet_turban",
    name = ccb.content.text("tempered steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets out of tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_helmet_turban",
    "xl_qt_helmet_turban",
    "xs_qt_helmet_turban",
})

add_group({
    id = "nested_all_helmet_turban",
    name = ccb.content.text("steel turban helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style turban helmets."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_helmet_turban",
    "nested_mc_helmet_turban",
    "nested_hc_helmet_turban",
    "nested_ch_helmet_turban",
    "nested_qt_helmet_turban",
})

add_group({
    id = "nested_lc_steel_facemask",
    name = ccb.content.text("mild steel face masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks out of mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_steel_facemask",
    "xl_lc_steel_facemask",
    "xs_lc_steel_facemask",
})

add_group({
    id = "nested_mc_steel_facemask",
    name = ccb.content.text("medium steel face masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks out of medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_steel_facemask",
    "xl_mc_steel_facemask",
    "xs_mc_steel_facemask",
})

add_group({
    id = "nested_hc_steel_facemask",
    name = ccb.content.text("high steel face masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks out of high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_steel_facemask",
    "xl_hc_steel_facemask",
    "xs_hc_steel_facemask",
})

add_group({
    id = "nested_ch_steel_facemask",
    name = ccb.content.text("hardened steel face masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks out of hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_steel_facemask",
    "xl_ch_steel_facemask",
    "xs_ch_steel_facemask",
})

add_group({
    id = "nested_qt_steel_facemask",
    name = ccb.content.text("tempered steel face masks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks out of tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_steel_facemask",
    "xl_qt_steel_facemask",
    "xs_qt_steel_facemask",
})

add_group({
    id = "nested_all_steel_facemask",
    name = ccb.content.text("steel facemasks"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style steel facemasks."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_lc_steel_facemask",
    "nested_mc_steel_facemask",
    "nested_hc_steel_facemask",
    "nested_ch_steel_facemask",
    "nested_qt_steel_facemask",
})

add_group({
    id = "nested_lc_mirror_armor",
    name = ccb.content.text("mild steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor out of mild steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "lc_mirror_armor",
    "xl_lc_mirror_armor",
    "xs_lc_mirror_armor",
})

add_group({
    id = "nested_mc_mirror_armor",
    name = ccb.content.text("medium steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor out of medium steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "mc_mirror_armor",
    "xl_mc_mirror_armor",
    "xs_mc_mirror_armor",
})

add_group({
    id = "nested_hc_mirror_armor",
    name = ccb.content.text("high steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor out of high steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "hc_mirror_armor",
    "xl_hc_mirror_armor",
    "xs_hc_mirror_armor",
})

add_group({
    id = "nested_ch_mirror_armor",
    name = ccb.content.text("hardened steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor out of hardened steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "ch_mirror_armor",
    "xl_ch_mirror_armor",
    "xs_ch_mirror_armor",
})

add_group({
    id = "nested_qt_mirror_armor",
    name = ccb.content.text("tempered steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor out of tempered steel."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "qt_mirror_armor",
    "xl_qt_mirror_armor",
    "xs_qt_mirror_armor",
})

add_group({
    id = "nested_all_mirror_armor",
    name = ccb.content.text("steel mirror armor"),
    description = ccb.content.text("Recipes related to constructing various sizes of Arabic style mirror armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 2,
}, {
    "nested_lc_mirror_armor",
    "nested_mc_mirror_armor",
    "nested_hc_mirror_armor",
    "nested_ch_mirror_armor",
    "nested_qt_mirror_armor",
})

add_group({
    id = "nested_legguard_bronze",
    name = ccb.content.text("bronze greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of greaves made out of bronze."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "legguard_bronze",
    "xl_legguard_bronze",
    "xs_legguard_bronze",
})

add_group({
    id = "nested_armguard_bronze",
    name = ccb.content.text("bronze vambraces"),
    description = ccb.content.text("Recipes related to constructing various sizes of vambraces made out of bronze."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    activity_level = 2,
}, {
    "armguard_bronze",
    "xl_armguard_bronze",
    "xs_armguard_bronze",
})

add_group({
    id = "nested_helmet_bronze",
    name = ccb.content.text("bronze helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes of single piece helmets made out of bronze."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "helmet_bronze",
    "xl_helmet_bronze",
    "xs_helmet_bronze",
})

add_group({
    id = "nested_helmet_corinthian",
    name = ccb.content.text("Corinthian helms"),
    description = ccb.content.text("Recipes related to constructing various sizes of helmets made out of bronze in the Ancient Greek Corinthian style."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "helmet_corinthian",
    "xl_helmet_corinthian",
    "helmet_corinthian_xs",
})

add_group({
    id = "nested_all_helmet_bronze",
    name = ccb.content.text("bronze helmets"),
    description = ccb.content.text("Recipes related to constructing various sizes and styles of helmets made out of bronze."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "nested_helmet_bronze",
    "nested_helmet_corinthian",
})

add_group({
    id = "nested_legguard_metal",
    name = ccb.content.text("iron greaves"),
    description = ccb.content.text("Recipes related to constructing various sizes of greaves made out of iron."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "legguard_metal",
    "xl_legguard_metal",
    "xs_legguard_metal",
})

add_group({
    id = "nested_loincloth",
    name = ccb.content.text("loincloths"),
    description = ccb.content.text("Recipes related to making loincloths out of varied materials."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    activity_level = 2,
}, {
    "loincloth",
    "loincloth_fur",
    "loincloth_leather",
    "loincloth_wool",
})

add_group({
    id = "nested_throat_guard",
    name = ccb.content.text("throat guards"),
    description = ccb.content.text("Recipes related to making throat guards out of varied materials."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 2,
}, {
    "throat_guard_nylon",
    "throat_guard_canvas",
    "throat_guard_mercenary",
})

add_group({
    id = "nested_pouch",
    name = ccb.content.text("pouches"),
    description = ccb.content.text("Recipes related to making pouches for a variety of roles and purposes."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    activity_level = 2,
}, {
    "legrig",
    "dump_pouch",
    "sustainment_pouch",
    "legpouch",
    "legpouch_large",
    "armrig",
    "chestpouch",
    "chestpouch_leather",
    "grenade_pouch",
    "grenadebandolier",
    "tactical_grenade_pouch",
    "stone_pouch",
    "leather_stone_pouch",
    "flintlock_pouch",
    "tactical_shotshell_pouch",
    "tool_pouch",
    "triple_stacker_pouch",
    "ammo_pouch",
    "ankle_wallet_pouch",
    "ragpouch",
    "leather_pouch",
})

add_group({
    id = "nested_cloak",
    name = ccb.content.text("cloaks"),
    description = ccb.content.text("Recipes related to making cloaks out of varied materials."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 2,
}, {
    "cloak",
    "cloak_denim",
    "cloak_fur",
    "cloak_leather",
    "cloak_wool",
    "grass_cloak",
})

add_group({
    id = "nested_mutagen_primers",
    name = ccb.content.text("mutagen primers"),
    description = ccb.content.text("Recipes related to synthesizing substances to aid in directing mutagenic change."),
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    activity_level = 2,
}, {
    "iv_purifier",
    "iv_mutagen",
    "iv_mutagen_rat",
    "iv_mutagen_chiropteran",
    "iv_mutagen_fish",
    "iv_mutagen_bird",
    "iv_mutagen_mouse",
    "iv_mutagen_elfa",
    "iv_mutagen_alpha",
    "iv_mutagen_beast",
    "iv_mutagen_slime",
    "iv_mutagen_plant",
    "iv_mutagen_snail",
    "iv_mutagen_feline",
    "iv_mutagen_ursine",
    "iv_mutagen_rabbit",
    "iv_mutagen_spider",
    "iv_mutagen_raptor",
    "iv_mutagen_cattle",
    "iv_mutagen_lupine",
    "iv_mutagen_insect",
    "iv_mutagen_lizard",
    "iv_mutagen_chimera",
    "iv_mutagen_medical",
    "iv_mutagen_crustacean",
    "iv_mutagen_troglobite",
    "iv_mutagen_batrachian",
    "iv_mutagen_cephalopod",
})

add_group({
    id = "nested_mutagen",
    name = ccb.content.text("mutagens"),
    description = ccb.content.text("Recipes related to synthesizing mutagenic substances."),
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    activity_level = 2,
}, {
    "purifier",
    "mutagen",
    "mutagen_rat",
    "mutagen_chiropteran",
    "mutagen_fish",
    "mutagen_bird",
    "mutagen_mouse",
    "mutagen_elfa",
    "mutagen_alpha",
    "mutagen_alpha_from_sample",
    "mutagen_beast",
    "mutagen_slime",
    "mutagen_plant",
    "mutagen_snail",
    "mutagen_feline",
    "mutagen_ursine",
    "mutagen_rabbit",
    "mutagen_spider",
    "mutagen_raptor",
    "mutagen_cattle",
    "mutagen_lupine",
    "mutagen_insect",
    "mutagen_lizard",
    "mutagen_chimera",
    "mutagen_medical",
    "mutagen_crustacean",
    "mutagen_troglobite",
    "mutagen_batrachian",
    "mutagen_cephalopod",
})

add_group({
    id = "nested_acid",
    name = ccb.content.text("acids"),
    description = ccb.content.text("Recipes related to synthesizing various acidic substances."),
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    activity_level = 2,
}, {
    "formic_acid",
    "formic_acid_from_oxalic_acid",
    "formic_acid_with_blood",
    "formic_acid_with_blood_distill",
    "chem_acetic_acid",
    "chem_acetic_acid_with_blood",
    "chem_acetic_acid_with_blood_distill",
    "chem_muriatic_acid",
    "chem_muriatic_acid_by_electrolysis",
    "chem_muriatic_acid_with_blood",
    "chem_muriatic_acid_with_blood_distill",
    "chem_citric_acid",
    "chem_nitric_acid_from ammonia",
    "chem_nitric_acid_from_muriatic",
    "chem_nitric_acid_from_sulphuric",
    "chem_sulphuric_acid",
    "chem_sulphuric_acid_with platinum",
    "chem_sulphuric_acid_with_blood",
    "acetic_anhydride",
    "chem_hydrogen_peroxide",
    "chem_hydrogen_peroxide_conc",
})

add_group({
    id = "nested_link_sheet",
    name = ccb.content.text("chainmail sheets"),
    description = ccb.content.text("Recipes related to making sheets of chainmail of different steel qualities."),
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    activity_level = 2,
}, {
    "lc_link_sheet",
    "mc_link_sheet",
    "hc_link_sheet",
    "ch_link_sheet",
    "qt_link_sheet",
})

add_group({
    id = "nested_spears",
    name = ccb.content.text("spears"),
    description = ccb.content.text("Recipes related to making spears from various materials."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    activity_level = 2,
}, {
    "pointy_stick",
    "pointy_stick_long",
    "simple_spear_pipe",
    "spear_bronze",
    "spear_copper",
    "spear_knife",
    "spear_knife_proper",
    "spear_knife_superior",
    "spear_knife_superior_from simple version",
    "spear_pipe",
    "spear_rebar",
    "spear_shaft_sharpened",
    "spear_spike",
    "nested_steel_spears",
    "spear_steel_crude",
    "spear_stone",
    "spear_stone_simple",
    "spear_wood",
    "spear_wood_simple",
    "nested_pikes",
    "crude_goedendag",
})

add_group({
    id = "nested_steel_spears",
    name = ccb.content.text("steel spears"),
    description = ccb.content.text("Recipes related to constructing steel spears from various materials."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "spear_steel",
    "lc_spear_steel",
    "hc_spear_steel",
    "ch_spear_steel",
    "qt_spear_steel",
})

add_group({
    id = "nested_pikes",
    name = ccb.content.text("pikes"),
    description = ccb.content.text("Recipes related to constructing pikes from various materials."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "nested_steel_pikes",
    "pike_bronze",
    "pike_copper",
    "pike_wood",
    "simple_pike_pipe",
    "pike_pipe",
})

add_group({
    id = "nested_steel_pikes",
    name = ccb.content.text("steel pikes"),
    description = ccb.content.text("Recipes related to constructing steel pikes from various materials."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "pike",
    "lc_pike",
    "hc_pike",
    "ch_pike",
    "qt_pike",
})

add_group({
    id = "nested_throwing_weapons",
    name = ccb.content.text("throwing weapons"),
    description = ccb.content.text("Recipes related to making all kind of weapons designed to be thrown at the enemy."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    activity_level = 2,
}, {
    "lawn_dart",
    "weighted_dart",
    "throwing_knife",
    "throwing_axe",
    "throwing_stick",
    "nested_javelins",
})

add_group({
    id = "nested_javelins",
    name = ccb.content.text("javelins"),
    description = ccb.content.text("Recipes related to constructing all kinds of javelins in their various forms."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 2,
}, {
    "javelin_fletched",
    "javelin_fletched_bronze",
    "javelin",
    "javelin_iron",
})

add_group({
    id = "nested_ballistic_plates",
    name = ccb.content.text("makeshift ballistic plates"),
    description = ccb.content.text("Recipes related to constructing makeshift ESAPI and ESBI plates."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 6,
}, {
    "scrap_esapi_plate",
    "lc_esapi_plate",
    "mc_esapi_plate",
    "hc_esapi_plate",
    "ch_esapi_plate",
    "qt_esapi_plate",
    "scrap_esbi_plate",
    "lc_esbi_plate",
    "mc_esbi_plate",
    "hc_esbi_plate",
    "ch_esbi_plate",
    "qt_esbi_plate",
})

add_group({
    id = "nested_cardboard_armor",
    name = ccb.content.text("cardboard armor"),
    description = ccb.content.text("Recipes related to the construction of cardboard 'armor'."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 2,
}, {
    "helmet_cardboard",
    "armor_cardboard",
    "armor_cardboard_cuirass",
    "cardboard_crown",
}, {
    "cardboard_shield",
})

add_group({
    id = "nested_bullet_necklaces",
    name = ccb.content.text("casing necklaces"),
    description = ccb.content.text("Recipes dealing with the manufacture of necklaces made with bullet casings, including ones made through simple techniques or more refined workmanship."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "simple_pistol_cartridge_necklace",
    "simple_rifle_cartridge_necklace",
    "simple_ordnance_cartridge_necklace",
    "fancy_pistol_cartridge_necklace",
    "fancy_rifle_cartridge_necklace",
    "fancy_ordinance_cartridge_necklace",
})

add_group({
    id = "nested_combat_exoskeleton_armor_reinforcement",
    name = ccb.content.text("exoskeleton armors reinforcements"),
    description = ccb.content.text("Recipes related to the reinforcement of standard exoskeleton armors."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "combat_exoskeleton_armor_head_heavy_reinforced",
    "combat_exoskeleton_armor_torso_heavy_reinforced",
    "combat_exoskeleton_armor_arm_heavy_reinforced",
    "combat_exoskeleton_armor_leg_heavy_reinforced",
    "combat_exoskeleton_armor_head_medium_reinforced",
    "combat_exoskeleton_armor_torso_medium_reinforced",
    "combat_exoskeleton_armor_arm_medium_reinforced",
    "combat_exoskeleton_armor_leg_medium_reinforced",
    "combat_exoskeleton_armor_head_light_reinforced",
    "combat_exoskeleton_armor_torso_light_reinforced",
    "combat_exoskeleton_armor_arm_light_reinforced",
    "combat_exoskeleton_armor_leg_light_reinforced",
})

add_group({
    id = "nested_combat_exoskeleton_armor",
    name = ccb.content.text("exoskeleton armors"),
    description = ccb.content.text("Recipes related to the production of custom exoskeleton armors."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "nested_combat_exoskeleton_armor_reinforcement",
})

add_group({
    id = "nested_hoodies",
    name = ccb.content.text("hoodies"),
    description = ccb.content.text("Recipes related to the production of hoodies."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 1,
}, {
    "hoodie",
    "hoodie_cropped",
    "hoodie_cropped_cutting",
    "nested_hoodies_animal",
    "nested_hoodies_cropped_animal",
})

add_group({
    id = "nested_hoodies_animal",
    name = ccb.content.text("animal hoodies"),
    description = ccb.content.text("Recipes related to the production of animal hoodies."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "hoodie_shark",
    "hoodie_bear",
    "hoodie_cat",
    "hoodie_bunny",
    "hoodie_wolf",
    "hoodie_lizard",
    "hoodie_dog",
    "hoodie_panda",
    "hoodie_frog",
})

add_group({
    id = "nested_hoodies_cropped_animal",
    name = ccb.content.text("cropped animal hoodies"),
    description = ccb.content.text("Recipes related to the production of cropped animal hoodies."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "hoodie_cropped_shark",
    "hoodie_cropped_bear",
    "hoodie_cropped_cat",
    "hoodie_cropped_bunny",
    "hoodie_cropped_wolf",
    "hoodie_cropped_lizard",
    "hoodie_cropped_dog",
    "hoodie_cropped_panda",
    "hoodie_cropped_frog",
})

add_group({
    id = "nested_scrapsuit",
    name = ccb.content.text("scrap armors"),
    description = ccb.content.text("Recipes related to the production of suits of scrap armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "armor_scrapsuit",
    "armor_scrapsuit_assembly",
    "armor_xl_scrapsuit",
    "armor_xl_scrapsuit_assembly",
    "armor_xs_scrapsuit",
    "armor_xs_scrapsuit_assembly",
})

add_group({
    id = "nested_aprons",
    name = ccb.content.text("aprons"),
    description = ccb.content.text("Recipes related to the production of aprons."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    activity_level = 1,
}, {
    "nested_aprons_cotton",
    "nested_aprons_leather",
    "nested_aprons_synthetic",
})

add_group({
    id = "nested_aprons_cotton",
    name = ccb.content.text("cotton aprons"),
    description = ccb.content.text("Recipes related to the production of cotton aprons."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "apron_cotton",
    "apron_cotton_xl",
    "apron_cotton_xs",
    "apron_cotton_maid_apron",
    "apron_cotton_xl_maid_apron_xl",
    "apron_cotton_xs_maid_apron_xs",
    "nested_aprons_cotton_waist",
})

add_group({
    id = "nested_aprons_cotton_waist",
    name = ccb.content.text("waist cotton aprons"),
    description = ccb.content.text("Recipes related to the production of cotton waist aprons."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "waist_apron_short",
    "waist_apron_short_xl",
    "waist_apron_short_xs",
    "waist_apron_short_maid_apron",
    "waist_apron_short_xl_maid_apron_xl",
    "waist_apron_short_xs_maid_apron_xs",
    "waist_apron_long",
    "waist_apron_long_xl",
    "waist_apron_long_xs",
    "waist_apron_long_maid_apron",
    "waist_apron_long_xl_maid_apron_xl",
    "waist_apron_long_xs_maid_apron_xs",
})

add_group({
    id = "nested_aprons_leather",
    name = ccb.content.text("leather aprons"),
    description = ccb.content.text("Recipes related to the production of leather aprons."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "apron_leather",
})

add_group({
    id = "nested_aprons_synthetic",
    name = ccb.content.text("synthetic fabric aprons"),
    description = ccb.content.text("Recipes related to the production of synthetic fabric aprons."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "apron_plastic",
    "apron_cut_resistant",
})

add_group({
    id = "nested_farmors",
    name = ccb.content.text("fur armors"),
    description = ccb.content.text("Recipes related to the production of suits of fur armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "armor_farmor",
    "armor_farmor_xs",
    "xl_armor_farmor",
    "armor_faux_farmor",
    "armor_faux_farmor_xs",
    "xl_armor_faux_farmor",
})

add_group({
    id = "nested_larmors",
    name = ccb.content.text("leather armors"),
    description = ccb.content.text("Recipes related to the production of suits of leather armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "armor_larmor",
    "armor_larmor_xs",
    "xl_armor_larmor",
})

add_group({
    id = "nested_sheetmetalarmors",
    name = ccb.content.text("sheet metal armors"),
    description = ccb.content.text("Recipes related to the production of suits of metal sheet armor."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "armor_ch_metal_sheets",
    "armor_ch_metal_sheets_assembly",
    "armor_ch_metal_sheets_heavy",
    "armor_ch_metal_sheets_heavy_assembly",
    "armor_ch_metal_sheets_chain",
    "armor_ch_metal_sheets_chain_assembly",
    "armor_ch_metal_sheets_chain_heavy",
    "armor_ch_metal_sheets_chain_heavy_assembly",
    "armor_metal_sheets_assembly",
    "armor_metal_sheets_chain_assembly",
    "armor_metal_sheets_heavy_assembly",
    "armor_metal_sheets_chain_heavy_assembly",
})

add_group({
    id = "nested_wetsuits",
    name = ccb.content.text("wetsuits"),
    description = ccb.content.text("Recipes related to the production of wetsuits."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "wetsuit",
    "xs_wetsuit",
    "xl_wetsuit",
    "wetsuit_thick",
    "xs_wetsuit_thick",
    "xl_wetsuit_thick",
    "wetsuit_spring",
}, {
    "nested_wetsuits_reinforced",
})

add_group({
    id = "nested_jumpsuits",
    name = ccb.content.text("jumpsuits"),
    description = ccb.content.text("Recipes related to the production of jumpsuits."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    activity_level = 1,
}, {
    "nested_all_survivor_jumpsuits",
    "jumpsuit",
    "jumpsuit_xs",
    "jumpsuit_xl",
    "jumpsuit_xl_from_jumpsuit",
})

add_group({
    id = "nested_nomadjumpsuits",
    name = ccb.content.text("nomad jumpsuits"),
    description = ccb.content.text("Recipes related to the production of nomad jumpsuits."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "armor_nomad",
    "armor_nomad_upgrade light jumpsuit",
    "armor_nomad_light",
    "armor_nomad_advanced",
})

add_group({
    id = "nested_pothelms",
    name = ccb.content.text("pot helms"),
    description = ccb.content.text("Recipes related to the production of helmets made out of pots."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 1,
}, {
    "pot_helmet",
    "pot_helmet_xs",
    "pot_xlhelmet",
    "stockpot_helmet",
})

add_group({
    id = "nested_scraphelmets",
    name = ccb.content.text("scrap helmets"),
    description = ccb.content.text("Recipes related to the production of helmets made out of scraps."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 1,
}, {
    "helmet_scrap",
    "helmet_scrap_xs",
    "xl_helmet_scrap",
})

add_group({
    id = "nested_kabutos",
    name = ccb.content.text("kabutos"),
    description = ccb.content.text("Recipes related to the production of kabuto helmets."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    activity_level = 1,
}, {
    "helmet_kabuto",
    "helmet_kabuto_xs",
    "xl_helmet_kabuto",
})

add_group({
    id = "nested_jewelry",
    name = ccb.content.text("jewelry"),
    description = ccb.content.text("Recipes related to the production of jewelry."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "nested_bracelets",
    "nested_necklaces",
    "nested_rings",
})

add_group({
    id = "nested_bracelets",
    name = ccb.content.text("bracelets"),
    description = ccb.content.text("Recipes related to the production of bracelets."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "gold_bracelet",
    "copper_bracelet",
    "silver_bracelet",
    "bead_bracelet",
})

add_group({
    id = "nested_necklaces",
    name = ccb.content.text("necklaces"),
    description = ccb.content.text("Recipes related to the production of necklaces."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "nested_bullet_necklaces",
    "nested_necklace_teeth",
    "gold_necklace",
    "copper_necklace",
    "silver_necklace",
    "bead_necklace",
})

add_group({
    id = "nested_necklace_teeth",
    name = ccb.content.text("teeth necklaces"),
    description = ccb.content.text("Recipes related to the production of necklaces made from teeth."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "necklace_teeth_necklace_teeth_monster",
})

add_group({
    id = "nested_rings",
    name = ccb.content.text("rings"),
    description = ccb.content.text("Recipes related to the production of rings."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "gold_ring",
})

add_group({
    id = "nested_blankets",
    name = ccb.content.text("blankets"),
    description = ccb.content.text("Recipes related to the production of blankets."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "grass_blanket",
    "grass_blanket_from_sheet",
    "blanket_blanket_makeshift",
    "electric_blanket",
    "down_blanket",
    "fur_blanket",
    "nested_quilts",
})

add_group({
    id = "nested_quilts",
    name = ccb.content.text("quilts"),
    description = ccb.content.text("Recipes related to the production of quilts."),
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    activity_level = 1,
}, {
    "quilt",
    "quilt_patchwork",
})

add_group({
    id = "nested_sleepingbags",
    name = ccb.content.text("sleeping bags"),
    description = ccb.content.text("Recipes related to the production of sleeping bags."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "sleeping_bag_roll",
    "sleeping_bag_fur_roll",
    "sleeping_bag_improvised",
})

add_group({
    id = "nested_tails",
    name = ccb.content.text("tails"),
    description = ccb.content.text("Recipes related to the production of fake tails."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "fur_cat_tail",
    "faux_fur_cat_tail",
    "leather_cat_tail",
})

add_group({
    id = "nested_ears",
    name = ccb.content.text("ears"),
    description = ccb.content.text("Recipes related to the production of fake ears."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "fur_cat_ears",
    "faux_fur_cat_ears",
    "leather_cat_ears",
})

add_group({
    id = "nested_collars",
    name = ccb.content.text("collars"),
    description = ccb.content.text("Recipes related to the production of collars."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "fur_collar",
    "faux_fur_collar",
    "leather_collar",
})

add_group({
    id = "nested_beltloops",
    name = ccb.content.text("belt loops"),
    description = ccb.content.text("Recipes related to the production of belt loops."),
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    activity_level = 1,
}, {
    "belt_loop_small",
    "belt_loop_medium",
    "belt_loop_large",
})

add_group({
    id = "nested_9mm",
    name = ccb.content.text("9x19mm ammo"),
    description = ccb.content.text("Recipes related to reloading 9x19mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_9mmfmj",
    "reloaded_9mm",
    "reloaded_9mmP",
    "reloaded_9mmP2",
    "bp_9mmfmj",
    "bp_9mm",
    "matchhead_9mmfmj",
    "matchhead_9mm",
})

add_group({
    id = "nested_40sw",
    name = ccb.content.text(".40 S&W ammo"),
    description = ccb.content.text("Recipes related to reloading .40 S&W ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_40sw",
    "reloaded_40fmj",
    "bp_40fmj",
    "bp_40sw",
    "matchhead_40fmj",
    "matchhead_40sw",
})

add_group({
    id = "nested_32acp",
    name = ccb.content.text(".32 ACP ammo"),
    description = ccb.content.text("Recipes related to reloading .32 ACP ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_32_acp",
    "reloaded_32_acp_jhp",
    "bp_32_acp",
    "bp_32_acp_jhp",
    "matchhead_32_acp",
    "matchhead_32_acp_jhp",
})

add_group({
    id = "nested_38_special",
    name = ccb.content.text(".38 Special ammo"),
    description = ccb.content.text("Recipes related to reloading .38 Special ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_38_fmj",
    "reloaded_38_special",
    "reloaded_38_special_p",
    "bp_38_fmj",
    "bp_38_special",
    "matchhead_38_fmj",
    "matchhead_38_special",
})

add_group({
    id = "nested_38_super",
    name = ccb.content.text(".38 Super ammo"),
    description = ccb.content.text("Recipes related to reloading .38 Super ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_38super_fmj",
    "reloaded_38_super",
    "bp_38super_fmj",
    "bp_38super",
    "matchhead_38_super_fmj",
    "matchhead_38_super",
})

add_group({
    id = "nested_44_magnum",
    name = ccb.content.text(".44 Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .44 Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_44fmj",
    "reloaded_44magnum",
    "bp_44fmj",
    "bp_44magnum",
})

add_group({
    id = "nested_45_acp",
    name = ccb.content.text(".45 ACP ammo"),
    description = ccb.content.text("Recipes related to reloading .45 ACP ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_45_acp",
    "reloaded_45_jhp",
    "reloaded_45_super",
    "bp_45_acp",
    "bp_45_jhp",
    "matchhead_45_acp",
    "matchhead_45_jhp",
})

add_group({
    id = "nested_500_s&w",
    name = ccb.content.text(".500 S&W Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .500 S&W Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_500_Magnum",
    "bp_500_Magnum",
})

add_group({
    id = "nested_50_ae",
    name = ccb.content.text(".50 AE ammo"),
    description = ccb.content.text("Recipes related to reloading .50 AE ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_50ae_fmj",
    "reloaded_50ae_jhp",
    "bp_50ae_fmj",
    "bp_50ae_jhp",
    "matchhead_50ae_fmj",
    "matchhead_50ae_jhp",
})

add_group({
    id = "nested_762_25",
    name = ccb.content.text("7.62x25mm ammo"),
    description = ccb.content.text("Recipes related to reloading 7.62x25mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_762_25",
    "bp_762_25",
    "matchhead_762_25",
})

add_group({
    id = "nested_9x18",
    name = ccb.content.text("9x18mm ammo"),
    description = ccb.content.text("Recipes related to reloading 9x18mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_9x18mmfmj",
    "reloaded_9x18mm",
    "reloaded_9x18mmP2",
    "bp_9x18mmfmj",
    "bp_9x18mm",
    "matchhead_9x18mmfmj",
    "matchhead_9x18mm",
})

add_group({
    id = "nested_380_acp",
    name = ccb.content.text(".380 ACP ammo"),
    description = ccb.content.text("Recipes related to reloading .380 ACP ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_380_FMJ",
    "reloaded_380_JHP",
    "reloaded_380_p",
    "bp_380_FMJ",
    "bp_380_JHP",
    "matchhead_380_FMJ",
    "matchhead_380_JHP",
})

add_group({
    id = "nested_57",
    name = ccb.content.text("5.7x28mm ammo"),
    description = ccb.content.text("Recipes related to reloading 5.7x28mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_57mm",
    "bp_57mm",
})

add_group({
    id = "nested_357_sig",
    name = ccb.content.text(".357 SIG ammo"),
    description = ccb.content.text("Recipes related to reloading .357 SIG ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_357sig_fmj",
    "reloaded_357sig_jhp",
    "bp_357sig_fmj",
    "bp_357sig_jhp",
    "matchhead_357sig_fmj",
    "matchhead_357sig_jhp",
})

add_group({
    id = "nested_357_magnum",
    name = ccb.content.text(".357 Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .357 Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_357mag_fmj",
    "reloaded_357mag_jhp",
    "bp_357mag_fmj",
    "bp_357mag_jhp",
    "matchhead_357mag_fmj",
    "matchhead_357mag_jhp",
})

add_group({
    id = "nested_10mm",
    name = ccb.content.text("10mm Auto ammo"),
    description = ccb.content.text("Recipes related to reloading 10mm Auto ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_10mm_fmj",
    "reloaded_10mm_jhp",
    "reloaded_10mmP",
    "bp_10mm_fmj",
    "bp_10mm_jhp",
    "matchhead_10mm_fmj",
    "matchhead_10mm_jhp",
})

add_group({
    id = "nested_454",
    name = ccb.content.text(".454 Casull ammo"),
    description = ccb.content.text("Recipes related to reloading .454 Casull ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_454_Casull",
    "bp_454_Casull",
})

add_group({
    id = "nested_45colt",
    name = ccb.content.text(".45 Colt ammo"),
    description = ccb.content.text("Recipes related to reloading .45 Colt ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_45colt_fmj",
    "reloaded_45colt_jhp",
    "reloaded_45colt_cowboy",
    "bp_45colt_fmj",
    "bp_45colt_jhp",
    "bp_45colt_cowboy",
    "matchhead_45colt_fmj",
    "matchhead_45colt_jhp",
    "matchhead_45colt_cowboy",
})

add_group({
    id = "nested_460",
    name = ccb.content.text(".460 S&W Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .460 S&W ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    activity_level = 1,
}, {
    "reloaded_460sw",
    "reloaded_460sw_jhp",
})

add_group({
    id = "nested_22lr",
    name = ccb.content.text(".22 LR ammo"),
    description = ccb.content.text("Recipes related to reloading .22 LR ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_22_lr",
    "reloaded_22_fmj",
    "bp_22_lr",
    "bp_22_fmj",
    "matchhead_22_lr",
    "matchhead_22_fmj",
})

add_group({
    id = "nested_223",
    name = ccb.content.text(".223/5.56x45mm ammo"),
    description = ccb.content.text("Recipes related to reloading .223/5.56x45mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_223",
    "bp_223",
    "reloaded_556",
    "reloaded_556_incendiary",
    "bp_556",
    "bp_556_incendiary",
})

add_group({
    id = "nested_270",
    name = ccb.content.text(".270 Winchester ammo"),
    description = ccb.content.text("Recipes related to reloading .270 Winchester ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_270win_jsp",
    "reloaded_270win_fmj",
    "bp_270win_jsp",
    "bp_270win_fmj",
})

add_group({
    id = "nested_300winmag",
    name = ccb.content.text(".300 Winchester Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .300 Winchester Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_300_winmag",
    "bp_300_winmag",
})

add_group({
    id = "nested_3006",
    name = ccb.content.text(".30-06 Springfield ammo"),
    description = ccb.content.text("Recipes related to reloading .30-06 Springfield ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_3006",
    "reloaded_3006_jsp",
    "reloaded_3006fmj",
    "reloaded_3006_incendiary",
    "bp_3006",
    "bp_3006_jsp",
    "bp_3006fmj",
    "bp_3006_incendiary",
})

add_group({
    id = "nested_308",
    name = ccb.content.text(".308/7.62x51mm ammo"),
    description = ccb.content.text("Recipes related to reloading .308/7.62x51mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_308",
    "reloaded_308_from_762x51",
    "bp_308",
    "bp_308_from_762x51",
    "reloaded_762_51",
    "reloaded_762_51_from_308",
    "reloaded_762_51_incendiary",
    "reloaded_762_51_incendiary_from_308",
    "bp_762_51",
    "bp_762_51_from_308",
    "bp_762_51_incendiary",
    "bp_762_51_incendiary_from_308",
})

add_group({
    id = "nested_4570",
    name = ccb.content.text(".45-70 ammo"),
    description = ccb.content.text("Recipes related to reloading .45-70 ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_4570_sp",
    "reloaded_4570_pen",
    "reloaded_4570_low",
    "reloaded_4570_bp",
})

add_group({
    id = "nested_50bmg",
    name = ccb.content.text(".50 BMG ammo"),
    description = ccb.content.text("Recipes related to reloading .50 BMG ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_50bmg",
    "reloaded_50_incendiary",
    "reloaded_50ss",
    "bp_50match",
    "bp_50_incendiary",
    "bp_50ss",
    "reloaded_50bmgfmj",
    "bp_50bmgfmj",
})

add_group({
    id = "nested_545",
    name = ccb.content.text("5.45x45mm ammo"),
    description = ccb.content.text("Recipes related to reloading 5.45x45mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_545",
    "reloaded_545_ap",
    "bp_545",
    "bp_545_ap",
})

add_group({
    id = "nested_300blk",
    name = ccb.content.text(".300 AAC Blackout ammo"),
    description = ccb.content.text("Recipes related to reloading .300 AAC Blackout ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_300blk",
    "reloaded_300blk_ss",
    "bp_300blk",
    "bp_300blk_ss",
})

add_group({
    id = "nested_458",
    name = ccb.content.text(".458 Winchester Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .458 Winchester Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_458wm",
    "bp_458wm",
})

add_group({
    id = "nested_762x54",
    name = ccb.content.text("7.62x54mmR ammo"),
    description = ccb.content.text("Recipes related to reloading 7.62x54mmR ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_762_54R",
    "bp_762_54R",
})

add_group({
    id = "nested_762x39",
    name = ccb.content.text("7.62x39mm ammo"),
    description = ccb.content.text("Recipes related to reloading 7.62x39mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_762_m87",
    "reloaded_762_jhp",
    "bp_762_m87",
    "bp_762_jhp",
})

add_group({
    id = "nested_303",
    name = ccb.content.text(".303 British ammo"),
    description = ccb.content.text("Recipes related to reloading .303 British ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_303",
    "reloaded_303fmj",
    "reloaded_303sp",
    "bp_303",
    "bp_303fmj",
    "bp_303sp",
})

add_group({
    id = "nested_77_arisaka",
    name = ccb.content.text("7.7x58mm Arisaka ammo"),
    description = ccb.content.text("Recipes related to reloading 7.7x58mm Arisaka ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_77mm_arisaka_jsp",
    "bp_77mm_arisaka_jsp",
    "reloaded_303sp",
    "bp_303",
    "bp_303fmj",
    "bp_303sp",
})

add_group({
    id = "nested_30carbine",
    name = ccb.content.text(".30 Carbine ammo"),
    description = ccb.content.text("Recipes related to reloading .30 Carbine ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_30carbine",
    "reloaded_30carbine_jsp",
    "bp_30carbine",
    "bp_30carbine_jsp",
    "matchhead_30carbine",
    "matchhead_30carbine_jsp",
})

add_group({
    id = "nested_123ln",
    name = ccb.content.text("12.3ln ammo"),
    description = ccb.content.text("Recipes related to reloading 12.3ln ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_123ln",
    "bp_123ln",
    "reloaded_123ln_ap",
    "bp_123ln_ap",
})

add_group({
    id = "nested_50beowulf",
    name = ccb.content.text(".50 Beowulf ammo"),
    description = ccb.content.text("Recipes related to reloading .50 Beowulf ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_50beowulf_xtp",
    "reloaded_50beowulf_penetrator",
    "bp_50beowulf_xtp",
    "bp_50beowulf_penetrator",
})

add_group({
    id = "nested_450",
    name = ccb.content.text(".450 Bushmaster ammo"),
    description = ccb.content.text("Recipes related to reloading .450 Bushmaster ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_450_ftx",
    "reloaded_450_penetrator",
    "bp_450_ftx",
    "bp_450_penetrator",
})

add_group({
    id = "nested_338",
    name = ccb.content.text(".338 Lapua Magnum ammo"),
    description = ccb.content.text("Recipes related to reloading .338 Lapua Magnum ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_338lapua_hpbt",
    "reloaded_338lapua_fmjbt",
    "reloaded_338lapua_api",
    "bp_338lapua_hpbt",
    "bp_338lapua_fmjbt",
    "bp_338lapua_api",
})

add_group({
    id = "nested_3030",
    name = ccb.content.text(".30-30 Winchester ammo"),
    description = ccb.content.text("Recipes related to reloading .30-30 Winchester ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    activity_level = 1,
}, {
    "reloaded_3030",
    "reloaded_3030_fmj",
    "reloaded_3030_bp",
    "reloaded_3030_fmj_bp",
})

add_group({
    id = "nested_12_gauge",
    name = ccb.content.text("12 gauge ammo"),
    description = ccb.content.text("Recipes related to reloading 12 gauge ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    activity_level = 1,
}, {
    "reloaded_shot_00",
    "reloaded_shot_bird",
    "reloaded_shot_slug",
    "wax_slug",
    "shot_scrap",
    "reloaded_shot_dragon",
    "reloaded_shot_flechette",
    "bp_shot_00",
    "bp_shot_bird",
    "bp_shot_slug",
    "bp_shot_scrap",
    "bp_shot_dragon",
    "bp_shot_flechette",
    "bp_shot_00_with dowel",
    "bp_shot_bird_with dowel",
    "bp_shot_slug_with dowel",
    "bp_shot_scrap_with dowel",
    "bp_shot_dragon_with dowel",
}, {
    "bp_shot_flechette_with dowel",
})

add_group({
    id = "nested_410bore",
    name = ccb.content.text(".410 bore ammo"),
    description = ccb.content.text("Recipes related to reloading .410 bore ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    activity_level = 1,
}, {
    "reloaded_410shot_000",
    "reloaded_410shot_bird",
    "reloaded_410shot_slug",
    "410shot_scrap",
    "bp_410shot_000",
    "bp_410shot_bird",
    "bp_410shot_slug",
    "bp_410shot_scrap",
    "bp_410shot_000_with_dowel",
    "bp_410shot_bird_with_dowel",
    "bp_410shot_slug_with_dowel",
    "bp_410shot_scrap_with_dowel",
})

add_group({
    id = "nested_blunderbuss",
    name = ccb.content.text("blunderbuss ammo"),
    description = ccb.content.text("Recipes related to reloading blunderbuss ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    activity_level = 1,
}, {
    "blun_lead_shot",
    "blun_shot",
    "blun_shot_using_big_scrap",
    "blun_slug_using_lead",
    "blun_flechette",
})

add_group({
    id = "nested_40x46",
    name = ccb.content.text("40x46mm ammo"),
    description = ccb.content.text("Recipes related to reloading 40x46mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    activity_level = 1,
}, {
    "40x46mm_hornets_nest_22lr",
    "40x46mm_hornets_nest_410_slug",
    "40x46mm_hornets_nest_410_bird",
    "40x46mm_hornets_nest_410",
    "40x46mm_hornets_nest_410_scrap",
})

add_group({
    id = "nested_40x53",
    name = ccb.content.text("40x53mm ammo"),
    description = ccb.content.text("Recipes related to reloading 40x53mm ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    activity_level = 1,
}, {
    "40x53mm_buckshot_m169",
    "40x53mm_slug_m169",
    "40x53mm_flechette_m169",
    "bp_40x53mm_buckshot_m169",
    "bp_40x53mm_slug_m169",
    "bp_40x53mm_flechette_m169",
})

add_group({
    id = "nested_wood_sword",
    name = ccb.content.text("wooden swords"),
    description = ccb.content.text("Recipes for making wooden swords with various purposes and levels of refinement."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "sword_wood",
    "sword_wood_large",
    "sword_nail",
    "bokken",
})

add_group({
    id = "nested_warhammer",
    name = ccb.content.text("warhammers"),
    description = ccb.content.text("Recipes for making hammers used as weapons instead of tools."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "warhammer",
    "lucern_hammer",
    "homemade_polehammer",
    "crowbar_warhammer",
})

add_group({
    id = "nested_bat",
    name = ccb.content.text("bats"),
    description = ccb.content.text("Recipes for making baseball bats and improving them with various materials."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "bat",
    "bat_with_lathe",
    "nailbat",
    "bwirebat",
    "nutboltbat",
    "bat_metal_bolt",
    "goedendag_bat",
})

add_group({
    id = "nested_baton",
    name = ccb.content.text("batons"),
    description = ccb.content.text("Recipes for making bashing sticks known variously as batons, tonfas or truncheons."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "tonfa",
    "tonfa_wood",
    "shocktonfa_off",
    "blackjack",
    "cudgel",
})

add_group({
    id = "nested_club",
    name = ccb.content.text("clubs"),
    description = ccb.content.text("Recipes for making wooden clubs of various levels of refinement."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    activity_level = 2,
}, {
    "club_wooden",
    "club_wooden_nails",
    "club_wooden_bolted",
    "club_wooden_large_nails",
    "club_wooden_large_bolted",
    "shillelagh",
}, {
    "2H_club_kanabo_spiked",
    "2H_club_kanabo_studded",
})

add_group({
    id = "nested_machete",
    name = ccb.content.text("machetes"),
    description = ccb.content.text("Recipes for making useful tools able to cut through both brush and zombie limbs."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 2,
}, {
    "machete",
    "makeshift_machete",
    "survivor_machete_qt",
})

add_group({
    id = "nested_makeshift_swords",
    name = ccb.content.text("improvised swords"),
    description = ccb.content.text("Recipes for creating metal swords of dubious quality out of dubious materials."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    activity_level = 2,
}, {
    "sword_metal",
    "sword_metal_large",
    "sword_crude",
    "sword_crude_large",
}, {
    "sword_sheets_welded",
    "sword_sheets_welded_large",
})

add_group({
    id = "nested_speedloader_chutes",
    name = ccb.content.text("speedloader chutes"),
    description = ccb.content.text("Recipes for creating tools useful to reload high capacity shotguns faster."),
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    activity_level = 2,
}, {
    "arredondo_chute_remington_870",
    "arredondo_chute_remington_870_simple",
    "arredondo_chute_remington_870_breacher",
    "arredondo_chute_remington_870_breacher_simple",
    "arredondo_chute_benelli_sa",
    "arredondo_chute_benelli_sa_simple",
    "arredondo_chute_mossberg_500",
    "arredondo_chute_mossberg_500_simple",
    "arredondo_chute_mossberg_930",
    "arredondo_chute_mossberg_930_simple",
    "arredondo_chute_mossberg_590",
    "arredondo_chute_mossberg_590_simple",
})

add_group({
    id = "nested_offal_canned",
    name = ccb.content.text("Canned Offal(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned offal in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "offal_canned_jarred",
    "offal_canned_jarred_3l",
    "offal_canned_canned",
    "offal_canned_canned_small",
    "offal_canned_canned_big",
})

add_group({
    id = "nested_offal_pickled",
    name = ccb.content.text("Pickled Offal(Jars)"),
    description = ccb.content.text("Recipes related to putting pickled offal in jars."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "offal_pickled_jarred",
    "offal_pickled_jarred_3l",
})

add_group({
    id = "nested_dogfood",
    name = ccb.content.text("Dogfood(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting dog food in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    activity_level = 2,
}, {
    "dogfood_jarred",
    "dogfood_jarred_3l",
    "dogfood_canned",
    "dogfood_canned_big",
})

add_group({
    id = "nested_catfood",
    name = ccb.content.text("Catfood(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting cat food in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    activity_level = 2,
}, {
    "catfood_jarred",
    "catfood_jarred_3l",
    "catfood_canned",
    "catfood_canned_medium",
    "catfood_canned_big",
})

add_group({
    id = "nested_mushroom_soup",
    name = ccb.content.text("Mushroom Soup(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting mushroom soup in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "soup_mushroom_jarred",
    "soup_mushroom_jarred_3l",
    "soup_mushroom_canned",
    "soup_mushroom_canned_small",
    "soup_mushroom_canned_big",
})

add_group({
    id = "nested_canned_meat",
    name = ccb.content.text("Canned Meat(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned meat in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "meat_canned_jarred",
    "meat_canned_jarred_3l",
    "meat_canned",
    "meat_canned_canned_medium",
    "meat_canned_canned_big",
})

add_group({
    id = "nested_pickled_meat",
    name = ccb.content.text("Pickled Meat(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting pickled meat in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "meat_pickled_jarred",
    "meat_pickled_jarred_3l",
})

add_group({
    id = "nested_canned_fish",
    name = ccb.content.text("Canned Fish(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned fish in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "fish_canned_jarred",
    "fish_canned_jarred_3l",
    "fish_canned",
    "fish_canned_canned_medium",
    "fish_canned_canned_big",
})

add_group({
    id = "nested_pickled_fish",
    name = ccb.content.text("Pickled Fish(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting pickled fish in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "fish_pickled_jarred",
    "fish_pickled_jarred_3l",
})

add_group({
    id = "nested_canned_lobster",
    name = ccb.content.text("Canned Lobster(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned lobster in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "lobster_canned_jarred",
    "lobster_canned_jarred_3l",
    "lobster_canned",
    "lobster_canned_canned_medium",
    "lobster_canned_canned_big",
})

add_group({
    id = "nested_canned_veggy",
    name = ccb.content.text("Canned Veggy(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned veggy in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "veggy_canned_jarred",
    "veggy_canned_jarred_3l",
    "veggy_canned",
    "veggy_canned_canned_medium",
    "veggy_canned_canned_big",
})

add_group({
    id = "nested_pickled_veggy",
    name = ccb.content.text("Pickled Veggy(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting pickled veggy in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "veggy_pickled_jarred",
    "veggy_pickled_jarred_3l",
})

add_group({
    id = "nested_canned_chicken",
    name = ccb.content.text("Canned Chicken(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned chicken in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "can_chicken_jarred",
    "can_chicken_jarred_3l",
    "can_chicken",
    "can_chicken_canned_medium",
    "can_chicken_canned_big",
})

add_group({
    id = "nested_woods_soup",
    name = ccb.content.text("Woods Soup(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting woods soup in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "soup_woods_jarred",
    "soup_woods_jarred_3l",
    "soup_woods_canned",
    "soup_woods_canned_big",
})

add_group({
    id = "nested_meat_soup",
    name = ccb.content.text("Meat Soup(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting meat soup in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "soup_meat_jarred",
    "soup_meat_jarred_3l",
    "soup_meat_canned",
    "soup_meat_canned_big",
})

add_group({
    id = "nested_veggy_soup",
    name = ccb.content.text("Veggy Soup(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting veggy soup in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "soup_veggy_jarred",
    "soup_veggy_jarred_3l",
    "soup_veggy_canned",
    "soup_veggy_canned_big",
})

add_group({
    id = "nested_fish_soup",
    name = ccb.content.text("Fish Soup(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting fish soup in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "soup_fish_jarred",
    "soup_fish_jarred_3l",
    "soup_fish_canned",
    "soup_fish_canned_big",
})

add_group({
    id = "nested_broth",
    name = ccb.content.text("Broth(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting broth in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "broth_jarred",
    "broth_jarred_3l",
    "broth_canned",
    "broth_canned_small",
    "broth_canned_big",
})

add_group({
    id = "nested_broth_meat",
    name = ccb.content.text("Meat Broth(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting meat broth in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "broth_meat_jarred",
    "broth_meat_jarred_3l",
    "broth_meat_canned",
    "broth_meat_canned_small",
    "broth_meat_canned_big",
})

add_group({
    id = "nested_broth_bone",
    name = ccb.content.text("Bone Broth(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting bone broth in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "broth_bone_jarred",
    "broth_bone_jarred_3l",
    "broth_bone_canned",
    "broth_bone_canned_small",
    "broth_bone_canned_big",
})

add_group({
    id = "nested_canned_beans",
    name = ccb.content.text("Canned Beans(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned beans in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "can_beans_jarred",
    "can_beans_jarred_3l",
    "can_beans",
    "can_beans_canned_big",
})

add_group({
    id = "nested_con_milk",
    name = ccb.content.text("Condensed Milk(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting condensed milk in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    activity_level = 2,
}, {
    "con_milk_jarred",
    "con_milk_jarred_3l",
    "con_milk_canned",
    "con_milk_canned_small",
    "con_milk_canned_big",
})

add_group({
    id = "nested_canned_liver",
    name = ccb.content.text("Canned Liver(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting canned liver in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "canned_liver_jarred",
    "canned_liver_jarred_3l",
    "canned_liver",
    "canned_liver_canned_medium",
    "canned_liver_canned_big",
})

add_group({
    id = "nested_canned_heart",
    name = ccb.content.text("Canned Heart(Jars)"),
    description = ccb.content.text("Recipes related to putting canned heart in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    activity_level = 2,
}, {
    "canned_heart_jarred",
    "canned_heart_jarred_3l",
})

add_group({
    id = "nested_v8_jarred",
    name = ccb.content.text("V8(Jars)"),
    description = ccb.content.text("Recipes related to putting V8 in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "V8_jarred",
})

add_group({
    id = "nested_sauce_red",
    name = ccb.content.text("Red Sauce(Jars and Tins)"),
    description = ccb.content.text("Recipes related to putting red sauce in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "sauce_red_jarred",
    "sauce_red_jarred_3l",
    "sauce_red_canned",
    "sauce_red_canned_small",
    "sauce_red_canned_big",
})

add_group({
    id = "nested_can_tomato",
    name = ccb.content.text("Canned Tomato(Jars)"),
    description = ccb.content.text("Recipes related to putting canned tomato in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "can_tomato_jarred",
    "can_tomato_jarred_3l",
    "can_tomato",
    "can_tomato_canned_medium",
    "can_tomato_canned_big",
})

add_group({
    id = "nested_kompot_jarred",
    name = ccb.content.text("Kompot(Jars)"),
    description = ccb.content.text("Recipes related to putting kompot in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "kompot_jarred",
    "kompot_jarred_3l",
})

add_group({
    id = "nested_cranberry_juice",
    name = ccb.content.text("Cranberry Juice(Jars and Canned)"),
    description = ccb.content.text("Recipes related to putting cranberry juice in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "cranberry_juice_jarred",
    "cranberry_juice_jarred_3l",
    "cranberry_juice_canned",
    "cranberry_juice_canned_small",
    "cranberry_juice_canned_big",
})

add_group({
    id = "nested_juice",
    name = ccb.content.text("Juice(Jars and Canned)"),
    description = ccb.content.text("Recipes related to putting juice in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "juice_jarred",
    "juice_jarred_3l",
    "juice_canned",
    "juice_canned_small",
    "juice_canned_big",
})

add_group({
    id = "nested_oj",
    name = ccb.content.text("Orange Juice(Jars and Canned)"),
    description = ccb.content.text("Recipes related to putting orange juice in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "oj_fresh_jarred",
    "oj_fresh_jarred_3l",
    "oj_fresh_canned",
    "oj_fresh_canned_small",
    "oj_fresh_canned_big",
})

add_group({
    id = "nested_apple_cider",
    name = ccb.content.text("Apple Cider(Jars and Canned)"),
    description = ccb.content.text("Recipes related to putting apple cider in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "apple_cider_jarred",
    "apple_cider_jarred_3l",
    "apple_cider_canned",
    "apple_cider_canned_small",
    "apple_cider_canned_big",
})

add_group({
    id = "nested_jam_fruit",
    name = ccb.content.text("Fruit Jam(Jars)"),
    description = ccb.content.text("Recipes related to putting fruit jam in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    activity_level = 2,
}, {
    "jam_fruit_jarred",
    "jam_fruit_jarred_3L",
})

add_group({
    id = "nested_apple_canned",
    name = ccb.content.text("Canned Fruit(Jars and Canned)"),
    description = ccb.content.text("Recipes related to putting canned fruit in jars and tins."),
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    activity_level = 2,
}, {
    "apple_canned_jarred",
    "apple_canned_jarred_3l",
    "apple_canned",
    "apple_canned_canned_medium",
    "apple_canned_canned_big",
})

add_group({
    id = "nested_steel_cores",
    name = ccb.content.text("steel cores"),
    description = ccb.content.text("Recipes for creating steel cores for making ap ammo."),
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    activity_level = 2,
}, {
    "9x18_steel_core",
    "3006_steel_core",
    "123_steel_core",
    "545_steel_core",
    "50_steel_core",
})
