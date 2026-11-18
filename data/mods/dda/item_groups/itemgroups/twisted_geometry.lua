local content = require("ccb").content

do
    local group = content.ItemGroup { id = "twisted_geometry", kind = "distribution" }
    group:item("art_bomorrean", 7)
    group:item("art_penrose", 10)
    group:item("art_trident", 10)
    group:item("art_klein", 10)
    group:item("art_tesseract", 10)
    group:item("art_irrational", 10)
    group:item("art_duocylinder", 10)
    content.add(group)
end
