local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_CYBORG_worn", kind = "collection" }
    group:item("briefs")
    group:item("footrags")
    group:item("jumpsuit_pocketless", 100, "orange")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CYBORG_carried", kind = "distribution" }
    group:item("hat_noise_cancelling")
    content.add(group)
end
