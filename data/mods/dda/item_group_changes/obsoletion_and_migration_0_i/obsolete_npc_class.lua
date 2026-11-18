local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARMY_pants_male", kind = "distribution" }
    group:item("pants_army", 90)
    group:item("pants_cargo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_pants_female", kind = "distribution" }
    group:item("pants_army", 90)
    group:item("pants_cargo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shirt_male", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("tank_top", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shirt_female", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("tank_top", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_gloves", kind = "distribution" }
    group:item("null", 50)
    group:item("gloves_tactical", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_coat", kind = "distribution" }
    group:item("null", 60)
    group:item("jacket_army", 40)
    group:item("ballistic_vest_esapi", 10)
    group:item("tacvest", 40)
    group:item("kevlar", 20)
    group:item("chestrig", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shoes", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_masks", kind = "distribution" }
    group:item("null", 60)
    group:item("keffiyeh", 30)
    group:item("mask_gas", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_eyes", kind = "distribution" }
    group:item("null", 40)
    group:item("glasses_bal", 50)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_hat", kind = "distribution" }
    group:item("null", 40)
    group:item("hat_ball", 10)
    group:item("tac_helmet", 30)
    group:item("helmet_army", 10)
    group:item("hat_boonie", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_extra", kind = "distribution" }
    group:item("null", 30)
    group:item("rucksack", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_bashing", kind = "distribution" }
    group:item("hammer", 20)
    group:item("wrench", 20)
    group:item("hammer_sledge", 20)
    group:item("pipe", 20)
    group:item("baton-extended", 20)
    group:item("crowbar", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_cutting", kind = "distribution" }
    group:item("knife_huge", 20, "knife_butcher")
    group:item("hatchet", 20)
    group:item("knife_combat", 20)
    group:item("machete", 20)
    group:item("knife_combat", 20)
    group:item("diveknife", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_throw", kind = "distribution" }
    group:item("throwing_knife", 50)
    group:item("throwing_axe", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_archery", kind = "distribution" }
    group:item("crossbow", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_pistols", kind = "distribution" }
    group:item("m1911", 30)
    group:item("m9", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shotgun", kind = "distribution" }
    group:item("mossberg_500", 25)
    group:item("remington_870", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_smg", kind = "distribution" }
    group:item("hk_mp5", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_rifle", kind = "distribution" }
    group:group("modular_m4a1", 50)
    group:item("m14ebr", 35)
    group:item("m249", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_launcher", kind = "distribution" }
    group:item("mgl", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_weapon_random", kind = "distribution" }
    group:item("q_staff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_misc", kind = "distribution" }
    group:item("grenade", 40)
    group:item("ref_lighter", 30)
    group:item("lighter", 30)
    group:item("matches", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HACKER_misc", kind = "distribution" }
    group:item("energy_drink", 55)
    group:item("energy_drink_atomic", 12)
    group:item("mag_computer", 45)
    group:item("mag_electronics", 25)
    group:item("colamdew", 50)
    group:group("adderall_bottle_plastic_pill_prescription_10", 10)
    group:item("fries", 10)
    group:item("cheese_fries", 10)
    group:item("onion_rings", 10)
    group:group("mintpatties_bag_plastic_3", 20)
    group:entry { item = "electrohack", charges = { 0, -1 }, probability = 3 }
    group:item("usb_drive", 15)
    group:group("ammo_pocket_batteries_full", 50)
    group:item("file", 10)
    group:item("manual_computer", 20)
    group:item("hackerman_computer", 20)
    group:item("textbook_computer", 8)
    group:item("textbook_anarch", 4)
    group:item("computer_science", 7)
    group:item("solar_cell", 5)
    group:item("SICP", 3)
    group:item("recipe_serum", 2)
    group:item("recipe_chimera", 1)
    group:item("recipe_labchem", 1)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:group("solder_wire_spool_part", 70)
    group:item("textbook_weapwest", 2)
    group:item("textbook_weparabic", 2)
    group:item("textbook_weapeast", 2)
    group:item("textbook_armwest", 2)
    group:item("textbook_armeast", 2)
    group:item("radio_book", 22)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NINJA_shirt", kind = "distribution" }
    group:item("karate_gi", 10)
    group:item("judo_gi", 10)
    group:item("keikogi", 10)
    group:item("zubon_gi", 10)
    group:item("hakama_gi", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NINJA_belt", kind = "distribution" }
    group:item("null", 50)
    group:item("judo_belt_black", 10)
    group:item("judo_belt_blue", 10)
    group:item("judo_belt_brown", 10)
    group:item("judo_belt_green", 40)
    group:item("judo_belt_orange", 40)
    group:item("judo_belt_white", 40)
    group:item("judo_belt_yellow", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_pants_male", kind = "distribution" }
    group:item("pants_army", 20)
    group:item("pants_cargo", 50)
    group:item("jeans", 30)
    group:item("shorts_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_pants_female", kind = "distribution" }
    group:item("pants_army", 20)
    group:item("pants_cargo", 50)
    group:item("jeans", 30)
    group:item("shorts_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shirt_male", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("denim_shirt", 20)
    group:item("tank_top", 20)
    group:item("longshirt", 20)
    group:item("hoodie", 40)
    group:item("sweatshirt", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shirt_female", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("tank_top", 20)
    group:item("longshirt", 20)
    group:item("hoodie", 40)
    group:item("sweatshirt", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_gloves", kind = "distribution" }
    group:item("null", 50)
    group:item("gloves_tactical", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_coat", kind = "distribution" }
    group:item("null", 60)
    group:item("jacket_army", 40)
    group:item("cloak", 20)
    group:item("ballistic_vest_esapi", 10)
    group:item("tacvest", 40)
    group:item("kevlar", 20)
    group:item("chestrig", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shoes", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_masks", kind = "distribution" }
    group:item("null", 60)
    group:item("keffiyeh", 30)
    group:item("mask_gas", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_eyes", kind = "distribution" }
    group:item("null", 40)
    group:item("glasses_bal", 50)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_hat", kind = "distribution" }
    group:item("null", 20)
    group:item("hat_ball", 50)
    group:item("tac_helmet", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_extra", kind = "distribution" }
    group:item("null", 30)
    group:item("rucksack", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_bashing", kind = "distribution" }
    group:item("hammer", 20)
    group:item("wrench", 20)
    group:item("hammer_sledge", 20)
    group:item("pipe", 20)
    group:item("baton-extended", 20)
    group:item("crowbar", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_cutting", kind = "distribution" }
    group:item("knife_huge", 20, "knife_butcher")
    group:item("hatchet", 20)
    group:item("knife_combat", 20)
    group:item("machete", 20)
    group:item("knife_combat", 20)
    group:item("diveknife", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_throw", kind = "distribution" }
    group:item("throwing_knife", 50)
    group:item("throwing_axe", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_archery", kind = "distribution" }
    group:item("crossbow", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_pistols", kind = "distribution" }
    group:item("m1911", 70)
    group:item("fn57", 50)
    group:item("m9", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shotgun", kind = "distribution" }
    group:item("mossberg_500", 25)
    group:item("remington_870", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_rifle", kind = "distribution" }
    group:group("modular_m4a1", 50)
    group:item("m14ebr", 35)
    group:item("m249", 20)
    group:group("h&k416a5_any", 50)
    group:item("M24", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_launcher", kind = "distribution" }
    group:item("mgl", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_weapon_random", kind = "distribution" }
    group:item("q_staff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_misc", kind = "distribution" }
    group:item("grenade", 40)
    group:item("ref_lighter", 30)
    group:item("lighter", 30)
    group:item("matches", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCIENTIST_eyes", kind = "distribution" }
    group:item("null", 20)
    group:item("glasses_safety", 40)
    group:item("glasses_eye", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCIENTIST_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 10)
    group:item("coat_lab", 60)
    group:item("jacket_light", 10)
    group:item("jacket_leather", 10)
    group:item("trenchcoat", 5)
    group:item("jacket_jean", 10)
    group:item("jacket_windbreaker", 5)
    group:item("kevlar", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_TRADER_storage", kind = "distribution" }
    group:item("duffelbag", 80)
    group:item("rucksack", 50)
    content.add(group)
end
