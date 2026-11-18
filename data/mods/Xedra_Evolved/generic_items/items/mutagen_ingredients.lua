local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ierde_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("ierde sample", "ierde samples"),
        description = ccb.content.text("A sample of rare earths."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "arvore_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("arvore sample", "arvore samples"),
        description = ccb.content.text("A sample of verdant plant life."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "salamander_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("salamander sample", "salamander samples"),
        description = ccb.content.text("A sample of fiery passion."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "undine_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("undine sample", "undine samples"),
        description = ccb.content.text("A sample of deep waters."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "homullus_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("homullus sample", "homullus samples"),
        description = ccb.content.text("A sample of lifelike dolls."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sylph_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("sylph sample", "sylph samples"),
        description = ccb.content.text("A sample of untamed air."),
        looks_like = "medical_sample",
    }
    item:material("fae_flesh", 1)
    item:material("fae_blood", 1)
    item:material("bone", 1)
    content.add(item)
end
