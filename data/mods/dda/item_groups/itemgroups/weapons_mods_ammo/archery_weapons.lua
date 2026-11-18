local content = require("ccb").content

do
    local group = content.ItemGroup { id = "archery_common", kind = "distribution" }
    group:item("shortbow", 8)
    group:item("longbow", 4)
    group:item("reflexbow", 2)
    group:item("compositebow", 1)
    group:item("bullet_crossbow", 1)
    group:item("hand_crossbow", 8)
    group:item("crossbow", 4)
    group:item("compositecrossbow", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "archery_rare", kind = "distribution" }
    group:item("compbow", 8)
    group:item("recurbow", 4)
    group:item("takedown_recurbow", 1)
    group:item("woodgreatbow", 1)
    group:item("compgreatbow", 1)
    group:item("compcrossbow", 1)
    group:item("huge_crossbow", 1)
    group:item("rep_crossbow", 1)
    content.add(group)
end
