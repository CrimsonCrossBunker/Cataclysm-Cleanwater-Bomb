local content = require("ccb").content

do
    local group = content.ItemGroup { id = "military_squad_guns", kind = "distribution" }
    group:group("military_standard_assault_rifles", 80)
    group:group("military_standard_lmgs", 10)
    group:group("military_standard_sniper_rifles", 5)
    group:group("military_standard_shotguns", 5)
    content.add(group)
end
