local content = require("ccb").content

do
    local group = content.ItemGroup { id = "homeless_broker_sell", kind = "distribution" }
    group:group("shoes", 80)
    group:group("harddrugs", 70)
    group:group("preserved_food", 90)
    group:group("dry_goods", 90)
    group:group("pet_food_in_container", 90)
    group:group("SUS_pantry", 90)
    group:group("foodintincan", 90)
    group:group("cannedfood", 90)
    group:group("big_canned_food", 90)
    group:group("produce", 80)
    group:group("snacks", 80)
    group:group("fast_food", 80)
    group:group("hardware_books", 80)
    group:group("homebooks", 80)
    group:group("manuals", 80)
    group:group("textbooks", 80)
    group:group("newspaper", 80)
    group:group("tools_common", 80)
    group:group("tools_workshop", 80)
    group:group("tools_general", 80)
    group:group("full_1st_aid", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NPC_homeless_worn", kind = "collection" }
    group:item("loincloth")
    group:item("footrags")
    group:item("gloves_wraps")
    group:item("tunic")
    group:item("bigback")
    group:item("duffelbag")
    group:item("leather_belt")
    group:item("jacket_leather")
    group:item("pants_leather")
    group:item("boots")
    content.add(group)
end
