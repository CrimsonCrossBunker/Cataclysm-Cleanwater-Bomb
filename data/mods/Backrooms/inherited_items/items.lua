local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "many_years_old_newspaper",
        category = "books",
        copy_from = "many_years_old_newspaper",
        looks_like = "many_years_old_newspaper",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_ancient_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  The date on it is so old it seems actually impossible for it to have lasted this long in such good condition.  Most of the information on there is shockingly uninteresting for an artifact so old, but one thing catches your eye briefly."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "years_old_newspaper",
        category = "books",
        copy_from = "years_old_newspaper",
        looks_like = "years_old_newspaper",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_very_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  The date on it suggests it's decades old, but miraculously it appears to be much newer.  Most of the information on there is terribly trivial, or out of date, but one thing catches your eye briefly."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "one_year_old_newspaper",
        copy_from = "one_year_old_newspaper",
        looks_like = "one_year_old_newspaper",
        category = "books",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_unknown_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It doesn't look like any newspaper you're familiar with and the text on it makes no sense…"),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "months_old_newspaper",
        category = "books",
        copy_from = "months_old_newspaper",
        looks_like = "months_old_newspaper",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_old_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It was printed a few years ago.  Most of the information on there is terribly trivial, or out of date, but one thing catches your eye briefly."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "weeks_old_newspaper",
        category = "books",
        copy_from = "weeks_old_newspaper",
        looks_like = "weeks_old_newspaper",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_lost_people_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  There seems to be an important article about a missing person."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "newest_newspaper",
        category = "books",
        copy_from = "newest_newspaper",
        looks_like = "newest_newspaper",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        snippet_category = "backrooms_recent_news",
        description = ccb.content.text("A single sheet of newspaper broadsheet.  It was printed within the last few months.  Most of the information on there is terribly trivial, or out of date, but one thing catches your eye briefly."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "survnote",
        category = "books",
        copy_from = "survnote",
        looks_like = "survnote",
        name = ccb.content.plural_text("survivor's note", "survivor's notes"),
        snippet_category = "backrooms_note",
        description = ccb.content.text("A scrap of paper.  Something's written on it, scrawled in bad handwriting."),
    }
    content.replace(item)
end
