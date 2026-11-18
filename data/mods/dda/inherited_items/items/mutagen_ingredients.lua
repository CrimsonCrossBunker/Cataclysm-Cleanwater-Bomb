local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "mutagen_sample",
        abstract = true,
        symbol = "q",
        color = "red",
        name = content.plural_text("abstract mutagen sample", "abstract mutagen samples"),
        description = content.text("This item needs a description defined, and is copied from abstract mutagen sample."),
        price_cents = 1000,
        price_postapoc_cents = 50,
        mass_milligrams = 114000,
        volume_ml = 250,
        category = "spare_parts",
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("MUTAGEN_SAMPLE")
    content.add(item)
end

do
    local item = content.Item {
        id = "raptor_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("raptor sample", "raptor samples"),
        description = ccb.content.text("A slurry of evolution."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "troglobite_sample",
        copy_from = "mutagen_sample",
        color = "light_gray",
        name = ccb.content.plural_text("troglobite sample", "troglobite samples"),
        description = ccb.content.text("A slurry of reliability."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("soil", 1)
    content.add(item)
end
