local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wall_bash_results", kind = "collection" }
    group:entry { item = "rock", count = { 0, 2 } }
    group:entry { item = "wood_panel", count = { 0, 1 } }
    group:entry { item = "nail", charges = { 4, 16 } }
    group:entry { item = "splinter", count = { 1, 5 } }
    group:entry { item = "2x4", count = { 1, 2 }, probability = 25 }
    group:entry { item = "pipe", count = { 0, 2 }, probability = 10 }
    group:entry { item = "cu_pipe", count = { 0, 2 }, probability = 10 }
    group:entry { item = "cable", count = { 0, 67 }, probability = 10 }
    content.add(group)
end
