local ccb = require("ccb")
local services = ccb.services

local function round_half_away(v)
    if v >= 0 then return math.floor(v + 0.5) end
    return math.ceil(v - 0.5)
end

local function char_enchant_val(actor, key, base)
    if not actor then
        return base or 0
    end
    local r = services.characters.enchantment_value(actor, key, base or 0)
    if not r.ok then
        return base or 0
    end
    return r.value or 0
end

local function jmath_immortal_path_qi_power(payload)
    return char_enchant_val(payload.speaker, "qi_power", 100)
end

local function jmath_immortal_path_polarization_fire(payload)
    return char_enchant_val(payload.speaker, "polarization_fire", 1)
end

local function jmath_immortal_path_polarization_water(payload)
    return char_enchant_val(payload.speaker, "polarization_water", 1)
end

ccb.runtime.handler("wave14a_immortal_path_stat_1", function(payload)
    return round_half_away(((8 * (jmath_immortal_path_qi_power(payload) / 100)) * jmath_immortal_path_polarization_fire(payload)))
end)

ccb.runtime.handler("wave14a_immortal_path_stat_2", function(payload)
    return round_half_away(((16 * (jmath_immortal_path_qi_power(payload) / 100)) * jmath_immortal_path_polarization_fire(payload)))
end)

ccb.runtime.handler("wave14a_immortal_path_stat_3", function(payload)
    return round_half_away(((8 * (jmath_immortal_path_qi_power(payload) / 100)) * jmath_immortal_path_polarization_water(payload)))
end)

ccb.runtime.handler("wave14a_immortal_path_stat_4", function(payload)
    return round_half_away(((16 * (jmath_immortal_path_qi_power(payload) / 100)) * jmath_immortal_path_polarization_water(payload)))
end)
