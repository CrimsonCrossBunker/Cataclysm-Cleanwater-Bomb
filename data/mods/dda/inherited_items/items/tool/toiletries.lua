local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function can_groom(character)
    return not checked(services.mutations.has(character, id("mutation", "EXODII_BODY_1")))
        and not checked(services.mutations.has(character, id("mutation", "EXODII_BODY_1b")))
        and not checked(services.bionics.has(character, id("bionic", "bio_robofac_xmlens")))
end

local function trim(topic)
    return function(use)
        local character = use.character
        if character and character.subtype == "avatar" then
            if can_groom(character) then
                checked(services.characters.open_topic(character, topic))
            else
                use:message(use:expand_text(ccb.services.translate("You don't have any hair to style!")))
            end
        end
        return 0
    end
end

ccb.runtime.handler("trim_item_hair", trim("TALK_CUT_YOUR_HAIR"))
ccb.runtime.handler("trim_item_beard", trim("TALK_CUT_YOUR_BEARD"))

ccb.runtime.handler("apply_item_makeup", function(use)
    local character = use.character
    if character and character.subtype == "avatar" then
        if checked(services.mutations.has(character, id("mutation", "VANITY"))) then
            use:message(use:expand_text(ccb.services.translate(
                "You apply some makeup.  The world will now get to know the true meaning of beauty.")))
        else
            use:message(use:expand_text(ccb.services.translate(
                "You apply some makeup.  It feels good to take care of yourself.")))
        end
    end
    return 0
end)

do
    local item = content.Item {
        id = "brush",
        name = ccb.content.plural_text("scrub brush", "scrub brushes"),
        description = ccb.content.text("A simple scrub brush for cleaning hard objects."),
        mass_milligrams = 70000,
        volume_ml = 350,
        longest_side_mm = 140,
        price_cents = 200,
        price_postapoc_cents = 10,
        melee_to_hit = 0,
        symbol = "/",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:dish_towel" }
    snippets:entry {
        id = "dtowel1",
        text = ccb.content.text("An elegant, monogrammed dish towel.  Unfortunately, they aren't your initials."),
    }
    snippets:entry {
        id = "dtowel2",
        text = ccb.content.text("An elegant, monogrammed dish towel.  It even has your initials!"),
    }
    snippets:entry { id = "dtowel3", text = ccb.content.text("A well-used dish towel, judging by the stains.") }
    snippets:entry {
        id = "dtowel4",
        text = ccb.content.text("A novelty dish towel featuring a popular children's cartoon character."),
    }
    snippets:entry {
        id = "dtowel5",
        text = ccb.content.text("A novelty dish towel which reads \"IT'S WINE O CLOCK\"."),
    }
    snippets:entry { id = "dtowel6", text = ccb.content.text("A dish towel with a floral pattern.") }
    snippets:entry { id = "dtowel7", text = ccb.content.text("A dish towel with a gingham pattern.") }
    snippets:entry { id = "dtowel8", text = ccb.content.text("A dish towel with a cat pattern.") }
    content.add(snippets)
end

do
    -- Calculated from cotton density because if I took exact product dimensions you'd have <2ml of volume BUT no way in hell is the player folding the towel so neatly.
    -- Based on https://www.amazon.com/dp/B01IG8X9E6
    local item = content.Item {
        id = "dish_towel",
        category = "other",
        name = ccb.content.plural_text("dish towel", "dish towels"),
        description = ccb.content.text("A dish towel, useful for cleaning hard surfaces."),
        mass_milligrams = 21000,
        volume_ml = 43,
        price_cents = 127,
        price_postapoc_cents = 20,
        symbol = ",",
        color = "white",
        snippet_category = "auto:dish_towel",
    }
    item:material("cotton", 1)
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mop",
        name = ccb.content.plural_text("mop", "mops"),
        description = ccb.content.text("An unwieldy mop.  Good for cleaning up spills.  Use to mop up any 'mess' you may have made."),
        mass_milligrams = 780000,
        volume_ml = 1470,
        longest_side_mm = 1300,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "QUARTERSTAVES" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:native_use("MOP")
    item:quality("MOP", 1)
    item:clear_flags()
    item:flag("MOP")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mop_folded",
        name = ccb.content.plural_text("collapsible mop", "collapsible mops"),
        description = ccb.content.text("A long, unwieldy mop with a collapsible handle for convenient transportation.  You may use it to clean up any 'mess' you have made."),
        mass_milligrams = 730000,
        volume_ml = 760,
        longest_side_mm = 630,
        price_cents = 1500,
        price_postapoc_cents = 15,
        symbol = "/",
        color = "light_gray",
        looks_like = "mop",
        weapon_categories = { "QUARTERSTAVES" },
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("MOP")
    item:quality("MOP", 1)
    item:clear_use_actions()
    item:native_use("MOP")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "emery_board",
        name = ccb.content.plural_text("emery board", "emery boards"),
        description = ccb.content.text("A slim cardboard stick coated with abrasive grit, meant for shaping fingernails."),
        mass_milligrams = 4000,
        volume_ml = 12,
        longest_side_mm = 180,
        price_cents = 50,
        price_postapoc_cents = 10,
        symbol = "`",
        color = "brown",
        replace_qualities = true,
    }
    item:material("cardboard", 1)
    item:quality("FILE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "razor_blade",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("razor blade", "razor blades"),
        description = ccb.content.text("A double-edged razor blade."),
        price_cents = 600,
        price_postapoc_cents = 100,
        mass_milligrams = 1000,
        volume_ml = 1,
        longest_side_mm = 38,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:sponge" }
    snippets:entry { id = "spng1", text = ccb.content.text("A round smiley-face sponge.") }
    snippets:entry { id = "spng2", text = ccb.content.text("A rectangular sponge with a green abrasive back.") }
    snippets:entry { id = "spng4", text = ccb.content.text("A dolphin-shaped sponge.  It looks at home in the water.") }
    snippets:entry { id = "spng5", text = ccb.content.text("A rectangular sponge.") }
    snippets:entry {
        id = "spng6",
        text = ccb.content.text("A sponge cake-shaped sponge, the abrasive pad looks like frosting."),
    }
    snippets:entry {
        id = "spng7",
        text = ccb.content.text("A sponge in the shape of a beloved character from a children's cartoon."),
    }
    snippets:entry { id = "spng8", text = ccb.content.text("A cat-shaped sponge.") }
    content.add(snippets)
end

do
    -- Based on https://www.amazon.com/dp/B08RFC3VH7
    local item = content.Item {
        id = "sponge",
        name = ccb.content.plural_text("sponge", "sponges"),
        description = ccb.content.text("A cleaning aid made of soft, porous material.  Typically used for cleaning hard objects."),
        mass_milligrams = 17000,
        volume_ml = 156,
        price_cents = 66,
        price_postapoc_cents = 10,
        symbol = "s",
        color = "yellow",
        snippet_category = "auto:sponge",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wash_kit",
        name = ccb.content.plural_text("washing kit", "washing kits"),
        description = ccb.content.text("A combination of a washboard and a scrubbing tool.  Everything you need to clean items after the apocalypse."),
        mass_milligrams = 866000,
        volume_ml = 2246,
        longest_side_mm = 400,
        price_cents = 0,
        price_postapoc_cents = 50,
        symbol = "%",
        color = "yellow",
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WASH_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- This is calculated from medium weight cotton at 203 GSM, with a size of 6 inches square
    local item = content.Item {
        id = "cotton_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("cotton patch", "cotton patches"),
        description = ccb.content.text("A 6-inch square cotton patch, suitable for repairing and tailoring clothing."),
        mass_milligrams = 3000,
        volume_ml = 6,
        price_cents = 200,
        price_postapoc_cents = 2,
        symbol = ",",
        replace_qualities = true,
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:quality("SIEVE", 1)
    item:quality("STRAIN", 2)
    item:clear_use_actions()
    item:heal {
        move_cost = 200,
        bleed = 1,
        used_up_item = { id = "cotton_patchwork", quantity = 1, flags = { "FILTHY" } },
    }
    item:native_use("WASH_HARD_ITEMS")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "elec_hairtrimmer",
        name = ccb.content.plural_text("electric hair trimmer", "electric hair trimmers"),
        description = ccb.content.text("A pocket-sized electric trimmer made for cutting hair.  You can use it to cut your hair if it's supplied with batteries.  It requires 1 unit of charge per use."),
        mass_milligrams = 138000,
        volume_ml = 191,
        longest_side_mm = 150,
        price_cents = 3000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ";",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    item:clear_use_actions()
    item:on_use("trim_item_hair", ccb.content.text("Activate"), ccb.content.text("Trim your hair"))
    content.add(item)
end

do
    local item = content.Item {
        id = "shavingkit",
        name = ccb.content.plural_text("shaving kit", "shaving kits"),
        description = ccb.content.text("A compact, lightweight shaving kit made for travelers.  You can use it to shave if it's supplied with soap.  It requires 1 unit of soap per use."),
        mass_milligrams = 99000,
        volume_ml = 735,
        longest_side_mm = 210,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:tool { charges_per_use = 1, ammo_types = { "soap" } }
    item:magazine_pocket { ammo_capacities = { soap = 10 } }
    item:clear_use_actions()
    item:on_use("trim_item_beard", ccb.content.text("Activate"), ccb.content.text("Trim your beard"))
    content.add(item)
end

do
    local item = content.Item {
        id = "survivor_hairtrimmer",
        name = ccb.content.plural_text("makeshift haircut kit", "makeshift haircut kits"),
        description = ccb.content.text("A kit containing various improvised tools for cutting hair."),
        mass_milligrams = 642000,
        volume_ml = 1000,
        longest_side_mm = 200,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "brown",
    }
    item:material("leather", 1)
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    item:clear_use_actions()
    item:on_use("trim_item_hair", ccb.content.text("Activate"), ccb.content.text("Trim your hair"))
    content.add(item)
end

do
    local item = content.Item {
        id = "survivor_shavingkit",
        name = ccb.content.plural_text("makeshift shaving kit", "makeshift shaving kits"),
        description = ccb.content.text("A makeshift shaving kit.  You can use it to shave if it's supplied with soap.  It requires 1 unit of soap per use."),
        mass_milligrams = 540000,
        volume_ml = 750,
        longest_side_mm = 150,
        price_cents = 1000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = ";",
        color = "brown",
        replace_pockets = true,
    }
    item:material("leather", 1)
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool { charges_per_use = 1, ammo_types = { "soap" } }
    item:magazine_pocket { ammo_capacities = { soap = 10 } }
    item:clear_use_actions()
    item:on_use("trim_item_beard", ccb.content.text("Activate"), ccb.content.text("Trim your beard"))
    content.add(item)
end

do
    local item = content.Item {
        id = "makeup_kit",
        copy_from = "hair_dye_kit",
        looks_like = "hair_dye_kit",
        name = ccb.content.plural_text("makeup kit", "makeup kits"),
        description = ccb.content.text("A kit containing all the essential tools and products for makeup, it even includes nail polish."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("apply_item_makeup", ccb.content.text("Apply makeup"), ccb.content.text("Apply makeup"))
    content.add(item)
end
