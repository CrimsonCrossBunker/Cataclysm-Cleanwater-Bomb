local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "survnote_cabin_reverberation_hint",
        name = ccb.content.plural_text("hastily-scribbled note", "hastily-scribbled notes"),
        copy_from = "survnote",
        looks_like = "survnote",
        snippet_category = "cabin_reverberation_hint",
    }
    content.add(item)
end
