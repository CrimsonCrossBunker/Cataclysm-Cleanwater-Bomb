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
