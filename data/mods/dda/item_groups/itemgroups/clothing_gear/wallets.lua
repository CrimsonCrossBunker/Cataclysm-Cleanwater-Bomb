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
