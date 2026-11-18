local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "corpse_yugg_rubber",
        name = ccb.content.plural_text("rubber yugg corpse", "rubber yugg corpses"),
        description = ccb.content.text("An oversized hollow tube made of black semi-liquid rubbery substance.  It is vaguely shaped like a yugg."),
        symbol = "W",
        color = "dark_gray",
        category = "corpses",
        price_postapoc_cents = 1000,
        volume_ml = 600000,
        mass_milligrams = 500000000,
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_yugg_jade",
        name = ccb.content.plural_text("jade yugg statue", "jade yugg statues"),
        description = ccb.content.text("A statue of a yugg, made entire out of jade.  If jade was still worth anything this could fetch a fortune.  A shame the world ended."),
        symbol = "W",
        color = "green",
        category = "corpses",
        price_postapoc_cents = 0,
        volume_ml = 600000,
        mass_milligrams = 900000000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_flailer_radiosphere",
        name = ccb.content.plural_text("torn flailer", "torn flailers"),
        description = ccb.content.text("A torn up cloth facsimile of a bird, you could tear it up even further for materials."),
        symbol = "v",
        color = "light_gray",
        category = "corpses",
        price_postapoc_cents = 0,
        volume_ml = 150,
        mass_milligrams = 60000,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "dead_solar_beetle_radiosphere",
        name = ccb.content.plural_text("giant solar beetle corpse", "giant solar beetle corpses"),
        description = ccb.content.text("Corpse of a giant beetle-like robot with a scratched blue plastic shell, the exterior of its open elytra is covered with curved, degraded solar panels."),
        symbol = "B",
        color = "light_blue",
        category = "corpses",
        price_postapoc_cents = 0,
        volume_ml = 31250,
        mass_milligrams = 40050000,
    }
    item:material("glass", 1)
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
