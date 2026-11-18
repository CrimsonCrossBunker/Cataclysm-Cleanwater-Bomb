local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_exodii_botrack", kind = "distribution" }
    group:item("exodii_sensor", 20)
    group:item("exodii_motor", 30)
    group:item("spring", 50)
    group:item("ch_steel_lump", 10)
    group:item("pipe", 10)
    group:item("frame", 20)
    group:item("hdframe", 20)
    group:item("exodii_computer", 25)
    group:item("exodii_chassis", 50)
    group:item("exodii_drone_chassis", 40)
    group:item("cyborg_matrix", 50)
    group:item("sheet_metal", 10)
    content.add(group)
end
