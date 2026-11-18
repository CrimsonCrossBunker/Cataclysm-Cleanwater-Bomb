local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wallets", kind = "distribution" }
    group:group("wallet_full", 40)
    group:group("wallet_duct_tape_full", 1)
    group:group("wallet_leather_full", 25)
    group:group("wallet_large_full", 9)
    group:group("wallet_stylish_full", 25)
    group:group("wallets_industrial", 5)
    content.add(group)
end
