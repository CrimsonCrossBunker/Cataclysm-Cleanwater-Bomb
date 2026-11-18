local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dreamforged_hacksaw",
        copy_from = "hacksaw",
        looks_like = "hacksaw",
        name = ccb.content.plural_text("dreamforged hacksaw", "dreamforged hacksaws"),
        description = ccb.content.text("A sturdy saw, useful for cutting through metal objects.  Forged from dreamdross, which makes it much lighter."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:adjust_melee_damage { factors = { bash = 0.25 } }
    item:tool()
    content.add(item)
end

do
    -- 0.75 for both metal and wooden parts
    local item = content.Item {
        id = "dreamforged_hammer",
        copy_from = "hammer",
        looks_like = "hammer",
        name = ccb.content.plural_text("dreamforged hammer", "dreamforged hammers"),
        description = ccb.content.text("A classic carpenter hammer with claw.  Forged from dreamdross, which makes it much lighter."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.75 } }
    item:adjust_melee_damage { factors = { bash = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_halligan",
        copy_from = "halligan",
        looks_like = "halligan",
        name = ccb.content.plural_text("dreamforged Halligan bar", "dreamforged Halligan bars"),
        description = ccb.content.text("A small tool for breaking into closed locations.  Forged from dreamdross, which makes it really light."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:adjust_melee_damage { factors = { bash = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_pliers_locking",
        copy_from = "pliers_locking",
        looks_like = "pliers_locking",
        name = ccb.content.plural_text("dreamforged locking pliers", "dreamforged locking pliers"),
        description = ccb.content.text("A pair of strong pliers with an adjustable mechanism.  Forged entirely from dreamdross, which makes it much lighter."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:adjust_melee_damage { factors = { bash = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_pickaxe",
        copy_from = "pickaxe",
        looks_like = "pickaxe",
        name = ccb.content.plural_text("dreamforged pickaxe", "dreamforged pickaxes"),
        description = ccb.content.text("A classic pickaxe, used for digging.  Forged from dreamdross, which makes it really light, albeit a bit weaker."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:native_use("PICKAXE")
    item:adjust_measurements { mass_milligrams = { factor = 0.3 } }
    item:adjust_melee_damage { factors = { bash = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_picklocks",
        copy_from = "picklocks",
        looks_like = "picklocks",
        name = ccb.content.plural_text("dreamforged locksmith kit", "dreamforged locksmith kits"),
        description = ccb.content.text("A set of light and sturdy dreamforged lockpicks and wrenches."),
        ascii_picture = "picklocks",
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("forged_dreamstuff", 1)
    item:quality("LOCKPICK", 10)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_scalpel",
        copy_from = "scalpel",
        looks_like = "scalpel",
        name = ccb.content.plural_text("dreamforged scalpel", "dreamforged scalpels"),
        description = ccb.content.text("A very sharp medical knife for surgical operations.  Almost weightless."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_e_tool",
        copy_from = "e_tool",
        looks_like = "e_tool",
        name = ccb.content.plural_text("dreamforged entrenching tool", "dreamforged entrenching tools"),
        description = ccb.content.text("A collapsible spade for digging small pits.  Forged from dreamdross to make it even lighter than before."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.25 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_ax",
        copy_from = "ax",
        looks_like = "ax",
        name = ccb.content.plural_text("dreamforged axe", "dreamforged axes"),
        description = ccb.content.text("A large, two-handed axe for chopping wood.  Light, but still useful."),
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.4 } }
    item:adjust_melee_damage { factors = { bash = 0.25, cut = 0.5 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sacrifice_table",
        category = "tools",
        name = ccb.content.plural_text("sacrifice table", "sacrifice tables"),
        description = ccb.content.text("A magickal space where offerings are sacrificed and transformed."),
        mass_milligrams = 1000000,
        volume_ml = 5000,
        price_cents = 2000,
        price_postapoc_cents = 750,
        looks_like = "glass_tube_small",
        symbol = "N",
        color = "light_blue",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("SACRIFICE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dream_drainer_catalyst",
        name = ccb.content.plural_text("dream-drainer catalyst", "dream-drainer catalyst"),
        color = "light_blue",
        volume_ml = 250,
        mass_milligrams = 10000,
        symbol = "@",
        description = ccb.content.text("A small ball of dreams, Fae blood and illicit substances from Under the Hill.  Your book claims it will transform any mosquito ingesting it in a dream-eating nightmare."),
    }
    item:clear_use_actions()
    item:cast_spell { spell = "dream_drainer_maker", no_fail = true, level = 1 }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end
