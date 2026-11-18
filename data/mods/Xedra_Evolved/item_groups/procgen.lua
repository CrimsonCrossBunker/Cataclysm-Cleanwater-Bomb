local content = require("ccb").content

do
    local group = content.ItemGroup { id = "nether_cult_items_worn", kind = "distribution" }
    group:item("art_robe")
    group:item("art_cloak")
    group:item("art_coat")
    group:item("art_mask")
    group:item("art_helm")
    group:item("art_gloves")
    group:item("art_boots")
    group:item("art_ring")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_cult_items_wielded", kind = "distribution" }
    group:item("art_staff")
    group:item("art_sword")
    group:item("art_harp")
    group:item("art_dagger")
    group:item("art_spear")
    group:item("art_club")
    content.add(group)
end
