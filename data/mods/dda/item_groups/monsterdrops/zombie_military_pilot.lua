local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "mon_zombie_military_pilot_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry { group = "clothing_military_pilot", damage = { 1, 4 } }
    group:entry {
        item = "holster",
        contents = {
            { group = "military_standard_pistols" },
        },
    }
    group:group("military_patrol_food", 30)
    group:item("two_way_radio", 30)
    group:group("adderall_bottle_plastic_pill_prescription_10", 40)
    group:group("wallets_military", 25)
    group:group("military_patrol_food", 30)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 60)
    content.add(group)
end
