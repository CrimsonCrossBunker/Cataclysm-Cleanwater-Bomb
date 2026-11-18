local content = require("ccb").content

do
    local group = content.ItemGroup { id = "book_motel", kind = "collection" }
    group:item("phonebook")
    group:item("holybook_bible3")
    content.add(group)
end
