local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bionics_string_dimension_exodii_vault", kind = "distribution" }
    group:item("bio_eye_enhancer", 1)
    group:item("bio_dex_enhancer", 1)
    group:item("bio_str_enhancer", 1)
    group:item("bio_int_enhancer", 1)
    group:item("bio_blade", 1)
    group:item("bio_uncanny_dodge", 1)
    group:item("bio_nanobots", 1)
    group:item("bio_targeting", 1)
    group:item("bio_evap", 1)
    group:item("bio_water_extractor", 1)
    group:item("bio_recoil", 1)
    group:item("bio_speed", 1)
    group:item("bio_time_freeze", 1)
    group:item("bio_probability_travel", 1)
    content.add(group)
end
