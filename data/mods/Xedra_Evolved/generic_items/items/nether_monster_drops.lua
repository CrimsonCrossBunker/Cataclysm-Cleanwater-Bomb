local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "corpse_yugg_jade_fragments",
        symbol = ",",
        color = "light_green",
        name = ccb.content.plural_text("jade shard", "jade shards"),
        category = "other",
        description = ccb.content.text("A shard of jade that fell away from the petrified corpse of a yugg.  The edges are rounded and sinuous, and when you look at it out of the corner of your eye it almost seems to be trying to crawl away."),
        mass_milligrams = 75000,
        volume_ml = 30,
        melee_to_hit = -5,
        weapon_categories = { "SHIVS" },
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "kreck_loot_star_stone",
        name = ccb.content.plural_text("star-stone", "star-stones"),
        description = ccb.content.text("A strange chunk of what looks like stone in the shape of a seven-pointed star.  Its surface is smooth with thin lines in it, like driftwood, but despite that it doesn't seem to reflect any light."),
        symbol = "*",
        color = "white",
        mass_milligrams = 657000,
        volume_ml = 250,
        longest_side_mm = 80,
        melee_to_hit = -2,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SLING_PROJECTILE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end
