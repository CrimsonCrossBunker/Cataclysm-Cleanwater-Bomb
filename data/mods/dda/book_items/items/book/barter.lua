local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_barter",
        category = "manuals",
        name = ccb.content.plural_text("Car Buyer's Guide", "copies of Car Buyer's Guide"),
        description = ccb.content.text("Normally this glossy, ad-filled magazine about cars would be pointless, but it has a series of articles on haggling techniques."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_business",
        category = "manuals",
        name = ccb.content.plural_text("How to Succeed in Business", "copies of How to Succeed in Business"),
        description = ccb.content.text("Useful if you want to get a good deal when purchasing goods."),
        mass_milligrams = 454000,
        volume_ml = 750,
        price_cents = 1900,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "manual_gun",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 6,
        read_time_turns = 1500,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    book:variants {
        {
            id = "manual_business",
            name = ccb.content.plural_text("How to Succeed in Business", "copies of How to Succeed in Business"),
            description = ccb.content.text("Useful if you want to get a good deal when purchasing goods."),
        },
        -- 978-1535585958
        {
            id = "manual_business_1",
            name = ccb.content.plural_text("How To Day Trade For A Living", "copies of How To Day Trade For A Living"),
            description = ccb.content.text("The fundamentals of day trading, and how it differs from other styles of trading and investment, with elaboration on important trading strategies that many traders use every day."),
        },
        -- 978-1119879589
        {
            id = "manual_business_2",
            name = ccb.content.plural_text("Trading Psychology For Dummies", "copies of Trading Psychology For Dummies"),
            description = ccb.content.text("A guide to help you develop a mindset to trade on a rapidly changing stock market.  Not very useful in current moment, when the main stock you have is a stock of ammo, or maybe just soup."),
        },
    }
    content.add(book)
end

do
    -- Biz majors can afford it.  Surely you're gonna make US$60K/yr out of school, and twice that in five years?
    local book = content.Item {
        id = "textbook_business",
        category = "manuals",
        name = ccb.content.plural_text("Advanced Economics", "copies of Advanced Economics"),
        description = ccb.content.text("A college textbook on economics."),
        mass_milligrams = 1587000,
        volume_ml = 1750,
        price_cents = 9800,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 5)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 9,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    book:variants {
        {
            id = "textbook_business",
            name = ccb.content.plural_text("Advanced Economics", "copies of Advanced Economics"),
            description = ccb.content.text("A college textbook on economics."),
        },
        -- 978-3838338194
        {
            id = "textbook_business_1",
            name = ccb.content.plural_text("Peer to Peer Bartering", "copies of Peer to Peer Bartering"),
            description = ccb.content.text("In this work, David Cabanillas adopts bartering incentive pattern as an attractive foundation in the age of the internet for a simple and robust form of exchange to reallocate resources."),
        },
        -- 978-1118464212
        {
            id = "textbook_business_2",
            name = ccb.content.plural_text("Trading Basics", "copies of Trading Basics"),
            description = ccb.content.text("Comprehensive coverage of most major stock trading styles."),
        },
    }
    content.add(book)
end
