local ccb = require("ccb")
local content = ccb.content

-- Hidden, caused by the Ominous Fog weather
content.add(content.EffectType {
    id = "effect_xe_weather_ominous_fog_monster_buff",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_xe_weather_ominous_fog_monster_buff_0"))
