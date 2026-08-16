local content = {}

function content.register(ccb)
    local emission = ccb.content.Emission {
        id = "emit_lua_first_purifying_mist",
        field = "fd_smoke",
        intensity = 1,
        quantity = 4,
        chance = 50,
    }
    emission:profile("lua_first_dynamic_mist_profile")
    ccb.content.add(emission)
end

return content
