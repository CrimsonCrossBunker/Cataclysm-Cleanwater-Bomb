local content = require("ccb").content

do
    local group = content.ItemGroup { id = "defense_caravan_melee", kind = "collection" }
    group:item("hammer")
    group:item("bat")
    group:item("mace")
    group:item("morningstar")
    group:item("hammer_sledge")
    group:item("hatchet")
    group:item("knife_combat")
    group:item("hc_rapier")
    group:item("machete")
    group:item("hc_katana")
    group:item("spear_knife")
    group:item("pike")
    group:item("chainsaw_off")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "defense_caravan_ammunition", kind = "collection" }
    group:item("bolt_steel")
    group:item("arrow_cf")
    group:item("22_lr")
    group:item("9mm")
    group:item("38_special")
    group:item("44magnum")
    group:item("45_acp")
    group:item("57mm")
    group:item("shot_00")
    group:item("shot_slug")
    group:item("3006")
    group:item("762_m87")
    group:item("556")
    group:item("762_51")
    group:item("12mm")
    group:item("plasma")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "defense_caravan_components", kind = "collection" }
    group:item("cotton_patchwork")
    group:item("fur")
    group:item("leather")
    group:group("glue_strong_domestic")
    group:group("glue_weak_domestic")
    group:item("string_36")
    group:item("chain")
    group:item("processor")
    group:item("RAM")
    group:item("power_supply")
    group:item("motor")
    group:item("hose")
    group:item("pot")
    group:item("2x4")
    group:group("ammo_any_batteries_full")
    group:item("nail")
    group:item("gasoline")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "defense_caravan_clothes", kind = "collection" }
    group:item("backpack")
    group:item("vest")
    group:item("trenchcoat")
    group:item("jacket_leather")
    group:item("kevlar")
    group:item("gloves_fingerless")
    group:item("mask_filter")
    group:item("mask_gas")
    group:item("glasses_eye")
    group:item("glasses_safety")
    group:item("goggles_ski")
    group:item("goggles_nv")
    group:item("helmet_ball")
    group:item("helmet_riot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "defense_caravan_tools", kind = "collection" }
    group:item("screwdriver")
    group:item("wrench")
    group:item("saw")
    group:item("hacksaw")
    group:item("lighter")
    group:item("sewing_kit")
    group:item("scissors")
    group:item("extinguisher")
    group:item("flashlight")
    group:item("hotplate")
    group:item("soldering_iron")
    group:item("shovel")
    group:item("jackhammer")
    group:item("landmine")
    group:item("teleporter")
    group:item("grenade")
    group:item("flashbang")
    group:item("EMPbomb")
    group:item("smokebomb")
    group:item("bot_manhack")
    group:item("bot_turret")
    group:item("UPS_OFF")
    group:item("mininuke")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DM_MERCHANT_worn", kind = "collection" }
    group:group("npc_pants_male")
    group:group("npc_underwear_feet_male")
    group:group("npc_underwear_bottom_male")
    group:group("npc_shirt_male")
    group:group("npc_shoes_male")
    group:item("debug_backpack")
    group:item("debug_backpack")
    group:item("debug_backpack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DM_MERCHANT_carry", kind = "collection" }
    group:group("NC_DM_MERCHANT_stock")
    group:group("NC_DM_MERCHANT_stock")
    group:group("NC_DM_MERCHANT_stock")
    group:entry { item = "FMCNote", count = { 700, 1000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DM_MERCHANT_stock", kind = "collection" }
    group:group("trader_farmingstuff", 70)
    group:group("everyday_gear", 70)
    group:group("child_items", 70)
    group:group("traveler", 70)
    group:group("swat_gear", 70)
    group:group("gear_survival", 70)
    group:group("civilian_body_armor", 70)
    group:group("drugs_pharmacy", 70)
    group:group("preserved_food")
    group:group("preserved_food")
    group:group("preserved_food")
    group:group("pet_food_in_container", 70)
    group:group("condiments", 70)
    group:entry { group = "trader_guns&ammo", charges = { 50, 50 }, probability = 70 }
    group:group("hardware", 70)
    group:group("defense_caravan_melee", 70)
    group:entry { group = "defense_caravan_ranged", charges = { 50, 50 }, probability = 70 }
    group:group("defense_caravan_ammunition", 70)
    group:group("defense_caravan_components", 70)
    group:group("defense_caravan_clothes", 70)
    group:group("defense_caravan_tools", 70)
    group:group("hardware_bulk", 70)
    group:group("lumberyard", 70)
    group:group("supplies_hardware", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "trader_farmingstuff", kind = "collection" }
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_seeds")
    group:group("farming_tools", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "trader_guns&ammo", kind = "collection" }
    group:group("guns_pistol_common")
    group:group("guns_shotgun_common")
    group:group("guns_shotgun_milspec", 95)
    group:group("guns_shotgun_improvised", 90)
    group:group("guns_smg_improvised", 90)
    group:group("guns_rifle_common")
    group:group("ammo_common_boxed")
    content.add(group)
end
