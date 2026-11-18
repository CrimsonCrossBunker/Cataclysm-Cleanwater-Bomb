local content = require("ccb").content

do
    local group = content.ItemGroup { id = "380_loose", kind = "distribution" }
    group:entry { item = "380_FMJ", charges = { 1, 10 }, probability = 60 }
    group:entry { item = "380_JHP", charges = { 1, 10 }, probability = 80 }
    group:entry { item = "380_p", charges = { 1, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "308_loose", kind = "distribution" }
    group:entry { item = "308", charges = { 1, 10 }, probability = 7 }
    group:entry { item = "762_51", charges = { 1, 10 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_loose", kind = "distribution" }
    group:entry { item = "20shot_buck", charges = { 1, 10 }, probability = 2 }
    group:entry { item = "20shot_bird", charges = { 1, 10 }, probability = 10 }
    group:entry { item = "20shot_slug", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "32_loose", kind = "distribution" }
    group:entry { item = "32_acp", charges = { 1, 10 }, probability = 4 }
    group:entry { item = "32_acp_jhp", charges = { 1, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "357sig_loose", kind = "distribution" }
    group:entry { item = "357sig_jhp", charges = { 1, 10 }, probability = 1 }
    group:entry { item = "357sig_fmj", charges = { 1, 10 }, probability = 7 }
    content.add(group)
end
