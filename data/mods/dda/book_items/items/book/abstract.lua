local content = require("ccb").content

do
    local book = content.Item {
        id = "book_nonf_tpl",
        name = content.plural_text("Generic Nonfiction Book", "Generic Nonfiction Books"),
        description = content.text("Template for a manuscript purporting to be factual."),
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
        abstract = true,
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_tpl",
        name = content.plural_text("Generic Fiction Book", "Generic Fiction Books"),
        description = content.text("Template for a work of fiction."),
        symbol = "?",
        looks_like = "story_book",
        color = "light_cyan",
        abstract = true,
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_tpl",
        name = content.plural_text("Generic Hard Bound Fiction Book", "Generic Hard Bound Fiction Books"),
        description = content.text("Template for hard bound book of fiction."),
        mass_milligrams = 1000000,
        volume_ml = 1100,
        longest_side_mm = 230,
        price_cents = 1999,
        price_postapoc_cents = 150,
        copy_from = "book_fict_tpl",
        abstract = true,
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 2)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_tpl",
        name = content.plural_text("paperback novel", "paperbacks"),
        description = content.text("An ordinary paperback book.  Or is it?  It is."),
        mass_milligrams = 425000,
        volume_ml = 662,
        longest_side_mm = 180,
        price_cents = 799,
        price_postapoc_cents = 150,
        copy_from = "book_fict_tpl",
        abstract = true,
    }
    book:material("paper", 1)
    book:clear_flags()
    book:clear_melee_damage()
    book:melee_damage("bash", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_collection_tpl",
        name = content.plural_text("paperback novel", "paperbacks"),
        description = content.text("Paperback fiction novel generic collection."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_tpl",
        name = content.plural_text("Nonfiction Book", "Nonfiction Books"),
        description = content.text("Template for hard bound nonfiction book."),
        mass_milligrams = 1000000,
        volume_ml = 1100,
        price_cents = 2950,
        price_postapoc_cents = 150,
        copy_from = "book_nonf_tpl",
        abstract = true,
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_tpl",
        name = content.plural_text("Nonfiction Paperback", "Nonfiction Paperbacks"),
        description = content.text("Template for a paperback nonfiction book."),
        mass_milligrams = 460000,
        volume_ml = 500,
        price_cents = 2790,
        price_postapoc_cents = 190,
        copy_from = "book_nonf_tpl",
        abstract = true,
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_pulp_tpl",
        name = content.plural_text("Generic Pulp Book", "Generic Pulp Books"),
        description = content.text("This is a template for pulp books.  Which really all ought to be paperbacks, right?"),
        looks_like = "novel_pulp",
        price_cents = 709,
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_scifi_tpl",
        name = content.plural_text("Generic SciFi Book", "Generic SciFi Books"),
        description = content.text("This is a template for paperback scifi books."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 24,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_scifi_tpl",
        name = content.plural_text("Generic SciFi Book", "Generic SciFi Books"),
        description = content.text("This is a template for a hard cover scifi book."),
        copy_from = "book_fict_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 24,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_tpl",
        name = content.plural_text("Homemaking Book", "Homemaking Books"),
        description = content.text("This is a template for books about homemaking, style, home decor, and home economics."),
        mass_milligrams = 1100000,
        price_postapoc_cents = 100,
        copy_from = "book_nonf_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 20,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_cook_tpl",
        name = content.plural_text("Hardcover Cookbook", "Hardcover Cookbooks"),
        description = content.text("This is a template for books about cooking."),
        copy_from = "book_nonf_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_cook_tpl",
        name = content.plural_text("Softcover Cookbook", "Softcover Cookbooks"),
        description = content.text("This is a template for books about cooking."),
        copy_from = "book_nonf_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_dodge_tpl",
        name = content.plural_text("dodge skillbook abstract", "dodge skillbook abstracts"),
        description = content.text("An ordinary book.  Or is it?  It is."),
        mass_milligrams = 600000,
        price_cents = 1000,
        price_postapoc_cents = 200,
        copy_from = "book_nonf_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 600,
        fun = -1,
        chapters = 18,
        scannable = true,
        skill = "dodge",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_phil_tpl",
        name = content.plural_text("Hardcover Philosophy", "Hardcover Philosophys"),
        description = content.text("This is a template for books about philosophy."),
        price_postapoc_cents = 100,
        price_cents = 3450,
        copy_from = "book_nonf_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2160,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_phil_tpl",
        name = content.plural_text("Softcover Philosophy.", "Softcover Philosophy.s"),
        description = content.text("This is a template for paperbacks about philosophy."),
        price_postapoc_cents = 140,
        price_cents = 3190,
        copy_from = "book_nonf_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2160,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_pulp_newage_tpl",
        name = content.plural_text("Generic New-Age Book", "Generic New-Age Books"),
        description = content.text("This is a template for pulp new-age books.  They're theoretically nonfiction."),
        mass_milligrams = 250000,
        price_cents = 3209,
        copy_from = "book_fict_soft_pulp_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 8,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_sports_tpl",
        name = content.plural_text("Hardcover Nonfiction Sports Book", "Hardcover Nonfiction Sports Books"),
        description = content.text("This is a template."),
        copy_from = "book_nonf_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_sports_tpl",
        name = content.plural_text("Softcover Nonfiction Sports Book.", "Softcover Nonfiction Sports Book.s"),
        description = content.text("This is a template."),
        copy_from = "book_nonf_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_sports_tpl",
        name = content.plural_text("Hardcover Fictional Sports Book", "Hardcover Fictional Sports Books"),
        description = content.text("This is a template."),
        copy_from = "book_fict_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_sports_tpl",
        name = content.plural_text("Softcover Fictional Sports Book.", "Softcover Fictional Sports Book.s"),
        description = content.text("This is a template."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    -- TODO fun should be conditional for this item
    local book = content.Item {
        id = "paperback_occult",
        name = content.plural_text("template for mass produced books on esoteric subjects", "template for mass produced books on esoteric subjectss"),
        description = content.text("An ordinary paperback book.  Or is it?  Is that a glimmer of higher truth?"),
        mass_milligrams = 371000,
        volume_ml = 700,
        price_cents = 2950,
        price_postapoc_cents = 150,
        symbol = "?",
        looks_like = "story_book",
        color = "dark_gray",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 2100,
        fun = 1,
        chapters = 30,
        scannable = true,
    }
    content.add(book)
end

do
    -- these are books are tiny
    local book = content.Item {
        id = "paperback_romance_spb",
        name = content.plural_text("Sweet Providence Romance Novel", "Sweet Providence Romance Novels"),
        description = content.text("Sweet Providence Books is a publisher of discount romance paperbacks easily recognized by their blue and yellow cover illustrations.  Despite the adult nature of their subject matter, the books tend to be under 250 pages of large print written in a vocabulary consistent with a 4th grade reading level."),
        mass_milligrams = 200000,
        volume_ml = 400,
        price_cents = 448,
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 660,
        fun = 2,
        chapters = 8,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_lnl",
        name = content.plural_text("Lorn and Loan Romance Novel", "Lorn and Loan Romance Novels"),
        description = content.text("Lorn and Loan Press marketed romance paperbacks to a variety of alt demographics, especially those with a penchant for eyeliner.  The books are billed as \"provocative,\" but words like \"malingering\" and \"turgid\" also come to mind."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_vanilla",
        name = content.plural_text("Vanilla Romance Novel", "Vanilla Romance Novels"),
        description = content.text("Vanilla Media is a mainstream publisher providing romantic literature to everyday readers of taste.  These stories contain explicit details only in the odd chapters, and invariably end with a conventionally uplifting moral."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_western_em",
        name = content.plural_text("The Everyman Library", "The Everyman Librarys"),
        description = content.text("The Everyman Library is an imprint of Vanilla Media that publishes stories about private eyes, cowboys, quarterbacks, and mobsters."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_vanilla",
        name = content.plural_text("Tween Topics", "Tween Topicss"),
        description = content.text("Tween Topics is an imprint of Vanilla Media that publishes stories that appeal to the youth of today.  Or, failing that, the parents of said youth."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_quiddity",
        name = content.plural_text("Quiddity Books", "Quiddity Bookss"),
        description = content.text("Quiddity publishes books for young adults.  They offer stories about self-discovery, personal identity, and contemporary trends."),
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 23,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_ya_quiddity",
        name = content.plural_text("Quiddity Books", "Quiddity Bookss"),
        description = content.text("Quiddity publishes books for young adults.  They offer stories about self-discovery, personal identity, and contemporary trends."),
        mass_milligrams = 500000,
        volume_ml = 1014,
        longest_side_mm = 220,
        copy_from = "book_fict_hard_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 26,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_tpl",
        name = content.plural_text("Satire Template", "Satire Templates"),
        description = content.text("Template for mass produced satirical fiction."),
        price_cents = 1048,
        copy_from = "book_fict_soft_tpl",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_zine",
        name = content.plural_text("Magazine Template", "Magazine Templates"),
        description = content.text("Template for magazine."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 400,
        price_postapoc_cents = 100,
        symbol = "?",
        color = "pink",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_zine_news_tpl",
        name = content.plural_text("News Magazine Template", "News Magazine Templates"),
        description = content.text("Template for news magazine."),
        looks_like = "flyer",
        copy_from = "book_nonf_zine",
        abstract = true,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 660,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- this is the original version of book_nonf_zine
    local book = content.Item {
        id = "book_magazine",
        name = content.plural_text("readable magazine", "readable magazines"),
        mass_milligrams = 70000,
        volume_ml = 250,
        symbol = "?",
        color = "pink",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_antho_tpl",
        name = content.plural_text("Generic Anthology Book", "Generic Anthology Books"),
        description = content.text("Template for a collection of stories."),
        price_cents = 1699,
        price_postapoc_cents = 100,
        symbol = "?",
        looks_like = "story_book",
        color = "yellow",
        abstract = true,
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_martial",
        category = "ma_manuals",
        name = content.plural_text("martial art manual", "martial art manuals"),
        mass_milligrams = 150000,
        volume_ml = 250,
        price_cents = 20000,
        symbol = "?",
        color = "green",
        looks_like = "manual_gun",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    book:clear_use_actions()
    book:martial_arts_manual()
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_arch_tpl",
        category = "manuals",
        name = content.plural_text("archery skill training abstract", "archery skill training abstracts"),
        description = content.text("Template for heavy books that confer archery skill training."),
        mass_milligrams = 1454000,
        volume_ml = 1250,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "story_book",
        color = "green",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "archery",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_abstract",
        name = content.plural_text("holybook abstract", "holybook abstracts"),
        description = content.text("Theoretically this isn't a book at all."),
        price_cents = 550,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "dark_gray",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_flags()
    book:flag("INSPIRATIONAL")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 600,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "exodii_blueprint",
        name = content.plural_text("Exodii blueprint abstract", "Exodii blueprint abstracts"),
        category = "manuals",
        mass_milligrams = 100000,
        volume_ml = 200,
        price_cents = 6000,
        price_postapoc_cents = 6000,
        symbol = "?",
        looks_like = "paper",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 4,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "schematics_generic",
        category = "manuals",
        name = content.plural_text("schematics", "schematics"),
        description = content.text("Seeing this is a bug."),
        mass_milligrams = 30000,
        volume_ml = 250,
        price_cents = 100000,
        price_postapoc_cents = 750,
        symbol = "ç",
        color = "blue",
        abstract = true,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 7,
        maximum_level = 7,
        intelligence = 8,
        read_time_turns = 3300,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end
