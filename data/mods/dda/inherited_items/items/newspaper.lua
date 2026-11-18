local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "survnote",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("survivor's note", "survivor's notes"),
        snippet_category = "note",
        description = ccb.content.text("A scrap of paper.  Something's written on it, scrawled in bad handwriting."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 12,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("BANK_NOTE_SHAPED")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "note_mutant_alpha_boss",
        name = ccb.content.plural_text("child's drawing", "child's drawings"),
        description = ccb.content.text("A scrap of paper with a faded drawing on it."),
        copy_from = "survnote",
        looks_like = "survnote",
        snippet_category = "mutant_kid_boss",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "toxic_waste_labnote",
        copy_from = "survnote",
        looks_like = "survnote",
        name = ccb.content.plural_text("forgotten note", "forgotten notes"),
        description = ccb.content.text("This grimy note seems out of place, as if someone lost it."),
        snippet_category = "toxic_waste_corpse_disposal",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_postit_bio",
        copy_from = "survnote",
        looks_like = "survnote",
        name = ccb.content.plural_text("yellow post-it note", "yellow post-it notes"),
        description = ccb.content.text("A bright post-it note."),
        snippet_category = "lab_postit_bio",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_postit_blob",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("gray post-it note", "gray post-it notes"),
        snippet_category = "lab_postit_blob",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_postit_migo",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("pink post-it note", "pink post-it notes"),
        snippet_category = "lab_postit_migo",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_postit_portal",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("orange post-it note", "orange post-it notes"),
        snippet_category = "lab_postit_portal",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_postit_tech",
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
        name = ccb.content.plural_text("red post-it note", "red post-it notes"),
        snippet_category = "lab_postit_tech",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "newest_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "newest_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It is possibly one of the last issues printed before New England was overwhelmed.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "many_years_old_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "many_years_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It seems to date from several years ago, and you have NO idea how it lasted this long.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "years_old_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "years_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It seems to date from a few years ago--amazing it has lasted this long.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "one_year_old_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "one_year_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It was printed more than a year ago.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "months_old_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "months_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It was printed in the months leading up to the Cataclysm.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "weeks_old_newspaper",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "weeks_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It was printed in the weeks leading up to the Cataclysm.  Most of the information is terribly trivial or out of date, but one thing catches your eye briefly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end
