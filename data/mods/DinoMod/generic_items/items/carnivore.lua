local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "skull_dino_small",
        name = ccb.content.plural_text("smaller dinosaur skull", "smaller dinosaur skulls"),
        description = ccb.content.text("The skull of a smaller plant eating dinosaur."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 1000000,
        volume_ml = 1400,
        symbol = "@",
        color = "white",
        price_cents = 10,
        price_postapoc_cents = 10,
    }
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_dino_med",
        name = ccb.content.plural_text("dinosaur skull", "dinosaur skulls"),
        description = ccb.content.text("The skull of a plant eating dinosaur."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 2000000,
        volume_ml = 2800,
        symbol = "@",
        color = "white",
        price_cents = 20,
        price_postapoc_cents = 20,
    }
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_dino_large",
        name = ccb.content.plural_text("larger dinosaur skull", "larger dinosaur skulls"),
        description = ccb.content.text("The skull of a larger plant eating dinosaur."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 4000000,
        volume_ml = 5600,
        symbol = "@",
        color = "white",
        price_cents = 40,
        price_postapoc_cents = 40,
    }
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_lokiceratops",
        name = ccb.content.plural_text("lokiceratops skull", "lokiceratops skulls"),
        description = ccb.content.text("Large dinosaur skull with two large horns above the eyes and a large crest with two large horns pointing out and down."),
        copy_from = "skull_dino_large",
        looks_like = "skull_dino_large",
        replace_qualities = true,
    }
    item:quality("COOK", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_triceratops",
        name = ccb.content.plural_text("triceratops skull", "triceratops skulls"),
        description = ccb.content.text("Large dinosaur skull with three large horns and a large crest."),
        copy_from = "skull_dino_large",
        looks_like = "skull_dino_large",
        replace_qualities = true,
    }
    item:quality("COOK", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_torosaurus",
        name = ccb.content.plural_text("torosaurus skull", "torosaurus skulls"),
        description = ccb.content.text("Large dinosaur skull with three large horns and a large crest."),
        copy_from = "skull_dino_large",
        looks_like = "skull_dino_large",
        replace_qualities = true,
    }
    item:quality("COOK", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_styracosaurus",
        name = ccb.content.plural_text("styracosaurus skull", "styracosaurus skulls"),
        description = ccb.content.text("Large dinosaur skull with a large horn above the nose and a spiked crest."),
        copy_from = "skull_dino_large",
        looks_like = "skull_dino_large",
        replace_qualities = true,
    }
    item:quality("COOK", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_centrosaurus",
        name = ccb.content.plural_text("centrosaurus skull", "centrosaurus skulls"),
        description = ccb.content.text("Large dinosaur skull with a large horn above the nose and a bony crest."),
        copy_from = "skull_dino_large",
        looks_like = "skull_dino_large",
        replace_qualities = true,
    }
    item:quality("COOK", 1)
    content.add(item)
end
