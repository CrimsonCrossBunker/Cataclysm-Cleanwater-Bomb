local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_fict_soft_sports_bunt",
        name = ccb.content.plural_text("The Art of Bunting", "copies of The Art of Bunting"),
        description = ccb.content.text("While you might be forgiven for expecting instructions for party decorating, it is in fact a novel about baseball.  In the final climactic game a young star proves to himself that he is ready for the big leagues."),
        mass_milligrams = 472000,
        volume_ml = 1074,
        longest_side_mm = 200,
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_sports_tdsp",
        name = ccb.content.plural_text("The Touchdown Special", "copies of The Touchdown Special"),
        description = ccb.content.text("In this absorbing novel of football fandom, a pizza delivery driver makes a desperate gamble on the Monday night game."),
        mass_milligrams = 184000,
        volume_ml = 450,
        longest_side_mm = 210,
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_sports_envy",
        name = ccb.content.plural_text("Trophy Envy", "copies of Trophy Envy"),
        description = ccb.content.text("This paperback tells the story of a tennis prodigy who begins to regret her own success."),
        mass_milligrams = 227000,
        volume_ml = 535,
        longest_side_mm = 200,
        price_cents = 1799,
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_sports_omni",
        name = ccb.content.plural_text("The Golf Omnivore", "copies of The Golf Omnivore"),
        description = ccb.content.text("This hardback book is a collection of short stories in which love and golf are the only two constants."),
        mass_milligrams = 648000,
        volume_ml = 720,
        longest_side_mm = 210,
        copy_from = "book_fict_hard_tpl",
    }
    content.add(book)
end

do
    -- sports and ya
    local book = content.Item {
        id = "book_fict_hard_sports_uni",
        name = ccb.content.plural_text("Uniform Boy", "copies of Uniform Boy"),
        description = ccb.content.text("This hardback book about an equipment manager for a minor league team explores themes of loyalty and resentment."),
        mass_milligrams = 363000,
        volume_ml = 640,
        longest_side_mm = 200,
        price_cents = 1899,
        copy_from = "book_fict_hard_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_sports",
        name = ccb.content.plural_text("sports novel", "sports novels"),
        description = ccb.content.text("The dramatic tale of a small-time boxer who gets a rare chance to fight the heavy-weight champion, and seize his one chance to make a better life for himself while impressing the cute girl who works in the pet store."),
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 2,
        chapters = 28,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9780689105180
    local book = content.Item {
        id = "book_fict_hard_sports_semi",
        name = ccb.content.plural_text("Semi-Rough", "copies of Semi-Rough"),
        description = ccb.content.text("This novel follows the humorous adventures of a professional athlete turned amateur reporter."),
        copy_from = "book_fict_hard_tpl",
    }
    content.add(book)
end

do
    -- isbn13: 9780393324815
    local book = content.Item {
        id = "book_nonf_soft_sports_bdgt",
        name = ccb.content.plural_text("Budgetball: Winning a Rigged Game", "copies of Budgetball: Winning a Rigged Game"),
        description = ccb.content.text("Budgetball tells the true story of the curious case of Benny Bobbin and his quixotic quest to defeat the deep-pocketed Orlando O's."),
        mass_milligrams = 245000,
        volume_ml = 679,
        longest_side_mm = 210,
        price_cents = 1299,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9780060883966
    local book = content.Item {
        id = "book_nonf_soft_sports_lads",
        name = ccb.content.plural_text("The Lads of Summer", "copies of The Lads of Summer"),
        description = ccb.content.text("This well worn paperback details the early baseball careers of one of the greatest teams professional sports has ever known."),
        mass_milligrams = 408000,
        volume_ml = 654,
        longest_side_mm = 200,
        price_cents = 1399,
        copy_from = "book_nonf_soft_tpl",
    }
    content.add(book)
end

do
    -- isbn13: 9781450468824
    local book = content.Item {
        id = "book_nonf_soft_sports_vlly",
        name = ccb.content.plural_text("Volleyball: Get Ready to Get Ready", "copies of Volleyball: Get Ready to Get Ready"),
        description = ccb.content.text("\"Volleyball: Get Ready to Get Ready\" is YOUR illustrated guide to level up your game.  With full-color photos and diagrams, you will learn the drills and techniques you need to dominate the competition."),
        mass_milligrams = 703000,
        volume_ml = 920,
        longest_side_mm = 280,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 12,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781595941893
    local book = content.Item {
        id = "book_nonf_hard_sports_morg",
        name = ccb.content.plural_text("William G. Morgan, the Godfather of Volleyball", "copies of The Godfather of Volleyball"),
        description = ccb.content.text("This odd little hardbound book is only 98 pages long, and a dozen of those are comprised of grainy black and white photos.  If you read this book, you learn that volleyball was originally called \"Mintonette\" and also some biographic details about its inventor."),
        mass_milligrams = 272000,
        volume_ml = 400,
        longest_side_mm = 220,
        price_cents = 3999,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781760340834
    local book = content.Item {
        id = "book_nonf_hard_sports_bike",
        name = ccb.content.plural_text("Legendary Bike Rides", "copies of Legendary Bike Rides"),
        description = ccb.content.text("This unwieldy coffee table book is titled \"LEGENDARY Bike Rides Around the WORLD.\"  It provides a wealth of detail about paved bike trails in every part of the globe except New England.  But if you make it to Patagonia on bike, you're all set."),
        mass_milligrams = 1589000,
        volume_ml = 1660,
        longest_side_mm = 270,
        price_cents = 2999,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 480,
        fun = 0,
        chapters = 40,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781587313776
    -- sports and phil
    local book = content.Item {
        id = "book_nonf_hard_sports_ergo",
        name = ccb.content.plural_text("Natare Ergo Sum", "copies of Natare Ergo Sum"),
        description = ccb.content.text("The poorly translated title is supposed to be Latin for \"I Swim, Therefore I Am.\"  This short hardback presents \"A Philosophy of Swimming\" and then playfully attributes a variety of famous philosophical expressions into endorsements for the sport of swimming.  It's not a bad book, just a bit odd."),
        mass_milligrams = 167000,
        volume_ml = 289,
        longest_side_mm = 180,
        price_cents = 1299,
        copy_from = "book_fict_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 900,
        fun = 2,
        chapters = 6,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781629376509
    local book = content.Item {
        id = "book_nonf_hard_sports_hoop",
        name = ccb.content.plural_text("Stratosphere: The Rise of Hoops", "copies of Stratosphere: The Rise of Hoops"),
        description = ccb.content.text("\"Stratosphere: The Rise of Hoops\" chronicles four decades of professional basketball against a backdrop of sustained social change."),
        mass_milligrams = 818000,
        volume_ml = 1114,
        longest_side_mm = 230,
        price_cents = 2699,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 0,
        chapters = 26,
        scannable = true,
    }
    content.add(book)
end
