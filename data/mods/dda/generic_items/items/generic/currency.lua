local ccb = require("ccb")
local content = ccb.content

do
    -- $50 bills have substantial pre-Cataclysm value, but are worth 1 meat jerky
    local item = content.Item {
        id = "FMCNote",
        category = "currency",
        name = ccb.content.plural_text("merch", "merch"),
        description = ccb.content.text("The Free Merchant Certified Note, also known by names such as a 'c-note' or 'merch', is a currency based on old American bills.  Fifty dollar bills and larger are printed with a promissory note signed by the treasurer of the Free Merchants, along with a complex design.  The note explains that this can be exchanged for food, water, and other services through the Free Merchants in the Refugee Center."),
        price_cents = 5000,
        price_postapoc_cents = 250,
        mass_milligrams = 1000,
        volume_ml = 1,
        color = "white",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("BANK_NOTE_SHAPED")
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "FlatCoin",
        category = "currency",
        name = ccb.content.plural_text("FlatCoin", "FlatCoins"),
        description = ccb.content.text("A coin that has been flattened in a novelty coin flattening machine.  The machine has been somewhat crudely altered so that the design - which appears to once have been Mickey Mouse - is overlaid with a hand-drawn emblem of a book.  There is some text that faintly reads 'Campus Exchange Token'."),
        price_cents = 5,
        price_postapoc_cents = 250,
        mass_milligrams = 18000,
        volume_ml = 1,
        color = "brown",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:material("copper", 1)
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "signed_chit",
        category = "currency",
        name = ccb.content.plural_text("chit", "chits"),
        description = ccb.content.text("A slip of paper signed by the issuer."),
        price_cents = 5,
        price_postapoc_cents = 250,
        mass_milligrams = 1000,
        volume_ml = 1,
        color = "white",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("BANK_NOTE_SHAPED")
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "icon",
        category = "currency",
        name = ccb.content.plural_text("icon", "icons"),
        description = ccb.content.text("A small picture, about the size of an ID card, symbolizing a religious figure.  On the back, there is text that faintly reads 'New England Church Community'."),
        price_cents = 200,
        price_postapoc_cents = 250,
        mass_milligrams = 1000,
        volume_ml = 2,
        color = "white",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_penny",
        category = "currency",
        name = ccb.content.plural_text("penny", "pennies"),
        description = ccb.content.text("A one-cent coin, featuring a portrait of Abraham Lincoln.  You could flip it."),
        mass_milligrams = 3000,
        volume_ml = 1,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "brown",
    }
    item:material("copper", 1)
    item:material("brass", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_nickel",
        category = "currency",
        name = ccb.content.plural_text("nickel", "nickels"),
        description = ccb.content.text("A five-cent coin, featuring a portrait of Thomas Jefferson.  You could flip it."),
        mass_milligrams = 5000,
        volume_ml = 1,
        price_cents = 5,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("copper_nickel", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_dime",
        category = "currency",
        name = ccb.content.plural_text("dime", "dimes"),
        description = ccb.content.text("A ten-cent coin, featuring a portrait of Franklin D Roosevelt.  You could flip it."),
        mass_milligrams = 2000,
        volume_ml = 1,
        price_cents = 10,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("copper_nickel", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_quarter",
        category = "currency",
        name = ccb.content.plural_text("quarter", "quarters"),
        description = ccb.content.text("A twenty-five-cent coin, featuring a portrait of George Washington.  You could flip it."),
        mass_milligrams = 6000,
        volume_ml = 1,
        price_cents = 25,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("copper_nickel", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_dollar",
        category = "currency",
        name = ccb.content.plural_text("dollar coin", "dollar coins"),
        description = ccb.content.text("A one-dollar coin, featuring a portrait of Susan B Anthony.  You could flip it."),
        mass_milligrams = 8000,
        volume_ml = 1,
        price_cents = 100,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("copper_nickel", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_gold",
        category = "currency",
        name = ccb.content.plural_text("American Buffalo coin", "American Buffalo coins"),
        description = ccb.content.text("The official 24-karat bullion coin of the United States, it has a nominal face value of fifty dollars and is guaranteed to contain one troy ounce of 99.99% pure gold."),
        mass_milligrams = 38000,
        volume_ml = 1,
        price_cents = 175000,
        price_postapoc_cents = 600,
        symbol = "o",
        color = "yellow",
    }
    item:material("gold", 1)
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_wrapper",
        category = "currency",
        name = ccb.content.plural_text("coin wrapper", "coin wrappers"),
        description = ccb.content.text("A coin wrapper capable of holding between twenty and fifty coins, depending on denomination, in accordance with American Banking Standards."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 1,
        price_postapoc_cents = 0,
        symbol = "$",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("paper", 1)
    item:container_pocket {
        max_volume_ml = 50,
        max_weight_milligrams = 200000,
        rigid = false,
        allowed_items = { "coin_penny", "coin_nickel", "coin_dime", "coin_quarter", "coin_half_dollar", "coin_dollar" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_one",
        category = "currency",
        name = ccb.content.plural_text("one-dollar bill", "one-dollar bills"),
        description = ccb.content.text("A one-dollar bill, featuring a portrait of George Washington."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "$",
        color = "green",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_two",
        name = ccb.content.plural_text("two-dollar bill", "two-dollar bills"),
        description = ccb.content.text("A two-dollar bill, featuring a portrait of Thomas Jefferson."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 200,
        price_postapoc_cents = 0,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_five",
        name = ccb.content.plural_text("five-dollar bill", "five-dollar bills"),
        description = ccb.content.text("A five-dollar bill, featuring a portrait of Abraham Lincoln."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 500,
        price_postapoc_cents = 0,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_ten",
        name = ccb.content.plural_text("ten-dollar bill", "ten-dollar bills"),
        description = ccb.content.text("A ten-dollar bill, featuring a portrait of Alexander Hamilton."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 1000,
        price_postapoc_cents = 0,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_twenty",
        name = ccb.content.plural_text("twenty-dollar bill", "twenty-dollar bills"),
        description = ccb.content.text("A twenty-dollar bill, featuring a portrait of Andrew Jackson."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 2000,
        price_postapoc_cents = 0,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_fifty",
        name = ccb.content.plural_text("fifty-dollar bill", "fifty-dollar bills"),
        description = ccb.content.text("A fifty-dollar bill, featuring a portrait of Ulysses S Grant."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 5000,
        price_postapoc_cents = 1,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_hundred",
        name = ccb.content.plural_text("hundred-dollar bill", "hundred-dollar bills"),
        description = ccb.content.text("A hundred-dollar bill, featuring a portrait of Benjamin Franklin."),
        looks_like = "money_one",
        copy_from = "money_one",
        color = "green",
        symbol = "$",
        price_cents = 10000,
        price_postapoc_cents = 1,
    }
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_one",
        category = "currency",
        name = ccb.content.plural_text("one-dollar currency strap", "one-dollar currency straps"),
        description = ccb.content.text("A hundred one-dollar bills held together by a blue currency strap."),
        looks_like = "money_one",
        mass_milligrams = 100000,
        volume_ml = 113,
        color = "green",
        symbol = "$",
        price_cents = 10000,
        price_postapoc_cents = 0,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("BANK_NOTE_STRAP_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_two",
        name = ccb.content.plural_text("two-dollar currency strap", "two-dollar currency straps"),
        description = ccb.content.text("A hundred two-dollar bills held together by a green currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 20000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_five",
        name = ccb.content.plural_text("five-dollar currency strap", "five-dollar currency straps"),
        description = ccb.content.text("A hundred five-dollar bills held together by a red currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 50000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_ten",
        name = ccb.content.plural_text("ten-dollar currency strap", "ten-dollar currency straps"),
        description = ccb.content.text("A hundred ten-dollar bills held together by a yellow currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 100000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_twenty",
        name = ccb.content.plural_text("twenty-dollar currency strap", "twenty-dollar currency straps"),
        description = ccb.content.text("A hundred twenty-dollar bills held together by a violet currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 200000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_fifty",
        name = ccb.content.plural_text("fifty-dollar currency strap", "fifty-dollar currency straps"),
        description = ccb.content.text("A hundred fifty-dollar bills held together by a brown currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 500000,
        price_postapoc_cents = 100,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_hundred",
        name = ccb.content.plural_text("hundred-dollar currency strap", "hundred-dollar currency straps"),
        description = ccb.content.text("A hundred hundred-dollar bills held together by a mustard currency strap."),
        looks_like = "money_strap_one",
        copy_from = "money_strap_one",
        color = "green",
        symbol = "$",
        price_cents = 1000000,
        price_postapoc_cents = 100,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_strap_FMCNote",
        name = ccb.content.plural_text("merch currency strap", "merch currency straps"),
        description = ccb.content.text("A hundred Free Merchant Certified Notes held together by an improvised currency strap.  This can be exchanged for food, water, and other services through the Free Merchants at the Refugee Center."),
        looks_like = "money_strap_one",
        copy_from = "FMCNote",
        color = "white",
        price_cents = 500000,
        price_postapoc_cents = 25000,
        mass_milligrams = 100000,
        volume_ml = 113,
    }
    item:clear_flags()
    item:flag("BANK_NOTE_STRAP_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_one",
        category = "currency",
        name = ccb.content.plural_text("one-dollar currency bundle", "one-dollar currency bundles"),
        description = ccb.content.text("A thousand one-dollar bills, divided evenly between ten blue currency straps, and bundled together with rubber bands."),
        looks_like = "money_one",
        mass_milligrams = 1000000,
        volume_ml = 1129,
        color = "green",
        symbol = "$",
        price_cents = 100000,
        price_postapoc_cents = 0,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_two",
        name = ccb.content.plural_text("two-dollar currency bundle", "two-dollar currency bundles"),
        description = ccb.content.text("A thousand two-dollar bills, divided evenly between ten green currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 200000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_five",
        name = ccb.content.plural_text("five-dollar currency bundle", "five-dollar currency bundles"),
        description = ccb.content.text("A thousand five-dollar bills, divided evenly between ten red currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 500000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_ten",
        name = ccb.content.plural_text("ten-dollar currency bundle", "ten-dollar currency bundles"),
        description = ccb.content.text("A thousand ten-dollar bills, divided evenly between ten yellow currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 1000000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_twenty",
        name = ccb.content.plural_text("twenty-dollar currency bundle", "twenty-dollar currency bundles"),
        description = ccb.content.text("A thousand twenty-dollar bills, divided evenly between ten violet currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 2000000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_fifty",
        name = ccb.content.plural_text("fifty-dollar currency bundle", "fifty-dollar currency bundles"),
        description = ccb.content.text("A thousand fifty-dollar bills, divided evenly between ten brown currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 5000000,
        price_postapoc_cents = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_hundred",
        name = ccb.content.plural_text("hundred-dollar currency bundle", "hundred-dollar currency bundles"),
        description = ccb.content.text("A thousand hundred-dollar bills, divided evenly between ten mustard currency straps, and bundled together with rubber bands."),
        looks_like = "money_bundle_one",
        copy_from = "money_bundle_one",
        color = "green",
        symbol = "$",
        price_cents = 10000000,
        price_postapoc_cents = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "money_bundle_FMCNote",
        name = ccb.content.plural_text("merch currency bundle", "merch currency bundles"),
        description = ccb.content.text("A thousand Free Merchant Certified Notes, divided evenly between ten improvised currency straps, and bundled together with rubber bands.  This can be exchanged for food, water, and other services through the Free Merchants at the Refugee Center."),
        looks_like = "money_bundle_one",
        copy_from = "money_strap_FMCNote",
        color = "green",
        price_cents = 5000000,
        price_postapoc_cents = 250000,
        mass_milligrams = 1000000,
        volume_ml = 1129,
    }
    content.add(item)
end

do
    -- Dimensions of a bottle cap
    local item = content.Item {
        id = "tacoma_drink_token",
        category = "currency",
        name = ccb.content.plural_text("Tacoma drink token", "Tacoma drink tokens"),
        description = ccb.content.text("A ordinary-looking bottle cap with a stamped logo of the Tacoma ranch on the inside.  You can take it back to the bartender with your glass for a small refund."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 2000,
        volume_ml = 6,
        longest_side_mm = 32,
        color = "light_gray",
        symbol = "o",
    }
    item:material("tin", 1)
    content.add(item)
end
