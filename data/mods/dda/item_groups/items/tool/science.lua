local content = require("ccb").content

do
    local group = content.ItemGroup { id = "toy_makerspace_kit", kind = "collection", container = "maker_kit_box" }
    group:item("engineering_makerspace_kit")
    group:entry { item = "bubblewrap", count = { 2, 2 } }
    group:item("manual_makerspace")
    group:item("screwdriver")
    group:item("wrench_small")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toy_robot_kit", kind = "collection", container = "robot_kit_box" }
    group:item("engineering_robotics_kit")
    group:entry { item = "bubblewrap", count = { 2, 2 } }
    group:item("manual_robotics_kit")
    group:item("screwdriver")
    group:item("wrench_small")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toy_engine_kit", kind = "collection", container = "stirling_kit_box" }
    group:item("engineering_engine_kit")
    group:entry { item = "bubblewrap", count = { 2, 2 } }
    group:item("manual_engine_kit")
    group:item("screwdriver")
    group:item("wrench_small")
    content.add(group)
end
