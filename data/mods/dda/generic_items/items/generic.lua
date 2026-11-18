local ccb = require("ccb")
local content = ccb.content

do
    -- pseudo item, used as fuel type for engines that are animal-powered
    -- NO_I18N
    local item = content.Item {
        id = "animal",
        symbol = "?",
        color = "white",
        name = ccb.content.plural_text("animal", "animal"),
        description = content.text("seeing this is a bug"),
        stackable = true,
        price_cents = 0,
        volume_ml = 1000,
    }
    item:material("animal", 1)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERPETUAL")
    content.add(item)
end

do
    -- pseudo item, only used for crafting as a required tool
    -- NO_I18N
    local item = content.Item {
        id = "fire",
        symbol = "$",
        color = "red",
        name = ccb.content.plural_text("nearby fire", "nearby fire"),
        description = content.text("seeing this is a bug"),
        price_cents = 0,
        volume_ml = 1,
    }
    item:clear_flags()
    item:flag("PSEUDO")
    content.add(item)
end

do
    local item = content.Item {
        id = "cottonwood_tree_boll",
        name = ccb.content.plural_text("cottonwood tree boll", "cottonwood tree bolls"),
        category = "other",
        mass_milligrams = 5000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A fluffy white seed.  While it looks like the common cotton, it is too weak and short to be turned into clothing."),
        price_cents = 1,
        price_postapoc_cents = 1,
        volume_ml = 250,
        stackable = true,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    -- pseudo item, used as fuel type for engines that are human-powered
    -- NO_I18N
    local item = content.Item {
        id = "muscle",
        symbol = "?",
        color = "white",
        name = ccb.content.plural_text("muscle", "muscle"),
        description = content.text("seeing this is a bug"),
        stackable = true,
        price_cents = 0,
        volume_ml = 1000,
    }
    item:material("muscle", 1)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERPETUAL")
    content.add(item)
end

do
    -- pseudo item, used as fuel type for engines that are wind-powered
    -- NO_I18N
    local item = content.Item {
        id = "wind",
        symbol = "?",
        color = "white",
        name = ccb.content.plural_text("wind", "wind"),
        description = content.text("seeing this is a bug"),
        stackable = true,
        price_cents = 0,
        volume_ml = 1000,
    }
    item:material("wind", 1)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERPETUAL")
    content.add(item)
end

do
    -- pseudo item, used as fuel type for CBMs that are sun-powered
    -- NO_I18N
    local item = content.Item {
        id = "sunlight",
        symbol = "?",
        color = "white",
        name = ccb.content.plural_text("sun light", "sun light"),
        description = content.text("seeing this is a bug"),
        stackable = true,
        price_cents = 0,
        volume_ml = 1000,
    }
    item:material("sunlight", 1)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERPETUAL")
    content.add(item)
end

do
    -- pseudo item, used as fuel type for CBMs that are metabolism-powered
    -- NO_I18N
    local item = content.Item {
        id = "metabolism",
        symbol = "?",
        color = "white",
        name = ccb.content.plural_text("metabolism", "metabolisms"),
        description = content.text("seeing this is a bug"),
        stackable = true,
        price_cents = 0,
        volume_ml = 1000,
    }
    item:material("metabolism", 1)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERPETUAL")
    content.add(item)
end

do
    -- pseudo item, only used for as a required tool, checked for in player::amount_of
    -- NO_I18N
    local item = content.Item {
        id = "apparatus",
        symbol = "$",
        color = "red",
        name = ccb.content.plural_text("a smoking device and a source of flame", "a smoking device and a source of flame"),
        description = content.text("seeing this is a bug"),
        price_cents = 0,
        volume_ml = 0,
    }
    item:clear_flags()
    item:flag("PSEUDO")
    content.add(item)
end

do
    -- Fist is internally represented as 'wielding a none as a weapon'
    -- NO_I18N
    local item = content.Item {
        id = "null",
        symbol = "$",
        color = "red",
        name = ccb.content.plural_text("none", "none"),
        description = content.text("seeing this is a bug"),
        price_cents = 0,
        volume_ml = 0,
    }
    item:clear_flags()
    item:flag("PSEUDO")
    content.add(item)
end

do
    local item = content.Item {
        id = "log_immersion27",
        copy_from = "file",
        looks_like = "file",
        name = ccb.content.plural_text("INCIDENT REPORT: IMMERSION-27A", "INCIDENT REPORT: IMMERSION-27As"),
        description = ccb.content.text("A white piece of paper, with the logo of XEDRA printed on its upper left corner.  It seems to be an internal report of some kind."),
        snippet_category = "log_immersion27",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "report_t_substrate",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("MATERIAL: T-SUBSTRATE", "MATERIAL: T-SUBSTRATE"),
        snippet_category = "t-substrate",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HAADF_t_substrate",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("HAADF MICROGRAPH: T-SUBSTRATE", "HAADF MICROGRAPH: T-SUBSTRATE"),
        snippet_category = "HAADF_t-substrate",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "monitoring_equipment_doc",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("XEDRA document", "XEDRA documents"),
        snippet_category = "monitoring_equipment",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_scp_doc",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("ANOMALOUS ARTIFACT REPORT", "ANOMALOUS ARTIFACT REPORT"),
        snippet_category = "artifact_scp",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "melchior_science_doc",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("MELCHIOR report", "MELCHIOR reports"),
        snippet_category = "melchior_science_doc",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "msu14_password",
        name = ccb.content.plural_text("annotated paper scrap", "annotated paper scraps"),
        category = "books",
        description = ccb.content.text("A small scrap of paper with two long character sequences scribbled on it."),
        mass_milligrams = 1000,
        color = "white",
        symbol = ",",
        volume_ml = 4,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "fp_loyalty_card",
        category = "other",
        symbol = "-",
        color = "pink",
        name = ccb.content.plural_text("Foodplace loyalty card", "Foodplace loyalty cards"),
        description = ccb.content.text("A bright pink loyalty card, all the points are stamped.  This would definitely prove your fidelity to Foodplace, if that still meant anything…"),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "twig",
        name = ccb.content.plural_text("twig", "twigs"),
        looks_like = "stick",
        description = ccb.content.text("A small, slender branch.  Makes passable firewood but is not useful for much else."),
        mass_milligrams = 40000,
        color = "brown",
        symbol = "/",
        volume_ml = 100,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "leaves",
        name = ccb.content.plural_text("handful of leaves", "handfuls of leaves"),
        looks_like = "withered",
        description = ccb.content.text("Some ordinary, mostly dry leaves.  They have very few uses and are thus (almost) only good for burning."),
        mass_milligrams = 30000,
        color = "green",
        symbol = ",",
        volume_ml = 100,
        stackable = true,
    }
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "withered",
        symbol = "%",
        color = "light_gray",
        name = ccb.content.plural_text("withered plant", "withered plants"),
        description = ccb.content.text("A dead plant.  Good for starting fires or making crude tailoring crafts."),
        mass_milligrams = 20000,
        volume_ml = 250,
    }
    item:material("dry_plant", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "dry_seaweed",
        name = ccb.content.plural_text("dried seaweed", "dried seaweed"),
        looks_like = "withered",
        description = ccb.content.text("A bit of dried seaweed.  It's tough, inedible, and possibly poisonous, but it could be burned or used for crafts."),
        mass_milligrams = 10000,
        color = "green",
        symbol = ",",
        volume_ml = 10,
        stackable = true,
    }
    item:material("dry_plant", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "dry_seaweed_pile",
        name = ccb.content.plural_text("pile of dried seaweed", "pile of dried seaweed"),
        looks_like = "withered",
        description = ccb.content.text("A big heap of dried seaweed.  It's tough, inedible, and possibly poisonous, but it could be burned or used for crafts."),
        mass_milligrams = 200000,
        color = "green",
        symbol = ",",
        volume_ml = 200,
        stackable = true,
    }
    item:material("dry_plant", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "fertilizer",
        symbol = "*",
        color = "green",
        name = ccb.content.plural_text("fertilizer", "fertilizers"),
        description = ccb.content.text("A token representing fertilization of a plant."),
    }
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    item:flag("FERTILIZER")
    content.add(item)
end

do
    local item = content.Item {
        id = "chain",
        category = "spare_parts",
        name = ccb.content.plural_text("steel chain", "steel chains"),
        description = ccb.content.text("A heavy steel chain.  Useful as a weapon, or for crafting.  It has a chance to wrap around your target, allowing for a bonus unarmed attack."),
        mass_milligrams = 3628000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WRAP" },
        volume_ml = 1000,
        price_cents = 8000,
        replace_qualities = true,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
    }
    item:material("steel", 1)
    item:quality("ROPE", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "ballast",
        category = "spare_parts",
        symbol = "o",
        color = "light_gray",
        name = ccb.content.plural_text("ballast organs", "clusters of ballast organs"),
        description = ccb.content.text("A cluster of hydrostatic organs, each about the size of a baseball, retrieved from inside a kraken mutant.  Some of them seem to be lighter than air, and some seem to weigh as much as air."),
        price_cents = 0,
        mass_milligrams = 50000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "acidchitin_piece",
        copy_from = "chitin_piece",
        looks_like = "chitin_piece",
        name = ccb.content.plural_text("chunk of biosilicified chitin", "chunks of biosilicified chitin"),
        description = ccb.content.text("A lump of exoskeleton that has undergone biosilicification.  It is acid-resistant but rather brittle."),
    }
    item:material("acidchitin", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "sample_t_substrate",
        category = "spare_parts",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("t-substrate sample", "t-substrate samples"),
        description = ccb.content.text("An acrylic cube cast around a small black crystal.  It's tepid to the touch."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 100000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("stone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "biollante_bud",
        symbol = ",",
        color = "magenta",
        name = ccb.content.plural_text("biollante bud", "biollante buds"),
        description = ccb.content.text("An unopened biollante flower, brilliant purple in color.  It may still have its sap-producing organ intact."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 60000,
        volume_ml = 250,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "canister_empty",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("empty canister", "empty canisters"),
        category = "container",
        description = ccb.content.text("An empty canister, which may have once held tear gas or other substances."),
        mass_milligrams = 40000,
        volume_ml = 263,
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
        sealed_spoil_multiplier = 0.0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "petrified_eye",
        symbol = "*",
        color = "dark_gray",
        name = ccb.content.plural_text("petrified eye", "petrified eyes"),
        description = ccb.content.text("A fist-sized eyeball with a cross-shaped pupil.  It seems to be made of stone, but doesn't look like it was carved."),
        price_cents = 200000,
        price_postapoc_cents = 1000,
        mass_milligrams = 700000,
        volume_ml = 250,
        melee_to_hit = -2,
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "spiral_stone",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("spiral stone", "spiral stones"),
        category = "artifacts",
        description = ccb.content.text("A rock the size of your fist.  It is covered with intricate spirals; it is impossible to tell whether they are carved, naturally formed, or some kind of fossil."),
        price_cents = 20000,
        price_postapoc_cents = 1000,
        mass_milligrams = 493000,
        volume_ml = 250,
        melee_to_hit = -2,
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("SLING_PROJECTILE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "usb_drive_nano",
        copy_from = "usb_drive",
        looks_like = "usb_drive",
        name = ccb.content.plural_text("secured USB drive", "secured USB drives"),
        description = ccb.content.text("A USB thumb drive.  Useful for holding software.  This one seems like it could get run over by a truck and be fine."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "nano_fabricator_encryption_code",
        copy_from = "usb_drive_nano",
        looks_like = "usb_drive_nano",
        name = ccb.content.plural_text("nano-fabricator licensing USB", "nano-fabricator licensing USB"),
        description = ccb.content.text("Some type of advanced data storage device, filled with credentials and licenses to operate the nano-fabricator."),
        price_cents = 10000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lixa_data",
        copy_from = "usb_drive_nano",
        looks_like = "usb_drive_nano",
        name = ccb.content.plural_text("LIXA research archive backup", "LIXA research archive backup"),
        description = ccb.content.text("A secured USB thumb drive, containing a copy of the LIXA facility's research archives."),
        price_cents = 10000,
        price_postapoc_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "robofac_hardcase",
        name = ccb.content.plural_text("DARPA hard case", "DARPA hard cases"),
        description = ccb.content.text("A heavy and very durable protective case made of steel and thick plastic, locked with a six-dial combination.  A sticker with the logo of DARPA is attached to the front, but looking at the surface, you can see that another marking - formerly stenciled into the material - was recently and hastily destroyed."),
        mass_milligrams = 1202000,
        volume_ml = 7958,
        longest_side_mm = 300,
        price_cents = 0,
        melee_to_hit = -1,
        symbol = "?",
        looks_like = "briefcase",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("thermo_resin", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "fema_data",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("FEMA data", "FEMA data"),
        description = ccb.content.text("Evacuation plans, disaster risk projections, personnel lists, and last-minute communications from just before the end, all scrubbed from FEMA servers and stored in an external HDD."),
        price_cents = 10000,
        price_postapoc_cents = 50,
        mass_milligrams = 30000,
        volume_ml = 250,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- Quest item, should not spawn naturally.
    local item = content.Item {
        id = "godcotrader_accounting_records_dirty",
        name = ccb.content.plural_text("accounting records", "accounting records"),
        description = ccb.content.text("A stack of various forms and papers with credits and debits listed all over them, detailing transactions and purchases.  Reading over them, all of the balances are mismatched, and a significant amount of money is missing."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
        color = "white",
        symbol = "r",
    }
    item:material("paper", 1)
    content.add(item)
end

do
    -- Quest item, should not spawn naturally.
    local item = content.Item {
        id = "godcotrader_accounting_records_clean",
        name = ccb.content.plural_text("accounting records", "accounting records"),
        description = ccb.content.text("A stack of various forms and papers with credits and debits listed all over them, detailing transactions and purchases.  Reading over them, everything is in good order, whoever did these is skilled at their job."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
        color = "white",
        symbol = "r",
    }
    item:material("paper", 1)
    content.add(item)
end

do
    -- Based on the medium variation from https://www.amazon.com/dp/B09TNCS7HL
    -- It's specifically not rigid because volume of candlestick and candle should be additive.
    local item = content.Item {
        id = "candlestick",
        symbol = "/",
        color = "yellow",
        name = ccb.content.plural_text("candlestick", "candlesticks"),
        description = ccb.content.text("A brass candlestick with a gold finish."),
        category = "other",
        price_cents = 500,
        price_postapoc_cents = 10,
        mass_milligrams = 180000,
        volume_ml = 100,
        longest_side_mm = 280,
        melee_to_hit = -1,
        replace_pockets = true,
    }
    item:material("brass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:container_pocket {
        max_volume_ml = 550,
        max_weight_milligrams = 500000,
        holster = true,
        max_item_length_mm = 300,
        allowed_items = { "candle", "candle_lit" },
        transparent = true,
    }
    content.add(item)
end

do
    -- Based on: https://www.amazon.com/Goblets-Chalices-Glasses-Hand-Made-Decoration/dp/B09FDW2RX2/ref=sr_1_4?crid=1N9BI6VTIV08Z&keywords=gold%2Bchalice&qid=1680851190&sprefix=gold%2Bchalic%2Caps%2C305&sr=8-4&th=1
    local item = content.Item {
        id = "chalice",
        name = ccb.content.plural_text("gold chalice", "gold chalices"),
        description = ccb.content.text("A gold chalice."),
        category = "other",
        mass_milligrams = 200000,
        volume_ml = 330,
        longest_side_mm = 120,
        price_cents = 1900,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "yellow",
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "blade",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("blade", "blades"),
        description = ccb.content.text("A large, relatively sharp blade.  Could be used to make bladed weaponry, or attached to a car."),
        category = "spare_parts",
        price_cents = 28000,
        price_postapoc_cents = 50,
        mass_milligrams = 553000,
        volume_ml = 750,
        melee_to_hit = -4,
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("BUTCHER", -38)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "blade_scythe",
        symbol = "(",
        color = "light_gray",
        name = ccb.content.plural_text("scythe blade", "scythe blades"),
        description = ccb.content.text("A large, curved blade.  Could be used to assemble a scythe, or make an improvised polearm."),
        category = "spare_parts",
        price_cents = 28000,
        price_postapoc_cents = 50,
        mass_milligrams = 1000000,
        volume_ml = 1500,
        replace_qualities = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:quality("BUTCHER", -38)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "circsaw_blade",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("circular sawblade", "circular sawblades"),
        description = ccb.content.text("An 8\" circular sawblade.  You could make a saw with it, or throw it.  Wielding it without sturdy gloves is a bad idea."),
        category = "spare_parts",
        price_cents = 20000,
        price_postapoc_cents = 50,
        mass_milligrams = 349000,
        volume_ml = 250,
        longest_side_mm = 204,
        melee_to_hit = -4,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    item:clear_melee_damage()
    item:melee_damage("cut", 14)
    content.add(item)
end

do
    local item = content.Item {
        id = "tree_spile",
        symbol = ".",
        color = "light_gray",
        name = ccb.content.plural_text("tree spile", "tree spiles"),
        description = ccb.content.text("A hollow metal cylinder which is inserted in a tree crust in order to slowly harvest its sap.  Can be used on a maple tree between late winter and early spring to harvest maple sap."),
        category = "tools",
        price_cents = 5,
        price_postapoc_cents = 10,
        mass_milligrams = 11000,
        volume_ml = 50,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("TREE_TAP", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_tree_spile",
        copy_from = "tree_spile",
        looks_like = "tree_spile",
        color = "brown",
        name = ccb.content.plural_text("makeshift tree spile", "makeshift tree spiles"),
        description = ccb.content.text("A carved piece of wood which is inserted in a tree crust in order to slowly harvest its sap.  Can be used on a maple tree in between late winter and early spring to harvest maple sap."),
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("TREE_TAP", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "egg_void_spider",
        name = ccb.content.plural_text("luminescent bead", "luminescent beads"),
        mass_milligrams = 55000,
        color = "white",
        symbol = "o",
        description = ccb.content.text("Strange lights perpetually glimmer within the sharpened internals of this glass globule."),
        price_cents = 44,
        price_postapoc_cents = 50,
        light = 8,
        volume_ml = 50,
    }
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tattered_garment",
        name = ccb.content.plural_text("tattered garments", "tattered garments"),
        category = "other",
        description = ccb.content.text("Time and the elements have reduced them to a mound of filthy ribbons."),
        mass_milligrams = 1175000,
        volume_ml = 3000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "[",
        looks_like = "cotton_patchwork",
        color = "brown",
    }
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wire",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("wire", "wires"),
        description = ccb.content.text("A length of thin, relatively stiff steel wire.  Like the sort you find in chain link fences."),
        category = "spare_parts",
        price_cents = 20000,
        price_postapoc_cents = 10,
        mass_milligrams = 151000,
        volume_ml = 100,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "piano_wire",
        symbol = "l",
        color = "light_gray",
        name = ccb.content.plural_text("piano wire", "piano wires"),
        description = ccb.content.text("A length of thin, relatively stretchy coiled steel wire.  Used to produce musical notes in instruments."),
        category = "spare_parts",
        price_cents = 2000,
        price_postapoc_cents = 10,
        mass_milligrams = 1000,
        volume_ml = 3,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_wire",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("steel wire", "steel wires"),
        description = ccb.content.text("A length of thin, relatively stiff wire made of mild steel.  Ubiquitously found in everyday applications such as chain link fences."),
        category = "spare_parts",
        price_cents = 20000,
        price_postapoc_cents = 100,
        mass_milligrams = 151000,
        volume_ml = 100,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_wire",
        copy_from = "lc_wire",
        looks_like = "lc_wire",
        name = ccb.content.plural_text("medium steel wire", "medium steel wires"),
        description = ccb.content.text("A length of thin, stiff wire made of medium steel.  Its balance between strength and flexibility makes it suitable for steel ropes and cables."),
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_wire",
        copy_from = "lc_wire",
        looks_like = "lc_wire",
        name = ccb.content.plural_text("high steel wire", "high steel wires"),
        description = ccb.content.text("A length of strong wire made of high carbon steel.  Often used in industrial machinery and springs."),
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_wire",
        copy_from = "lc_wire",
        looks_like = "lc_wire",
        name = ccb.content.plural_text("hardened steel wire", "hardened steel wires"),
        description = ccb.content.text("A length of thin, relatively stiff steel wire, made of hardened steel."),
    }
    item:material("ch_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_wire",
        copy_from = "lc_wire",
        looks_like = "lc_wire",
        name = ccb.content.plural_text("tempered steel wire", "tempered steel wires"),
        description = ccb.content.text("A length of flexible and durable steel wire, made of tempered spring steel.  Often used in industrial and automotive springs, and the wire in musical instruments."),
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wire_barbed",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("barbed wire", "barbed wires"),
        description = ccb.content.text("A length of stiff wire, covered in sharp barbs."),
        price_cents = 20000,
        price_postapoc_cents = 200,
        mass_milligrams = 302000,
        volume_ml = 500,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    content.add(item)
end

do
    -- Reference tables for calculating steel mesh weight (current one assumes 100 mesh twill weave): http://www.wirecloth.com/mesh-cloth-specification-tables/
    local item = content.Item {
        id = "wire_mesh",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("steel mesh", "steel meshes"),
        description = ccb.content.text("A 6-inch square piece of finely-woven steel wire, useful for dryer lint traps and reusable coffee filter baskets.  You could put this on a window to keep mosquitoes and other bugs out if it was larger, but chain link fencing will do these days."),
        category = "spare_parts",
        mass_milligrams = 19000,
        volume_ml = 6,
        price_cents = 700,
        price_postapoc_cents = 100,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- 80 cm x 16mm diameter
    local item = content.Item {
        id = "rebar",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("rebar", "rebars"),
        description = ccb.content.text("A rod of rebar, makes a nice melee weapon, and could be handy in constructing tougher walls and such."),
        category = "spare_parts",
        price_cents = 7500,
        price_postapoc_cents = 25,
        mass_milligrams = 1245000,
        volume_ml = 159,
        longest_side_mm = 800,
        melee_to_hit = 0,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "railroad_track_small",
        symbol = "=",
        color = "dark_gray",
        name = ccb.content.plural_text("small railroad track", "small railroad tracks"),
        description = ccb.content.text("A length of track, made from some planks and rails."),
        category = "spare_parts",
        price_cents = 7500,
        price_postapoc_cents = 10,
        mass_milligrams = 40000000,
        volume_ml = 30000,
        stackable = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "concrete",
        symbol = "%",
        color = "light_gray",
        name = ccb.content.plural_text("dry concrete mix", "dry concrete mix"),
        description = ccb.content.text("Some mixed cement, sand and aggregates, precombined and ready to be used in a construction project."),
        category = "spare_parts",
        price_cents = 10000,
        price_postapoc_cents = 5,
        mass_milligrams = 450000,
        volume_ml = 300,
    }
    item:material("cement", 3)
    item:material("sand", 2)
    item:material("stone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "drum_skin",
        name = ccb.content.plural_text("drum skin", "drum skins"),
        copy_from = "tanned_hide",
        looks_like = "tanned_hide",
        mass_milligrams = 10000,
        description = ccb.content.text("The tanned hide of an animal repurposed to become the head on a percussion drum."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "torch_done",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("burnt out torch", "burnt out torches"),
        description = ccb.content.text("A torch that has consumed all its fuel; it can be recrafted into another torch."),
        category = "other",
        mass_milligrams = 510000,
        volume_ml = 1042,
        longest_side_mm = 1220,
        melee_to_hit = 0,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "handflare_dead",
        category = "other",
        symbol = ";",
        color = "red",
        name = ccb.content.plural_text("dead flare", "dead flares"),
        description = ccb.content.text("A spent magnesium flare.  It is essentially trash."),
        mass_milligrams = 39000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "spring",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("large spring", "large springs"),
        category = "spare_parts",
        description = ccb.content.text("A large, heavy-duty spring.  Expands with significant force when compressed."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 2000000,
        volume_ml = 750,
        melee_to_hit = -5,
    }
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "spring_medium",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("medium spring", "medium springs"),
        category = "spare_parts",
        description = ccb.content.text("A medium spring wound from tempered steel wire.  Resists corrosion and expands consistently when compressed."),
        price_cents = 50,
        price_postapoc_cents = 10,
        mass_milligrams = 100000,
        volume_ml = 60,
        longest_side_mm = 100,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spring_small",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("small spring", "small springs"),
        category = "spare_parts",
        description = ccb.content.text("A small spring wound from tempered steel wire.  Resists corrosion and expands consistently when compressed."),
        price_cents = 20,
        price_postapoc_cents = 5,
        mass_milligrams = 10000,
        volume_ml = 5,
        longest_side_mm = 30,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lawnmower",
        symbol = ";",
        color = "green",
        name = ccb.content.plural_text("lawnmower", "lawnmowers"),
        description = ccb.content.text("A motorized pushmower that seems to be broken.  You could take it apart if you had a wrench."),
        category = "other",
        price_cents = 10000,
        price_postapoc_cents = 50,
        mass_milligrams = 28680000,
        volume_ml = 6250,
        longest_side_mm = 1000,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "broketent",
        symbol = ";",
        color = "green",
        name = ccb.content.plural_text("damaged tent", "damaged tents"),
        description = ccb.content.text("A small tent, just big enough to fit one person comfortably.  This tent is broken and cannot be deployed."),
        price_cents = 6500,
        price_postapoc_cents = 100,
        mass_milligrams = 1133000,
        volume_ml = 2500,
        longest_side_mm = 1000,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "largebroketent",
        symbol = ";",
        color = "green",
        name = ccb.content.plural_text("large damaged tent", "large damaged tents"),
        description = ccb.content.text("A family-sized tent, very bulky but with plenty of space.  This tent is broken and cannot be deployed."),
        price_cents = 10000,
        price_postapoc_cents = 150,
        mass_milligrams = 2266000,
        volume_ml = 10000,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "element",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("heating element", "heating elements"),
        category = "spare_parts",
        description = ccb.content.text("A heating element, like the ones used in hotplates or kettles.  Consists of nichrome wire surrounded by electrical insulator and placed inside a steel casing."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 226000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "crude_heating_element",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("crude heating element", "crude heating elements"),
        category = "spare_parts",
        description = ccb.content.text("A primitive heating element made from thin coiled steel wire.  It will degrade much quicker with use than normal heating elements, but it'll do for some applications."),
        price_cents = 100,
        price_postapoc_cents = 50,
        mass_milligrams = 226000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "thermostat",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("bimetal thermostat", "bimetal thermostats"),
        category = "spare_parts",
        description = ccb.content.text("A simple thermostat controlled by thermal expansion of a bimetal strip."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 226000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    -- weight and volume assumed to be from model XE36S06ST45U0 water heater <https://images.thdstatic.com/catalog/pdfImages/2d/2d7ed116-1a8c-439d-b7fe-a62a0a98f806.pdf>
    local item = content.Item {
        id = "household_water_heater",
        symbol = "0",
        color = "white",
        name = ccb.content.plural_text("household water heater", "household water heaters"),
        description = ccb.content.text("A large metal tank with a water faucet attached to it, primarily used to store and heat water."),
        price_cents = 0,
        price_postapoc_cents = 10,
        mass_milligrams = 54431000,
        volume_ml = 240000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_water_heater")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    -- weight and volume assumed to be from model XG55T06EC50UO water heater <https://images.thdstatic.com/catalog/pdfImages/7e/7e7928b1-8b4f-472a-8ee8-b48eb1e7932a.pdf>
    local item = content.Item {
        id = "household_water_heater_family",
        symbol = "0",
        color = "white",
        name = ccb.content.plural_text("family–sized household water heater", "family–sized household water heaters"),
        description = ccb.content.text("A large metal tank with a water faucet attached to it, primarily used to store and heat water.  Large enough for a whole family."),
        price_cents = 0,
        price_postapoc_cents = 20,
        mass_milligrams = 80000000,
        volume_ml = 406000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_water_heater_family")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "television",
        symbol = ";",
        color = "dark_gray",
        name = ccb.content.plural_text("television", "televisions"),
        description = ccb.content.text("A large LCD television, full of delicious electronics."),
        price_cents = 0,
        price_postapoc_cents = 10,
        mass_milligrams = 15000000,
        volume_ml = 20000,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "household_washing_machine",
        symbol = "{",
        color = "white",
        name = ccb.content.plural_text("household washing machine", "household washing machines"),
        description = ccb.content.text("An appliance used to wash laundry, not of much use without power and water.  Can be placed as an appliance."),
        price_cents = 0,
        price_postapoc_cents = 10,
        mass_milligrams = 66000000,
        volume_ml = 500000,
        longest_side_mm = 1160,
        replace_pockets = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 135000, max_weight_milligrams = 15000000, rigid = true, watertight = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "household_dishwasher",
        symbol = "{",
        color = "white",
        name = ccb.content.plural_text("household dishwasher", "household dishwashers"),
        description = ccb.content.text("An appliance used to clean dishes, not of much use without power and water.  Can be placed as an appliance."),
        price_cents = 0,
        price_postapoc_cents = 10,
        mass_milligrams = 41000000,
        volume_ml = 300000,
        longest_side_mm = 840,
        replace_pockets = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 120000, max_weight_milligrams = 15000000, rigid = true, watertight = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "pilot_light",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("pilot light", "pilot lights"),
        category = "spare_parts",
        description = ccb.content.text("A pilot light from a gas-burning device, this particular one is a simple piezoelectric igniter."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000,
        volume_ml = 5,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "delay_fuze",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("delayed fuze", "delayed fuzes"),
        category = "spare_parts",
        description = ccb.content.text("A complex mechanical fuze.  It seems it can be used to detonate stable explosives after a short time by triggering it."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 5000,
        volume_ml = 5,
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "impact_fuze",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("impact fuze", "impact fuzes"),
        category = "spare_parts",
        description = ccb.content.text("A complex mechanical fuze.  It seems it can be used to detonate stable explosives upon a solid impact."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 5000,
        volume_ml = 1,
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_kord",
        looks_like = "kord",
        symbol = "(",
        color = "light_gray",
        name = ccb.content.plural_text("Kord AK rifle (Demilled)", "Kord AK rifles (Demilled)"),
        mass_milligrams = 3250000,
        volume_ml = 2418,
        longest_side_mm = 480,
        price_cents = 250000,
        category = "other",
        description = ccb.content.text("A special forces Russian rifle chambered in 5.45 that someone has taken a plasma cutter to, cutting it in three places to comply with import restrictions.  This thing would have been hard to source, and thankfully its unique complex recoil balance system remains intact, unlike the receiver and barrel.  The telltale rainbow patterns of torch cuts mar the otherwise beautiful receiver.  A well-equipped gunsmith with time and materials could probably build a new one out of this…"),
        variant_kind = "gun",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:variants {
        { id = "broken_kord", name = ccb.content.plural_text("Kord 6P67 rifle (Demilled)", "Kord 6P67 rifles (Demilled)"), description = ccb.content.text("A special forces Russian rifle chambered in 5.45 that someone has taken a plasma cutter to, cutting it in three places to comply with import restrictions.  This thing would have been hard to source, and thankfully its unique complex recoil balance system remains intact, unlike the receiver and barrel.  The telltale rainbow patterns of torch cuts mar the otherwise beautiful receiver.  A well-equipped gunsmith with time and materials could probably build a new one out of this…") },
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_robofac_camspy",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken camspy", "broken camspies"),
        category = "other",
        description = ccb.content.text("A broken camspy.  It probably won't spy on anything ever again.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 31520000,
        volume_ml = 15000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_robofac_skittergun",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken exterminatron", "broken exterminatrons"),
        category = "other",
        description = ccb.content.text("A broken Hub 01 exterminatron.  Much less threatening now that it lies limp on solid ground.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 32700000,
        volume_ml = 105000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_robofac_hound",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken Hub 01 HOUND", "broken Hub 01 HOUNDs"),
        category = "other",
        description = ccb.content.text("A broken Hub 01 Hostile Overstimulation & Unmanned Neutralization Drone.  Much less threatening now that it lies limp on solid ground.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 32700000,
        volume_ml = 105000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_science_bot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken lab defense bot", "broken lab defense bots"),
        category = "other",
        description = ccb.content.text("A broken lab defense bot, with its casing broken and fluid drained.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 100000000,
        volume_ml = 65000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_nursebot",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken nurse bot", "broken nurse bots"),
        category = "other",
        description = ccb.content.text("A broken nurse bot.  Its smooth face stares vacantly into empty space.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_grocerybot",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken grocery bot", "broken grocery bots"),
        category = "other",
        description = ccb.content.text("A broken grocery bot.  Its smiling face stares vacantly into empty space.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_grocerybot_busted",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken grocery bot", "broken grocery bots"),
        category = "other",
        description = ccb.content.text("The body of a busted grocery bot.  Its tarnished face is still smiling.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_nursebot_defective",
        name = ccb.content.plural_text("broken nurse bot", "broken nurse bots"),
        copy_from = "broken_nursebot",
        looks_like = "broken_nursebot",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_robofac_prototype",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken prototype robot", "broken prototype robots"),
        category = "other",
        description = ccb.content.text("A broken prototype robot--well, more broken than before.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_mech_recon",
        name = ccb.content.plural_text("broken recon mech", "broken recon mechs"),
        description = ccb.content.text("A broken mech exoskeleton suit, it looks beyond repair."),
        mass_milligrams = 700388000,
        volume_ml = 125000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_green",
    }
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_mech_lifter",
        name = ccb.content.plural_text("broken mech lifter", "broken mech lifters"),
        description = ccb.content.text("A broken mech exoskeleton suit, it looks beyond repair."),
        mass_milligrams = 1280388000,
        volume_ml = 250000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_green",
    }
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_mech_combat",
        name = ccb.content.plural_text("broken combat mech", "broken combat mechs"),
        description = ccb.content.text("A broken mech exoskeleton suit, it looks beyond repair."),
        mass_milligrams = 1480388000,
        volume_ml = 250000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_green",
    }
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_dispatch",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("broken riot dispatch", "broken riot dispatches"),
        category = "other",
        description = ccb.content.text("A broken riot dispatch, with its mesh midsection filled with fried manhacks and its motor limp and still.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 100000000,
        volume_ml = 85000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_dispatch_military",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken military dispatch", "broken military dispatches"),
        category = "other",
        description = ccb.content.text("A broken military dispatch.  Though the scratched manhacks visible in its belly are disarmed, their destructive potential still inspires a spark of fear in you, even now.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 100000000,
        volume_ml = 85000,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_manhack",
        symbol = ",",
        color = "light_green",
        name = ccb.content.plural_text("broken manhack", "broken manhacks"),
        category = "other",
        description = ccb.content.text("A broken manhack.  Much less threatening now that it lies limp on solid ground.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 1500000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_grenade_hack",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken grenade hack", "broken grenade hacks"),
        category = "other",
        description = ccb.content.text("A broken grenade hack.  Much less threatening now that it lies quiet on solid ground.  Could be gutted for parts."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 2000000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_gasbomb_hack",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken tear gas hack", "broken tear gas hacks"),
        category = "other",
        description = ccb.content.text("A broken tear gas hack.  Much less threatening now that it lies quiet on solid ground.  Could be gutted for parts."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 2600000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_EMP_hack",
        symbol = ",",
        color = "cyan",
        name = ccb.content.plural_text("broken EMP hack", "broken EMP hacks"),
        category = "other",
        description = ccb.content.text("A broken EMP hack.  Much less threatening now that it lies quiet on solid ground.  Could be gutted for parts."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 2000000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_flashbang_hack",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken flashbang hack", "broken flashbang hacks"),
        category = "other",
        description = ccb.content.text("A broken flashbang hack.  Much less threatening now that it lies quiet on solid ground.  Could be gutted for parts."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 1750000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_c4_hack",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("broken C-4 hack", "broken C-4 hacks"),
        category = "other",
        description = ccb.content.text("A broken C-4 hack.  Much less threatening now that it lies quiet on solid ground.  Could be gutted for parts."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 3100000,
        volume_ml = 750,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_speaker",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("broken loudspeaker", "broken loudspeakers"),
        category = "other",
        description = ccb.content.text("A broken loudspeaker.  It's so unusually quiet now…  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 500,
        mass_milligrams = 52000000,
        volume_ml = 50500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "processor",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("processor board", "processor boards"),
        category = "spare_parts",
        description = ccb.content.text("A central processor unit, useful in advanced electronics crafting."),
        price_cents = 12000,
        price_postapoc_cents = 10,
        mass_milligrams = 56000,
        volume_ml = 250,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- A stick of DDR4 SRAM is 133.35 x 31.25 x 4.2mm, or 17.5ml. We round up a touch.
    local item = content.Item {
        id = "RAM",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("RAM", "RAMs"),
        category = "spare_parts",
        description = ccb.content.text("A stick of memory.  Useful in advanced electronics crafting."),
        price_cents = 9000,
        price_postapoc_cents = 10,
        mass_milligrams = 18000,
        volume_ml = 18,
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "power_supply",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("power converter", "power converters"),
        category = "spare_parts",
        description = ccb.content.text("A power supply unit.  Useful in lots of electronics recipes."),
        price_cents = 17000,
        price_postapoc_cents = 25,
        mass_milligrams = 113000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "amplifier",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("amplifier circuit", "amplifier circuits"),
        category = "spare_parts",
        description = ccb.content.text("A circuit designed to amplify the strength of a signal.  Useful in lots of electronics recipes."),
        price_cents = 20000,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "transponder",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("transponder circuit", "transponder circuits"),
        category = "spare_parts",
        description = ccb.content.text("A circuit designed to repeat a signal.  Useful for crafting communications equipment."),
        price_cents = 14000,
        price_postapoc_cents = 10,
        mass_milligrams = 480000,
        volume_ml = 250,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "receiver",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("signal receiver", "signal receivers"),
        category = "spare_parts",
        description = ccb.content.text("A module designed to receive many forms of signals.  Useful for crafting communications equipment."),
        price_cents = 13500,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_lcd_screen",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("large LCD screen", "large LCD screens"),
        category = "spare_parts",
        description = ccb.content.text("A large backlit screen, used for displaying images.  Useful in some electronics recipes."),
        price_cents = 10000,
        price_postapoc_cents = 10,
        mass_milligrams = 13000000,
        volume_ml = 15000,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_lcd_screen",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("small LCD screen", "small LCD screens"),
        category = "spare_parts",
        description = ccb.content.text("A small backlit screen, used for displaying images.  Useful in some electronics recipes."),
        price_cents = 24000,
        price_postapoc_cents = 10,
        mass_milligrams = 500000,
        volume_ml = 250,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lens_small",
        symbol = ".",
        color = "light_cyan",
        name = ccb.content.plural_text("small high-quality lens", "small high-quality lenses"),
        category = "spare_parts",
        description = ccb.content.text("A small, high-quality glass lens, useful for focusing or diffusing light.  Might be useful for crafting."),
        price_cents = 6000,
        price_postapoc_cents = 50,
        mass_milligrams = 1000,
        volume_ml = 1,
        stackable = true,
    }
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_tinted",
        symbol = ".",
        color = "dark_gray",
        name = ccb.content.plural_text("tinted glass lenses (pair)", "tinted glass lenses (pair)"),
        category = "spare_parts",
        description = ccb.content.text("A pair of small, darkened glass lenses, like the ones used in sunglasses."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 30000,
        volume_ml = 2,
        stackable = true,
    }
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "burnt_out_bionic",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("burnt out bionic", "burnt out bionics"),
        category = "spare_parts",
        description = ccb.content.text("Once a valuable bionic implant, it has not held up well under repeated use.  It has been destroyed by excessive electric current and is now useless."),
        price_cents = 13500,
        price_postapoc_cents = 10,
        mass_milligrams = 317000,
        volume_ml = 2500,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- actually worth millions
    local item = content.Item {
        id = "template_photonics",
        copy_from = "standard_template_construct",
        looks_like = "standard_template_construct",
        color = "yellow",
        name = ccb.content.plural_text("nanofabricator template (silicon photonics)", "nanofabricator templates (silicon photonics)"),
        description = ccb.content.text("A state-of-the-art optical storage system, containing the instruction set required for the fabrication of complex silicon photonic circuitry.  The data within was once clearly worth millions, but now, you are not sure if it's anything more than a fancy, high-tech paperweight."),
        price_cents = 200000000,
        price_postapoc_cents = 3000,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    -- given to HUB 01 for even better armor
    local item = content.Item {
        id = "template_armor",
        copy_from = "standard_template_construct",
        looks_like = "standard_template_construct",
        color = "yellow",
        name = ccb.content.plural_text("nanofabricator template (UHMWPE)", "nanofabricator templates (UHMWPE)"),
        description = ccb.content.text("A state-of-the-art optical storage system, containing the instruction set required for the fabrication of advanced armor materials.  This seems to just be routines for working with the materials, not actual armor schematics."),
        price_cents = 100000000,
        price_postapoc_cents = 3000,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "antenna",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("antenna", "antennas"),
        category = "spare_parts",
        description = ccb.content.text("A simple thin copper shaft.  Useful in lots of electronics recipes."),
        price_cents = 8000,
        price_postapoc_cents = 10,
        mass_milligrams = 68000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_micro",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("micro electric motor", "micro electric motors"),
        category = "spare_parts",
        description = ccb.content.text("A very small electric motor like those used in RC cars or electric hair trimmers."),
        price_cents = 1000,
        price_postapoc_cents = 25,
        mass_milligrams = 125000,
        volume_ml = 25,
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "circuit",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("circuit board", "circuit boards"),
        category = "spare_parts",
        description = ccb.content.text("A printed card that supports and electrically connects electronic components on a non-conductive substrate."),
        price_cents = 5000,
        price_postapoc_cents = 10,
        mass_milligrams = 26000,
        volume_ml = 15,
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "e_scrap",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("electronic scrap", "electronic scraps"),
        category = "spare_parts",
        description = ccb.content.text("A random collection of resistors, capacitors, and diodes which have been stripped from printed circuits."),
        price_cents = 3000,
        price_postapoc_cents = 10,
        mass_milligrams = 14000,
        volume_ml = 5,
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "radio_repeater_mod",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("radio repeater mod", "radio repeater mods"),
        category = "spare_parts",
        description = ccb.content.text("A system designed to convert a radio station into an autonomous repeater."),
        price_cents = 25000,
        price_postapoc_cents = 50,
        mass_milligrams = 2100000,
        volume_ml = 2000,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "ceramic_armor",
        category = "spare_parts",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("ceramic armor plate", "ceramic armor plates"),
        description = ccb.content.text("A ceramic armor plate, specifically engineered for use as armor.  Not suitable for human use."),
        price_cents = 8000,
        price_postapoc_cents = 100,
        mass_milligrams = 362000,
        volume_ml = 500,
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("ceramic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "fish_bowl",
        symbol = "u",
        color = "light_cyan",
        name = ccb.content.plural_text("fishbowl", "fishbowls"),
        description = ccb.content.text("A filled fishbowl, the tag says 'to Ed' and the fish's name, 'Hoss'.  The fish appears to have tiny antlers."),
        price_cents = 100,
        price_postapoc_cents = 10,
        mass_milligrams = 8000000,
        volume_ml = 8500,
        melee_to_hit = -4,
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "pipe_cleaner",
        name = ccb.content.plural_text("pipe cleaner", "pipe cleaners"),
        description = ccb.content.text("A tool designed to clean the interior surface of pipes, bottles, and similar objects.  This one is thin enough to be used for cleaning firearm barrels from dirt and fouling."),
        mass_milligrams = 50000,
        volume_ml = 250,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clock",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("clock", "clocks"),
        description = ccb.content.text("A small mechanical clock, it's stopped at 10:10."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 725000,
        volume_ml = 250,
        melee_to_hit = -3,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "clockworks",
        category = "spare_parts",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("clockworks", "clockworks"),
        description = ccb.content.text("A small assortment of gears and other clockwork gubbins."),
        price_cents = 200,
        price_postapoc_cents = 10,
        mass_milligrams = 50000,
        volume_ml = 50,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mirror",
        symbol = "o",
        color = "light_cyan",
        name = ccb.content.plural_text("hand mirror", "hand mirrors"),
        description = ccb.content.text("A small hand mirror."),
        price_cents = 15000,
        price_postapoc_cents = 10,
        mass_milligrams = 300000,
        volume_ml = 750,
        melee_to_hit = -2,
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:native_use("CHANGE_EYES")
    item:native_use("CHANGE_SKIN")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "manhole_cover",
        symbol = "]",
        color = "dark_gray",
        name = ccb.content.plural_text("manhole cover", "manhole covers"),
        description = ccb.content.text("A heavy iron disc that typically covers a ladder into the sewers.  Lifting it from the manhole is impossible without a crowbar."),
        category = "other",
        price_cents = 20000,
        price_postapoc_cents = 10,
        mass_milligrams = 115000000,
        volume_ml = 20000,
        melee_to_hit = -3,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end

do
    local item = content.Item {
        id = "pine_bough",
        symbol = "/",
        color = "green",
        name = ccb.content.plural_text("pine bough", "pine boughs"),
        description = ccb.content.text("A branch from a pine tree, oozing sticky sap and bristling with prickly needles."),
        mass_milligrams = 220000,
        volume_ml = 500,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    content.add(item)
end

do
    -- Commercial pinecones average 300g. We're assuming wild ones weigh less than this.
    local item = content.Item {
        id = "pinecone",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("pinecone", "pinecones"),
        description = ccb.content.text("A spiny pod from a pine tree."),
        mass_milligrams = 200000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    content.add(item)
end

do
    local item = content.Item {
        id = "sake_koji_rice",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("koji rice", "koji rice"),
        mass_milligrams = 200000,
        color = "white",
        default_container = "bag_plastic_small",
        symbol = "%",
        description = ccb.content.text("Some rice covered in koji mold, mixed in with yeast.  Useful for making sake, but not really tasty on its own.  Smells vaguely of chestnuts."),
        price_cents = 0,
        volume_ml = 250,
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "young_koji_done",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("grown wild koji mold", "grown wild koji mold"),
        description = ccb.content.text("Some cooked rice sprinkled with ash and wrapped into a corn husk.  It has grown patches of koji mold inside; disassemble this item to extract it."),
        mass_milligrams = 200000,
        color = "white",
        symbol = ",",
        price_postapoc_cents = 50,
        volume_ml = 250,
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "soy_wheat_dough_done",
        looks_like = "flour",
        name = ccb.content.plural_text("soy and wheat dough with koji", "soy and wheat dough with koji"),
        mass_milligrams = 550000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A block of dried dough made from cooked and mashed soybeans and wheat flour, covered with koji mold.  Usable for making soy sauce."),
        price_cents = 0,
        volume_ml = 500,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "poppy_bud",
        name = ccb.content.plural_text("poppy bud", "poppy buds"),
        category = "chems",
        description = ccb.content.text("A poppy bud.  Contains some substances commonly produced by a mutated poppy flower."),
        mass_milligrams = 30000,
        color = "light_red",
        symbol = ",",
        volume_ml = 5,
        price_cents = 200,
        price_postapoc_cents = 50,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sunflower",
        name = ccb.content.plural_text("sunflower", "sunflowers"),
        description = ccb.content.text("The top of a sunflower, with yellow petals and some seeds that have yet to be eaten by animals."),
        mass_milligrams = 450000,
        color = "yellow",
        symbol = ",",
        volume_ml = 1500,
        price_cents = 0,
        price_postapoc_cents = 10,
        stackable = true,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chamomile",
        name = ccb.content.plural_text("chamomile flowers", "chamomile flowers"),
        description = ccb.content.text("A handful of white chamomile flowers, used as an herbal remedy since ancient times."),
        mass_milligrams = 10000,
        color = "white",
        symbol = ",",
        volume_ml = 20,
        price_cents = 0,
        price_postapoc_cents = 0,
        stackable = true,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lotus",
        name = ccb.content.plural_text("lotus flower", "lotus flowers"),
        description = ccb.content.text("A lovely flower that grows on the surface of bodies of fresh water.  Traditionally connected with many Eastern cultures."),
        mass_milligrams = 20000,
        color = "white",
        symbol = ",",
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 0,
        stackable = true,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spurge",
        name = ccb.content.plural_text("spurge flowers", "spurge flowers"),
        description = ccb.content.text("A handful of yellow-green flowers.  Can be brewed into a tea that prevents asthma attacks."),
        mass_milligrams = 50000,
        color = "white",
        symbol = ",",
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 0,
        stackable = true,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    -- Estimated weight is between 1.5-2 lb. When withered, assuming 60% weight loss, gives us around 300 g.
    -- A medium sized bouquet is roughly 13" x 5.5" x 5.5", or roughly 6.4 L. When withered, I'm estimating a 30% shrinkage in volume, or 4.5 L.
    local item = content.Item {
        id = "bouquet",
        name = ccb.content.plural_text("withered bouquet", "withered bouquet"),
        description = ccb.content.text("A mixed collection of flowers.  Unfortunately, they have all withered with time."),
        mass_milligrams = 300000,
        color = "white",
        symbol = ",",
        volume_ml = 4500,
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("veggy", 4)
    item:material("glass", 1)
    content.add(item)
end

do
    -- dog tags are roughly 50mm x 28mm x 0.4mm, or 0.56 ml, but that's so small I needed to round up to 1 ml
    local item = content.Item {
        id = "dog_tag_dog",
        name = ccb.content.plural_text("dog tag", "dog tag"),
        description = ccb.content.text("An identification tag for a pet, engraved with their name and their owner's address and phone number.  It says \"<dog_name>\"."),
        expand_snippets = true,
        mass_milligrams = 1000,
        color = "green",
        symbol = "[",
        volume_ml = 1,
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_lump",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("lump of clay", "lumps of clay"),
        category = "spare_parts",
        description = ccb.content.text("A fresh piece of clay.  Useful for some crafting recipes."),
        price_cents = 531,
        price_postapoc_cents = 10,
        mass_milligrams = 530000,
        volume_ml = 250,
    }
    item:material("freshclay", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_kaolin",
        symbol = ",",
        color = "white",
        looks_like = "clay_lump",
        name = ccb.content.plural_text("lump of kaolin clay", "lumps of kaolin clay"),
        category = "spare_parts",
        description = ccb.content.text("A fresh soft lump of kaolin.  Useful for making ceramics like porcelain, or for high temperature applications as refractory."),
        price_cents = 1999,
        price_postapoc_cents = 10,
        mass_milligrams = 660000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- I consider this value to be too high, but lowering it further would put it below rocks, and rocks are a staple of balance due to ferals.
    local item = content.Item {
        id = "brick",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("brick", "bricks"),
        category = "spare_parts",
        description = ccb.content.text("A fire-hardened building block used in masonry construction."),
        price_cents = 2500,
        price_postapoc_cents = 10,
        mass_milligrams = 969000,
        volume_ml = 500,
        replace_qualities = true,
        melee_to_hit = -4,
    }
    item:material("clay", 1)
    item:material("stone", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "mortar_build",
        symbol = "%",
        color = "light_gray",
        name = ccb.content.plural_text("mortar", "mortar"),
        display_type = "BY_VOLUME",
        description = ccb.content.text("Some mortar, ready to be used in building projects."),
        category = "spare_parts",
        default_container = "bag_canvas",
        price_cents = 5000,
        price_postapoc_cents = 25,
        mass_milligrams = 2340000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mortar_lime",
        symbol = "%",
        color = "white",
        name = ccb.content.plural_text("lime mortar", "lime mortar"),
        description = ccb.content.text("Some lime mortar, made from quicklime and aggregate and ready for building."),
        category = "spare_parts",
        default_container = "bag_canvas",
        price_cents = 2000,
        price_postapoc_cents = 15,
        mass_milligrams = 2340000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "adobe_brick",
        category = "spare_parts",
        symbol = ",",
        color = "yellow",
        looks_like = "brick",
        name = ccb.content.plural_text("adobe brick", "adobe bricks"),
        description = ccb.content.text("A compacted mass of soil and natural fibers, baked dry enough to harden into a brick."),
        mass_milligrams = 10000000,
        volume_ml = 8000,
        longest_side_mm = 360,
        price_cents = 2000,
        price_postapoc_cents = 10,
        replace_qualities = true,
        melee_to_hit = -4,
    }
    item:material("soil", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "mortar_adobe",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("adobe mortar", "adobe mortar"),
        description = ccb.content.text("A thick, pasty mud, low in sand content to reduce crumbling once dry.  Used to glue larger, heavier pieces of mud and clay together."),
        category = "spare_parts",
        default_container = "bag_canvas",
        price_cents = 200,
        price_postapoc_cents = 10,
        mass_milligrams = 2340000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("soil", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tanbark",
        name = ccb.content.plural_text("piece of tanbark", "pieces of tanbark"),
        description = ccb.content.text("A sheet of tannin-rich bark from a tree, useful for tanning leather."),
        copy_from = "bark_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "birchbark",
        name = ccb.content.plural_text("piece of birchbark", "pieces of birchbark"),
        description = ccb.content.text("A sheet of tough, water-resistant bark taken from a birch tree."),
        copy_from = "bark_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "willowbark",
        name = ccb.content.plural_text("piece of willowbark", "pieces of willowbark"),
        description = ccb.content.text("A sheet of bark taken from a willow tree.  Used in the production of aspirin."),
        copy_from = "bark_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sassafras_root",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("sassafras root", "sassafras root"),
        description = ccb.content.text("A root taken from a sassafras tree.  Used in the production of certain sweet beverages."),
        price_cents = 0,
        price_postapoc_cents = 5,
        mass_milligrams = 85000,
        volume_ml = 109,
        stackable = true,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "diamond",
        symbol = "*",
        color = "white",
        name = ccb.content.plural_text("diamond", "diamonds"),
        description = ccb.content.text("A sparkling diamond."),
        price_cents = 1000000,
        price_postapoc_cents = 50,
        mass_milligrams = 200,
        volume_ml = 6,
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    item:material("diamond", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "garnet",
        symbol = "*",
        color = "red",
        name = ccb.content.plural_text("garnet", "garnets"),
        description = ccb.content.text("A sparkling garnet."),
        price_cents = 800000,
        price_postapoc_cents = 30,
        mass_milligrams = 200,
        volume_ml = 6,
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    item:material("gemstone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "amethyst",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "blue",
        name = ccb.content.plural_text("amethyst", "amethysts"),
        description = ccb.content.text("A sparkling amethyst."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "aquamarine",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "cyan",
        name = ccb.content.plural_text("aquamarine", "aquamarines"),
        description = ccb.content.text("A sparkling aquamarine."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "emerald",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "green",
        name = ccb.content.plural_text("emerald", "emeralds"),
        description = ccb.content.text("A sparkling emerald."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "alexandrite",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "green",
        name = ccb.content.plural_text("alexandrite", "alexandrites"),
        description = ccb.content.text("A sparkling alexandrite."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "malachite",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "green",
        name = ccb.content.plural_text("malachite", "malachites"),
        description = ccb.content.text("A sparkling malachite."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "pearl",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "white",
        name = ccb.content.plural_text("pearl", "pearls"),
        description = ccb.content.text("A lustrous pearl."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "ruby",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "red",
        name = ccb.content.plural_text("ruby", "rubies"),
        description = ccb.content.text("A sparkling ruby."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "peridot",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "green",
        name = ccb.content.plural_text("peridot", "peridots"),
        description = ccb.content.text("A sparkling peridot."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "sapphire",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "blue",
        name = ccb.content.plural_text("sapphire", "sapphires"),
        description = ccb.content.text("A sparkling sapphire."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "opal",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "white",
        name = ccb.content.plural_text("opal", "opals"),
        description = ccb.content.text("A lustrous opal."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tourmaline",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "light_red",
        name = ccb.content.plural_text("tourmaline", "tourmalines"),
        description = ccb.content.text("A sparkling tourmaline."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "citrine",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "yellow",
        name = ccb.content.plural_text("citrine", "citrines"),
        description = ccb.content.text("A sparkling citrine."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "blue_topaz",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "light_blue",
        name = ccb.content.plural_text("topaz", "topazes"),
        description = ccb.content.text("A sparkling blue topaz."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "onyx",
        copy_from = "garnet",
        looks_like = "garnet",
        color = "dark_gray",
        name = ccb.content.plural_text("onyx", "onyxes"),
        description = ccb.content.text("A beautiful black onyx."),
    }
    item:clear_flags()
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "straw_doll",
        symbol = "o",
        color = "light_gray",
        name = ccb.content.plural_text("straw doll", "straw dolls"),
        description = ccb.content.text("An old straw doll, made to look like a woman in a dress."),
        price_cents = 100,
        price_postapoc_cents = 0,
        mass_milligrams = 80000,
        volume_ml = 500,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "pillow",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("pillow", "pillows"),
        description = ccb.content.text("A pillow to rest your head on when sleeping.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 1210000,
        default_container = "pillowcase",
        volume_ml = 9000,
        category = "other",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_pillow",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("makeshift pillow", "makeshift pillows"),
        description = ccb.content.text("A pillowcase with straw and other dead plants as filling.  It's better than nothing…  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 1210000,
        default_container = "pillowcase",
        volume_ml = 11000,
        category = "other",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    content.add(item)
end

do
    local item = content.Item {
        id = "bodypillow",
        symbol = "[",
        color = "white",
        name = ccb.content.plural_text("body pillow", "body pillows"),
        description = ccb.content.text("A big, body-sized pillow with a print of an anime character on the front and their scantily-clad version on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."),
        price_cents = 1500,
        price_postapoc_cents = 100,
        mass_milligrams = 2317000,
        volume_ml = 50000,
        variant_kind = "generic",
        category = "other",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    item:variants {
        { id = "bodypillow_generic", name = ccb.content.plural_text("anime body pillow", "anime body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of an anime character on the front and their scantily-clad version on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_azurlane", name = ccb.content.plural_text("ship body pillow", "ship body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of an aircraft carrier drawn on both sides.  The one on the back is stripped of its armor plating, how naughty.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_gfl", name = ccb.content.plural_text("gun body pillow", "gun body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a fully-modded tacticool M4 SOPMOD II on both sides.  The rifle firing a grenade somehow looks suggestive.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_boston", name = ccb.content.plural_text("Boston-Chan body pillow", "Boston-Chan body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a blue-haired Boston-Chan, the mascot of Boston AnimeCon, on both sides.  This seems to be official merch, and the art on both sides is quite tame.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."), weight = 2 },
        { id = "bodypillow_boston_lewd", name = ccb.content.plural_text("Boston-Chan body pillow", "Boston-Chan body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a blue-haired Boston-Chan, the mascot of Boston AnimeCon, on both sides.  It's highly unlikely the convention would officially endorse such a lewd depiction of her.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_survivor", name = ccb.content.plural_text("survivor body pillow", "survivor body pillows"), description = ccb.content.text("A big, body-sized pillow with an anime-style print of Bear Grillings, Ultimate Survivor on both sides.  On one side he's holding a pneumatic air rifle, and on the other he is clad in nothing but duct tape.  The pillow is stylized to look like Kevlar.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_furry", name = ccb.content.plural_text("fox body pillow", "fox body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of an anthropomorphic fox on the front and a scantily-clad version on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_vocaloid", name = ccb.content.plural_text("vocaloid body pillow", "vocaloid body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a popular blue-twintailed virtual musician on the front and her scantily-clad version on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_goth", name = ccb.content.plural_text("goth body pillow", "goth body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of an anime character dressed in all black on the front and their scantily-clad version on the back.  They're surrounded by red candles and laying atop a demonic pentagram.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_yandere", name = ccb.content.plural_text("yandere body pillow", "yandere body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a cute maid on the front and the same maid - covered in blood and holding a knife - on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_tomboy", name = ccb.content.plural_text("tomboy body pillow", "tomboy body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a masculine woman on the front and her scantily-clad version on the back.  It's captioned with 'TOMBOY SUPREMACY' on both sides.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_femboy", name = ccb.content.plural_text("femboy body pillow", "femboy body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a feminine man on the front and his scantily-clad version on the back.  It's captioned with 'FEMBOY SUPREMACY' on both sides.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_tsundere", name = ccb.content.plural_text("tsundere body pillow", "tsundere body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a pouting anime character on the front and their scantily-clad version on the back.  They don't actually like you or anything, they swear!  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_vtuber", name = ccb.content.plural_text("VTuber body pillow", "VTuber body pillows"), description = ccb.content.text("A big, body-sized pillow with a print of a popular anime VTuber on the front and their scantily-clad version on the back.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping.") },
        { id = "bodypillow_makeshift", name = ccb.content.plural_text("makeshift body pillow", "makeshift body pillows"), description = ccb.content.text("A big, body-sized pillow.  Someone drew a vaguely humanoid figure on it.  Its heartwarming smile fills you with joy.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "down_pillow",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("down-filled pillow", "down-filled pillows"),
        description = ccb.content.text("A fluffy pillow to rest your head on when sleeping.  It is rolled for compact storage and transportation.  You will automatically unroll it when you place it for sleeping."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 1260000,
        default_container = "pillowcase",
        volume_ml = 10000,
        category = "other",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    content.add(item)
end

do
    local item = content.Item {
        id = "cigar_butt",
        name = ccb.content.plural_text("cigar butt", "cigar butts"),
        color = "dark_gray",
        symbol = "!",
        mass_milligrams = 1000,
        volume_ml = 1,
        description = ccb.content.text("A true gentleman always finishes his cigars."),
        category = "other",
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "cig_butt",
        name = ccb.content.plural_text("cigarette butt", "cigarette butts"),
        color = "dark_gray",
        symbol = "!",
        description = ccb.content.text("What was once a wonderfully addictive tube of dried tobacco leaf is now just a smelly piece of trash.  What a tragedy!\nThe leftover tobacco in a few of these could probably be used to roll another cigarette.  If you're willing to go that far…"),
        category = "other",
        mass_milligrams = 1000,
        volume_ml = 1,
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "joint_roach",
        name = ccb.content.plural_text("joint roach", "joint roaches"),
        color = "green",
        symbol = "!",
        description = ccb.content.text("The smoked-down butt of a joint, a reminder of some good times.  Pretty much trash now.  Bummer, man.\nA few of these could probably be used to roll another joint."),
        category = "other",
        mass_milligrams = 1000,
        volume_ml = 1,
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "cannabis",
        symbol = "%",
        color = "light_green",
        name = ccb.content.plural_text("cannabis plant", "cannabis plants"),
        description = ccb.content.text("A psychoactive plant indigenous to Central Asia and the Indian subcontinent traditionally cultivated for its fiber, oil, for medicinal purposes, and for use as a recreational drug.  It requires further processing to be useful."),
        price_cents = 2000,
        price_postapoc_cents = 50,
        mass_milligrams = 420000,
        volume_ml = 1000,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tobacco_raw",
        symbol = "%",
        color = "light_green",
        name = ccb.content.plural_text("raw tobacco", "raw tobacco"),
        description = ccb.content.text("Various parts of a tobacco plant, full of nicotine.  They need to be dried to become smokable."),
        looks_like = "wild_herbs",
        price_cents = 300,
        price_postapoc_cents = 50,
        mass_milligrams = 100000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "credit_card",
        category = "currency",
        copy_from = "card_plastic_abstract",
        symbol = "$",
        color = "yellow",
        name = ccb.content.plural_text("credit card", "credit cards"),
        ascii_picture = "cashcard",
        description = ccb.content.text("A plastic card used to purchase goods and services.  It's useless now."),
        price_cents = 1000,
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- Item for meteorologist mission.
    local item = content.Item {
        id = "module_meteorologist",
        name = ccb.content.plural_text("drone memory bank", "drone memory banks"),
        description = ccb.content.text("A memory bank containing the information collected by the meteorologist drone."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "neoprene",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("neoprene patch", "neoprene patches"),
        description = ccb.content.text("A small neoprene patch.  Can be used to repair neoprene clothing."),
        price_cents = 1000,
        price_postapoc_cents = 5,
        mass_milligrams = 3000,
        volume_ml = 23,
        category = "spare_parts",
        stackable = true,
    }
    item:material("neoprene", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "light_bulb",
        name = ccb.content.plural_text("light bulb", "light bulbs"),
        description = ccb.content.text("A rather outdated light bulb used in all sorts of lighting equipment."),
        symbol = ",",
        color = "white",
        category = "spare_parts",
        mass_milligrams = 10000,
        volume_ml = 250,
        price_cents = 500,
        price_postapoc_cents = 10,
        stackable = true,
    }
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "shrapnel",
        name = ccb.content.plural_text("shrapnel", "shrapnel"),
        description = ccb.content.text("A twisted shard of jagged metal."),
        mass_milligrams = 5000,
        volume_ml = 20,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ".",
        color = "white",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_pot_flower",
        category = "other",
        name = ccb.content.plural_text("clay flower pot", "clay flower pots"),
        description = ccb.content.text("A nice-looking clay pot used for planting."),
        mass_milligrams = 480000,
        volume_ml = 2500,
        price_cents = 600,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
    }
    item:material("clay", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_pot_flower",
        category = "other",
        name = ccb.content.plural_text("plastic flower pot", "plastic flower pots"),
        description = ccb.content.text("A cheap plastic pot used for planting."),
        mass_milligrams = 190000,
        volume_ml = 2500,
        price_cents = 300,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "green",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fluid_preserved_brain",
        category = "other",
        name = ccb.content.plural_text("fluid-preserved brain", "fluid-preserved brains"),
        description = ccb.content.text("This 3 L jar contains a human brain preserved in a formaldehyde solution."),
        mass_milligrams = 365000,
        volume_ml = 3000,
        price_cents = 100,
        price_postapoc_cents = 0,
        melee_to_hit = -5,
        symbol = ")",
        color = "pink",
        looks_like = "jar_3l_glass_sealed",
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "evaporator_coil",
        category = "spare_parts",
        name = ccb.content.plural_text("evaporator coil", "evaporator coils"),
        description = ccb.content.text("A set of long, snakelike tubes for evaporating refrigerant."),
        mass_milligrams = 20000000,
        volume_ml = 2000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "#",
        color = "dark_gray",
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "condensor_coil",
        category = "spare_parts",
        name = ccb.content.plural_text("condensor coil", "condensor coils"),
        description = ccb.content.text("A compressor and fan that work together to cool down refrigerant."),
        mass_milligrams = 20000000,
        volume_ml = 2000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "#",
        color = "dark_gray",
        melee_to_hit = -3,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "refrigerant_tank",
        name = ccb.content.plural_text("refrigerant tank", "refrigerant tanks"),
        description = ccb.content.text("A small tank containing some sort of refrigerant often used in devices such as freezers.  Hermetically sealed to prevent evaporation - cannot be opened without prior connection to a compatible valve."),
        mass_milligrams = 410000,
        volume_ml = 1000,
        price_cents = 3000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = "}",
        color = "light_cyan",
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "hard_steel_armor",
        category = "spare_parts",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("hard steel plate", "hard steel plates"),
        description = ccb.content.text("An armor plate made of very thick steel, specifically engineered for use in a bullet-resistant vest."),
        price_cents = 10000,
        price_postapoc_cents = 100,
        mass_milligrams = 1500000,
        volume_ml = 500,
        stackable = true,
    }
    item:material("qt_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "steel_armor",
        category = "spare_parts",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("steel plate", "steel plates"),
        description = ccb.content.text("A steel armor plate, specifically engineered for use in a bullet-resistant vest."),
        price_cents = 9000,
        price_postapoc_cents = 50,
        mass_milligrams = 1000000,
        volume_ml = 500,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "lock",
        category = "spare_parts",
        symbol = "P",
        color = "dark_gray",
        name = ccb.content.plural_text("small lock and key", "small locks and keys"),
        description = ccb.content.text("A small lock, with its key still inserted."),
        price_cents = 500,
        price_postapoc_cents = 10,
        mass_milligrams = 5000,
        volume_ml = 20,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "craft",
        symbol = "%",
        color = "white",
        name = ccb.content.plural_text("in-progress craft", "in-progress crafts"),
        description = ccb.content.text("This is an in-progress craft."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 250,
    }
    item:clear_use_actions()
    item:native_use("CRAFT")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:flag("CAN_HAVE_CHARGES")
    content.add(item)
end

do
    local item = content.Item {
        id = "disassembly",
        symbol = "%",
        color = "white",
        name = ccb.content.plural_text("in-progress disassembly", "in-progress disassemblies"),
        description = ccb.content.text("This is an in-progress disassembly."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 250,
    }
    item:clear_use_actions()
    item:native_use("DISASSEMBLE")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:flag("CAN_HAVE_CHARGES")
    content.add(item)
end

do
    local item = content.Item {
        id = "spare_tire_carrier",
        category = "spare_parts",
        symbol = "t",
        color = "dark_gray",
        name = ccb.content.plural_text("spare tire carrier", "spare tire carriers"),
        description = ccb.content.text("A bumper-mounted rig for attaching and storing a spare tire on the back of a vehicle.  Combine it with a wheel to get a mountable piece."),
        price_cents = 3500,
        price_postapoc_cents = 250,
        mass_milligrams = 5000000,
        volume_ml = 5000,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "amplifier_head",
        symbol = ";",
        color = "blue",
        name = ccb.content.plural_text("amplifier head", "amplifier heads"),
        description = ccb.content.text("An amplifier head.  Typically paired with a speaker cabinet for amplifying musical instruments.  Basically only good for spare parts now."),
        price_cents = 25000,
        price_postapoc_cents = 100,
        mass_milligrams = 11339000,
        volume_ml = 3000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_riot",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("broken riot control turret", "broken riot control turrets"),
        description = ccb.content.text("A broken riot control turret.  Much less threatening now that it's laid limp on solid ground.  Could be gutted for parts."),
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_robofac_laserturret_mk1",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken laser turret", "broken laser turrets"),
        mass_milligrams = 40000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_searchlight",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken milspec searchlight", "broken milspec searchlights"),
        mass_milligrams = 117000000,
        volume_ml = 108500,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fire_brick",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("fire brick", "fire bricks"),
        category = "spare_parts",
        description = ccb.content.text("A reinforced brick designed to withstand intense heat."),
        price_cents = 2500,
        price_postapoc_cents = 10,
        mass_milligrams = 969000,
        volume_ml = 500,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:material("stone", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_six_dice",
        category = "other",
        name = ccb.content.plural_text("plastic die", "plastic dice"),
        description = ccb.content.text("A six-sided plastic die."),
        mass_milligrams = 5000,
        volume_ml = 10,
        price_cents = 100,
        price_postapoc_cents = 1,
        symbol = ".",
        color = "white",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:flag("SLING_PROJECTILE")
    content.add(item)
end

do
    local item = content.Item {
        id = "salt_lick",
        category = "other",
        name = ccb.content.plural_text("salt lick", "salt licks"),
        description = ccb.content.text("A heavy cube-shaped block of salt for livestock.  Don't lick it, it's gross."),
        mass_milligrams = 18000000,
        volume_ml = 10000,
        looks_like = "adobe_brick",
        price_cents = 5000,
        price_postapoc_cents = 100,
        symbol = ".",
        color = "white",
    }
    item:material("salt", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    -- Folded Sleeve
    -- Card Sleeves
    -- Coin Purse
    local item = content.Item {
        id = "wallet",
        category = "container",
        name = ccb.content.plural_text("wallet", "wallets"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A small, flat case used to carry items such as currency, identification documents, and laminated cards."),
        volume_ml = 200,
        mass_milligrams = 60000,
        price_cents = 1,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 150,
        max_weight_milligrams = 60000,
        rigid = false,
        moves = 100,
        allowed_flags = { "BANK_NOTE_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 150,
        max_weight_milligrams = 60000,
        rigid = false,
        max_item_length_mm = 85,
        moves = 100,
        allowed_flags = { "CREDIT_CARD_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 150,
        max_weight_milligrams = 600000,
        rigid = false,
        moves = 200,
        allowed_flags = { "COIN_SHAPED" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wallet_duct_tape",
        copy_from = "wallet",
        looks_like = "wallet",
        name = ccb.content.plural_text("duct tape wallet", "duct tape wallets"),
        description = ccb.content.text("A wallet made entirely out of duct tape."),
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "wallet_leather",
        copy_from = "wallet",
        looks_like = "wallet",
        name = ccb.content.plural_text("leather wallet", "leather wallets"),
        description = ccb.content.text("A wallet made of leather."),
    }
    item:material("leather", 1)
    content.add(item)
end

do
    -- Folded Sleeve
    -- Card Sleeves
    -- Coin Purse
    local item = content.Item {
        id = "wallet_large",
        copy_from = "wallet",
        looks_like = "wallet",
        name = ccb.content.plural_text("large wallet", "large wallets"),
        description = ccb.content.text("A flat case used to carry items such as currency, identification documents, laminated cards, and other small items."),
        volume_ml = 285,
        mass_milligrams = 80000,
        replace_pockets = true,
    }
    item:material("leather", 1)
    item:container_pocket {
        max_volume_ml = 175,
        max_weight_milligrams = 80000,
        rigid = false,
        moves = 100,
        allowed_flags = { "BANK_NOTE_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 175,
        max_weight_milligrams = 80000,
        rigid = false,
        max_item_length_mm = 100,
        moves = 100,
        allowed_flags = { "CREDIT_CARD_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 175,
        max_weight_milligrams = 600000,
        rigid = false,
        moves = 200,
        allowed_flags = { "COIN_SHAPED" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wallet_stylish",
        copy_from = "wallet",
        looks_like = "wallet",
        name = ccb.content.plural_text("stylish wallet", "stylish wallets"),
        description = ccb.content.text("A stylish flat case used to carry items such as currency, identification documents, laminated cards, and other small items."),
    }
    item:material("leather", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_tazer_hack",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken taser hack", "broken taser hacks"),
        category = "other",
        description = ccb.content.text("A broken taser hack, with its propellers still and taser inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 1600000,
        volume_ml = 600,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_GM",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken green maintenance security drone", "broken green maintenance security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_YM",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("broken yellow maintenance security drone", "broken yellow maintenance security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_BM",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("broken blue maintenance security drone", "broken blue maintenance security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_BM2",
        symbol = ",",
        color = "cyan",
        name = ccb.content.plural_text("broken blue maintenance security drone", "broken blue maintenance security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_GR",
        symbol = ",",
        color = "light_green",
        name = ccb.content.plural_text("broken green research security drone", "broken green research security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_lab_security_drone_BS",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken black security drone", "broken black security drones"),
        category = "other",
        description = ccb.content.text("A broken security drone, with its propellers still and camera inert.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 5000000,
        volume_ml = 650,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "parachute_mil",
        name = ccb.content.plural_text("military parachute", "military parachutes"),
        description = ccb.content.text("This is a big, bulky military-level parachute, designed to slow the fall of up to a thousand kilograms of cargo dropped from an aircraft.  You have no clue how to put all the straps back in their place."),
        mass_milligrams = 113400000,
        volume_ml = 136080,
        price_cents = 200000,
        price_postapoc_cents = 1000,
        symbol = "[",
        looks_like = "ragpouch",
        color = "green",
    }
    item:material("nylon", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pallet",
        name = ccb.content.plural_text("wooden pallet", "wooden pallets"),
        description = ccb.content.text("This is a heavy and bulky 40x48 inch pallet."),
        mass_milligrams = 28000000,
        volume_ml = 194400,
        symbol = "#",
        color = "brown",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cash_register",
        category = "container",
        symbol = "$",
        color = "dark_gray",
        name = ccb.content.plural_text("cash register", "cash registers"),
        description = ccb.content.text("An electronic device for registering and calculating sales transactions.  It doesn't seem to be working."),
        price_cents = 23600,
        price_postapoc_cents = 200,
        mass_milligrams = 5000000,
        volume_ml = 22000,
        longest_side_mm = 360,
        replace_pockets = true,
        melee_to_hit = -4,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 2000000,
        rigid = true,
        moves = 100,
        allowed_flags = { "BANK_NOTE_SHAPED", "BANK_NOTE_STRAP_SHAPED", "COIN_SHAPED", "CREDIT_CARD_SHAPED" },
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    -- Based on https://www.cadexdefence.com/products/helmet-electro-optic-mount/ach-side-mounted-helmet-bracket/ + https://www.cadexdefence.com/products/helmet-electro-optic-mount/universal-helmet-strap-kit/
    local item = content.Item {
        id = "helmet_mounting_brackets",
        symbol = "+",
        color = "dark_gray",
        name = ccb.content.plural_text("helmet mounting brackets", "helmet mounting brackets"),
        category = "other",
        description = ccb.content.text("An assortment of mounting brackets designed to allow stuff such as NV goggles or flashlights to be mounted to army helmets.  These can be attached to other types of helmets, providing it's properly modified."),
        price_cents = 9000,
        price_postapoc_cents = 200,
        mass_milligrams = 230000,
        volume_ml = 100,
        longest_side_mm = 50,
    }
    item:material("plastic", 9)
    item:material("mc_steel", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_chop_shop_head",
        name = ccb.content.plural_text("broken red robotic head", "broken red robotic head"),
        mass_milligrams = 1400000,
        volume_ml = 1400,
        color = "red",
        symbol = "@",
        description = ccb.content.text("The broken metal head and partial neck of some sort of robot.  It would almost resemble a helmet, as several parts of the \"face\" are open, allowing one to glance inside, only to find a hollow shell, stained by blood and oil.  A frayed metal spinal cord of wires and tubes hangs from the \"neck.\""),
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("qt_steel", 1)
    item:material("aluminum", 1)
    item:material("copper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
