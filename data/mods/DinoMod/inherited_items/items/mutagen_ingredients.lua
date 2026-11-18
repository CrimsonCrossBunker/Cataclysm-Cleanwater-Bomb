local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "raptor_sample",
        symbol = "q",
        color = "light_green",
        name = ccb.content.plural_text("raptor sample", "raptor samples"),
        description = ccb.content.text("A sample of tissues and liquids from a living dromaeosaurid, popularly called a 'raptor', a flightless feathered predatory dinosaur popularized by an American film."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
        category = "spare_parts",
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.upsert_item(item)
end
