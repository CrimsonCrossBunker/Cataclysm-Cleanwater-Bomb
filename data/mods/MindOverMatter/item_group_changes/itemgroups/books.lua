local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_book_nonf_soft_psych", kind = "distribution" }
    group:group("dist_meditation_books_begin", 1)
    group:group("dist_meditation_books_int", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_book_nonf_pulp_newage", kind = "distribution" }
    group:group("dist_meditation_books_begin", 1)
    group:group("dist_meditation_books_int", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "homebooks", kind = "distribution" }
    group:group("dist_meditation_books_begin", 8)
    group:group("dist_meditation_books_int", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "manuals_school", kind = "distribution" }
    group:item("manual_meditation", 5, "manual_meditation_1")
    group:item("manual_meditation", 3, "manual_meditation_2")
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "lab_bookshelves", kind = "distribution" }
    group:group("dist_meditation_books_begin", 6)
    group:group("dist_meditation_books_int", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:group("dist_meditation_books_begin", 10)
    group:group("dist_meditation_books_int", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "esoteric_books", kind = "distribution" }
    group:group("dist_meditation_books_begin", 12)
    group:group("dist_meditation_books_int", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "chem_lab", kind = "distribution" }
    group:item("manual_psionics_advan", 2)
    content.extend_item_group(group)
end
