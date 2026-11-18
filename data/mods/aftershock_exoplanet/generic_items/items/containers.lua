local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_thermos",
        category = "container",
        name = ccb.content.plural_text("radio thermos", "radio thermoses"),
        looks_like = "thermos",
        description = ccb.content.text("A small radioactive source is used to safely(?) heat the contents of this vacuum flask.  Its not powerful enough to melt already frozen liquids.\n\n Frontier rated only."),
        ascii_picture = "thermos",
        mass_milligrams = 530000,
        volume_ml = 1250,
        longest_side_mm = 320,
        price_cents = 17500,
        price_postapoc_cents = 17500,
        symbol = "I",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 4000000,
        rigid = true,
        watertight = true,
        insulation = 3000,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("BELT_CLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_bowl_fast_food",
        category = "container",
        name = ccb.content.plural_text("plastic bowl", "plastic bowls"),
        symbol = ")",
        description = ccb.content.text("A perfectly ordinary disposable plastic bowl.  It has a sealed lid with a wide spigot for drinking or serving."),
        copy_from = "base_ceramic_dish",
        volume_ml = 625,
        price_cents = 0,
        price_postapoc_cents = 0,
        longest_side_mm = 130,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        sealed_spoil_multiplier = 0.0,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_mre_package",
        copy_from = "mre_package",
        looks_like = "mre_package",
        name = ccb.content.plural_text("Astronaut MRE", "Astronaut MREs"),
        description = ccb.content.text("Marketing has adorned the package of this individual ration with white and red livery, a deliberate callback to the space corporations of old.  Despite best efforts, the food within is no more natural than usual, but is at least palatable."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_foil_bag",
        copy_from = "plastic_bag_vac",
        looks_like = "plastic_bag_vac",
        name = ccb.content.plural_text("foil bag", "foil bags"),
        description = ccb.content.text("A plastic and aluminum foil bag for long term food storage."),
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 1500,
        max_weight_milligrams = 3000000,
        open_container = true,
        watertight = true,
        sealed_spoil_multiplier = 0.0,
    }
    content.add(item)
end
