local ccb = require("ccb")
local state = require("spell_state")
local services = ccb.services
local sorcerer = services.types.id("mutation", "SORCERER")

ccb.runtime.handler("sorcerer_initialize", function()
    local avatar = services.characters.avatar()
    if state.checked(services.mutations.has(avatar, sorcerer)) then
        return
    end

    state.set(avatar, "exp_to_sorcerer_level", 100)
    state.set(avatar, "exp_per_sorcerer_level", 300)
    state.set(avatar, "available_exp_sorcerer", 0)
    state.set(avatar, "current_sorcerer_level", 0)
    state.open_menu(avatar)
    services.messages.add(ccb.services.translate("You can open the Sorcerer menu again from the mutations menu."))
    state.checked(services.mutations.replace(avatar, sorcerer))
end)
ccb.runtime.on("game:game_start", "sorcerer_initialize")

ccb.runtime.handler("sorcerer_open_menu", function(payload)
    state.open_menu(payload.character)
end)
