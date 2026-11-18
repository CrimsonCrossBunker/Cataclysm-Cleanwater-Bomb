local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nl_surg_int_unit",
        name = ccb.content.plural_text("surgical bonebot brain", "surgical bonebot brains"),
        description = ccb.content.text("The core of a surgical bonebot, dug out of its head capsule.  Its shape very much resembles a human brain, but is made of what appears to be hard, dark glass.  It looks a bit like a fancy, and creepy, decoration."),
        copy_from = "ai_module",
        looks_like = "ai_module",
    }
    item:material("cyber_bone", 1)
    item:material("anomaly", 1)
    content.add(item)
end
