local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BEGGAR_2_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks_wool")
    group:item("fursuit", 100, "dinosuit")
    group:item("cardboard_crown_loose")
    group:item("boots_winter")
    group:item("coat_winter")
    content.add(group)
end
