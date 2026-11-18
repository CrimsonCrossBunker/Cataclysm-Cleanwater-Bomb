local content = require("ccb").content

do
    local group = content.ItemGroup { id = "skate_park", kind = "distribution" }
    group:item("folded_skateboard_generic", 2)
    group:item("roller_blades", 2)
    group:item("rollerskates", 2)
    group:item("knee_pads", 1)
    group:item("elbow_pads", 1)
    group:item("helmet_bike", 1)
    content.add(group)
end
