local content = require("ccb").content

do
    -- copy-from: wallet_leather_full
    local group = content.ItemGroup {
        id = "wallet_phavian_leather_full",
        kind = "collection",
        container = "wallet_leather",
        overflow = "discard",
    }
    group:entry { item = "cash_card", charges = { 0, 50000 } }
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:item("id_science")
    group:item("id_science_visitor_phavian")
    group:item("id_science_visitor_1", 15)
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
        id = "wallet_phavian_full",
        kind = "collection",
        container = "wallet",
        overflow = "discard",
    }
    group:entry { item = "cash_card", charges = { 0, 50000 } }
    group:item("id_science")
    group:item("id_science_visitor_phavian")
    group:item("id_science_visitor_1", 15)
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 1, 3 }, probability = 40 }
    group:item("condom", 10)
    group:item("labmap", 20)
    group:item("wallet_photo", 20)
    group:item("scorecard", 20)
    content.add(group)
end

do
    -- copy-from: wallet_stylish_full
    local group = content.ItemGroup {
        id = "wallet_phavian_stylish_full",
        kind = "collection",
        container = "wallet_stylish",
        overflow = "discard",
    }
    group:item("id_science")
    group:item("id_science_visitor_phavian")
    group:item("id_science_visitor_1", 15)
    group:entry { item = "cash_card", charges = { 10000, 50000 } }
    group:entry { group = "banknotes", count = { 1, 20 }, probability = 80 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 80 }
    group:entry { group = "discount_cards", count = { 2, 5 }, probability = 60 }
    group:item("condom", 10)
    group:item("labmap", 20)
    group:item("wallet_photo", 20)
    group:item("scorecard", 5)
    content.add(group)
end
