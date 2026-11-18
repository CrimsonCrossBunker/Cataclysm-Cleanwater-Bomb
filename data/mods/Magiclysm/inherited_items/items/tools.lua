local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "parabolan_wool_staple",
        category = "spare_parts",
        name = ccb.content.plural_text("parabolan wool staple", "parabolan wool staples"),
        description = ccb.content.text("The natural cluster of parabolan wool fibers.  Could be processed to felt patches or yarns."),
        mass_milligrams = 120000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ",",
        color = "white",
    }
    item:material("parabolan_wool", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glassteel_shard",
        copy_from = "glass_shard",
        looks_like = "glass_shard",
        name = ccb.content.plural_text("glassteel shard", "glassteel shards"),
        category = "other",
        description = ccb.content.text("A broken shard of glassteel covered in sharp edges.  You could use it as a weapon, but you might want to wear gloves."),
    }
    item:material("glassteel", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 7)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "magic_circle_rank_1",
        name = ccb.content.plural_text("Magic Circle Rank 1", "Magic Circles Rank 1"),
        description = content.text("This is the pseudo-tool provided by having a nearby magic circle.  You shouldn't see this as an individual item."),
        symbol = "O",
        color = "red",
        mass_milligrams = 0,
        volume_ml = 0,
        replace_qualities = true,
    }
    item:quality("MANA_INFUSE", 1)
    item:quality("MANA_FOCUS", 1)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "magic_circle_rank_2",
        name = ccb.content.plural_text("Magic Circle Rank 2", "Magic Circles Rank 2"),
        description = content.text("This is the pseudo-tool provided by having a nearby magic circle.  You shouldn't see this as an individual item."),
        symbol = "O",
        color = "red",
        mass_milligrams = 0,
        volume_ml = 0,
        replace_qualities = true,
    }
    item:quality("MANA_INFUSE", 2)
    item:quality("MANA_FOCUS", 2, 0.66)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "demon_forge",
        name = ccb.content.plural_text("demon forge", "demon forges"),
        description = ccb.content.text("This is a portable version of the charcoal forge that is magically enhanced and fortified with demon spider chitin in order to be able to resmelt magical metals into their workable ingot form."),
        mass_milligrams = 8000000,
        volume_ml = 8000,
        price_cents = 200000,
        symbol = ";",
        color = "red",
        replace_pockets = true,
    }
    item:material("demon_chitin", 40)
    item:material("cement", 60)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool { ammo_types = { "alumentum" }, crafting_subtype = "forge" }
    item:magazine_pocket { ammo_capacities = { alumentum = 500 } }
    content.add(item)
end
