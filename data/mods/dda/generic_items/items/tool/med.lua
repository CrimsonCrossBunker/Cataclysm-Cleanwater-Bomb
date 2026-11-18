local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "vacutainer",
        category = "tools",
        name = ccb.content.plural_text("blood draw kit", "blood draw kits"),
        description = ccb.content.text("A kit for drawing blood, including a test tube for holding the sample.  Use this tool to draw blood, either from yourself or from a corpse you are standing on."),
        mass_milligrams = 13000,
        volume_ml = 262,
        price_cents = 3000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("BLOOD_DRAW")
    item:container_pocket { max_volume_ml = 250, max_weight_milligrams = 500000, watertight = true, rigid = true }
    content.add(item)
end
