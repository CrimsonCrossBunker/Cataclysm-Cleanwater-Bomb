local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local returning = require("raid_return")
local sickness = require("raid_sickness")
local content = ccb.content

ccb.runtime.handler("sky_homeward_mote", function(context)
    if not context.character then return nil end
    returning.home(context.character)
    -- Returning destroys every carried mote, including the one being activated.
    return 0
end)

ccb.runtime.handler("sky_earthbound_pill", function(context)
    if not context.character then return end
    state.set("timeawayfromhome", state.number("timeawayfromhome") - 5)
    sickness.tick(context.character)
end)

do
    local item = content.Item {
        id = "warphome",
        name = content.text("homeward mote"),
        description = content.text("Though visibly little more than a glowing dustbunny, this strange ethereal mote of warp essence reveals, on closer inspection, something more.  A tiny, twisting, half-visible thread of shimmering bluish-purple trails away into the sky and far out of sight, unimpeded by any obstacles.\n\nTaking this rare and valuable artifact with you on an expedition is essentially buying life insurance.  If you die with this mote in your inventory, you will instead be restored to full health and brought home, WITH all items and equipment carried.  But this effect will only last for a single expedition.  Even if you extract safely, any and all motes carried on your person when you return home will be DESTROYED."),
        mass_grams = 15,
        volume_ml = 5,
        looks_like = "fishing_hook_basic",
        symbol = "!",
        color = "red",
    }
    item:material("alien_resin", 1)
    item:flag("TRADER_AVOID")
    item:flag("UNBREAKABLE")
    item:tool()
    item:on_use("sky_homeward_mote", content.text("Activate"), content.text("A hasty escape."))
    content.add(item)
end

do
    local item = content.Item {
        id = "warpextender",
        name = content.text("earthbound pill"),
        description = content.text("This pseudomagical pill extends the amount of time you can stay earthside by 4 pulses, or about 50% of a normal trip.  They're precious, but should help buy time for a difficult extract.  However, the air of the lower world destabilizes its structure and it will only last a single trip to the surface"),
        mass_grams = 15,
        volume_ml = 5,
        looks_like = "panacea",
        symbol = "!",
        color = "red",
    }
    item:material("plastic", 1)
    item:flag("TRADER_AVOID")
    item:flag("UNBREAKABLE")
    item:comestible { type = "MED" }
    item:on_consume("sky_earthbound_pill")
    content.add(item)
end
