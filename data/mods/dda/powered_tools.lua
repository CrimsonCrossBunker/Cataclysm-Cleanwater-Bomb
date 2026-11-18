local ccb = require("ccb")
local services = ccb.services

local function register_running_tool(item_id, off_id, sound_chance, volume, sound_message)
    local off_type = services.types.id("item", off_id)
    ccb.runtime.handler("tick_" .. item_id, function(use)
        local position = use.item_position
        if services.gameplay.environment.is_divable(position) then
            local carrier = use.character
            if carrier and carrier.subtype == "avatar" then
                use:message(use:expand_text(ccb.services.translate("Your <npc_name> gurgles in the water and stops.")))
            end
            local result = services.items.transform(use.item, off_type, { carrier = carrier, active = false })
            if not result.ok then
                error(result.error.message)
            end
        elseif sound_chance <= 1 or services.random.native_int(0, sound_chance - 1) == 0 then
            local message = sound_message()
            services.messages.add_if_audible(use:expand_text(message))
            services.sound.emit(position, volume, "activity", message, true)
        end
        return 0
    end)
end

register_running_tool("carver_on", "carver_off", 10, 8, function()
    return ccb.services.translate("Your electric carver buzzes.")
end)
register_running_tool("noise_emitter_super_on", "noise_emitter_super", 0, 300, function()
    return ccb.services.translate("Your super noise emitter produces an unholy blast of sonic chaos.")
end)
register_running_tool("trimmer_on", "trimmer_off", 15, 10, function()
    return ccb.services.translate("Your hedge trimmer rumbles.")
end)
register_running_tool("masonrysaw_on", "masonrysaw_off", 15, 7, function()
    return ccb.services.translate("Your masonry saw buzzes.")
end)
register_running_tool("electric_masonrysaw_on", "electric_masonrysaw_off", 15, 7, function()
    return ccb.services.translate("Your electric masonry saw buzzes.")
end)
register_running_tool("heavy_masonrysaw_on", "heavy_masonrysaw_off", 15, 7, function()
    return ccb.services.translate("Your heavy masonry saw buzzes.")
end)
register_running_tool("chainsaw_on", "chainsaw_off", 15, 12, function()
    return ccb.services.translate("Your chainsaw rumbles.")
end)
register_running_tool("polesaw_on", "polesaw_off", 15, 12, function()
    return ccb.services.translate("Your pole saw rumbles.")
end)
register_running_tool("circsaw_on", "circsaw_off", 15, 7, function()
    return ccb.services.translate("Your circular saw buzzes.")
end)
register_running_tool("elec_chainsaw_on", "elec_chainsaw_off", 5, 12, function()
    return ccb.services.translate("Your electric chainsaw rumbles.")
end)
register_running_tool("elec_chainsaw_cord_on", "elec_chainsaw_cord_off", 5, 12, function()
    return ccb.services.translate("Your corded electric chainsaw rumbles.")
end)

-- The gasoline chainsaw still defines its separate manual shutdown sound in JSON.
local chainsaw = ccb.content.Item { id = "chainsaw_on", copy_from = "chainsaw_on" }
chainsaw:clear_tick_actions()
chainsaw:on_tick("tick_chainsaw_on")
ccb.content.replace(chainsaw)
