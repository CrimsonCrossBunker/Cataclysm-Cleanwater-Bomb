local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local overmap = services.overmap

local function position(character)
    local state = services.creatures.snapshot(character)
    if not state.ok then error(state.error.message) end
    return state.value.position:project_to("omt")
end

local function route_point(character, terrain, options)
    local target = overmap.find_target(position(character), terrain, options)
    -- The native route lookup loads a detached map at each target before revealing it.
    services.world.find_location(target:project_to("ms"), nil)
    return target
end

local function message(ctx, character, text, severity)
    if character.subtype == "avatar" then
        ctx:message(ctx:expand_text(text), severity)
    end
end

ccb.runtime.handler("deface_denarius", function(ctx)
    local character = ctx.character
    if not character then
        return 0
    end
    if not overmap.matches_location_near(position(character), "road", 1) then
        message(ctx, character, ccb.services.translate("You rub the scratches on the coin, but leave no mark.  Oh, would-be traveller, how can you wear upon his visage like the wagon wheels upon the roads?"), "mixed")
        return 0
    end

    local forge = route_point(character, "forge_x2y2z1", { z = 0 })
    overmap.reveal_native(forge, 4)
    -- Route finding expects the starting tile to have a road connection.
    local road = route_point(character, "road", { z = 0, search_range = 3, random = true })
    message(ctx, character, ccb.services.translate("You scratch your nails against the coin like so many before you, and feel Valzain's tears.  He longingly cries for somewhere that is not here, and now you know where."), "good")
    overmap.reveal_route(road, forge, 0, false)
    return 0
end)

do
    local item = content.Item {
        id = "denarius",
        category = "currency",
        name = ccb.content.plural_text("denarius", "denarii"),
        description = ccb.content.text("Each of these mithril coins has a profile of Valzain, and strangely each of these coins is defaced in some way."),
        price_cents = 2500,
        price_postapoc_cents = 2,
        mass_milligrams = 1000,
        volume_ml = 1,
        melee_to_hit = -3,
        color = "light_gray",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:material("mithril_metal", 1)
    item:on_use("deface_denarius", ccb.content.text("Activate"), ccb.content.text("Further deface the coin"))
    content.add(item)
end
