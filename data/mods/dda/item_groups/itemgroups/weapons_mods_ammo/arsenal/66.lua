local content = require("ccb").content

do
    -- have no idea how they contained due the lack of documentation, so left them as it is
    local group = content.ItemGroup { id = "milspec_arsenal_66_gun&mags", kind = "collection" }
    group:entry { item = "LAW_Packed", count = { 1, 3 }, probability = 60 }
    group:entry { item = "m202_flash", count = { 1, 1 }, charges = { 4, 4 }, probability = 25 }
    content.add(group)
end
