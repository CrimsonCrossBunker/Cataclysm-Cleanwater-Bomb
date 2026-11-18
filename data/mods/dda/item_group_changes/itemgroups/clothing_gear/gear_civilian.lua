local content = require("ccb").content

do
    local group = content.ItemGroup { id = "child_items", kind = "distribution" }
    group:group("child_items_pockets", 1634)
    group:item("bat", 40)
    group:item("bat_nerf", 20)
    group:item("bat_metal", 20)
    group:item("hockey_stick", 10)
    group:group("toy_radio_car", 1)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:item("air_launcher", 1)
    group:item("mouthpiece", 3)
    group:item("basketball", 8)
    group:item("beach_volleyball", 8)
    group:item("indoor_volleyball", 8)
    group:item("football", 8)
    group:item("slingshot", 10)
    group:item("frisbee", 10)
    group:item("dnd_handbook", 1)
    group:item("balloon", 5)
    group:item("milkshake_fastfood", 3)
    group:group("butterfly_net_any", 5)
    content.upsert_item_group(group)
end
