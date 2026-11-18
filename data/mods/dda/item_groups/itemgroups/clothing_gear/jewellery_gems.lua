local content = require("ccb").content

do
    local group = content.ItemGroup { id = "jewelry_safe", kind = "distribution" }
    group:entry { item = "platinum_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 80 }
    group:entry { item = "gold_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 80 }
    group:entry { item = "silver_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 85 }
    group:item("diamond", 75)
    group:item("diamond", 75)
    group:group("gemstones", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cufflinks_silver", kind = "distribution" }
    group:item("cufflinks", 50)
    group:item("cufflinks_intricate", 50)
    group:item("citrine_silver_cufflinks", 50)
    group:item("diamond_silver_cufflinks", 50)
    group:item("emerald_silver_cufflinks", 50)
    group:item("peridot_silver_cufflinks", 50)
    group:item("amethyst_silver_cufflinks", 50)
    group:item("sapphire_silver_cufflinks", 50)
    group:item("aquamarine_silver_cufflinks", 50)
    group:item("blue_topaz_silver_cufflinks", 50)
    group:item("tourmaline_silver_cufflinks", 50)
    group:item("alexandrite_silver_cufflinks", 50)
    group:item("pearl_silver_cufflinks", 50)
    group:item("onyx_silver_cufflinks", 50)
    group:item("opal_silver_cufflinks", 50)
    group:item("ruby_silver_cufflinks", 50)
    group:item("garnet_silver_cufflinks", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cufflinks_gold", kind = "distribution" }
    group:item("citrine_gold_cufflinks", 50)
    group:item("diamond_gold_cufflinks", 50)
    group:item("emerald_gold_cufflinks", 50)
    group:item("peridot_gold_cufflinks", 50)
    group:item("amethyst_gold_cufflinks", 50)
    group:item("sapphire_gold_cufflinks", 50)
    group:item("aquamarine_gold_cufflinks", 50)
    group:item("blue_topaz_gold_cufflinks", 50)
    group:item("tourmaline_gold_cufflinks", 50)
    group:item("alexandrite_gold_cufflinks", 50)
    group:item("pearl_gold_cufflinks", 50)
    group:item("onyx_gold_cufflinks", 50)
    group:item("opal_gold_cufflinks", 50)
    group:item("ruby_gold_cufflinks", 50)
    group:item("garnet_gold_cufflinks", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cufflinks_platinum", kind = "distribution" }
    group:item("citrine_platinum_cufflinks", 50)
    group:item("diamond_platinum_cufflinks", 50)
    group:item("emerald_platinum_cufflinks", 50)
    group:item("peridot_platinum_cufflinks", 50)
    group:item("amethyst_platinum_cufflinks", 50)
    group:item("sapphire_platinum_cufflinks", 50)
    group:item("aquamarine_platinum_cufflinks", 50)
    group:item("blue_topaz_platinum_cufflinks", 50)
    group:item("tourmaline_platinum_cufflinks", 50)
    group:item("alexandrite_platinum_cufflinks", 50)
    group:item("pearl_platinum_cufflinks", 50)
    group:item("onyx_platinum_cufflinks", 50)
    group:item("opal_platinum_cufflinks", 50)
    group:item("ruby_platinum_cufflinks", 50)
    group:item("garnet_platinum_cufflinks", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dental_grills", kind = "distribution" }
    group:item("gold_dental_grill", 50)
    group:item("platinum_dental_grill", 50)
    group:item("citrine_dental_grill", 50)
    group:item("diamond_dental_grill", 50)
    group:item("emerald_dental_grill", 50)
    group:item("peridot_dental_grill", 50)
    group:item("amethyst_dental_grill", 50)
    group:item("sapphire_dental_grill", 50)
    group:item("aquamarine_dental_grill", 50)
    group:item("blue_topaz_dental_grill", 50)
    group:item("tourmaline_dental_grill", 50)
    group:item("alexandrite_dental_grill", 50)
    group:item("ruby_dental_grill", 50)
    group:item("garnet_dental_grill", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tiaras_silver", kind = "distribution" }
    group:item("citrine_silver_tiara", 50)
    group:item("diamond_silver_tiara", 50)
    group:item("emerald_silver_tiara", 50)
    group:item("peridot_silver_tiara", 50)
    group:item("amethyst_silver_tiara", 50)
    group:item("sapphire_silver_tiara", 50)
    group:item("aquamarine_silver_tiara", 50)
    group:item("blue_topaz_silver_tiara", 50)
    group:item("tourmaline_silver_tiara", 50)
    group:item("alexandrite_silver_tiara", 50)
    group:item("pearl_silver_tiara", 50)
    group:item("onyx_silver_tiara", 50)
    group:item("opal_silver_tiara", 50)
    group:item("ruby_silver_tiara", 50)
    group:item("garnet_silver_tiara", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tiaras_gold", kind = "distribution" }
    group:item("citrine_gold_tiara", 50)
    group:item("diamond_gold_tiara", 50)
    group:item("emerald_gold_tiara", 50)
    group:item("peridot_gold_tiara", 50)
    group:item("amethyst_gold_tiara", 50)
    group:item("sapphire_gold_tiara", 50)
    group:item("aquamarine_gold_tiara", 50)
    group:item("blue_topaz_gold_tiara", 50)
    group:item("tourmaline_gold_tiara", 50)
    group:item("alexandrite_gold_tiara", 50)
    group:item("pearl_gold_tiara", 50)
    group:item("onyx_gold_tiara", 50)
    group:item("opal_gold_tiara", 50)
    group:item("ruby_gold_tiara", 50)
    group:item("garnet_gold_tiara", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tiaras_platinum", kind = "distribution" }
    group:item("citrine_platinum_tiara", 50)
    group:item("diamond_platinum_tiara", 50)
    group:item("emerald_platinum_tiara", 50)
    group:item("peridot_platinum_tiara", 50)
    group:item("amethyst_platinum_tiara", 50)
    group:item("sapphire_platinum_tiara", 50)
    group:item("aquamarine_platinum_tiara", 50)
    group:item("blue_topaz_platinum_tiara", 50)
    group:item("tourmaline_platinum_tiara", 50)
    group:item("alexandrite_platinum_tiara", 50)
    group:item("pearl_platinum_tiara", 50)
    group:item("onyx_platinum_tiara", 50)
    group:item("opal_platinum_tiara", 50)
    group:item("ruby_platinum_tiara", 50)
    group:item("garnet_platinum_tiara", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pendant_necklaces_silver", kind = "distribution" }
    group:item("silver_necklace", 50)
    group:item("citrine_silver_pendant_necklace", 50)
    group:item("diamond_silver_pendant_necklace", 50)
    group:item("emerald_silver_pendant_necklace", 50)
    group:item("peridot_silver_pendant_necklace", 50)
    group:item("amethyst_silver_pendant_necklace", 50)
    group:item("sapphire_silver_pendant_necklace", 50)
    group:item("aquamarine_silver_pendant_necklace", 50)
    group:item("blue_topaz_silver_pendant_necklace", 50)
    group:item("tourmaline_silver_pendant_necklace", 50)
    group:item("alexandrite_silver_pendant_necklace", 50)
    group:item("pearl_silver_pendant_necklace", 50)
    group:item("onyx_silver_pendant_necklace", 50)
    group:item("opal_silver_pendant_necklace", 50)
    group:item("ruby_silver_pendant_necklace", 50)
    group:item("garnet_silver_pendant_necklace", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pendant_necklaces_gold", kind = "distribution" }
    group:item("gold_necklace", 50)
    group:item("citrine_gold_pendant_necklace", 50)
    group:item("diamond_gold_pendant_necklace", 50)
    group:item("emerald_gold_pendant_necklace", 50)
    group:item("peridot_gold_pendant_necklace", 50)
    group:item("amethyst_gold_pendant_necklace", 50)
    group:item("sapphire_gold_pendant_necklace", 50)
    group:item("aquamarine_gold_pendant_necklace", 50)
    group:item("blue_topaz_gold_pendant_necklace", 50)
    group:item("tourmaline_gold_pendant_necklace", 50)
    group:item("alexandrite_gold_pendant_necklace", 50)
    group:item("pearl_gold_pendant_necklace", 50)
    group:item("onyx_gold_pendant_necklace", 50)
    group:item("opal_gold_pendant_necklace", 50)
    group:item("ruby_gold_pendant_necklace", 50)
    group:item("garnet_gold_pendant_necklace", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pendant_necklaces_platinum", kind = "distribution" }
    group:item("platinum_necklace", 50)
    group:item("citrine_platinum_pendant_necklace", 50)
    group:item("diamond_platinum_pendant_necklace", 50)
    group:item("emerald_platinum_pendant_necklace", 50)
    group:item("peridot_platinum_pendant_necklace", 50)
    group:item("amethyst_platinum_pendant_necklace", 50)
    group:item("sapphire_platinum_pendant_necklace", 50)
    group:item("aquamarine_platinum_pendant_necklace", 50)
    group:item("blue_topaz_platinum_pendant_necklace", 50)
    group:item("tourmaline_platinum_pendant_necklace", 50)
    group:item("alexandrite_platinum_pendant_necklace", 50)
    group:item("pearl_platinum_pendant_necklace", 50)
    group:item("onyx_platinum_pendant_necklace", 50)
    group:item("opal_platinum_pendant_necklace", 50)
    group:item("ruby_platinum_pendant_necklace", 50)
    group:item("garnet_platinum_pendant_necklace", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earrings_silver", kind = "distribution" }
    group:item("silver_ear", 50)
    group:item("citrine_silver_earring", 50)
    group:item("diamond_silver_earring", 50)
    group:item("emerald_silver_earring", 50)
    group:item("peridot_silver_earring", 50)
    group:item("amethyst_silver_earring", 50)
    group:item("sapphire_silver_earring", 50)
    group:item("aquamarine_silver_earring", 50)
    group:item("blue_topaz_silver_earring", 50)
    group:item("tourmaline_silver_earring", 50)
    group:item("alexandrite_silver_earring", 50)
    group:item("pearl_silver_earring", 50)
    group:item("onyx_silver_earring", 50)
    group:item("opal_silver_earring", 50)
    group:item("ruby_silver_earring", 50)
    group:item("garnet_silver_earring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earrings_gold", kind = "distribution" }
    group:item("gold_ear", 50)
    group:item("citrine_gold_earring", 50)
    group:item("diamond_gold_earring", 50)
    group:item("emerald_gold_earring", 50)
    group:item("peridot_gold_earring", 50)
    group:item("amethyst_gold_earring", 50)
    group:item("sapphire_gold_earring", 50)
    group:item("aquamarine_gold_earring", 50)
    group:item("blue_topaz_gold_earring", 50)
    group:item("tourmaline_gold_earring", 50)
    group:item("alexandrite_gold_earring", 50)
    group:item("pearl_gold_earring", 50)
    group:item("onyx_gold_earring", 50)
    group:item("opal_gold_earring", 50)
    group:item("ruby_gold_earring", 50)
    group:item("garnet_gold_earring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earrings_platinum", kind = "distribution" }
    group:item("platinum_ear", 50)
    group:item("citrine_platinum_earring", 50)
    group:item("diamond_platinum_earring", 50)
    group:item("emerald_platinum_earring", 50)
    group:item("peridot_platinum_earring", 50)
    group:item("amethyst_platinum_earring", 50)
    group:item("sapphire_platinum_earring", 50)
    group:item("aquamarine_platinum_earring", 50)
    group:item("blue_topaz_platinum_earring", 50)
    group:item("tourmaline_platinum_earring", 50)
    group:item("alexandrite_platinum_earring", 50)
    group:item("pearl_platinum_earring", 50)
    group:item("onyx_platinum_earring", 50)
    group:item("opal_platinum_earring", 50)
    group:item("ruby_platinum_earring", 50)
    group:item("garnet_platinum_earring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rings_silver", kind = "distribution" }
    group:item("silver_ring", 50)
    group:item("citrine_silver_ring", 50)
    group:item("diamond_silver_ring", 50)
    group:item("emerald_silver_ring", 50)
    group:item("peridot_silver_ring", 50)
    group:item("amethyst_silver_ring", 50)
    group:item("sapphire_silver_ring", 50)
    group:item("aquamarine_silver_ring", 50)
    group:item("blue_topaz_silver_ring", 50)
    group:item("tourmaline_silver_ring", 50)
    group:item("alexandrite_silver_ring", 50)
    group:item("pearl_silver_ring", 50)
    group:item("onyx_silver_ring", 50)
    group:item("opal_silver_ring", 50)
    group:item("ruby_silver_ring", 50)
    group:item("garnet_silver_ring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rings_gold", kind = "distribution" }
    group:item("gold_ring", 50)
    group:item("citrine_gold_ring", 50)
    group:item("diamond_ring", 50)
    group:item("emerald_gold_ring", 50)
    group:item("peridot_gold_ring", 50)
    group:item("amethyst_gold_ring", 50)
    group:item("sapphire_gold_ring", 50)
    group:item("aquamarine_gold_ring", 50)
    group:item("blue_topaz_gold_ring", 50)
    group:item("tourmaline_gold_ring", 50)
    group:item("alexandrite_gold_ring", 50)
    group:item("pearl_gold_ring", 50)
    group:item("onyx_gold_ring", 50)
    group:item("opal_gold_ring", 50)
    group:item("ruby_gold_ring", 50)
    group:item("garnet_gold_ring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rings_platinum", kind = "distribution" }
    group:item("platinum_ring", 50)
    group:item("citrine_platinum_ring", 50)
    group:item("diamond_platinum_ring", 50)
    group:item("emerald_platinum_ring", 50)
    group:item("peridot_platinum_ring", 50)
    group:item("amethyst_platinum_ring", 50)
    group:item("sapphire_platinum_ring", 50)
    group:item("aquamarine_platinum_ring", 50)
    group:item("blue_topaz_platinum_ring", 50)
    group:item("tourmaline_platinum_ring", 50)
    group:item("alexandrite_platinum_ring", 50)
    group:item("pearl_platinum_ring", 50)
    group:item("onyx_platinum_ring", 50)
    group:item("opal_platinum_ring", 50)
    group:item("ruby_platinum_ring", 50)
    group:item("garnet_platinum_ring", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bracelets_silver", kind = "distribution" }
    group:item("silver_bracelet", 50)
    group:item("citrine_silver_bracelet", 50)
    group:item("diamond_silver_bracelet", 50)
    group:item("emerald_silver_bracelet", 50)
    group:item("peridot_silver_bracelet", 50)
    group:item("amethyst_silver_bracelet", 50)
    group:item("sapphire_silver_bracelet", 50)
    group:item("aquamarine_silver_bracelet", 50)
    group:item("blue_topaz_silver_bracelet", 50)
    group:item("tourmaline_silver_bracelet", 50)
    group:item("alexandrite_silver_bracelet", 50)
    group:item("pearl_silver_bracelet", 50)
    group:item("onyx_silver_bracelet", 50)
    group:item("opal_silver_bracelet", 50)
    group:item("ruby_silver_bracelet", 50)
    group:item("garnet_silver_bracelet", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bracelets_gold", kind = "distribution" }
    group:item("gold_bracelet", 50)
    group:item("citrine_gold_bracelet", 50)
    group:item("diamond_gold_bracelet", 50)
    group:item("emerald_gold_bracelet", 50)
    group:item("peridot_gold_bracelet", 50)
    group:item("amethyst_gold_bracelet", 50)
    group:item("sapphire_gold_bracelet", 50)
    group:item("aquamarine_gold_bracelet", 50)
    group:item("blue_topaz_gold_bracelet", 50)
    group:item("tourmaline_gold_bracelet", 50)
    group:item("alexandrite_gold_bracelet", 50)
    group:item("pearl_gold_bracelet", 50)
    group:item("onyx_gold_bracelet", 50)
    group:item("opal_gold_bracelet", 50)
    group:item("ruby_gold_bracelet", 50)
    group:item("garnet_gold_bracelet", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bracelets_platinum", kind = "distribution" }
    group:item("platinum_bracelet", 50)
    group:item("citrine_platinum_bracelet", 50)
    group:item("diamond_platinum_bracelet", 50)
    group:item("emerald_platinum_bracelet", 50)
    group:item("peridot_platinum_bracelet", 50)
    group:item("amethyst_platinum_bracelet", 50)
    group:item("sapphire_platinum_bracelet", 50)
    group:item("aquamarine_platinum_bracelet", 50)
    group:item("blue_topaz_platinum_bracelet", 50)
    group:item("tourmaline_platinum_bracelet", 50)
    group:item("alexandrite_platinum_bracelet", 50)
    group:item("pearl_platinum_bracelet", 50)
    group:item("onyx_platinum_bracelet", 50)
    group:item("opal_platinum_bracelet", 50)
    group:item("ruby_platinum_bracelet", 50)
    group:item("garnet_platinum_bracelet", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gemstones", kind = "distribution" }
    group:item("citrine", 50)
    group:item("diamond")
    group:item("emerald", 50)
    group:item("peridot", 50)
    group:item("amethyst", 50)
    group:item("sapphire", 50)
    group:item("aquamarine", 50)
    group:item("blue_topaz", 50)
    group:item("tourmaline", 50)
    group:item("alexandrite", 50)
    group:item("malachite", 50)
    group:item("pearl")
    group:item("onyx", 50)
    group:item("opal", 50)
    group:item("ruby", 50)
    group:item("garnet", 50)
    content.add(group)
end
