local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "bloodthorne_druid_bandage_01",
        name = ccb.content.plural_text("Heartvines", "Heartvines"),
        looks_like = "bandage",
        description = content.text("A magical bandage.  You should never see this."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "!",
        color = "magenta",
        max_worn = 1,
    }
    item:clear_flags()
    item:flag("NO_INGEST")
    item:flag("EDIBLE_FROZEN")
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 1, bleed = 7, move_cost = 0 }
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "bloodthorne_druid_bandages_02",
        name = ccb.content.plural_text("Heartvines", "Heartvines"),
        looks_like = "bandage",
        description = content.text("A magical bandage.  You should never see this."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "!",
        color = "magenta",
        max_worn = 1,
    }
    item:clear_flags()
    item:flag("NO_INGEST")
    item:flag("EDIBLE_FROZEN")
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 2, bleed = 14, move_cost = 0 }
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "bloodthorne_druid_bandages_03",
        name = ccb.content.plural_text("Heartvines", "Heartvines"),
        looks_like = "bandage",
        description = content.text("A magical bandage.  You should never see this."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "!",
        color = "magenta",
        max_worn = 1,
    }
    item:clear_flags()
    item:flag("NO_INGEST")
    item:flag("EDIBLE_FROZEN")
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 3, bleed = 20, move_cost = 0 }
    content.add(item)
end
