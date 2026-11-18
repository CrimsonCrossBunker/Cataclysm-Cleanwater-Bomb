local content = require("ccb").content

do
    local group = content.ItemGroup { id = "robofac_basic_trade", kind = "distribution" }
    group:group("textbooks")
    group:group("electronics")
    group:group("science")
    group:group("robofac_basic_robots")
    group:group("robofac_id_cards")
    group:group("robofac_basic_grenades")
    group:group("cop_armory")
    group:group("ammo_any_batteries_full")
    group:entry { item = "jumpsuit", count = { 10, 10 }, variant = "robofac" }
    content.add(group)
end
