local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "vita_bandage_01",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Wound Staunching", "[Ψ]Vitakinetic Wound Staunchings"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop bleeding"),
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
    local item = content.Item {
        id = "vita_bandages_02",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Wound Staunching", "[Ψ]Vitakinetic Wound Staunchings"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop bleeding"),
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
    local item = content.Item {
        id = "vita_bandages_03",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Wound Staunching", "[Ψ]Vitakinetic Wound Staunchings"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop bleeding"),
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

do
    local item = content.Item {
        id = "vita_disinfectant_01",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Disinfectant", "[Ψ]Vitakinetic Disinfectants"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop infections"),
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
    item:heal { bite = 0.5, disinfectant_power = 1, infect = 0.4, move_cost = 0 }
    content.add(item)
end

do
    local item = content.Item {
        id = "vita_disinfectant_02",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Disinfectant", "[Ψ]Vitakinetic Disinfectants"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop infections"),
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
    item:heal { bite = 0.7, disinfectant_power = 2, infect = 0.6, move_cost = 0 }
    content.add(item)
end

do
    local item = content.Item {
        id = "vita_disinfectant_03",
        name = ccb.content.plural_text("[Ψ]Vitakinetic Disinfectant", "[Ψ]Vitakinetic Disinfectants"),
        looks_like = "bandage",
        description = ccb.content.text("The power to stop infections"),
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
    item:heal { bite = 0.9, disinfectant_power = 3, infect = 0.8, move_cost = 0 }
    content.add(item)
end
