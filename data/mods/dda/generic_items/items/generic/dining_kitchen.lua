local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_glass_dish",
        abstract = true,
        name = content.plural_text("generic glass dish", "generic glass dishes"),
        description = content.text("generic item template"),
        symbol = ")",
        color = "cyan",
        price_cents = 1400,
        price_postapoc_cents = 0,
        mass_milligrams = 322000,
        volume_ml = 262,
        melee_to_hit = -5,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "ceramic_bowl",
        category = "container",
        name = ccb.content.plural_text("ceramic bowl", "ceramic bowls"),
        symbol = ")",
        description = ccb.content.text("A perfectly ordinary ceramic soup bowl."),
        copy_from = "base_ceramic_dish",
        volume_ml = 625,
        longest_side_mm = 130,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    -- Weight calculated proportionally from the coffee mug as I couldn't find detailed weight information for the product.
    -- Based on https://www.dimensions.com/element/ikea-vardagen-coffee-cup-saucer
    -- This isn't true. It should contain 150ml. But I can't lower it beyond this much because then it won't be able to hold common liquids. I love charges.
    local item = content.Item {
        id = "ceramic_cup",
        category = "container",
        name = ccb.content.plural_text("ceramic cup", "ceramic cups"),
        symbol = "u",
        description = ccb.content.text("A light ceramic teacup.  Quite classy."),
        copy_from = "base_ceramic_dish",
        mass_milligrams = 254000,
        volume_ml = 380,
        longest_side_mm = 120,
        price_cents = 500,
        melee_to_hit = -3,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 300000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0B6CWNKCP
    local item = content.Item {
        id = "ceramic_mug",
        category = "container",
        name = ccb.content.plural_text("coffee mug", "coffee mugs"),
        symbol = "u",
        description = ccb.content.text("A small, <color> ceramic coffee cup."),
        expand_snippets = true,
        copy_from = "base_ceramic_dish",
        mass_milligrams = 318000,
        volume_ml = 475,
        longest_side_mm = 120,
        price_cents = 500,
        melee_to_hit = -3,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 330,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:variants {
        { id = "mug1", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'World's Greatest Dad'.") },
        { id = "mug2", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'World's Greatest Mom'.") },
        { id = "mug3", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug has a picture of a happy-looking family.") },
        { id = "mug4", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug has a comical green face on it and says 'I'm a zombie without my coffee!'.") },
        { id = "mug5", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'I'd rather be playing open source games'.") },
        { id = "mug6", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'If you think I'm bad, look in a mirror'.") },
        { id = "mug7", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug has a diagram of a caffeine molecule.") },
        { id = "mug8", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug has a cute picture of a sleeping cat.") },
        { id = "mug9", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The mug is printed in leopard spots.") },
        { id = "mug10", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The mug is blue and looks like a TARDIS.") },
        { id = "mug11", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'STAR WARS' over a picture of a lightsaber.") },
        { id = "mug12", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'House Stark' and depicts a fictional crest.") },
        { id = "mug13", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'My fandom could beat up your fandom'. ") },
        { id = "mug14", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'Do you even linux, bro?' and has a picture of a muscular penguin.") },
        { id = "mug15", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'I wish this was wine!'") },
        { id = "mug16", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("The side of the mug reads 'CasUaL aLcoHoLiSm'") },
        { id = "mug17", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"World's Best Dad!\" on the side.") },
        { id = "mug18", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"Great Ideas start with Great Coffee.\" on the side.") },
        { id = "mug19", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("On the side is a glass of wine and a cup of coffee both saying \"She loves me more!\"") },
        { id = "mug20", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"This is a designer mug.  It fuels designers.\" on the side.") },
        { id = "mug21", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("On the side is a winking woman in lingerie.") },
        { id = "mug22", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"You're my definition of perfect.  <3\" on the side.") },
        { id = "mug23", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"You've been poisoned.\" on the bottom, inside of it.") },
        { id = "mug24", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("On the side is a dog wearing a hat, sitting in a burning room, saying \"This is fine.\"") },
        { id = "mug25", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("There's a tiny dinosaur sculpture inside of it.") },
        { id = "mug26", append = true, expand_snippets = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), description = ccb.content.text("It says \"I <3 Massachusetts.\" on the side.") },
        { id = "mean_mug", description = ccb.content.text("The side of the mug reads \"fuck you, <name_b>!\""), append = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), expand_snippets = true, weight = 0 },
        { id = "mean_mug2", description = ccb.content.text("The side of the mug reads \"Worlds Worst Dad\"."), expand_snippets = true, append = true, name = ccb.content.plural_text("coffee mug", "coffee mugs"), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "tin_plate",
        category = "other",
        longest_side_mm = 260,
        name = ccb.content.plural_text("tin plate", "tin plates"),
        symbol = ",",
        description = ccb.content.text("A tin dinner plate, lightweight and clanky."),
        looks_like = "ceramic_plate",
        copy_from = "base_tin_dish",
        replace_qualities = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_pewter",
        category = "container",
        name = ccb.content.plural_text("pewter bowl", "pewter bowls"),
        description = ccb.content.text("A small pewter serving bowl without a lid.  Holds 250 mL of liquid."),
        copy_from = "base_tin_dish",
        symbol = "u",
        longest_side_mm = 110,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_plate",
        category = "other",
        longest_side_mm = 260,
        name = ccb.content.plural_text("glass plate", "glass plates"),
        symbol = ",",
        description = ccb.content.text("A glass dinner plate, for people who don't have clumsy children."),
        looks_like = "ceramic_plate",
        copy_from = "base_glass_dish",
        replace_qualities = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glass",
        category = "container",
        name = ccb.content.plural_text("drinking glass", "drinking glasses"),
        symbol = "U",
        description = ccb.content.text("A tall drinking glass."),
        copy_from = "base_glass_dish",
        volume_ml = 620,
        longest_side_mm = 160,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B01M4OEU65
    local item = content.Item {
        id = "wine_glass",
        category = "container",
        volume_ml = 420,
        mass_milligrams = 130000,
        longest_side_mm = 200,
        price_cents = 1300,
        name = ccb.content.plural_text("wine glass", "wine glasses"),
        symbol = "Y",
        description = ccb.content.text("A stemmed drinking glass that makes you feel very fancy when you drink from it."),
        copy_from = "base_glass_dish",
        replace_pockets = true,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 500000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_bowl",
        category = "container",
        name = ccb.content.plural_text("glass bowl", "glass bowls"),
        symbol = "u",
        description = ccb.content.text("A glass bowl for soup or dessert."),
        copy_from = "base_glass_dish",
        volume_ml = 620,
        longest_side_mm = 130,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_plate",
        category = "other",
        longest_side_mm = 260,
        name = ccb.content.plural_text("plastic plate", "plastic plates"),
        symbol = ",",
        description = ccb.content.text("A durable plastic plate, the sort you might use as patio dishware."),
        copy_from = "base_plastic_dish",
        replace_qualities = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tumbler_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic tumbler", "plastic tumblers"),
        symbol = "U",
        description = ccb.content.text("A durable plastic drinking vessel.  This one is made of clear acrylic and looks almost like glass."),
        copy_from = "base_plastic_dish",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.co.uk/dp/B097HTDRNZ
    local item = content.Item {
        id = "bowl_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic tupperware", "plastic tupperwares"),
        symbol = "u",
        description = ccb.content.text("A piece of plastic tupperware with a matching watertight lid.  Holds 750 mL of liquid."),
        copy_from = "base_plastic_dish",
        volume_ml = 1463,
        mass_milligrams = 57000,
        longest_side_mm = 200,
        price_cents = 132,
        replace_pockets = true,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        max_item_length_mm = 239,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B086D4PV2G
    local item = content.Item {
        id = "fork",
        category = "other",
        ascii_picture = "fork",
        name = ccb.content.plural_text("fork", "forks"),
        description = ccb.content.text("A fork, if you stab something with it, you eat it right away.  Wait… nevermind."),
        mass_milligrams = 43000,
        volume_ml = 45,
        longest_side_mm = 210,
        price_cents = 75,
        copy_from = "base_silverware",
        weapon_categories = { "SHIVS" },
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_fork",
        category = "other",
        name = ccb.content.plural_text("plastic fork", "plastic forks"),
        description = ccb.content.text("A plastic disposable fork.  Great for picnic lunches in the post-apocalyptic wasteland."),
        mass_milligrams = 4000,
        volume_ml = 15,
        longest_side_mm = 150,
        looks_like = "fork",
        copy_from = "base_plastic_silverware",
        weapon_categories = { "SHIVS" },
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0886HQRD3
    local item = content.Item {
        id = "spoon",
        category = "other",
        ascii_picture = "spoon",
        name = ccb.content.plural_text("spoon", "spoons"),
        description = ccb.content.text("Do not try to bend the spoon.  That is impossible."),
        mass_milligrams = 43000,
        volume_ml = 70,
        longest_side_mm = 190,
        price_cents = 69,
        copy_from = "base_silverware",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_spoon",
        category = "other",
        name = ccb.content.plural_text("plastic spoon", "plastic spoons"),
        description = ccb.content.text("A plastic disposable spoon.  Easier to bend than the metal variety."),
        mass_milligrams = 4000,
        volume_ml = 22,
        longest_side_mm = 150,
        looks_like = "spoon",
        copy_from = "base_plastic_silverware",
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B08NFVGSRJ
    local item = content.Item {
        id = "knife_butter",
        category = "other",
        ascii_picture = "knife_butter",
        name = ccb.content.plural_text("butter knife", "butter knives"),
        description = ccb.content.text("A dull knife, absolutely worthless in combat.  Excellent for spreading soft things on bread."),
        mass_milligrams = 71000,
        volume_ml = 75,
        longest_side_mm = 210,
        price_cents = 400,
        copy_from = "base_silverware",
        melee_to_hit = -3,
        weapon_categories = { "SHIVS" },
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_knife",
        category = "other",
        name = ccb.content.plural_text("plastic knife", "plastic knives"),
        description = ccb.content.text("A plastic butter knife.  It's actually a bit sharper than its metal counterpart, but that doesn't make it any more effective as a weapon."),
        mass_milligrams = 4000,
        volume_ml = 10,
        longest_side_mm = 150,
        looks_like = "knife_butter",
        weapon_categories = { "SHIVS" },
        copy_from = "base_plastic_silverware",
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    -- Lower than what the amazon link implies but I refuse to believe it's 1l of volume. 800ml is probably way overkill either way, since it has plenty of empty space that this calculation does not account for.
    -- Based on https://www.amazon.com/dp/B081R28ZLP
    local item = content.Item {
        id = "corkscrew",
        category = "other",
        ascii_picture = "corkscrew",
        name = ccb.content.plural_text("corkscrew", "corkscrews"),
        description = ccb.content.text("Many a pleasant date has been ruined by forgetting this important tool."),
        looks_like = "fork",
        copy_from = "base_silverware",
        mass_milligrams = 130000,
        volume_ml = 800,
        longest_side_mm = 230,
        price_cents = 900,
        melee_to_hit = -4,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B00004OCIP
    local item = content.Item {
        id = "peeler",
        category = "other",
        ascii_picture = "peeler",
        name = ccb.content.plural_text("vegetable peeler", "vegetable peelers"),
        description = ccb.content.text("A simple tool for peeling the outer skin off fruits and veggies without stabbing yourself."),
        looks_like = "knife_butter",
        copy_from = "base_silverware",
        mass_milligrams = 82000,
        volume_ml = 138,
        longest_side_mm = 190,
        price_cents = 1200,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:material("plastic", 17)
    item:material("steel", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "spork",
        category = "other",
        name = ccb.content.plural_text("spork", "sporks"),
        description = ccb.content.text("The bastardized hybrid of a spoon and fork, with all the power and capabilities of both in a more annoying to use package."),
        looks_like = "fork",
        copy_from = "base_silverware",
        weapon_categories = { "SHIVS" },
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "foon",
        category = "other",
        name = ccb.content.plural_text("foon", "foons"),
        description = ccb.content.text("Clearly the superior instrument.  Sporks are just imitators."),
        looks_like = "spork",
        copy_from = "base_silverware",
        weapon_categories = { "SHIVS" },
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07N47CN44
    local item = content.Item {
        id = "chopsticks",
        category = "other",
        name = ccb.content.plural_text("chopsticks (pair)", "chopsticks (pair)"),
        description = ccb.content.text("One of the most popular eating utensils in the world.  Does double duty as a way of dealing with especially fragile vampires."),
        symbol = "X",
        color = "light_gray",
        price_cents = 100,
        price_postapoc_cents = 0,
        mass_milligrams = 11000,
        volume_ml = 40,
        longest_side_mm = 230,
        weapon_categories = { "SHIVS" },
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("stab", 1)
    content.add(item)
end

do
    -- Volume calculated as a cylinder with ~3cm diameter and 30.5cm length
    -- Based on https://www.dimensions.com/element/ikea-koncis-whisk
    local item = content.Item {
        id = "whisk",
        category = "other",
        ascii_picture = "whisk",
        name = ccb.content.plural_text("whisk", "whisks"),
        description = ccb.content.text("A tool designed for finely mixing ingredients or introducing air into the blend.  Also known as a 'wire whip', but it's a less effective weapon than that name makes it sound."),
        mass_milligrams = 90000,
        volume_ml = 220,
        longest_side_mm = 310,
        price_cents = 600,
        looks_like = "spoon",
        copy_from = "base_utensil",
        melee_to_hit = -1,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "potato_masher",
        category = "other",
        ascii_picture = "potato_masher",
        name = ccb.content.plural_text("potato masher", "potato mashers"),
        description = ccb.content.text("A tool for mashing potatoes and soft root vegetables; it cannot do the twist."),
        looks_like = "fork",
        copy_from = "base_utensil",
    }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07N7KFHVH
    local item = content.Item {
        id = "garlic_press",
        category = "other",
        ascii_picture = "garlic_press",
        name = ccb.content.plural_text("garlic press", "garlic presses"),
        description = ccb.content.text("A tool for squashing a clove or two of garlic into a fine paste."),
        looks_like = "spoon",
        copy_from = "base_utensil",
        mass_milligrams = 238000,
        volume_ml = 224,
        longest_side_mm = 170,
        price_cents = 1200,
        melee_to_hit = -2,
    }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B087MSWH65 with the volume multiplied by 0.85 - otherwise the volume is way higher than it should be since Amazon lists package volume
    local item = content.Item {
        id = "can_opener",
        category = "other",
        ascii_picture = "can_opener",
        name = ccb.content.plural_text("can opener", "can openers"),
        description = ccb.content.text("A tool for opening cans that lack pull-tabs.  Now that you think about it, you haven't seen any of those around lately."),
        looks_like = "hand_crank_charger",
        copy_from = "base_utensil",
        price_cents = 900,
        mass_milligrams = 204000,
        volume_ml = 364,
        longest_side_mm = 210,
        melee_to_hit = -1,
    }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B083FJXZM5
    local item = content.Item {
        id = "carving_fork",
        category = "other",
        ascii_picture = "carving_fork",
        name = ccb.content.plural_text("carving fork", "carving forks"),
        description = ccb.content.text("A utensil used to hold meat still while you slice it.  It's like a tiny pitchfork, or a very large dinner fork."),
        looks_like = "fork",
        copy_from = "base_utensil",
        mass_milligrams = 90000,
        volume_ml = 180,
        longest_side_mm = 290,
        price_cents = 1200,
        weapon_categories = { "SHIVS" },
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("stab", 2)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B001BKWXOY
    local item = content.Item {
        id = "spatula",
        category = "other",
        ascii_picture = "spatula",
        name = ccb.content.plural_text("spatula", "spatulas"),
        description = ccb.content.text("A rubber scraper for making sure you get every last scrap of cookie dough."),
        looks_like = "spoon",
        mass_milligrams = 50000,
        volume_ml = 195,
        longest_side_mm = 240,
        price_cents = 435,
        copy_from = "base_plastic_silverware",
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B087PB2L83
    local item = content.Item {
        id = "pot",
        category = "tools",
        name = ccb.content.plural_text("pot", "pots"),
        description = ccb.content.text("A cooking pot, useful for boiling water and making all kinds of food."),
        copy_from = "base_cookpot",
        color = "light_gray",
        mass_milligrams = 1000000,
        volume_ml = 3700,
        longest_side_mm = 190,
        price_cents = 3100,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 4000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "iron_pot",
        category = "tools",
        name = ccb.content.plural_text("cast-iron pot", "cast-iron pots"),
        description = ccb.content.text("This hefty black pot is made from cast iron and coated in a sturdy enamel."),
        copy_from = "base_cookpot",
        color = "dark_gray",
        mass_milligrams = 2490000,
        volume_ml = 3980,
        longest_side_mm = 250,
        price_cents = 2900,
        replace_pockets = true,
    }
    item:material("iron", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 4000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "pot_copper",
        category = "tools",
        name = ccb.content.plural_text("copper pot", "copper pots"),
        description = ccb.content.text("A cooking pot, useful for boiling water and making all kinds of food.  Made from copper, with a lining of tin to prevent metal from leaching into acidic foods."),
        copy_from = "base_cookpot",
        color = "light_red",
        mass_milligrams = 750000,
        volume_ml = 3500,
        longest_side_mm = 230,
        replace_pockets = true,
    }
    item:material("copper", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 2000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B08J7TPT98
    local item = content.Item {
        id = "casserole",
        category = "tools",
        name = ccb.content.plural_text("casserole pot", "casserole pots"),
        description = ccb.content.text("A ceramic pot made for both cooking and serving, particularly one-pot dinners."),
        copy_from = "base_cookpot",
        color = "white",
        mass_milligrams = 1400000,
        volume_ml = 3140,
        longest_side_mm = 220,
        price_cents = 2000,
        replace_pockets = true,
    }
    item:material("ceramic", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 2000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0075O2Z34
    local item = content.Item {
        id = "pot_canning",
        category = "tools",
        name = ccb.content.plural_text("canning pot", "canning pots"),
        description = ccb.content.text("A very large 20 liter pot, primarily meant for canning food in glass jars via the water bath method, though it can cook normal foods just as well.  Canning foods with it will require a lot of water.  If you're only canning a couple of jars at a time, you'd fill it up with rocks or something to displace the water above the lids."),
        mass_milligrams = 4082000,
        volume_ml = 25400,
        longest_side_mm = 450,
        price_cents = 6800,
        price_postapoc_cents = 815,
        melee_to_hit = -4,
        symbol = ")",
        color = "dark_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 20000,
        max_weight_milligrams = 40000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("CHEM", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "pot_makeshift",
        category = "tools",
        name = ccb.content.plural_text("makeshift pot", "makeshift pots"),
        description = ccb.content.text("A sheet of metal crudely hammered into a cooking pot.  Good enough to cook food and boil water, but not as useful as proper cookware."),
        mass_milligrams = 6000000,
        volume_ml = 1050,
        longest_side_mm = 200,
        price_cents = 200,
        price_postapoc_cents = 5,
        melee_to_hit = -5,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("COOK", 2)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "pot_makeshift_copper",
        category = "tools",
        name = ccb.content.plural_text("makeshift copper pot", "makeshift copper pots"),
        description = ccb.content.text("A cooking pot crudely hammered out of copper.  Good enough to cook food and boil water, but not as useful as proper cookware."),
        mass_milligrams = 300000,
        volume_ml = 1100,
        longest_side_mm = 200,
        price_cents = 200,
        price_postapoc_cents = 5,
        melee_to_hit = -5,
        symbol = ")",
        color = "light_red",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("copper", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("COOK", 2)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "colander_steel",
        name = ccb.content.plural_text("mesh colander", "mesh colanders"),
        category = "tools",
        description = ccb.content.text("A stainless steel mesh colander, for washing rice and vegetables, or straining liquid off from noodles or other foods."),
        volume_ml = 500,
        mass_milligrams = 318000,
        symbol = ")",
        replace_qualities = true,
        price_cents = 600,
        price_postapoc_cents = 5,
    }
    item:quality("SIEVE", 2)
    item:quality("WINNOW", 1)
    item:quality("STRAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "splatter_guard",
        name = ccb.content.plural_text("splatter guard", "splatter guards"),
        description = ccb.content.text("A stainless steel mesh screen for preventing flying oil from getting all over your nice counters (or you) when frying."),
        volume_ml = 500,
        mass_milligrams = 357000,
        symbol = ")",
        replace_qualities = true,
        price_cents = 600,
        price_postapoc_cents = 5,
    }
    item:quality("SIEVE", 2)
    item:quality("STRAIN", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B00063QBL8
    local item = content.Item {
        id = "cutting_board",
        category = "other",
        ascii_picture = "cutting_board",
        name = ccb.content.plural_text("cutting board", "cutting boards"),
        description = ccb.content.text("A large, flat piece of wood for chopping vegetables on without ruining your knife or your countertop."),
        mass_milligrams = 455000,
        melee_to_hit = -4,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_2" },
        volume_ml = 2625,
        longest_side_mm = 410,
        price_cents = 4800,
        price_postapoc_cents = 5,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "mess_tray",
        name = ccb.content.plural_text("meal tray", "meal trays"),
        description = ccb.content.text("A stainless steel tray used for serving food in cafeterias, mess halls, or similar places."),
        looks_like = "tin_plate",
        symbol = ")",
        color = "light_gray",
        price_cents = 10,
        price_postapoc_cents = 0,
        mass_milligrams = 300000,
        volume_ml = 250,
        longest_side_mm = 400,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("COOK", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07YP2VL68
    local item = content.Item {
        id = "pizza_cutter",
        category = "other",
        name = ccb.content.plural_text("pizza cutter", "pizza cutters"),
        description = ccb.content.text("A utensil used for cutting pizza.  Practically useless in combat."),
        price_cents = 600,
        mass_milligrams = 186000,
        volume_ml = 350,
        longest_side_mm = 230,
        melee_to_hit = -2,
        copy_from = "base_silverware",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "icecream_scoop",
        category = "other",
        ascii_picture = "icecream_scoop",
        name = ccb.content.plural_text("icecream scoop", "icecream scoops"),
        description = ccb.content.text("A utensil used for scooping icecream into bowls.  It has a spring powered lever to assist."),
        looks_like = "spoon",
        copy_from = "base_silverware",
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    content.add(item)
end

do
    local item = content.Item {
        id = "cheese_grater",
        category = "other",
        ascii_picture = "cheese_grater",
        name = ccb.content.plural_text("cheese grater", "cheese graters"),
        description = ccb.content.text("A stainless steel cheese grater with a plastic grip.  It is used to shred cheese."),
        looks_like = "spoon",
        copy_from = "base_silverware",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "aluminum_pan",
        name = ccb.content.plural_text("aluminum frying pan", "aluminum frying pans"),
        description = ccb.content.text("An aluminum frying pan.  Makes a decent melee weapon, and is used for cooking."),
        copy_from = "pan",
        looks_like = "pan",
        mass_milligrams = 400000,
        volume_ml = 3000,
        longest_side_mm = 350,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "pot_aluminum",
        name = ccb.content.plural_text("aluminum pot", "aluminum pots"),
        description = ccb.content.text("A cooking pot, useful for boiling water and making all kinds of food.  Made from aluminum."),
        copy_from = "pot",
        looks_like = "pot",
        mass_milligrams = 231000,
        volume_ml = 2100,
        longest_side_mm = 230,
    }
    item:material("aluminum", 1)
    content.add(item)
end
