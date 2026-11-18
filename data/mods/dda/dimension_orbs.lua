local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function travel_and_exchange(dimension, other_orb, travel_message)
    return function(ctx)
        local character = ctx.character
        if not character then
            return 1
        end
        local item = ctx.item
        local travel = services.relocation.travel_to_dimension(dimension, {
            npc_travel_radius = 0,
            npc_travel_filter = "none",
            item_travel_radius = -1,
        })
        if not travel.ok and travel.error.code ~= "invalid_dimension" then
            error(travel.error.message)
        end
        local arrived = travel.ok and travel.value.accepted
        if character.subtype == "avatar" then
            ctx:message(travel_message(arrived))
        end

        -- The other orb is received even if dimension travel was rejected.
        local receipt = services.inventory.receive_item(character, services.types.id("item", other_orb), 1)
        if not receipt.ok and arrived and character.subtype == "npc"
            and (receipt.error.code == "stale_identity" or receipt.error.code == "destroyed") then
            -- NPCs outside the destination are unloaded during the dimension change.
            return 0
        end

        local received = value(receipt)
        local giver = services.items.snapshot(item, 0)
        if not giver.ok and giver.error.code == "destroyed" then
            return 0
        end
        local giver_name = value(giver).display_name
        if giver_name ~= "" then
            ccb.presentation.notice(services.format(ccb.services.translate("%1$s gives you a %2$s."),
                { giver_name, received.name }))
        end
        return value(services.inventory.contains(character, item)) and 1 or 0
    end
end

ccb.runtime.handler("enter_abyss_orb", travel_and_exchange("abyss", "default_dimension_teleport_orb", function(arrived)
    if arrived then
        return ccb.services.translate("The abyss opens up around you.")
    end
    return ccb.services.translate("Nothing happens.")
end))

-- Retain the original target. The empty definition ID currently follows the failure path.
ccb.runtime.handler("squeeze_default_dimension_orb", travel_and_exchange("", "abyss_teleport_orb", function(arrived)
    if arrived then
        return ccb.services.translate("The familiar world re-appears.")
    end
    return ccb.services.translate("Nothing seems to change.")
end))

do
    local item = content.Item {
        id = "abyss_teleport_orb",
        name = ccb.content.plural_text("black glass orb", "black glass orb"),
        description = ccb.content.text("A mysterious black glass orb.  It seems to have endless depths hidden in it."),
        color = "black",
        symbol = "o",
        mass_milligrams = 1000000,
        volume_ml = 500,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:on_use("enter_abyss_orb", ccb.content.text("Activate"), ccb.content.text("Gaze into the orb."))
    content.add(item)
end

do
    local item = content.Item {
        id = "default_dimension_teleport_orb",
        copy_from = "abyss_teleport_orb",
        looks_like = "abyss_teleport_orb",
        name = ccb.content.plural_text("dull brown orb", "dull brown orb"),
        description = ccb.content.text("A dull brown orb.  The surface has the texture of dried earth."),
        color = "brown",
    }
    item:clear_use_actions()
    item:on_use("squeeze_default_dimension_orb", ccb.content.text("Activate"), ccb.content.text("Squeeze the orb."))
    content.add(item)
end
