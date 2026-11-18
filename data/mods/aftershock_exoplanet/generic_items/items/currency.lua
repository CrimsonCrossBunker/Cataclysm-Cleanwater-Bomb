local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "UICA_10d",
        category = "currency",
        copy_from = "UICA_1d",
        looks_like = "UICA_1d",
        name = ccb.content.plural_text("$10 chit", "$10 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly 10 United Solar Denominations."),
        price_cents = 1000,
        color = "yellow",
        price_postapoc_cents = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "UICA_50d",
        category = "currency",
        copy_from = "UICA_1d",
        looks_like = "UICA_1d",
        name = ccb.content.plural_text("$50 chit", "$50 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly 50 United Solar Denominations."),
        price_cents = 5000,
        color = "yellow",
        price_postapoc_cents = 5000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "UICA_100d",
        category = "currency",
        copy_from = "UICA_1d",
        looks_like = "UICA_1d",
        name = ccb.content.plural_text("$100 chit", "$100 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly a 100 United Solar Denominations."),
        price_cents = 10000,
        color = "light_gray",
        price_postapoc_cents = 10000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "UICA_1000d",
        category = "currency",
        copy_from = "UICA_1d",
        looks_like = "UICA_1d",
        name = ccb.content.plural_text("$1000 chit", "$1000 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly a 1000 United Solar Denominations."),
        price_cents = 100000,
        color = "white",
        price_postapoc_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "UICA_10000d",
        category = "currency",
        copy_from = "UICA_1d",
        looks_like = "UICA_1d",
        name = ccb.content.plural_text("$10000 chit", "$10000 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly 10000 United Solar Denominations."),
        price_cents = 1000000,
        color = "cyan",
        price_postapoc_cents = 1000000,
    }
    content.add(item)
end
