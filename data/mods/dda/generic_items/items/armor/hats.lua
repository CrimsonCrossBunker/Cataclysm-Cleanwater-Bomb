local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "golden_hat",
        copy_from = "wizard_hat_costume",
        looks_like = "wizard_hat_costume",
        name = ccb.content.plural_text("golden hat", "golden hats"),
        description = ccb.content.text("An incredibly tall hat made from leather covered in gold leaf.  Its crown in divided into several segments, with patterns describing the phases of the moon, the seasons and the movements of strange constellations."),
    }
    item:material("leather", 1)
    content.add(item)
end
