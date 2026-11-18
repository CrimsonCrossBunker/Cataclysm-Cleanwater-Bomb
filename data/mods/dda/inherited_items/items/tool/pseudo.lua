local ccb = require("ccb")
local content = ccb.content

do
    -- This is a pseudo item to represent the support of a tree or butchery rack without a hook.
    -- NO_I18N
    local item = content.Item {
        id = "butchery_tree_pseudo",
        name = content.plural_text("butchery tree pseudo item", "butchery tree pseudo items"),
        copy_from = "fake_item",
        symbol = "[",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:quality("SUSPENDING", 2)
    item:tool()
    content.add(item)
end

do
    -- This is a pseudo item to represent the support of a tree or butchery rack with a hook.
    -- NO_I18N
    local item = content.Item {
        id = "fake_butcher_rack",
        name = content.plural_text("fake butcher rack (pseudo item)", "fake butcher racks (pseudo items)"),
        copy_from = "fake_item",
        symbol = "[",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:quality("SUSPENDING", 2)
    item:quality("ROPE", 2)
    item:tool()
    content.add(item)
end

do
    -- This is a pseudo item to represent a surface large enough to butcher a medium animal on.
    -- NO_I18N
    local item = content.Item {
        id = "medium_surface_pseudo",
        name = content.plural_text("medium surface pseudo item", "medium surface pseudo items"),
        copy_from = "fake_item",
        symbol = "[",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:quality("SURFACE", 2)
    item:tool()
    content.add(item)
end

do
    -- This is a pseudo item to represent a surface large enough to butcher a large animal on.
    -- NO_I18N
    local item = content.Item {
        id = "large_surface_pseudo",
        name = content.plural_text("large surface pseudo item", "large surface pseudo items"),
        copy_from = "fake_item",
        symbol = "[",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:quality("SURFACE", 3)
    item:tool()
    content.add(item)
end

do
    -- A fake stove used for basecamps.
    local item = content.Item {
        id = "fake_stove",
        name = ccb.content.plural_text("basecamp stove", "basecamp stoves"),
        copy_from = "fake_item",
        replace_pockets = true,
    }
    item:ammo_pocket("tinder", 50000)
    item:tool { charge_factor = 10, ammo_types = { "tinder" }, crafting_subtype = "hotplate" }
    content.add(item)
end

do
    -- This is a pseudo item to represent t_brick_oven.
    local item = content.Item {
        id = "brick_oven_pseudo",
        name = ccb.content.plural_text("brick oven", "brick ovens"),
        copy_from = "fake_item",
        symbol = "[",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:quality("OVEN", 2)
    item:quality("TEMPER", 2, 1.1)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "butter_churn",
        name = content.plural_text("pseudo butter churn", "pseudo butter churns"),
        copy_from = "fake_item",
        replace_qualities = true,
        symbol = "H",
        color = "light_cyan",
    }
    item:quality("CHURN", 1)
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    -- Pseudo item for parabolic solar cooker furniture.  Provides cooking heat when sufficient sunlight is available.
    local item = content.Item {
        id = "fake_solar_cooker",
        name = ccb.content.plural_text("solar cooker", "solar cookers"),
        copy_from = "fake_item",
        symbol = ")",
        color = "yellow",
    }
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("PSEUDO")
    item:flag("NEEDS_SUNLIGHT")
    item:tool()
    content.add(item)
end
