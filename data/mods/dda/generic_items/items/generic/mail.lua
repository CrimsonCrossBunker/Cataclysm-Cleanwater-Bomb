local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "envelope",
        category = "container",
        name = ccb.content.plural_text("envelope", "envelopes"),
        looks_like = "paper",
        description = ccb.content.text("A flat paper container with a sealable flap, used to enclose a letter or other paper goods."),
        mass_milligrams = 6750,
        volume_ml = 80,
        longest_side_mm = 241,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = "`",
        color = "white",
    }
    item:material("paper", 1)
    item:container_pocket { max_volume_ml = 150, max_weight_milligrams = 150000, max_item_length_mm = 240, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "letter",
        category = "other",
        name = ccb.content.plural_text("letter", "letters"),
        looks_like = "paper",
        description = ccb.content.text("A written message from one person to another, usually put in an envelope.  Reading it would be rude."),
        mass_milligrams = 3000,
        volume_ml = 6,
        longest_side_mm = 297,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "`",
        color = "white",
        variant_kind = "generic",
    }
    item:material("paper", 1)
    item:variants {
        { id = "letter_home_soldier_1", name = ccb.content.plural_text("love letter", "love letters"), description = ccb.content.text("A written message from a soldier to their partner, carefully folded into its envelope.  Their deployment ends soon and they can't wait to see their lover.  Reading the rest of it would be rude.") },
        { id = "letter_home_soldier_2", name = ccb.content.plural_text("angry letter home", "angry letters home"), description = ccb.content.text("A written message from a soldier to their partner, stuffed angrily into its envelope.  They know, they know she knows, and don't even pretend you don't know.  This letter is full of expletives you don't dare read aloud.") },
        { id = "letter_home_soldier_3", name = ccb.content.plural_text("sad letter home", "sad letters home"), description = ccb.content.text("A written message from a soldier to their parents.  Their deployment has been extended and they won't be home for the holidays.  This sad letter makes you feel homesick.") },
        { id = "letter_love", name = ccb.content.plural_text("love letter", "love letters"), description = ccb.content.text("A written message from a woman to her lover, it's sealed with a heart-shaped sticker and smells of perfume.  You start to read it but it quickly becomes embarrassing.") },
        { id = "letter_home_student_1", name = ccb.content.plural_text("sad letter home", "sad letters home"), description = ccb.content.text("A written message from a student to their parents scrawled on notebook paper.  They're having a really bad time at college and want to come home, nothing seems to be going well, their grades and heart are in the dumps.") },
        { id = "letter_home_student_2", name = ccb.content.plural_text("letter home", "letters home"), description = ccb.content.text("A written message from a student to their parents scrawled on notebook paper.  They're having a great time at college and can't wait to introduce you to their new lover.  Coincidentally they have run out of money for gas again and it sure would be great if you could send some.") },
        { id = "letter_home_immigrant", name = ccb.content.plural_text("letter home", "letters home"), description = ccb.content.text("A written message home in a foreign tongue, carefully folded into its envelope.") },
        { id = "letter_pink_slip", name = ccb.content.plural_text("pink slip", "pink slips"), description = ccb.content.text("A folded pink sheet of paper declaring the homeowner fired!  Oh no.") },
        { id = "letter_credit", name = ccb.content.plural_text("credit card offer", "credit card offers"), description = ccb.content.text("A notification from a credit card company, the recipient has been preapproved!  Attached in a thick wad of glue is a fake credit card, this could be theirs if they wanted it."), weight = 5 },
        { id = "letter_overdue", name = ccb.content.plural_text("letter from the bank", "letters from the bank"), description = ccb.content.text("A letter from the bank stating the homeowners account is overdrawn and they owe quite a bit of money."), weight = 2 },
        { id = "letter_rent", name = ccb.content.plural_text("late rent notice", "late rent notices"), description = ccb.content.text("A letter to recipient notifying them of their overdue rent, they have 30 days to pay or they are going to court!"), weight = 2 },
        { id = "letter_ticket", name = ccb.content.plural_text("automated speeding ticket", "automated speeding tickets"), description = ccb.content.text("A notice from the local police, there is a tiny picture of a car and a demand of 350 dollars for speeding in a school zone."), weight = 2 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "postcard",
        category = "other",
        name = ccb.content.plural_text("postcard", "postcards"),
        looks_like = "paper",
        description = ccb.content.text("A piece of thick, rectangular paper intended for writing and mailing without an envelope."),
        mass_milligrams = 6000,
        volume_ml = 6,
        longest_side_mm = 152,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "`",
        color = "white",
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "gift_card",
        category = "other",
        name = ccb.content.plural_text("gift card", "gift cards"),
        looks_like = "cash_card",
        description = ccb.content.text("A small card that can be exchanged for goods or services from a particular business, usually given as a gift."),
        mass_milligrams = 5000,
        volume_ml = 5,
        longest_side_mm = 80,
        price_cents = 0,
        price_postapoc_cents = 0,
        variant_kind = "generic",
        symbol = "`",
        color = "white",
    }
    item:material("plastic", 1)
    item:variants {
        { id = "restaurant_gift_card", name = ccb.content.plural_text("restaurant gift card", "restaurant gift cards"), description = ccb.content.text("A gift card for a local restaurant, covering the cost for an entire meal.") },
        { id = "clothing_gift_card", name = ccb.content.plural_text("$20 gift card", "$20 gift cards"), description = ccb.content.text("A $20 gift card, redeemable for purchases at your local clothing store.") },
        { id = "barber_gift_card", name = ccb.content.plural_text("barbershop gift card", "barbershop gift cards"), description = ccb.content.text("This gift card could be exchanged for a free cut at a local barbershop.") },
        { id = "megastore_gift_card", name = ccb.content.plural_text("$100 gift card", "$100 gift cards"), description = ccb.content.text("A $100 electronic gift card, redeemable for purchases at your local megastore.") },
        { id = "mall_gift_card", name = ccb.content.plural_text("5% discount card", "5% discount cards"), description = ccb.content.text("This gift card gives you a 5% discount for purchases at your local shopping mall.  Can only be redeemed once.") },
        { id = "bookstore_gift_card", name = ccb.content.plural_text("$5 gift card", "$5 gift cards"), description = ccb.content.text("A $5 gift card, redeemable for purchases at your local bookstore.") },
        { id = "hardware_gift_card", name = ccb.content.plural_text("$10 gift card", "$10 gift cards"), description = ccb.content.text("A $10 gift card, redeemable for purchases at your local hardware store.") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "greeting_card",
        category = "other",
        name = ccb.content.plural_text("greeting card", "greeting cards"),
        looks_like = "paper",
        description = ccb.content.text("A piece of card stock meant to convey an expression of sentiment."),
        mass_milligrams = 30000,
        volume_ml = 72,
        longest_side_mm = 177,
        price_cents = 0,
        price_postapoc_cents = 0,
        variant_kind = "generic",
        symbol = "`",
        color = "white",
    }
    item:material("paper", 1)
    item:variants {
        { id = "generic_greeting_card", name = ccb.content.plural_text("greeting card", "greeting cards"), description = ccb.content.text("A greeting card for expressing best wishes.  Its corners are decorated with paintings of flowers and leaves."), weight = 4 },
        { id = "baby_shower_greeting_card", name = ccb.content.plural_text("baby shower card", "baby shower cards"), description = ccb.content.text("A baby blue greeting card with a drawing of a teddy bear holding an umbrella.  Words printed on it read: \"It's getting closer by the hour, so let's have a baby shower!\""), color = "blue" },
        { id = "birthday_greeting_card", name = ccb.content.plural_text("birthday card", "birthday cards"), description = ccb.content.text("A greeting card given to a person to celebrate their birthday.  This one has a floral design.") },
        { id = "congratulations_greeting_card", name = ccb.content.plural_text("congratulations card", "congratulations cards"), description = ccb.content.text("This greeting card displays a picture of a graduate tossing their graduation cap.  Above the cap is the word 'CONGRATULATIONS'.") },
        { id = "farewell_greeting_card", name = ccb.content.plural_text("farewell card", "farewell cards"), description = ccb.content.text("A white greeting card with a stylized drawing of an empty road.  Words printed on it read: \"You're going places (literally).  Wishing you the best!\""), color = "white" },
        { id = "friendship_greeting_card", name = ccb.content.plural_text("friendship card", "friendship cards"), description = ccb.content.text("A greeting card with a stylized picture of a donut and a coffee cup.  Above the picture, it says 'I am thankful for our friendship' and below are the words 'we are better together'.") },
        { id = "get_well_greeting_card", name = ccb.content.plural_text("get well card", "get well cards"), description = ccb.content.text("This greeting card displays a cartoon turtle in a cozy blanket sipping hot tea.  Above the turtle, it says 'Wishing you a SPEEDY recovery!'") },
        { id = "retirement_greeting_card", name = ccb.content.plural_text("retirement card", "retirement cards"), description = ccb.content.text("A greeting card wishing the recipient a long and happy retirement.  This one displays a drawing of a rocking chair surrounded with white roses.") },
        { id = "sympathy_greeting_card", name = ccb.content.plural_text("sympathy card", "sympathy cards"), description = ccb.content.text("A black greeting card with a picture of a dimly lit candle.  Words printed on it read: \"Please accept our deepest and most heartfelt condolences at this challenging time.\""), color = "dark_gray" },
        { id = "thank_you_greeting_card", name = ccb.content.plural_text("thank you card", "thank you cards"), description = ccb.content.text("A plain white greeting card featuring an expression of gratitude to the recipient.") },
    }
    content.add(item)
end
