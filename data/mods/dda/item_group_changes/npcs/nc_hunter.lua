local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_HUNTER_shirt", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("tank_top", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 20)
    group:item("gloves_fingerless", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 20)
    group:item("vest_jean", 10)
    group:item("jacket_flannel", 20)
    group:item("jacket_windbreaker", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_hat", kind = "distribution" }
    group:item("null", 40)
    group:item("hat_ball", 40)
    group:item("hat_hunting", 40)
    group:item("hat_boonie", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_extra", kind = "distribution" }
    group:item("null", 5)
    group:item("backpack_leather", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_archery", kind = "distribution" }
    group:item("crossbow", 20)
    group:item("shortbow", 5)
    group:item("compbow", 15)
    group:item("recurbow", 15)
    group:item("reflexbow", 10)
    group:item("longbow", 10)
    group:item("hand_crossbow", 15)
    group:item("selfbow", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_rifle", kind = "distribution" }
    group:item("rifle_22", 5)
    group:item("ruger_1022", 10)
    group:item("browning_blr", 10)
    group:item("remington_700", 10)
    group:item("remington_700_308", 5)
    group:item("marlin_9a", 25)
    group:item("m1903", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_HUNTER_misc", kind = "distribution" }
    group:item("sinew", 10)
    group:item("water_clean", 20)
    group:item("meat_cooked", 10)
    group:item("meat", 40)
    group:item("fish_cooked", 10)
    group:item("fish", 10)
    group:entry { item = "tallow", count = { 2, 2 }, probability = 10 }
    group:item("fat", 10)
    group:item("dry_meat", 10)
    group:item("dry_fish", 10)
    group:entry { item = "dry_veggy", count = { 2, 2 }, probability = 10 }
    group:item("dry_fruit", 10)
    group:group("salt_various", 10)
    group:group("pepper_various", 10)
    group:item("meat_smoked", 10)
    group:item("meat_smoked", 10)
    group:item("bone", 10)
    group:item("fur", 10)
    group:item("froglegs", 5)
    group:item("froglegs_cooked", 5)
    group:item("froglegs_smoked", 5)
    group:item("dry_froglegs", 5)
    content.add(group)
end
