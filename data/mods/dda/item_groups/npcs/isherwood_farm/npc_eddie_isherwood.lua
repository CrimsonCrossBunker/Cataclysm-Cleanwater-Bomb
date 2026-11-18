local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ISHERWOOD_EDDIE_misc", kind = "distribution" }
    group:group("cheese_hard_wrapper_8", 55)
    group:group("cheese_bag_plastic", 55)
    group:group("butter_wrapper_32", 55)
    group:item("meat_smoked", 45)
    group:item("fish_smoked", 25)
    group:entry { item = "milk", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 70 }
    content.add(group)
end
