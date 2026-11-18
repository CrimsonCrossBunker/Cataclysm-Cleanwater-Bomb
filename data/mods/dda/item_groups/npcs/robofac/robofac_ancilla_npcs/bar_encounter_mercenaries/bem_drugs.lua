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
