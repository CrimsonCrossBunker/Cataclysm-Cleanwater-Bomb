local content = require("ccb").content

do
    -- women's personal accessories that do not contain the adult-specific ones
    local group = content.ItemGroup { id = "accesories_personal_womens_child", kind = "distribution" }
    group:item("hairpin", 90)
    group:item("fc_hairpin", 70)
    group:item("copper_hairpin", 60)
    group:item("silver_hairpin", 50)
    group:item("gold_hairpin", 30)
    group:item("platinum_hairpin", 10)
    group:item("barrette", 60)
    group:item("pearl_collar", 5)
    group:item("jade_brooch", 5)
    group:item("gold_anklet", 30)
    group:item("silver_anklet", 50)
    group:item("gold_toe_ring", 30)
    group:item("silver_toe_ring", 50)
    group:item("woven_anklet", 30)
    group:item("bat_anklet", 30)
    group:item("flower_anklet", 30)
    content.add(group)
end

do
    -- men's personal accessories
    local group = content.ItemGroup { id = "accesories_personal_mens", kind = "distribution" }
    group:item("tie_bow", 30)
    group:item("tie_clipon", 10)
    group:item("tie_necktie", 80)
    group:item("tieclip", 20)
    group:item("cufflinks", 20)
    group:item("cufflinks_intricate", 5)
    group:item("ring_signet", 30)
    group:item("tie_skinny", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "neckties", kind = "distribution" }
    group:item("tie_skinny", 40)
    group:item("tie_necktie", 40)
    group:item("tie_bow", 40)
    group:item("tie_clipon", 40)
    content.add(group)
end

do
    -- decorative earrings and miscellaneous ear accessories worn by people.
    local group = content.ItemGroup { id = "accessory_earring", kind = "distribution" }
    group:group("earrings_silver", 70)
    group:group("earrings_gold", 25)
    group:group("earrings_platinum", 5)
    content.add(group)
end

do
    -- decorative bracelets worn by people.
    local group = content.ItemGroup { id = "accessory_bracelet", kind = "distribution" }
    group:entry { item = "bead_bracelet", count = { 1, 2 }, probability = 80 }
    group:entry { item = "bracelet_friendship", count = { 1, 2 }, probability = 60 }
    group:entry { item = "copper_bracelet", count = { 1, 2 }, probability = 50 }
    group:entry { item = "silver_bracelet", count = { 1, 2 }, probability = 40 }
    group:entry { item = "gold_bracelet", count = { 1, 2 }, probability = 10 }
    group:item("platinum_bracelet", 10)
    content.add(group)
end

do
    -- decorative necklaces or neck accessories worn by people.
    local group = content.ItemGroup { id = "accessory_necklace", kind = "distribution" }
    group:entry { item = "bead_necklace", count = { 1, 2 }, probability = 80 }
    group:entry { item = "copper_necklace", count = { 1, 2 }, probability = 60 }
    group:entry { item = "silver_necklace", count = { 1, 2 }, probability = 40 }
    group:entry { item = "gold_necklace", count = { 1, 2 }, probability = 20 }
    group:entry { item = "platinum_necklace", count = { 1, 2 }, probability = 10 }
    group:entry { item = "copper_locket", count = { 1, 2 }, probability = 60 }
    group:entry { item = "silver_locket", count = { 1, 2 }, probability = 40 }
    group:entry { item = "gold_locket", count = { 1, 2 }, probability = 20 }
    group:entry { item = "platinum_locket", count = { 1, 2 }, probability = 10 }
    group:item("collarpin", 10)
    group:item("bronze_medal", 6)
    group:item("silver_medal", 4)
    group:item("gold_medal", 2)
    group:item("small_relic", 10)
    group:item("holy_symbol", 10)
    group:item("holy_symbol_wood", 10)
    content.add(group)
end

do
    -- accessories that some say were the cause of the Cataclysm.
    local group = content.ItemGroup { id = "accessory_cat", kind = "distribution" }
    group:item("faux_fur_cat_ears", 80)
    group:item("leather_cat_ears", 50)
    group:item("fur_cat_ears", 10)
    group:item("faux_fur_cat_tail", 80)
    group:item("leather_cat_tail", 50)
    group:item("fur_cat_tail", 10)
    group:item("faux_fur_collar", 80)
    group:item("leather_collar", 50)
    group:item("fur_collar", 10)
    content.add(group)
end

do
    -- clothing designed to hold a small weapon worn by people.
    local group = content.ItemGroup { id = "accessory_weaponcarry", kind = "distribution" }
    group:item("bootstrap", 20)
    group:item("bootsheath", 50)
    group:item("leg_sheath6", 1)
    group:item("gartersheath1", 40)
    group:item("gartersheath2", 10)
    group:item("sheath", 80)
    group:item("back_holster", 10)
    group:item("holster", 10)
    group:item("nylon_holster", 20)
    group:item("sholster", 10)
    group:item("shoulder_holster", 1)
    group:item("bholster", 10)
    group:item("bbholster", 8)
    content.add(group)
end

do
    -- assorted sportsgear worn by people.
    local group = content.ItemGroup { id = "accessory_sportsgear", kind = "distribution" }
    group:item("elbow_pads", 50)
    group:item("knee_pads", 50)
    group:item("iggaak", 5)
    group:item("goggles_swim", 10)
    group:item("glasses_bal", 10)
    group:item("eclipse_glasses", 5)
    group:item("goggles_ski", 10)
    content.add(group)
end

do
    -- tefillin sets
    local group = content.ItemGroup { id = "tefillin_sets", kind = "distribution" }
    group:group("tefillin_right_hand", 1)
    group:group("tefillin_left_hand", 1)
    content.add(group)
end

do
    -- tefillin sets
    local group = content.ItemGroup { id = "tefillin_right_hand", kind = "collection" }
    group:item("tefillin_hand_r")
    group:item("tefillin_head")
    content.add(group)
end

do
    -- tefillin sets
    local group = content.ItemGroup { id = "tefillin_left_hand", kind = "collection" }
    group:item("tefillin_hand_l")
    group:item("tefillin_head")
    content.add(group)
end

do
    -- unisex personal accessories that a kid could have on them
    local group = content.ItemGroup { id = "accesories_personal_unisex_child", kind = "collection" }
    group:group("clothing_glasses", 50)
    group:group("clothing_watch", 15)
    group:group("accessory_ring", 15)
    group:group("accessory_earring", 15)
    group:group("accessory_bracelet", 15)
    group:group("accessory_teeth", 2)
    group:group("accessory_necklace", 15)
    group:group("accessory_sportsgear", 5)
    group:item("folding_poncho", 5)
    group:item("leather_belt", 30)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 10 }
    group:item("binoculars", 2)
    group:item("whistle", 3)
    group:item("harmonica_holder", 1)
    group:group("costume_accessories", 1)
    group:group("costume_jewelry", 1)
    group:entry { group = "costume_accessories", event = "halloween", probability = 30 }
    group:entry { group = "costume_jewelry", event = "halloween", probability = 30 }
    content.add(group)
end
