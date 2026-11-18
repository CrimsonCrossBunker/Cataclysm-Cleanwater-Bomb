local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_skitterbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken skitterbot", "broken skitterbots"),
        category = "other",
        description = ccb.content.text("A broken skitterbot.  Much less threatening now that it lies limp on solid ground.  Could be gutted for parts."),
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
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "bark_abstract",
        abstract = true,
        symbol = ",",
        color = "brown",
        name = content.plural_text("piece of abstract bark", "pieces of abstract bark"),
        description = content.text("A sheet of bark from a hypothetical tree.  Useful for making adding new bark items slightly simpler."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 200000,
        volume_ml = 250,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken turret", "broken turrets"),
        category = "other",
        description = ccb.content.text("A broken turret.  Much less threatening now that it's laid limp on solid ground.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 72650000,
        volume_ml = 30000,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_rifle",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken M249 autonomous CROWS II", "broken M249 autonomous CROWS II turrets"),
        mass_milligrams = 75000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_rifle_balthazar",
        name = ccb.content.plural_text("broken M249 autonomous CROWS II", "broken M249 autonomous CROWS II turrets"),
        copy_from = "broken_turret_rifle",
        looks_like = "broken_turret_rifle",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_crows_m240",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken M240 autonomous CROWS II", "broken M240 autonomous CROWS II turrets"),
        mass_milligrams = 75000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_bmg",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken M2 autonomous CROWS II", "broken M2 autonomous CROWS II turrets"),
        mass_milligrams = 100000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_turret_artisans",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken custom plated turret", "broken custom plated turrets"),
        mass_milligrams = 75000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_secubot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken secubot", "broken secubots"),
        category = "other",
        description = ccb.content.text("A broken secubot, with its casing broken and fluid drained.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 100000000,
        volume_ml = 65000,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_secubot_balthazar",
        name = ccb.content.plural_text("broken secubot", "broken secubots"),
        copy_from = "broken_secubot",
        looks_like = "broken_secubot",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_talon_m202a1",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken M202A1 TALON", "broken M202A1 TALONs"),
        category = "other",
        description = ccb.content.text("A broken TALON UGV, with its casing broken and fluid drained.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 100000000,
        volume_ml = 65000,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "alder_bark",
        name = ccb.content.plural_text("piece of alder bark", "pieces of alder bark"),
        description = ccb.content.text("A strip of bark pulled from an alder tree.  Used in the production of topical hemostatics."),
        copy_from = "bark_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "robofac_test_data",
        copy_from = "card_plastic_abstract",
        color = "yellow",
        name = ccb.content.plural_text("prototype I/O recorder", "prototype I/O recorders"),
        description = ccb.content.text("A small, transparent card that was attached to the prototype robot's CPU.  It might contain the data the intercom spoke of."),
        category = "other",
        price_cents = 500,
    }
    item:flag("MISSION_ITEM")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gasdiscount_silver",
        category = "currency",
        copy_from = "card_plastic_abstract",
        color = "yellow",
        name = ccb.content.plural_text("silver gas discount card", "silver gas discount cards"),
        description = ccb.content.text("This card gives you a little discount on the purchase of gasoline."),
        price_cents = 500,
    }
    item:flag("GAS_DISCOUNT")
    item:flag("DISCOUNT_VALUE_1")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gasdiscount_gold",
        category = "currency",
        copy_from = "card_plastic_abstract",
        color = "yellow",
        name = ccb.content.plural_text("gold gas discount card", "gold gas discount cards"),
        description = ccb.content.text("This card gives you a good discount on the purchase of gasoline."),
        price_cents = 500,
    }
    item:flag("GAS_DISCOUNT")
    item:flag("DISCOUNT_VALUE_2")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gasdiscount_platinum",
        category = "currency",
        copy_from = "card_plastic_abstract",
        color = "yellow",
        name = ccb.content.plural_text("platinum gas discount card", "platinum gas discount cards"),
        description = ccb.content.text("This card gives you a splendid discount on the purchase of gasoline."),
        price_cents = 500,
    }
    item:flag("GAS_DISCOUNT")
    item:flag("DISCOUNT_VALUE_3")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "training_dummy_light",
        symbol = "@",
        color = "brown",
        name = ccb.content.plural_text("training dummy", "training dummies"),
        category = "other",
        description = ccb.content.text("A hand-made humanoid figure, useful for training in close quarters combat.  This one is made from wood and has some duct tape to mark the striking points.  Use the construction menu (* by default) to embed it into the ground for training."),
        price_cents = 15000,
        price_postapoc_cents = 600,
        mass_milligrams = 50000000,
        volume_ml = 80000,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "training_dummy_heavy",
        symbol = "@",
        color = "light_gray",
        name = ccb.content.plural_text("armored training dummy", "armored training dummies"),
        category = "other",
        description = ccb.content.text("A hand-made humanoid figure, useful for training in close quarters combat.  This one is covered in scrap armor and looks on guard.  Use the construction menu (* by default) to embed it into the ground for training."),
        price_cents = 15000,
        price_postapoc_cents = 1000,
        mass_milligrams = 55000000,
        volume_ml = 80000,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "archery_target_box",
        symbol = "@",
        color = "brown",
        name = ccb.content.plural_text("box archery target", "box archery targets"),
        category = "other",
        description = ccb.content.text("A soft target for archery, consisting of tightly-packed cloth stuffed into a cardboard box, with a bullseye marked on the front.  Must be set up in the construction menu (* by default) to use."),
        price_cents = 3000,
        price_postapoc_cents = 200,
        mass_milligrams = 16000000,
        volume_ml = 50000,
        longest_side_mm = 600,
    }
    item:material("cotton", 9)
    item:material("cardboard", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "book_binder",
        category = "books",
        symbol = "/",
        looks_like = "story_book",
        color = "light_gray",
        name = ccb.content.plural_text("book binder", "book binders"),
        description = ccb.content.text("A book binder.  With a pen and some paper you could copy some recipes from books into it."),
        mass_milligrams = 200000,
        volume_ml = 640,
        price_cents = 500,
        price_postapoc_cents = 50,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("BINDER_ADD_RECIPE")
    item:native_use("BINDER_MANAGE_RECIPE")
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:tool()
    item:magazine_pocket { ammo_capacities = { paper = 90 }, rigid = false }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B000U9WXEC, although the volume calculated from package dimensions has been multiplied by 0.5 because there really is not a reasonable way to calculate fan volume without the numbers going into extremes
    local item = content.Item {
        id = "fan",
        symbol = ",",
        name = ccb.content.plural_text("desk fan", "desk fans"),
        description = ccb.content.text("A small fan, used to propel air around a room."),
        color = "light_gray",
        price_cents = 2500,
        price_postapoc_cents = 10,
        mass_milligrams = 1588000,
        volume_ml = 19265,
        melee_to_hit = -3,
        charged_qualities = { { id = "WINNOW", level = 1 } },
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("FRAGILE_MELEE")
    item:clear_use_actions()
    item:link_cable { cable_length = 3, charge_milliwatts = 35000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool { charges_per_use = 4, ammo_types = { "battery" } }
    content.add(item)
end
