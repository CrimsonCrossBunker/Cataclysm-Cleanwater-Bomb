local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "skull_dino_pred_small",
        name = ccb.content.plural_text("smaller dinosaur predator skull", "smaller dinosaur predator skulls"),
        description = ccb.content.text("A smaller dinosaur skull with sharp teeth."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 1000000,
        volume_ml = 1400,
        symbol = "@",
        color = "white",
        price_cents = 10,
        price_postapoc_cents = 10,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:quality("CUT_FINE", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "skull_dino_pred_med",
        name = ccb.content.plural_text("dinosaur predator skull", "dinosaur predator skulls"),
        description = ccb.content.text("The skull of a dinosaur with sharp teeth."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 2000000,
        volume_ml = 2800,
        symbol = "@",
        color = "white",
        price_cents = 20,
        price_postapoc_cents = 20,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:quality("CUT", 1)
    item:quality("CUT_FINE", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "skull_dino_pred_large",
        name = ccb.content.plural_text("larger dinosaur predator skull", "larger dinosaur predator skulls"),
        description = ccb.content.text("The skull of a larger dinosaur with sharp teeth."),
        category = "spare_parts",
        looks_like = "skull_human",
        mass_milligrams = 4000000,
        volume_ml = 5600,
        symbol = "@",
        color = "white",
        price_cents = 40,
        price_postapoc_cents = 40,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:quality("CUT", 1)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 1)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "skull_tyrannosaurus",
        name = ccb.content.plural_text("tyrannosaurus skull", "tyrannosaurus skulls"),
        copy_from = "skull_dino_pred_large",
        looks_like = "skull_dino_pred_large",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_allosaurus",
        name = ccb.content.plural_text("allosaurus skull", "allosaurus skulls"),
        copy_from = "skull_dino_pred_large",
        looks_like = "skull_dino_pred_large",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_acrocanthosaurus",
        name = ccb.content.plural_text("acrocanthosaurus skull", "acrocanthosaurus skulls"),
        copy_from = "skull_dino_pred_large",
        looks_like = "skull_dino_pred_large",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_giganotosaurus",
        name = ccb.content.plural_text("giganotosaurus skull", "giganotosaurus skulls"),
        copy_from = "skull_dino_pred_large",
        looks_like = "skull_dino_pred_large",
    }
    content.add(item)
end
