local content = require("ccb").content

do
    local group = content.ItemGroup { id = "baseball_equip", kind = "distribution" }
    group:item("bat", 55)
    group:item("baseball", 80)
    group:item("armguard_hard", 55)
    group:item("legguard_hard", 55)
    group:item("hat_ball", 75)
    group:item("helmet_ball", 65)
    content.add(group)
end
