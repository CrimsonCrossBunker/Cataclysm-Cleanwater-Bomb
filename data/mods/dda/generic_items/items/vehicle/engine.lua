local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "engine_block_massive",
        copy_from = "spare_part",
        name = ccb.content.plural_text("massive engine block", "massive engine blocks"),
        description = ccb.content.text("The beginnings of a massive gas or diesel engine.  It's not good for much of anything on its own."),
        mass_milligrams = 96000000,
        volume_ml = 96000,
        price_cents = 30000,
        price_postapoc_cents = 500,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "engine_block_large",
        copy_from = "spare_part",
        name = ccb.content.plural_text("large engine block", "large engine blocks"),
        description = ccb.content.text("The beginnings of a large gas or diesel engine.  It's not good for much of anything on its own."),
        mass_milligrams = 95000000,
        volume_ml = 95000,
        price_cents = 20000,
        price_postapoc_cents = 500,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "engine_block_medium",
        copy_from = "spare_part",
        name = ccb.content.plural_text("medium engine block", "medium engine blocks"),
        description = ccb.content.text("The beginnings of a medium gas or diesel engine.  It's not good for much of anything on its own."),
        mass_milligrams = 81000000,
        volume_ml = 81000,
        price_cents = 10000,
        price_postapoc_cents = 250,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "engine_block_small",
        copy_from = "spare_part",
        name = ccb.content.plural_text("small engine block", "small engine blocks"),
        description = ccb.content.text("The beginnings of a small gas or diesel engine.  It's not good for much of anything on its own."),
        mass_milligrams = 23000000,
        volume_ml = 23000,
        price_cents = 5000,
        price_postapoc_cents = 250,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "engine_block_tiny",
        copy_from = "spare_part",
        name = ccb.content.plural_text("tiny engine block", "tiny engine blocks"),
        description = ccb.content.text("The beginnings of a tiny gas or diesel engine.  It's not good for much of anything on its own."),
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 3500,
        price_postapoc_cents = 100,
    }
    item:material("iron", 1)
    content.add(item)
end
