local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local returning = require("raid_return")
local sickness = require("raid_sickness")
local healing = require("raid_healing")
local warp = require("raid_warp")
local content = ccb.content
local id = services.types.id

ccb.runtime.handler("sky_quickheal_pill", function(context)
    if context.character then healing.full(context.character) end
end)

local function activation_charge(context)
    if context.item:is_valid()
        and state.checked(services.inventory.contains(context.character, context.item)) then
        return 1
    end
    return 0
end

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

ccb.runtime.handler("sky_skyward_beacon", function(context)
    local character = context.character
    if not character then return nil end
    if warp.no_enemies(character) then
        state.checked(services.activities.assign_timed(character, id("activity", "ACT_WARP_HOME"),
            services.time.duration(60, "turn")))
    else
        state.message(character, services.translate("You cannot warp home with enemies nearby!"), "bad")
    end
    return activation_charge(context)
end)

ccb.runtime.handler("sky_waterwalking_stone", function(context)
    local character = context.character
    if not character then return nil end
    state.checked(services.inventory.consume_by_type(character, id("item", "warp_waterwalking_stone"), 1, 0))
    state.message(character, services.translate("You feel somehow lighter."), "good")
    state.add_effect(character, "effect_warped_waterwalking", 180)
    return activation_charge(context)
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

do
    local item = content.Item {
        id = "warp_skyward_beacon",
        name = content.plural_text("skyward beacon", "skyward beacon"),
        description = content.text("This smooth purplish sphere seems like it wants to rise right out of your hand.  If you activate it, you will return directly to the island with everything you are carrying."),
        mass_grams = 5,
        volume_ml = 5,
        category = "other",
        looks_like = "spiral_stone",
        symbol = ".",
        color = "magenta",
    }
    item:material("alien_resin", 1)
    item:flag("UNBREAKABLE")
    item:ammunition { type = "components", count = 1, stack_size = 100 }
    item:on_use("sky_skyward_beacon", content.text("Activate"), content.text("Return to the sky."))
    content.add(item)
end

do
    local item = content.Item {
        id = "warp_waterwalking_stone",
        name = content.plural_text("flotation stone", "flotation stone"),
        description = content.text("This smooth, whorled stone seems cool and wet to the touch, but when you take your hand off it your skin is perfectly dry.  If you activate it, you will be able to walk on the surface of water for three minutes."),
        mass_grams = 5,
        volume_ml = 5,
        category = "other",
        looks_like = "spiral_stone",
        symbol = ".",
        color = "cyan",
    }
    item:material("alien_resin", 1)
    item:flag("UNBREAKABLE")
    item:ammunition { type = "components", count = 1, stack_size = 100 }
    item:on_use("sky_waterwalking_stone", content.text("Activate"), content.text("Cross the waters."))
    content.add(item)
end

do
    local item = content.Item {
        id = "quickheal",
        name = content.text("quickheal pill"),
        description = content.text("This pseudomagical pill will heal all your damaged parts, but only if swallowed while on your sanctuary island.  No reason to bring this into the field."),
        mass_grams = 15, volume_ml = 5,
        looks_like = "panacea",
        symbol = "!",
        color = "red",
    }
    item:material("water", 1)
    item:flag("ALLOWS_REMOTE_USE")
    item:comestible { type = "FOOD", calories = 0, charges = 0, stack_size = 0,
        spoils_in_turns = 24 * 60 * 60, freezing_point_celsius = -1000 }
    item:on_consume("sky_quickheal_pill")
    content.add(item)
end
