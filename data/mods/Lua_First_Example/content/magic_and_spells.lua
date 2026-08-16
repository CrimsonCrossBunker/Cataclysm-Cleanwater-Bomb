local content = {}

function content.register(ccb)
    local magic = ccb.content.MagicType {
        id = "magic_lua_first_cybermancy",
        energy = "mana",
        energy_color = "c_light_blue",
        cannot_cast_message = "你的赛博法力回路受阻，无法引导能量。",
        failure_cost_fraction = 0.5,
        failure_experience_fraction = 0.25,
    }
    magic:progression("lua_first_magic_level_for_exp", "lua_first_magic_exp_for_level")
    magic:casting_experience("lua_first_magic_cast_exp")
    magic:failure_chance("lua_first_magic_fail_chance")
    magic:on_failure("lua_first_magic_on_failure")
    ccb.content.add(magic)
end

return content
