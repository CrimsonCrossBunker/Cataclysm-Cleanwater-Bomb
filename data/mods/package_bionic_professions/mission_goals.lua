local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function has_bionic(character, bionic)
    return services.bionics.has(character, id("bionic", bionic)).value
end

local faulty_bionics = {
    "bio_ankles", "bio_deformity", "bio_dis_acid", "bio_dis_shock",
    "bio_drain", "bio_glowy", "bio_itchy", "bio_leaky",
    "bio_noise", "bio_nostril", "bio_pokedeye", "bio_power_weakness",
    "bio_shakes", "bio_sleepy", "bio_spasm", "bio_stiff",
    "bio_thumbs", "bio_trip", "bio_voice", "bio_faulty_electromagnetic_leak",
    "bio_faulty_grossfood", "bio_radleak", "bio_sleep_shutdown",
}

ccb.runtime.handler("complete_mission_bionics_faulty", function(context)
    for _, bionic in ipairs(faulty_bionics) do
        if has_bionic(context.speaker, bionic) then return false end
    end
    return true
end)

ccb.runtime.handler("morale_mission_bionics_faulty", function(context)
    local day = services.time.duration(1, "day")
    services.morale.add(context.character, id("morale", "morale_feeling_good"),
        50, 50, { duration = day, decay_start = day })
end)
