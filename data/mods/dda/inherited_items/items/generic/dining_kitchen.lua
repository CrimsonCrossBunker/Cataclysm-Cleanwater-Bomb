local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_tin_dish",
        abstract = true,
        name = content.plural_text("generic tin dish", "generic tin dishes"),
        description = content.text("generic item template"),
        symbol = ")",
        color = "light_gray",
        price_cents = 400,
        price_postapoc_cents = 0,
        mass_milligrams = 262000,
        volume_ml = 262,
        melee_to_hit = -5,
    }
    item:material("tin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "tin_cup",
        category = "container",
        name = ccb.content.plural_text("tin cup", "tin cups"),
        symbol = "u",
        description = ccb.content.text("An enameled tin cup.  Great for camping or for prison use; makes a wonderful sound when clanged along bars."),
        looks_like = "ceramic_cup",
        copy_from = "base_tin_dish",
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
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_straw",
        category = "other",
        name = ccb.content.plural_text("plastic straw", "plastic straws"),
        description = ccb.content.text("A plastic straw, for drinking things and littering."),
        copy_from = "base_plastic_silverware",
    }
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.7 } }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B000ARPJRM
    local item = content.Item {
        id = "rolling_pin",
        category = "other",
        ascii_picture = "rolling_pin",
        name = ccb.content.plural_text("rolling pin", "rolling pins"),
        description = ccb.content.text("A stout piece of hardwood, turned and sanded smooth, with rounded handles at the ends.  This timeless kitchen tool also doubles as an effective club."),
        mass_milligrams = 318000,
        longest_side_mm = 460,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "RAPID" },
        volume_ml = 1450,
        price_cents = 800,
        price_postapoc_cents = 5,
        melee_to_hit = -3,
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
        id = "steel_pan",
        category = "tools",
        name = ccb.content.plural_text("steel frying pan", "steel frying pans"),
        description = ccb.content.text("A steel frying pan.  Makes a decent melee weapon, and is used for cooking."),
        copy_from = "base_cookpot",
        color = "light_gray",
        looks_like = "pan",
        mass_milligrams = 660000,
        volume_ml = 3000,
        longest_side_mm = 350,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:adjust_quality("COOK", -1)
    content.add(item)
end

do
    local item = content.Item {
        id = "copper_pan",
        category = "tools",
        name = ccb.content.plural_text("copper frying pan", "copper frying pans"),
        description = ccb.content.text("A copper frying pan, coated in a thin layer of tin.  Makes a decent melee weapon, and is used for cooking."),
        copy_from = "base_cookpot",
        color = "light_red",
        looks_like = "pan",
        mass_milligrams = 628000,
        volume_ml = 3000,
        longest_side_mm = 350,
        replace_pockets = true,
    }
    item:material("copper", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:adjust_quality("COOK", -1)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_silverware",
        abstract = true,
        name = content.plural_text("generic silverware", "generic silverware"),
        description = content.text("generic item template"),
        symbol = ";",
        color = "light_gray",
        price_cents = 100,
        price_postapoc_cents = 0,
        mass_milligrams = 48000,
        volume_ml = 25,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_plastic_silverware",
        abstract = true,
        name = content.plural_text("generic plastic silverware", "generic plastic silverware"),
        description = content.text("generic item template"),
        symbol = ";",
        color = "light_gray",
        price_cents = 10,
        price_postapoc_cents = 0,
        mass_milligrams = 28000,
        volume_ml = 25,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_plastic_dish",
        abstract = true,
        name = content.plural_text("generic plastic dish", "generic plastic dishes"),
        description = content.text("generic item template"),
        symbol = ")",
        color = "light_cyan",
        price_cents = 400,
        price_postapoc_cents = 0,
        mass_milligrams = 130000,
        volume_ml = 262,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:plastic_bowl_kids" }
    snippets:entry { id = "kbowl1", text = ccb.content.text("This bowl is decorated with cartoon bears.") }
    snippets:entry {
        id = "kbowl2",
        text = ccb.content.text("There is a drawing of Yoda at the bottom of this bowl, and the words 'Eaten it all, you have'."),
    }
    snippets:entry {
        id = "kbowl3",
        text = ccb.content.text("This bowl is covered in cartoon dogs and a logo that reads 'Paw Patrol'."),
    }
    snippets:entry {
        id = "kbowl4",
        text = ccb.content.text("There are orange and blue fish chasing each other around the rim of this bowl."),
    }
    snippets:entry {
        id = "kbowl5",
        text = ccb.content.text("This bowl is shaped like the head of a silly frog with the opening forming the mouth."),
    }
    snippets:entry { id = "kbowl6", text = ccb.content.text("There are cute farm animals decorating this bowl.") }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "plastic_bowl_kids",
        category = "container",
        name = ccb.content.plural_text("kiddie bowl", "kiddie bowls"),
        symbol = "u",
        description = ccb.content.text("A plastic bowl designed for use by children."),
        copy_from = "base_plastic_dish",
        replace_pockets = true,
        replace_qualities = true,
        snippet_category = "auto:plastic_bowl_kids",
    }
    item:container_pocket {
        max_volume_ml = 120,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:quality("CONTAIN", 1)
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.6 } }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:sippy_cup" }
    snippets:entry { id = "sippycup1", text = ccb.content.text("This cup is decorated with cartoon bears.") }
    snippets:entry {
        id = "sippycup2",
        text = ccb.content.text("This cup has a cartoony picture of the Avengers wrapped around the side."),
    }
    snippets:entry {
        id = "sippycup3",
        text = ccb.content.text("This sippy cup is made of plastic in bright clashing colors."),
    }
    snippets:entry {
        id = "sippycup4",
        text = ccb.content.text("This is a simple blue sippy cup with tooth marks around the spout."),
    }
    snippets:entry { id = "sippycup5", text = ccb.content.text("This cup is decorated to look like a pokeball.") }
    snippets:entry {
        id = "sippycup6",
        text = ccb.content.text("There are cute anthropomorphic fruits decorating this cup."),
    }
    snippets:entry {
        id = "sippycup7",
        text = ccb.content.text("This sippy cup is decorated with crayon-like text that reads 'I love you'."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "sippy_cup",
        category = "container",
        name = ccb.content.plural_text("sippy cup", "sippy cups"),
        symbol = "u",
        description = ccb.content.text("A plastic cup with a spill-proof lid, designed for use by children."),
        copy_from = "base_plastic_dish",
        replace_pockets = true,
        replace_qualities = true,
        snippet_category = "auto:sippy_cup",
    }
    item:container_pocket { max_volume_ml = 120, max_weight_milligrams = 1000000, watertight = true, rigid = true }
    item:quality("CONTAIN", 1)
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.4 } }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:plastic_spoon_kids" }
    snippets:entry { id = "kspoon1", text = ccb.content.text("This spoon is striped in bright primary colors.") }
    snippets:entry { id = "kspoon2", text = ccb.content.text("This spoon is styled to look like a bulldozer.") }
    snippets:entry {
        id = "kspoon3",
        text = ccb.content.text("This spoon is covered in cartoon dogs and a logo that reads 'Paw Patrol'."),
    }
    snippets:entry {
        id = "kspoon4",
        text = ccb.content.text("There is a cute cartoon bear on the handle of this spoon."),
    }
    snippets:entry { id = "kspoon5", text = ccb.content.text("There are cartoon cats all over this spoon.") }
    snippets:entry {
        id = "kspoon6",
        text = ccb.content.text("This spoon has a silhouette of a giraffe going down the handle."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "plastic_spoon_kids",
        category = "other",
        name = ccb.content.plural_text("kiddie spoon", "kiddie spoons"),
        symbol = "u",
        description = ccb.content.text("A plastic spoon designed for use by children."),
        looks_like = "spoon",
        copy_from = "base_plastic_silverware",
        snippet_category = "auto:plastic_spoon_kids",
    }
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.7 } }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:bottle_opener" }
    snippets:entry {
        id = "bottleopener1",
        text = ccb.content.text("This bottle opener is shaped like a zombie head, the mouth pops open the bottle."),
    }
    snippets:entry { id = "bottleopener2", text = ccb.content.text("This bottle opener is shaped like a lightsaber.") }
    snippets:entry { id = "bottleopener3", text = ccb.content.text("This bottle opener is shaped like a revolver.") }
    snippets:entry {
        id = "bottleopener4",
        text = ccb.content.text("This bottle opener is engraved with the words 'I'll die before I give you my beer'."),
    }
    snippets:entry {
        id = "bottleopener5",
        text = ccb.content.text("This bottle opener is emblazoned with a logo for an HVAC contracting company."),
    }
    snippets:entry {
        id = "bottleopener6",
        text = ccb.content.text("This bottle opener reads 'Corporate Team Building Exercise 1999'."),
    }
    snippets:entry {
        id = "bottleopener7",
        text = ccb.content.text("This bottle opener reads 'I'd rather be drinking whiskey'."),
    }
    snippets:entry { id = "bottleopener8", text = ccb.content.text("This bottle opener is shaped like a phaser.") }
    snippets:entry {
        id = "bottleopener9",
        text = ccb.content.text("This novelty bottle opener is designed to look like a hobo clown."),
    }
    content.add(snippets)
end

do
    -- Based on https://www.amazon.com/dp/B087QF9SWM
    local item = content.Item {
        id = "bottle_opener",
        category = "other",
        ascii_picture = "bottle_opener",
        name = ccb.content.plural_text("bottle opener", "bottle openers"),
        description = ccb.content.text("A simple lever for popping open bottles."),
        mass_milligrams = 64000,
        volume_ml = 93,
        longest_side_mm = 180,
        price_cents = 400,
        looks_like = "fork",
        copy_from = "base_silverware",
        melee_to_hit = -1,
        snippet_category = "auto:bottle_opener",
    }
    content.add(item)
end

do
    -- Calculated as a cylinder of 7.44in diameter and 4.5in height. Calculating it from package dimensions of the amazon listing would give ridiculous volume.
    -- Based on https://www.amazon.com/dp/B0858VCYTB
    local item = content.Item {
        id = "kettle",
        category = "tools",
        name = ccb.content.plural_text("kettle", "kettles"),
        description = ccb.content.text("A stovetop kettle for boiling water."),
        copy_from = "base_cookpot",
        color = "light_gray",
        mass_milligrams = 508000,
        volume_ml = 3205,
        longest_side_mm = 190,
        price_cents = 1300,
        replace_pockets = true,
        remove_qualities = { "COOK" },
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 1500, max_weight_milligrams = 2000000, watertight = true, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "coffeepot",
        category = "tools",
        name = ccb.content.plural_text("coffee pot", "coffee pots"),
        description = ccb.content.text("A glass pot for making a cup of joe."),
        copy_from = "base_cookpot",
        color = "light_gray",
        mass_milligrams = 676000,
        volume_ml = 3100,
        replace_pockets = true,
        remove_qualities = { "COOK" },
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:container_pocket { max_volume_ml = 3000, max_weight_milligrams = 6000000, watertight = true, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "dutch_oven",
        category = "tools",
        name = ccb.content.plural_text("cast-iron dutch oven", "cast-iron dutch ovens"),
        description = ccb.content.text("A cast-iron dutch oven, suitable for boiling, broiling, roasting, baking, stewing, frying and any other method of cooking."),
        copy_from = "base_cookpot",
        color = "dark_gray",
        mass_milligrams = 6210000,
        volume_ml = 12152,
        longest_side_mm = 310,
        replace_pockets = true,
    }
    item:material("iron", 1)
    item:container_pocket { max_volume_ml = 6300, max_weight_milligrams = 6300000, watertight = true, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:quality("OVEN", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "improvised_oven",
        category = "tools",
        name = ccb.content.plural_text("improvised oven", "improvised ovens"),
        description = ccb.content.text("A large pot converted into an improvised oven, suitable for basic baking on a hot surface."),
        copy_from = "base_cookpot",
        color = "light_gray",
        mass_milligrams = 2490000,
        volume_ml = 12800,
        longest_side_mm = 250,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 12000,
        max_weight_milligrams = 12000000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:quality("OVEN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_dutch_oven",
        category = "tools",
        name = ccb.content.plural_text("clay pot oven", "clay pot ovens"),
        description = ccb.content.text("A makeshift oven made of a big clay pot with a lid, containing firebricks to hold heat and a smaller pot to bake in."),
        copy_from = "base_cookpot",
        looks_like = "pot_canning_clay",
        color = "brown",
        mass_milligrams = 11388000,
        volume_ml = 30000,
        longest_side_mm = 350,
        replace_pockets = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 2000, max_weight_milligrams = 2100000, watertight = true, rigid = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:quality("OVEN", 1)
    content.add(item)
end
