local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "krar",
        looks_like = "krar_golden",
        name = ccb.content.plural_text("krar", "krars"),
        description = ccb.content.text("A wooden krar, similar to a harp."),
        copy_from = "krar_golden",
        mass_milligrams = 2500000,
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end
