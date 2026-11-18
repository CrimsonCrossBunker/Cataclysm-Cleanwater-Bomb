local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "lc_shoulder_guards",
        category = "spare_parts",
        name = ccb.content.plural_text("mild steel shoulder guards (pair)", "mild steel shoulder guards (pair)"),
        description = ccb.content.text("A pair of thin shoulder guards, made of steel.  Designed to be attached to brigandine."),
        mass_milligrams = 438000,
        volume_ml = 600,
        price_cents = 60000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "light_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_lc_shoulder_guards",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("mild steel shoulder guards (pair)", "mild steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XL")
    item:adjust_measurements { price_cents = { factor = 1.25 }, volume_ml = { factor = 1.13 }, mass_milligrams = { factor = 1.125 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_shoulder_guards_xs",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("mild steel shoulder guards (pair)", "mild steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XS")
    item:adjust_measurements { price_cents = { factor = 0.5 }, volume_ml = { factor = 0.75 }, mass_milligrams = { factor = 0.75 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_shoulder_guards",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("medium steel shoulder guards (pair)", "medium steel shoulder guards (pair)"),
    }
    item:replace_material("lc_steel", "mc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_mc_shoulder_guards",
        copy_from = "mc_shoulder_guards",
        looks_like = "mc_shoulder_guards",
        name = ccb.content.plural_text("medium steel shoulder guards (pair)", "medium steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XL")
    item:adjust_measurements { price_cents = { factor = 1.25 }, volume_ml = { factor = 1.13 }, mass_milligrams = { factor = 1.125 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_shoulder_guards_xs",
        copy_from = "mc_shoulder_guards",
        looks_like = "mc_shoulder_guards",
        name = ccb.content.plural_text("medium steel shoulder guards (pair)", "medium steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XS")
    item:adjust_measurements { price_cents = { factor = 0.5 }, volume_ml = { factor = 0.75 }, mass_milligrams = { factor = 0.75 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_shoulder_guards",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("high steel shoulder guards (pair)", "high steel shoulder guards (pair)"),
    }
    item:replace_material("lc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_hc_shoulder_guards",
        copy_from = "hc_shoulder_guards",
        looks_like = "hc_shoulder_guards",
        name = ccb.content.plural_text("high steel shoulder guards (pair)", "high steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XL")
    item:adjust_measurements { price_cents = { factor = 1.25 }, volume_ml = { factor = 1.13 }, mass_milligrams = { factor = 1.125 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_shoulder_guards_xs",
        copy_from = "hc_shoulder_guards",
        looks_like = "hc_shoulder_guards",
        name = ccb.content.plural_text("high steel shoulder guards (pair)", "high steel shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XS")
    item:adjust_measurements { price_cents = { factor = 0.5 }, volume_ml = { factor = 0.75 }, mass_milligrams = { factor = 0.75 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_shoulder_guards",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("hardened shoulder guards (pair)", "hardened shoulder guards (pair)"),
    }
    item:replace_material("lc_steel", "ch_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_ch_shoulder_guards",
        copy_from = "ch_shoulder_guards",
        looks_like = "ch_shoulder_guards",
        name = ccb.content.plural_text("hardened shoulder guards (pair)", "hardened shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XL")
    item:adjust_measurements { price_cents = { factor = 1.25 }, volume_ml = { factor = 1.13 }, mass_milligrams = { factor = 1.125 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_shoulder_guards_xs",
        copy_from = "ch_shoulder_guards",
        looks_like = "ch_shoulder_guards",
        name = ccb.content.plural_text("hardened shoulder guards (pair)", "hardened shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XS")
    item:adjust_measurements { price_cents = { factor = 0.5 }, volume_ml = { factor = 0.75 }, mass_milligrams = { factor = 0.75 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_shoulder_guards",
        copy_from = "lc_shoulder_guards",
        looks_like = "lc_shoulder_guards",
        name = ccb.content.plural_text("tempered shoulder guards (pair)", "tempered shoulder guards (pair)"),
    }
    item:replace_material("lc_steel", "qt_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_qt_shoulder_guards",
        copy_from = "qt_shoulder_guards",
        looks_like = "qt_shoulder_guards",
        name = ccb.content.plural_text("tempered shoulder guards (pair)", "tempered shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XL")
    item:adjust_measurements { price_cents = { factor = 1.25 }, volume_ml = { factor = 1.13 }, mass_milligrams = { factor = 1.125 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_shoulder_guards_xs",
        copy_from = "qt_shoulder_guards",
        looks_like = "qt_shoulder_guards",
        name = ccb.content.plural_text("tempered shoulder guards (pair)", "tempered shoulder guards (pair)"),
    }
    item:clear_flags()
    item:flag("PREFIX_XS")
    item:adjust_measurements { price_cents = { factor = 0.5 }, volume_ml = { factor = 0.75 }, mass_milligrams = { factor = 0.75 } }
    content.add(item)
end
