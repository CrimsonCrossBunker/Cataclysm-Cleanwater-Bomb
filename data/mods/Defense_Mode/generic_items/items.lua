local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mercenary_contract",
        name = ccb.content.plural_text("service contract", "service contracts"),
        description = ccb.content.text("A slip of paper signed by the issuer and the recipient, detailing the terms of service of a hiring contract."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
        color = "white",
        symbol = "$",
    }
    item:material("paper", 1)
    content.add(item)
end
