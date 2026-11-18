local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "mon_zombie_milbase_personnel_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry { group = "clothing_military", damage = { 0, 4 } }
    group:entry { group = "clothing_military_headwear", damage = { 0, 4 }, probability = 40 }
    group:group("gear_soldier_sidearm", 10)
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:group("mil_food_nodrugs", 15)
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:item("dog_tag", 20)
    content.add(group)
end
