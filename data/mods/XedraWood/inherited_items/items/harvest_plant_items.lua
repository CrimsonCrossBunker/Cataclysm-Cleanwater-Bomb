local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dryad_bark",
        copy_from = "alder_bark",
        looks_like = "alder_bark",
        name = ccb.content.plural_text("dryad bark", "chunks of dryad bark"),
        description = ccb.content.text("A strip of bark taken from a fallen dryad.  It's still slightly supple, as though it were attached to a living tree."),
    }
    content.upsert_item(item)
end
