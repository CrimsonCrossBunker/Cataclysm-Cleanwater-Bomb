local content = require("ccb").content

do
    local group = content.ItemGroup { id = "standing_stones_accident", kind = "collection" }
    group:item("holy_symbol", 5)
    group:item("holy_symbol_wood", 4)
    group:item("essay_book", 6)
    group:item("poetry_book", 6)
    group:item("philosophy_book", 2)
    group:item("holybook_havamal", 8)
    group:item("robe", 3)
    group:item("tunic", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "standing_stones_libation", kind = "collection" }
    group:entry { item = "mead", charges = { 2, 7 }, container = "bowl_clay" }
    content.add(group)
end
