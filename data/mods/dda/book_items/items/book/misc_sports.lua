local content = require("ccb").content

do
    local book = content.Item {
        id = "book_fict_soft_sports_bunt",
        name = content.plural_text("The Art of Bunting", "copies of The Art of Bunting"),
        description = content.text("While you might be forgiven for expecting instructions for party decorating, it is in fact a novel about baseball.  In the final climactic game a young star proves to himself that he is ready for the big leagues."),
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
        name = content.plural_text("The Touchdown Special", "copies of The Touchdown Special"),
        description = content.text("In this absorbing novel of football fandom, a pizza delivery driver makes a desperate gamble on the Monday night game."),
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
        name = content.plural_text("Trophy Envy", "copies of Trophy Envy"),
        description = content.text("This paperback tells the story of a tennis prodigy who begins to regret her own success."),
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
        name = content.plural_text("The Golf Omnivore", "copies of The Golf Omnivore"),
        description = content.text("This hardback book is a collection of short stories in which love and golf are the only two constants."),
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
        name = content.plural_text("Uniform Boy", "copies of Uniform Boy"),
        description = content.text("This hardback book about an equipment manager for a minor league team explores themes of loyalty and resentment."),
        mass_milligrams = 363000,
        volume_ml = 640,
        longest_side_mm = 200,
        price_cents = 1899,
        copy_from = "book_fict_hard_tpl",
    }
    content.add(book)
end
