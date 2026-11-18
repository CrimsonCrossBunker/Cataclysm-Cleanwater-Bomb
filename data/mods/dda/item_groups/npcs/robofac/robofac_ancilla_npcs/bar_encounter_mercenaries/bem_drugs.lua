local content = require("ccb").content

do
    local group = content.ItemGroup { id = "BEM_DRUGRUNNER_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:group("NC_BOUNTY_HUNTER_pants")
    group:item("pants_army")
    group:group("NC_BOUNTY_HUNTER_coat")
    group:item("boots_combat")
    group:item("molle_pack")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pure_meth_bag_zipper_1_6", kind = "collection", container = "bag_zipper" }
    group:entry { item = "pure_meth", count = { 1, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "BEM_DRUGRUNNER_stock", kind = "collection" }
    group:entry { item = "glock17_22", count = { 1, 2 }, charges = { 22, 22 }, ammo = { item = "9mmP" } }
    group:group("coke_bag_zipper_1_8", 30)
    group:group("pure_meth_bag_zipper_1_6", 30)
    group:group("heroin_bag_zipper_1_4")
    group:group("oxycodone_bottle_plastic_pill_prescription_1_10")
    group:entry { group = "harddrugs", count = { 6, 12 } }
    content.add(group)
end
