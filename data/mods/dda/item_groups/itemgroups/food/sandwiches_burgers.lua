local content = require("ccb").content

do
    local group = content.ItemGroup { id = "sandwiches", kind = "distribution" }
    group:item("sandwich_cucumber", 15)
    group:group("sandwich_deluxe_wrapper_2", 10)
    group:group("sandwich_reuben_wrapper_2", 15)
    group:item("sandwich_veggy", 30)
    group:group("sandwich_t_wrapper_2", 30)
    group:item("sandwich_pb", 1)
    group:item("sandwich_pbf", 1)
    group:item("sandwich_pbj", 1)
    group:item("sandwich_pbh", 1)
    group:item("sandwich_pbm", 1)
    group:item("fish_sandwich", 15)
    group:item("sandwich_jam_butter", 5)
    group:item("sandwich_jam", 5)
    group:item("sandwich_cheese", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toast_bag_plastic_2", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "toast", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "PBJ_Toast_bag_plastic_2", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "PBJ_Toast", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "blt_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "blt", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandwich_t_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "sandwich_t", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandwich_deluxe_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "sandwich_deluxe", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandwich_reuben_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "sandwich_reuben", count = { 2, 2 }, container = "null" }
    content.add(group)
end
