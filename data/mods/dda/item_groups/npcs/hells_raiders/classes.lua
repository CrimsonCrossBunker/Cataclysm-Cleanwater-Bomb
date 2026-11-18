local content = require("ccb").content

do
    -- Stuff a quartermaster from the Hell's Raiders might sell.
    local group = content.ItemGroup { id = "bandit_quartermaster_sell", kind = "distribution" }
    group:group("preserved_food", 50)
    group:group("cannedfood", 70)
    group:group("big_canned_food", 30)
    group:group("dry_goods", 40)
    content.add(group)
end

do
    -- Stuff a fenceman from the Hell's Raiders might sell.
    local group = content.ItemGroup { id = "bandit_merchant_sell", kind = "distribution" }
    group:group("bandit_drugs", 30)
    group:group("bandit_guns&ammo", 25)
    group:group("traveler", 50)
    group:group("alcohol", 30)
    content.add(group)
end

do
    -- Stuff a fenceman from the Hell's Raiders might sell.
    local group = content.ItemGroup { id = "bandit_drugs", kind = "distribution" }
    group:group("drugs_pharmacy", 80)
    group:group("drugs_analgesic", 80)
    group:group("tobacco_products", 80)
    group:group("drugs_soldier", 40)
    content.add(group)
end

do
    -- Stuff a fenceman from the Hell's Raiders might sell.
    local group = content.ItemGroup { id = "bandit_guns&ammo", kind = "distribution" }
    group:group("guns_pistol_common", 270)
    group:group("guns_smg_improvised", 90)
    group:group("guns_rifle_common", 175)
    group:group("ammo_common_boxed", 300)
    content.add(group)
end
