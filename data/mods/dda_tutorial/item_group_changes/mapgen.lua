local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fully_loaded_lighter", kind = "distribution" }
    group:entry { item = "lighter", charges = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "paint_tutorial", kind = "collection" }
    group:entry { item = "paint_red", container_group = "paintcans" }
    group:entry { item = "paint_blue", container_group = "paintcans" }
    group:entry { item = "paint_yellow", container_group = "paintcans" }
    group:entry { item = "paint_green", container_group = "paintcans" }
    group:entry { item = "paint_purple", container_group = "paintcans" }
    group:entry { item = "paint_orange", container_group = "paintcans" }
    group:entry { item = "paint_pink", container_group = "paintcans" }
    group:entry { item = "paint_cyan", container_group = "paintcans" }
    group:entry { item = "paint_brown", container_group = "paintcans" }
    group:entry { item = "paint_white", container_group = "paintcans" }
    group:entry { item = "paint_black", container_group = "paintcans" }
    group:entry { item = "paint_gray", container_group = "paintcans" }
    content.add(group)
end
