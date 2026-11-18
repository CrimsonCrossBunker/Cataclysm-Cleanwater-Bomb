local content = require("ccb").content

do
    local group = content.ItemGroup { id = "zebra_worn_override", kind = "collection" }
    group:item("pants")
    group:item("dress_shirt")
    group:item("tie_skinny")
    group:item("blazer")
    group:item("trenchcoat")
    group:item("badge_zebra")
    group:item("gloves_leather")
    group:item("wristwatch")
    group:item("socks")
    group:item("dress_shoes")
    group:item("cig")
    group:item("shoulder_holster")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zebra_carry_override", kind = "collection" }
    group:group("charged_smart_phone")
    group:group("charged_two_way_radio")
    group:group("charged_ref_lighter")
    group:group("suppressed_fn57")
    group:group("diazepam_scrip")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zebra_weapon_override", kind = "collection" }
    group:entry { item = "fn57_sup", charges = { 20, 20 }, ammo = { item = "57mm_ss" } }
    content.add(group)
end
