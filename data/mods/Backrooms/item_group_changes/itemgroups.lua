local content = require("ccb").content

do
    local group = content.ItemGroup { id = "newspaper", kind = "distribution" }
    group:group("newspaper_recent", 500)
    group:group("newspaper_old", 500)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "vending_drink_items", kind = "distribution" }
    group:entry { item = "gasoline", container = "bottle_glass", probability = 25 }
    group:entry { item = "diesel", container = "bottle_glass", probability = 25 }
    group:entry { item = "lamp_oil", container = "bottle_glass", probability = 15 }
    group:entry { item = "motor_oil", container = "bottle_plastic", probability = 5 }
    content.extend_item_group(group)
end
