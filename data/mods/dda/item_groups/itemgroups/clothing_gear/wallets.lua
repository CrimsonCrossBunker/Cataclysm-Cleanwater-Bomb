local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wallets_military", kind = "distribution" }
    group:group("wallet_military_full", 50)
    group:group("wallet_military_leather_full", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallets_industrial", kind = "distribution" }
    group:group("wallet_industrial_full", 50)
    group:group("wallet_industrial_leather_full", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallet_full", kind = "collection", container = "wallet" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_full
    local group = content.ItemGroup { id = "wallet_leather_full", kind = "collection", container = "wallet_leather" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_full
    local group = content.ItemGroup { id = "wallet_large_full", kind = "collection", container = "wallet_large" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallet_duct_tape_full", kind = "collection", container = "wallet_duct_tape" }
    group:item("credit_card", 50)
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 50 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:group("discount_cards", 10)
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallet_stylish_full", kind = "collection", container = "wallet_stylish" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 2, 5 }, probability = 60 }
    group:item("condom_sealed", 10)
    group:entry { item = "money_hundred", count = { 1, 5 }, probability = 10 }
    group:item("wallet_photo", 20)
    group:item("scorecard", 5)
    content.add(group)
end

do
    -- copy-from: wallet_leather_full
    local group = content.ItemGroup { id = "wallet_military_leather_full", kind = "collection", container = "wallet_leather" }
    group:item("credit_card")
    group:item("id_military")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_full
    local group = content.ItemGroup { id = "wallet_military_full", kind = "collection", container = "wallet" }
    group:item("credit_card")
    group:item("id_military")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_leather_full
    local group = content.ItemGroup {
        id = "wallet_science_leather_full",
        kind = "collection",
        container = "wallet_leather",
        overflow = "discard",
    }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:item("id_science")
    group:item("id_science_visitor_1")
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("labmap", 30)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_full
    local group = content.ItemGroup {
        id = "wallet_science_full",
        kind = "collection",
        container = "wallet",
        overflow = "discard",
    }
    group:item("credit_card")
    group:item("id_science")
    group:item("id_science_visitor_1")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("labmap", 20)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_stylish_full
    local group = content.ItemGroup {
        id = "wallet_science_stylish_full",
        kind = "collection",
        container = "wallet_stylish",
        overflow = "discard",
    }
    group:item("id_science")
    group:item("id_science_visitor_1")
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 2, 5 }, probability = 60 }
    group:item("condom_sealed", 10)
    group:item("labmap", 20)
    group:item("wallet_photo", 20)
    group:item("scorecard", 5)
    content.add(group)
end

do
    -- No coins/cash cards and less physical money.
    local group = content.ItemGroup {
        id = "lanyard_science_full",
        kind = "collection",
        container = "lanyard",
        overflow = "discard",
    }
    group:item("id_science")
    group:item("id_science_visitor_1")
    group:entry { group = "banknotes", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("labmap", 20)
    group:item("wallet_photo", 30)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_leather_full
    local group = content.ItemGroup { id = "wallet_industrial_leather_full", kind = "collection", container = "wallet_leather" }
    group:item("credit_card")
    group:item("id_industrial")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_full
    local group = content.ItemGroup { id = "wallet_industrial_full", kind = "collection", container = "wallet" }
    group:item("credit_card")
    group:item("id_industrial")
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom_sealed", 10)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "starter_wallet_full", kind = "collection", container = "wallet" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 2 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 5 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "starter_rich_wallet_full", kind = "collection", container = "wallet_stylish" }
    group:item("credit_card")
    group:entry { group = "banknotes", count = { 1, 2 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 5 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallets_science", kind = "distribution" }
    group:group("wallet_science_full", 45)
    group:group("wallet_science_leather_full", 20)
    group:group("wallet_science_stylish_full", 20)
    group:group("lanyard_science_full", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "banknotes", kind = "distribution" }
    group:item("money_one", 26)
    group:item("money_two", 2)
    group:item("money_five", 6)
    group:item("money_ten", 5)
    group:item("money_twenty", 23)
    group:item("money_fifty", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coins", kind = "distribution" }
    group:item("coin_penny", 57)
    group:item("coin_nickel", 10)
    group:item("coin_dime", 19)
    group:item("coin_quarter", 13)
    group:item("coin_half_dollar", 1)
    group:item("coin_dollar", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "discount_cards", kind = "distribution" }
    group:item("fp_loyalty_card", 40)
    group:item("gasdiscount_silver", 20)
    group:item("gasdiscount_gold", 10)
    group:item("gasdiscount_platinum", 5)
    content.add(group)
end
