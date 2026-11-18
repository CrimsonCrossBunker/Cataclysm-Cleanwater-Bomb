local ccb = require("ccb")
local services = ccb.services

local function tool_message(use, character, text)
    if character.subtype == "avatar" then
        use:message(use:expand_text(text))
    end
end

local function chainsaw_cue(id)
    services.sound.play_if_audible(id, "chainsaw_on", 80, true)
end

local function register_starting_tool(off_id, on_id, threshold, volume, success_message,
                                      failure_message, gasoline_chainsaw)
    local on_type = services.types.id("item", on_id)
    ccb.runtime.handler("start_" .. off_id, function(use)
        local character = use.character
        if not character then
            return 0
        end
        local function fail()
            if gasoline_chainsaw then
                chainsaw_cue("chainsaw_cord")
            end
            tool_message(use, character, failure_message())
        end
        if services.random.native_float(0, 10) - use.damage_level <= threshold then
            fail()
        elseif services.gameplay.environment.is_divable(use.item_position) then
            if gasoline_chainsaw then
                fail()
            else
                tool_message(use, character, ccb.services.translate("The <npc_name> won't start underwater."))
            end
        else
            local ammo = services.items.has_ammo(use.item, character)
            if not ammo.ok then
                error(ammo.error.message)
            end
            if not ammo.value then
                fail()
                return 0
            end
            -- The old 0.6 and 0.8 turn costs truncated to zero native turns.
            local message = success_message()
            services.sound.emit(use.item_position, volume, "combat", message)
            tool_message(use, character, message)
            use:transform(on_type, true)
            if gasoline_chainsaw then
                chainsaw_cue("chainsaw_cord")
                chainsaw_cue("chainsaw_start")
            end
        end
        return 0
    end)
end

local function cord_failure()
    return ccb.services.translate("You yank the cord, but nothing happens.")
end

local function switch_failure()
    return ccb.services.translate("You flip the switch, but nothing happens.")
end

local function masonry_start()
    return ccb.services.translate("With a roar, the <npc_name> screams to life!")
end

register_starting_tool("chainsaw_off", "chainsaw_on", 5, 20, function()
    return ccb.services.translate("With a roar, the chainsaw screams to life!")
end, cord_failure, true)
register_starting_tool("trimmer_off", "trimmer_on", 3, 15, function()
    return ccb.services.translate("With a roar, the hedge trimmer leaps to life!")
end, cord_failure)
register_starting_tool("masonrysaw_off", "masonrysaw_on", 5, 20, masonry_start, cord_failure)
register_starting_tool("heavy_masonrysaw_off", "heavy_masonrysaw_on", 5, 20, masonry_start, cord_failure)
register_starting_tool("elec_chainsaw_off", "elec_chainsaw_on", 5, 20, function()
    return ccb.services.translate("With a roar, the electric chainsaw screams to life!")
end, switch_failure)
register_starting_tool("elec_chainsaw_cord_off", "elec_chainsaw_cord_on", 5, 20, function()
    return ccb.services.translate("With a roar, the corded electric chainsaw screams to life!")
end, switch_failure)

local chainsaw_off = services.types.id("item", "chainsaw_off")
ccb.runtime.handler("stop_chainsaw", function(use)
    local character = use.character
    if character then
        tool_message(use, character, ccb.services.translate("Your <npc_name> goes quiet."))
    end
    use:transform(chainsaw_off)
    chainsaw_cue("chainsaw_stop")
    return 0
end)

local function register_running_tool(item_id, off_id, sound_chance, volume, sound_message)
    local off_type = services.types.id("item", off_id)
    ccb.runtime.handler("tick_" .. item_id, function(use)
        local position = use.item_position
        if services.gameplay.environment.is_divable(position) then
            local carrier = use.character
            if carrier then
                tool_message(use, carrier, ccb.services.translate("Your <npc_name> gurgles in the water and stops."))
            end
            use:transform(off_type)
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
