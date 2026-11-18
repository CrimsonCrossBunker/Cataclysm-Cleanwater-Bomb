local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_Isherwood_male_worn", kind = "collection" }
    group:entry {
        distribution = {
            { item = "backpack_leather" },
            { item = "wicker_backpack" },
            { item = "slingpack" },
        },
    }
    group:entry {
        distribution = {
            { item = "jacket_light" },
            { item = "jacket_leather" },
            { item = "trenchcoat" },
            { item = "jacket_jean" },
            { item = "vest_jean" },
            { item = "jacket_flannel" },
        },
    }
    group:entry {
        collection = {
            { item = "3006", container = "ammo_pouch" },
            { item = "3006", charges = { 4, 8 } },
        },
    }
    group:entry { item = "3006", charges = { 4, 8 } }
    group:entry {
        distribution = {
            { item = "boxer_briefs" },
            { item = "boxer_shorts" },
            { item = "briefs" },
        },
    }
    group:entry {
        distribution = {
            { item = "tshirt" },
            { item = "undershirt" },
        },
    }
    group:entry {
        distribution = {
            { item = "jeans" },
            { item = "pants_cargo" },
            { item = "pants_leather" },
        },
    }
    group:item("leather_belt", 50)
    group:item("gloves_fingerless", 50)
    group:item("cowboy_hat", 80)
    group:entry {
        distribution = {
            { item = "boots" },
            { item = "boots_western" },
        },
    }
    group:item("socks", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_Isherwood_female_worn", kind = "collection" }
    group:entry {
        distribution = {
            { item = "backpack_leather" },
            { item = "wicker_backpack" },
            { item = "slingpack" },
        },
    }
    group:entry {
        distribution = {
            { item = "jacket_light" },
            { item = "jacket_leather" },
            { item = "trenchcoat" },
            { item = "jacket_jean" },
            { item = "vest_jean" },
            { item = "jacket_flannel" },
        },
    }
    group:entry {
        collection = {
            { item = "3006", container = "ammo_pouch" },
            { item = "3006", charges = { 4, 8 } },
        },
    }
    group:entry { item = "3006", charges = { 4, 8 } }
    group:entry {
        distribution = {
            { item = "bra" },
            { item = "sports_bra" },
            { item = "camisole" },
            { item = "halter_top" },
        },
    }
    group:entry {
        distribution = {
            { item = "panties" },
            { item = "boy_shorts" },
        },
    }
    group:entry {
        distribution = {
            { item = "tshirt" },
            { item = "longshirt" },
            { item = "undershirt" },
        },
    }
    group:entry {
        distribution = {
            { item = "jeans" },
            { item = "pants_cargo" },
            { item = "pants_leather" },
        },
    }
    group:item("leather_belt", 50)
    group:item("gloves_fingerless", 50)
    group:item("cowboy_hat", 80)
    group:entry {
        distribution = {
            { item = "boots" },
            { item = "boots_western" },
        },
    }
    group:item("socks", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_rifle", kind = "distribution" }
    group:entry {
        item = "browning_blr",
        charges = { 4, 4 },
        contents = {
            { group = "NC_ISHERWOOD_rifle_mods" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_rifle_mods", kind = "collection" }
    group:item("shoulder_strap")
    group:entry {
        distribution = {
            { item = "butt_hook" },
            { item = "cheek_pad" },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "improve_sights" },
            { item = "rifle_scope" },
        },
        probability = 90,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_JACK_misc", kind = "distribution" }
    group:group("cheese_hard_wrapper_8", 50)
    group:item("vinegar", 55)
    group:group("veggy_pickled_jar_glass_sealed_2", 50)
    group:group("sauerkraut_jar_glass_sealed_2", 50)
    group:group("meat_pickled_jar_glass_sealed_2", 50)
    group:group("fish_pickled_jar_glass_sealed_2", 60)
    group:group("meat_canned_jar_3l_glass_sealed_12", 40)
    group:group("veggy_canned_jar_3l_glass_sealed_12", 40)
    group:group("fruits_in_3l_jar", 40)
    group:group("can_tomato_jar_3l_glass_sealed_24", 40)
    group:group("fish_pickled_jar_3l_glass_sealed_12", 40)
    group:group("meat_pickled_jar_3l_glass_sealed_12", 40)
    group:group("veggy_pickled_jar_3l_glass_sealed_12", 40)
    group:group("fish_pickled_jar_3l_glass_sealed_12", 40)
    group:entry { item = "sauce_red", charges = { 48, 48 }, container = "jar_3l_glass_sealed", probability = 40 }
    group:entry { item = "kompot", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 40 }
    content.add(group)
end
