local content = require("ccb").content

do
    local group = content.ItemGroup { id = "any_soda", kind = "distribution" }
    group:item("cola", 60)
    group:item("colamdew", 55)
    group:item("creamsoda", 50)
    group:item("lemonlime", 50)
    group:item("orangesoda", 50)
    group:item("rootbeer", 45)
    group:item("crispycran", 40)
    group:item("purple_drink", 35)
    group:item("zerocola", 35)
    group:item("zeroorange", 35)
    group:item("zerotropical", 35)
    group:item("zeromdew", 35)
    group:item("foodplace_zero_drink", 10)
    group:item("choc_drink", 25)
    group:item("sparkling", 20)
    group:item("sparkling_peach", 20)
    group:item("sparkling_pomegranate", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soda_in_container_full", kind = "distribution" }
    group:entry { group = "any_soda", container = "bottle_twoliter" }
    group:entry { group = "any_soda", container = "bottle_plastic" }
    group:entry { group = "any_soda", container = "bottle_plastic_355ml" }
    group:entry { group = "any_soda", container = "can_drink" }
    group:entry { group = "any_soda", container = "can_aluminum_250ml" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soda_in_small_container_full", kind = "distribution" }
    group:entry { group = "any_soda", container = "bottle_plastic_355ml" }
    group:entry { group = "any_soda", container = "can_drink" }
    group:entry { group = "any_soda", container = "can_aluminum_250ml" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kvass_bottle", kind = "distribution" }
    group:entry { item = "kvass", container = "bottle_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soda_in_container", kind = "distribution" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "bottle_twoliter" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "bottle_plastic" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "bottle_plastic_355ml" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "can_drink" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "can_aluminum_250ml" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soda_in_small_container", kind = "distribution" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "bottle_plastic_355ml" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "can_drink" }
    group:entry { group = "any_soda", charges = { 1, -1 }, container = "can_aluminum_250ml" }
    content.add(group)
end
