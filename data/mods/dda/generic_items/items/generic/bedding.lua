local ccb = require("ccb")
local content = ccb.content

do
    -- Based on https://www.amazon.com/dp/B01MUDQUN9
    local item = content.Item {
        id = "pillowcase",
        category = "container",
        name = ccb.content.plural_text("pillowcase", "pillowcases"),
        looks_like = "pillow",
        description = ccb.content.text("A simple cotton pillowcase."),
        mass_milligrams = 45000,
        volume_ml = 90,
        price_cents = 650,
        price_postapoc_cents = 2,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID_CONTAINER")
    item:container_pocket { max_volume_ml = 22000, max_weight_milligrams = 15000000, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "hammock",
        name = ccb.content.plural_text("hammock", "hammocks"),
        category = "tools",
        description = ccb.content.text("A large sheet of cloth with ropes on two sides.  Could be tied to something and then used as a sleeping place that is comfortable, but lacks warmth."),
        mass_milligrams = 1000000,
        price_cents = 5000,
        price_postapoc_cents = 250,
        color = "white",
        symbol = "=",
        volume_ml = 2000,
    }
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hammock_net",
        name = ccb.content.plural_text("net hammock", "net hammocks"),
        category = "tools",
        description = ccb.content.text("A large net with ropes on two sides.  Could be tied to something and then used as a sleeping place that is comfortable, but lacks warmth."),
        mass_milligrams = 750000,
        price_cents = 5000,
        price_postapoc_cents = 250,
        color = "white",
        symbol = "=",
        volume_ml = 1500,
    }
    item:material("cotton", 1)
    content.add(item)
end
