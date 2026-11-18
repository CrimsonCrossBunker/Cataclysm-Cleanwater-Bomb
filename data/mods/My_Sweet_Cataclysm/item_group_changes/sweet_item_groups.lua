local content = require("ccb").content

do
    local group = content.ItemGroup { id = "snacks", kind = "distribution" }
    group:item("cookies", 300)
    group:item("grahmcrackers", 200)
    group:item("marshmallow")
    group:item("smores", 60)
    group:item("gum", 150)
    group:item("caff_gum", 250)
    group:item("licorice", 230)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "coffee_shop", kind = "distribution" }
    group:item("candy3")
    group:item("cookies", 300)
    group:item("grahmcrackers", 200)
    group:item("marshmallow")
    group:item("gum", 150)
    group:item("smores", 50)
    group:item("caff_gum", 150)
    group:item("cow_candy", 30)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "coffee_display", kind = "distribution" }
    group:item("cookies", 300)
    group:item("marshmallow")
    group:item("smores", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "coffee_table", kind = "distribution" }
    group:item("candy3")
    group:item("cookies", 300)
    group:item("marshmallow")
    group:item("smores", 50)
    group:item("cow_candy", 30)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "vitamin_shop", kind = "distribution" }
    group:item("caff_gum", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ant_food", kind = "distribution" }
    group:item("candy3", 50)
    group:item("cookies", 150)
    group:item("grahmcrackers")
    group:item("marshmallow", 50)
    group:item("smores", 25)
    group:item("cow_candy", 40)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_trash_trashcan", kind = "distribution" }
    group:item("candy3", 5)
    group:item("gum", 10)
    group:item("caff_gum", 10)
    group:item("cow_candy", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "camping_cooking", kind = "collection" }
    group:item("grahmcrackers")
    group:item("marshmallow")
    group:item("smores")
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "livingroom", kind = "distribution" }
    group:item("candy3", 50)
    group:item("cookies", 150)
    group:item("grahmcrackers")
    group:item("marshmallow", 50)
    group:item("gum", 75)
    group:item("smores", 25)
    group:item("cow_candy", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "stash_food", kind = "collection" }
    group:item("candy3", 10)
    group:item("cookies", 30)
    group:item("grahmcrackers", 20)
    group:item("marshmallow", 10)
    group:item("gum", 20)
    group:item("smores", 20)
    group:item("caff_gum", 20)
    group:item("cow_candy", 10)
    content.extend_item_group(group)
end
