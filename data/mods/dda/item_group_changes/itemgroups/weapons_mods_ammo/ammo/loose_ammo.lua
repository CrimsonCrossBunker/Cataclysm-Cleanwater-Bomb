local content = require("ccb").content

do
    local group = content.ItemGroup { id = "9mm_loose", kind = "distribution" }
    group:entry { item = "9mm", charges = { 1, 10 } }
    group:entry { item = "9mmfmj", charges = { 1, 10 }, probability = 80 }
    group:entry { item = "9mmP", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "9mmP2", charges = { 1, 5 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "223_loose", kind = "distribution" }
    group:entry { item = "223", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "556", charges = { 1, 10 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "45_loose", kind = "distribution" }
    group:entry { item = "45_acp", charges = { 1, 10 }, probability = 80 }
    group:entry { item = "45_jhp", charges = { 1, 10 }, probability = 80 }
    group:entry { item = "45_super", charges = { 1, 10 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "40_loose", kind = "distribution" }
    group:entry { item = "40fmj", charges = { 1, 10 }, probability = 60 }
    group:entry { item = "40sw", charges = { 1, 10 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "762_loose", kind = "distribution" }
    group:entry { item = "762_m87", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "762_jhp", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "357_loose", kind = "distribution" }
    group:entry { item = "357mag_fmj", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "357mag_jhp", charges = { 1, 10 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_loose", kind = "distribution" }
    group:entry { item = "shot_00", charges = { 1, 10 }, probability = 2 }
    group:entry { item = "shot_bird", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "shot_slug", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "38_loose", kind = "distribution" }
    group:entry { item = "38_fmj", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "38_special", charges = { 1, 10 }, probability = 12 }
    group:entry { item = "38_special_p", charges = { 1, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "44_loose", kind = "distribution" }
    group:entry { item = "44magnum", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "44fmj", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "3006_loose", kind = "distribution" }
    group:entry { item = "3006", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "3006_jsp", charges = { 1, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "45colt_loose", kind = "distribution" }
    group:entry { item = "45colt_jhp", charges = { 1, 10 } }
    group:entry { item = "45colt_cowboy", charges = { 1, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "410_loose", kind = "distribution" }
    group:entry { item = "410shot_000", charges = { 1, 10 }, probability = 2 }
    group:entry { item = "410shot_bird", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "410shot_slug", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "10mm_loose", kind = "distribution" }
    group:entry { item = "10mm_fmj", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "10mm_jhp", charges = { 1, 10 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "303_loose", kind = "distribution" }
    group:entry { item = "303_sp", charges = { 1, 10 }, probability = 3 }
    group:entry { item = "303_fmjbt", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "30carbine_loose", kind = "distribution" }
    group:entry { item = "30carbine_jsp", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "30carbine", charges = { 1, 10 }, probability = 4 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "38super_loose", kind = "distribution" }
    group:entry { item = "38_super", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "38super_fmj", charges = { 1, 10 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "4570_loose", kind = "distribution" }
    group:entry { item = "4570_sp", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "4570_low", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "4570_pen", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "50beowulf_loose", kind = "distribution" }
    group:entry { item = "50beowulf_xtp", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "50beowulf_penetrator", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "50AE_loose", kind = "distribution" }
    group:entry { item = "50ae_jhp", charges = { 1, 10 }, probability = 4 }
    group:entry { item = "50ae_fmj", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end
