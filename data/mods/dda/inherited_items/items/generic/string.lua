local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cordage_6",
        copy_from = "string_6",
        looks_like = "string_6",
        name = ccb.content.plural_text("short cordage piece", "short cordage pieces"),
        description = ccb.content.text("A 6-inch (or about 15 cm) long piece of natural cordage.  Useful for some purposes, but not as strong or flexible as proper string."),
    }
    item:material("dry_plant", 1)
    item:adjust_measurements { price_cents = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cordage_36",
        copy_from = "string_36",
        looks_like = "string_36",
        name = ccb.content.plural_text("long cordage piece", "long cordage pieces"),
        description = ccb.content.text("A 3-foot (or about 90 cm) long piece of natural cordage.  Useful for some purposes, but not as strong or flexible as proper string."),
    }
    item:material("dry_plant", 1)
    item:adjust_measurements { price_cents = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cordage_6_leather",
        copy_from = "string_6",
        looks_like = "string_6",
        name = ccb.content.plural_text("short leather lace", "short leather laces"),
        description = ccb.content.text("A 6-inch (or about 15 cm) long piece of leather lace.  Useful for some purposes, but not as flexible as proper string."),
        color = "brown",
    }
    item:material("leather", 1)
    item:adjust_measurements { price_cents = { factor = 0.7 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cordage_36_leather",
        copy_from = "cordage_6_leather",
        looks_like = "cordage_6_leather",
        name = ccb.content.plural_text("long leather lace", "long leather laces"),
        description = ccb.content.text("A 3-foot (or about 90 cm) long piece of leather lace, made from smaller pieces that are tied together.  Useful for some purposes, but not as flexible as proper string."),
    }
    item:adjust_measurements { price_cents = { factor = 6 }, volume_ml = { factor = 6 }, mass_milligrams = { factor = 6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "vine_6",
        copy_from = "rope_6",
        looks_like = "rope_6",
        name = ccb.content.plural_text("short vine", "short vines"),
        description = ccb.content.text("A sturdy 6-foot (or about 180 cm) long vine.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
        color = "light_green",
    }
    item:material("dry_plant", 1)
    item:adjust_measurements { price_cents = { factor = 0.9 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "vine_30",
        copy_from = "rope_30",
        looks_like = "rope_30",
        name = ccb.content.plural_text("long vine", "long vines"),
        description = ccb.content.text("A sturdy 30-foot (or about 9 m) long vine.  Could easily be used as a rope.  Strong enough to suspend a large corpse for butchering.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
        color = "light_green",
        replace_qualities = true,
    }
    item:material("dry_plant", 1)
    item:quality("ROPE", 2)
    item:adjust_measurements { price_cents = { factor = 0.9 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "rope_makeshift_6",
        copy_from = "vine_6",
        looks_like = "vine_6",
        name = ccb.content.plural_text("short cordage rope", "short cordage ropes"),
        description = ccb.content.text("A 6-foot (or about 180 cm) long piece of rough rope, woven from natural cordage.  Useful for some purposes, but not as strong or flexible as proper rope.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
    }
    item:adjust_measurements { price_cents = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "rope_makeshift_30",
        copy_from = "vine_30",
        looks_like = "vine_30",
        name = ccb.content.plural_text("long cordage rope", "long cordage ropes"),
        description = ccb.content.text("A 30-foot (or about 9 m) long rough rope, woven from natural cordage.  Not strong enough to hold up to falls, but still useful for some things, such as suspending large corpses for butchering.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
        replace_qualities = true,
    }
    item:quality("ROPE", 2)
    item:adjust_measurements { price_cents = { factor = 0.5 } }
    content.add(item)
end
