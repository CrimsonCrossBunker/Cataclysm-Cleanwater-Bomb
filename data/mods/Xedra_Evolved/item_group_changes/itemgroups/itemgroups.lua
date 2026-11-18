local content = require("ccb").content

do
    -- Adding spell learning items to standard itemgroups
    local group = content.ItemGroup { id = "costume_misc_items", kind = "distribution" }
    group:item("magicians_hat", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "religious_books", kind = "distribution" }
    group:item("book_deduction_black_iron_prison", 1)
    group:item("book_deduction_out_of_place", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "kids_books", kind = "distribution" }
    group:item("book_teens_deduction", 4)
    content.extend_item_group(group)
end

do
    -- Adding spell learning items to standard itemgroups
    local group = content.ItemGroup { id = "homebooks", kind = "distribution" }
    group:item("book_deduction_out_of_place", 1)
    group:item("manual_deduction", 1)
    group:item("mag_deduction", 10)
    group:item("mag_deduction_tabloid", 40)
    group:item("firmament_driver_book", 1)
    group:item("eater_book_artifact", 1)
    group:group("hedge_magic_books", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:group("hedge_magic_books", 5)
    group:group("nether_sorcery_books", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "esoteric_books", kind = "distribution" }
    group:group("hedge_magic_books", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "book_mag_gen", kind = "distribution" }
    group:item("mag_deduction_tabloid", 40)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "newspaper", kind = "distribution" }
    group:item("mag_deduction_tabloid", 40)
    content.extend_item_group(group)
end
