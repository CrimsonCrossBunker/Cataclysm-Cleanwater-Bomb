local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "treesung_mace",
        copy_from = "mace",
        looks_like = "mace",
        name = ccb.content.plural_text("treesung mace", "treesung maces"),
        description = ccb.content.text("A weapon with a long wooden handle connected to a knobby wooden head, all formed from a single piece of wood, with twists and curves like it grew in place rather than being made."),
        color = "green",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("WOODEN_WEAPON")
    item:adjust_measurements { mass_milligrams = { factor = 0.7 } }
    item:adjust_melee_damage { factors = { bash = 0.9 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "treesung_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("treesung warhammer", "treesung warhammers"),
        description = ccb.content.text("A long hammer with a spike on one end, all formed from a single piece of wood, with twists and curves like it grew in place rather than being carved."),
        color = "green",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("WOODEN_WEAPON")
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 1.1, stab = 0.9 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "treesung_baselard",
        copy_from = "knife_baselard",
        looks_like = "knife_baselard",
        name = ccb.content.plural_text("treesung baselard", "treesung baselards"),
        description = ccb.content.text("A large knife, all formed from a single piece of wood, with twists and curves like it grew in place rather than being carved.  You're not sure how long it will hold its edge, but it's surprisingly sharp."),
        color = "green",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("NO_REPAIR")
    item:flag("SHEATH_KNIFE")
    item:flag("WOODEN_WEAPON")
    item:adjust_measurements { mass_milligrams = { factor = 0.2 } }
    item:adjust_melee_damage { factors = { stab = 0.9 } }
    content.add(item)
end
