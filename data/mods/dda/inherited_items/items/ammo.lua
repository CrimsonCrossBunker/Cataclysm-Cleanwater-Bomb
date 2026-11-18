local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "betavoltaic",
        category = "spare_parts",
        price_cents = 40711,
        price_postapoc_cents = 200,
        name = ccb.content.plural_text("betavoltaic cell", "betavoltaic cells"),
        symbol = "=",
        color = "green",
        description = ccb.content.text("Harness the power of radiation in your own home!  It looks similar to a D-cell battery, but actually contains folded layers of radioactive material inside.  It can produce electricity for several years at a steady voltage… but it's barely enough to power a small LED, and these batteries were worth hundreds of dollars.  Mostly they're a good way to brag to your neighbors that you have a nuclear power source in your house."),
        volume_ml = 250,
        mass_milligrams = 160000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:material("lead", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "RTG_coffee",
        category = "spare_parts",
        price_cents = 20000,
        price_postapoc_cents = 2000,
        name = ccb.content.plural_text("radioisotope thermoelectric generator", "radioisotope thermoelectric generators"),
        symbol = "=",
        color = "green",
        description = ccb.content.text("Did your neighbors brag about their cool beta-decay-powered nightlights?  Do them one better!  The CuppaTech 4 radioisotope thermoelectric generator is a three kilogram chunk of metal - mostly lead - with a slug of cerium-244 encased within.  It is capable of generating somewhere between 100-150 Watts of thermal energy, although its electrical generation capacity is minimal at only 2 Watts.  Careful!  Curium is great at making heat, and also releases deadly gamma radiation.  Keep away from cellular life forms."),
        volume_ml = 500,
        mass_milligrams = 4000000,
    }
    item:material("steel", 1)
    item:material("lead", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:tool()
    content.add(item)
end
