local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "crashing_ship_locker_card",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("ID card", "ID cards"),
        description = ccb.content.text("This is your personal ID card.  The reverse side describes the protocol for using it; this grants you access to the barracks locker room."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("AFS_CS_LOCKER_CARD")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "crashing_ship_armory_card",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("ID card", "ID cards"),
        description = ccb.content.text("This is an ID card you found.  The reverse side describes the protocol for using it; this grants you access to the barracks locker room."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("AFS_CS_ARMORY_CARD")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "crashing_ship_exobay_card",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("ID card", "ID cards"),
        description = ccb.content.text("This is an ID card you found.  The reverse side describes the protocol for using it; this grants you access to the workshop's exosuit storage bay."),
        price_cents = 60000,
        price_postapoc_cents = 250,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("AFS_CS_EXOBAY_CARD")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tskbem_master_keycard",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("TSKBEM industrial master key", "TSKBEM industrial master keys"),
        description = ccb.content.text("A master keycard for all TSKBEM prefab industrial infrastructure built before the year 2152.  Invaluable to anyone seeking to salvage the industrial ruins of Orion."),
        price_cents = 800000,
        price_postapoc_cents = 800000,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("OLD_TSKBEM_CARD")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "enforcer_master_keycard",
        symbol = ",",
        color = "blue",
        name = ccb.content.plural_text("Enforcer master key", "Enforcer master keys"),
        description = ccb.content.text("Issued only to the highest echelons of Mercurial corporate security, these cards provide unfettered access to all enforcer prefab facilites built before the year 2152.  A lucrative find for any salvor on Salus IV."),
        price_cents = 800000,
        price_postapoc_cents = 800000,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("OLD_ENFORCER_CARD")
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mercurial_master_keycard",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("Mercurial master key", "Mercurial master keys"),
        description = ccb.content.text("A master keycard for nearly all Mercurial corporate facilities and infrastructure built before the year 2152.  Invaluable on Salus IV, this card will grant you entry to all but the most secure Mercurial facilities."),
        price_cents = 800000,
        price_postapoc_cents = 800000,
        mass_milligrams = 6000,
        volume_ml = 5,
        category = "keys",
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("OLD_MERCURIAL_CARD")
    item:material("plastic", 1)
    content.add(item)
end
