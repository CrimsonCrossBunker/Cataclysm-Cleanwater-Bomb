local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ps_artifacts", kind = "distribution" }
    group:item("art_sphere")
    group:item("art_rod")
    group:item("art_teardrop")
    group:item("art_lamp")
    group:item("art_snake")
    group:item("art_disc")
    group:item("art_beads")
    group:item("art_napkin")
    group:item("art_urchin")
    group:item("art_jelly")
    group:item("art_spiral")
    group:item("art_pin")
    group:item("art_tube")
    group:item("art_pyramid")
    group:item("art_crystal")
    group:item("art_knot")
    group:item("art_crescent")
    content.add(group)
end
