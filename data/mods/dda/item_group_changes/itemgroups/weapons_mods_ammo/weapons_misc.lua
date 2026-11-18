local content = require("ccb").content

do
    local group = content.ItemGroup { id = "grenades", kind = "distribution" }
    group:item("grenade", 30)
    group:item("grenade_inc", 30)
    group:item("flashbang", 30)
    group:item("EMPbomb", 20)
    group:item("grenade_emp", 5)
    group:item("gasbomb", 15)
    group:item("gasbomb_makeshift", 15)
    group:item("smokebomb", 50)
    group:item("dynamite", 50)
    group:item("c4", 50)
    content.add(group)
end
