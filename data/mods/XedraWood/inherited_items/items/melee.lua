local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "teeth_macuahuitl",
        name = ccb.content.plural_text("teeth-bladed macuahuitl", "teeth-bladed macuahuitls"),
        copy_from = "teeth_macuahuitl",
        looks_like = "teeth_macuahuitl",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 30)
    content.replace(item)
end
