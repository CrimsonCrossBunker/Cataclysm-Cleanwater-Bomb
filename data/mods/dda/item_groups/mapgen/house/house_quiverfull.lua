local content = require("ccb").content

do
    local group = content.ItemGroup { id = "book_house_quiverfull_bible", kind = "collection" }
    group:item("holybook_bible1")
    content.add(group)
end
