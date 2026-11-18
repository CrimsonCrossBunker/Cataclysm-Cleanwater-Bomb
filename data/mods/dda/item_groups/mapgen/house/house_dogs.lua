local content = require("ccb").content

do
    local group = content.ItemGroup { id = "dogfight", kind = "collection" }
    group:item("postman_shirt")
    group:item("postman_shorts")
    group:item("postman_hat")
    group:group("underwear")
    group:item("dress_shoes")
    group:item("corpse")
    group:group("mail_postal")
    content.add(group)
end
