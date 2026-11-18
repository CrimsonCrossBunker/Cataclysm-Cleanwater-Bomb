local content = require("ccb").content

do
    local group = content.ItemGroup { id = "boxed_primers_full", kind = "distribution", container = "primer_tray" }
    group:entry { item = "smpistol_primer", charges = { 100, 100 }, probability = 250 }
    group:entry { item = "lgpistol_primer", charges = { 100, 100 }, probability = 150 }
    group:entry { item = "smrifle_primer", charges = { 100, 100 }, probability = 250 }
    group:entry { item = "lgrifle_primer", charges = { 100, 100 }, probability = 200 }
    group:entry { item = "shotgun_primer", charges = { 100, 100 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_primers_used", kind = "distribution", container = "primer_tray" }
    group:entry { item = "smpistol_primer", charges = { 0, 100 }, probability = 250 }
    group:entry { item = "lgpistol_primer", charges = { 0, 100 }, probability = 150 }
    group:entry { item = "smrifle_primer", charges = { 0, 100 }, probability = 250 }
    group:entry { item = "lgrifle_primer", charges = { 0, 100 }, probability = 200 }
    group:entry { item = "shotgun_primer", charges = { 0, 100 }, probability = 50 }
    content.add(group)
end
