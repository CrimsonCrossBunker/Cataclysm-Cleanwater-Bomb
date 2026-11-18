local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cash_register_full", kind = "collection", container = "cash_register" }
    group:entry { group = "banknotes", count = { 5, 33 }, probability = 80 }
    group:entry { group = "coins", count = { 5, 33 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cash_register_looted", kind = "collection", container = "cash_register" }
    group:entry { group = "banknotes", count = { 1, 2 }, probability = 15 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 50 }
    group:item("survnote", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cash_register_empty", kind = "collection", container = "cash_register" }
    group:item("survnote", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cash_register_random", kind = "distribution" }
    group:group("cash_register_full", 40)
    group:group("cash_register_looted", 45)
    group:group("cash_register_empty", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cash_register_random_ransacked", kind = "distribution" }
    group:group("cash_register_looted", 30)
    group:group("cash_register_empty", 20)
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cash_register_impulse_buy_general", kind = "collection" }
    group:entry { item = "gift_card", count = { 0, 60 } }
    group:entry { group = "snacks", count = { 0, 20 } }
    group:group("SUS_commercial_chewing_gum")
    content.add(group)
end
