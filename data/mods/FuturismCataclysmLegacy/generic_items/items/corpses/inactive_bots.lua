local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_fcl_eyebot",
        looks_like = "broken_eyebot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken eyebot", "broken eyebots"),
        category = "other",
        description = ccb.content.text("A broken eyebot.  Much less threatening now that it won't be calling for backup.  Could be gutted for parts."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 31520000,
        volume_ml = 15000,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
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
        id = "broken_fcl_copbot",
        looks_like = "broken_copbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken police bot", "broken police bots"),
        category = "other",
        description = ccb.content.text("A broken police bot.  Much less threatening now that it's quiet and still.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
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
        id = "broken_fcl_molebot",
        looks_like = "broken_molebot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken miner bot", "broken miner bots"),
        category = "other",
        description = ccb.content.text("A broken miner bot.  Much less threatening now that it's no longer capable of drilling anything.  Could be gutted for parts."),
        price_cents = 20000,
        price_postapoc_cents = 10,
        mass_milligrams = 170200000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_fcl_riotbot",
        looks_like = "broken_riotbot",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken riot control bot", "broken riot control bots"),
        category = "other",
        description = ccb.content.text("A broken riot control bot.  Much less threatening now that it's out of gas.  Could be gutted for parts."),
        price_cents = 30000,
        price_postapoc_cents = 10,
        mass_milligrams = 140000000,
        volume_ml = 62500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end
