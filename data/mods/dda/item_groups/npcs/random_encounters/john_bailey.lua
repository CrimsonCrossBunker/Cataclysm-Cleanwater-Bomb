local content = require("ccb").content

do
    -- Needs some editing, this is a quick version.  Should be equipped to last to mid-game at least, but feel mostly scavenged.
    local group = content.ItemGroup { id = "John_Bailey_worn", kind = "collection" }
    group:item("boots_combat")
    group:item("socks")
    group:entry {
        item = "level_3_vest",
        variant = "national_guard_armor_vest",
        contents = {
            { group = "some_steel_front_plates" },
        },
    }
    group:item("boxer_shorts")
    group:item("pants_army")
    group:item("legguard_hard")
    group:item("tshirt")
    group:item("sweatshirt")
    group:item("spearsling")
    group:item("tac_helmet")
    group:item("backpack_hiking")
    group:item("wristwatch")
    group:entry {
        item = "bandolier_pistol",
        contents = {
            { group = "john_bailey_bandolier" },
        },
    }
    group:entry {
        item = "holster",
        contents = {
            { group = "john_bailey_pistol" },
        },
    }
    group:entry {
        item = "bow_sling",
        contents = {
            { item = "compbow_low" },
        },
    }
    group:entry {
        item = "quiver",
        contents = {
            { group = "john_bailey_quiver" },
        },
    }
    content.add(group)
end

do
    -- Needs some editing, and randomization.  Should carry a first aid kit, food and a bit of prep, and some random loot he's gathered from his travels.  We could pare down what he has on his person and move a bit more to his bike.
    local group = content.ItemGroup { id = "John_Bailey_carried", kind = "collection" }
    group:group("candy_chocolate")
    group:group("snacks")
    group:group("beer_in_container")
    group:group("foodintincan")
    group:group("charged_two_way_radio")
    group:group("soup_packet")
    group:item("dogfood_dry")
    group:entry { item = "lighter", charges = { 100, 100 } }
    group:group("bottle_otc_painkiller_20")
    group:entry { item = "bandages", count = { 1, 3 } }
    group:item("pot")
    group:entry { item = "FMCNote", count = { 10, 10 } }
    group:entry { item = "357mag_fmj", count = { 2, 2 } }
    group:entry { item = "water_clean", container = "camelbak" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "John_Bailey_wield", kind = "collection" }
    group:item("spear_pipe")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "john_bailey_bandolier", kind = "collection" }
    group:entry { item = "357mag_fmj", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "john_bailey_quiver", kind = "collection" }
    group:entry { item = "arrow_cf", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "john_bailey_pistol", kind = "collection" }
    group:entry { item = "sw_619", charges = { 7, 7 }, ammo = { item = "357mag_fmj" } }
    content.add(group)
end
