local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.content.add(ccb.content.Bionic {
    id = "mountain_tattoo_two",
    name = "Base of the Mountain",
    description = "The second element of the mountain pattern, the lower paths and foothills of a mountain on the lower back.  When activated, your unarmed attacks hit harder.  The damage increases as you complete more of the mountain pattern.",
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 35000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 10 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_mountain_tattoo_two_0" },
    required_bionic = "mountain_tattoo_one",
})
ccb.content.add(ccb.content.Bionic {
    id = "mountain_tattoo_six",
    name = "The Crown of the Mountain",
    description = "The sixth element of the mountain pattern, the lofty summit beneath the sky.  You may activate this element to turn your skin into stone, slowing you slightly but greatly increasing your resilience",
    activation_energy_millijoules = 195000,
    over_time_energy_millijoules = 195000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 25 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_mountain_tattoo_six_0" },
    required_bionic = "mountain_tattoo_five",
})
ccb.runtime.handler("w16b_xedrawood_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "mountain_tattoo_two" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_TWO_ON", ctx)
    elseif bid == "mountain_tattoo_six" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_SIX_ON", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_xedrawood_on_bionic_activated")
ccb.runtime.handler("w16b_xedrawood_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "mountain_tattoo_two" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_TWO_OFF", ctx)
    elseif bid == "mountain_tattoo_six" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_SIX_OFF", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_xedrawood_on_bionic_deactivated")
