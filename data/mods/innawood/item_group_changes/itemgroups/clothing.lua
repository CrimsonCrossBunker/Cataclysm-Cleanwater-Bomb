local content = require("ccb").content

do
    local group = content.ItemGroup { id = "large_bags", kind = "distribution" }
    group:item("backpack_leather", 28)
    group:item("wicker_backpack", 38)
    group:item("backpack_hiking", 3)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "small_bags", kind = "distribution" }
    group:item("purse", 40)
    group:item("backpack_leather", 8)
    content.replace(group)
end

do
    -- Protective clothing for motorbike riding.
    local group = content.ItemGroup { id = "clothing_biker", kind = "collection" }
    group:item("straw_hat")
    group:item("leathersandals", 80)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "grass_cloak" },
                    { item = "skirt_leather", probability = 80 },
                },
                probability = 40,
            },
        },
        probability = 80,
    }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "clothing_glasses", kind = "distribution" }
    group:item("null", 10)
    content.replace(group)
end

do
    -- Clothes that hunters take on hunting trips.
    local group = content.ItemGroup { id = "clothing_hunting", kind = "distribution" }
    group:item("hat_fur", 50)
    group:item("leathersandals", 75)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "pants_male", kind = "distribution" }
    group:item("pants_leather", 60)
    group:item("pants_fur", 5)
    group:item("hot_pants_fur", 5)
    group:item("hot_pants_leather", 25)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "pants_female", kind = "distribution" }
    group:group("pants_male", 200)
    group:item("skirt_leather", 5)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "shirts", kind = "distribution" }
    group:item("shirt_straw", 80)
    group:item("turtleneck", 10)
    group:item("poncho", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "jackets", kind = "distribution" }
    group:item("jacket_leather", 30)
    group:item("apron_leather", 1)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "hatstore_hats", kind = "distribution" }
    group:item("hat_knit", 10)
    group:item("hat_fur", 20)
    group:item("hat_newsboy", 10)
    group:item("hat_sombrero", 10)
    group:item("straw_hat")
    group:item("straw_fedora")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "common_gloves", kind = "distribution" }
    group:item("gloves_leather", 15)
    group:item("gloves_wool", 10)
    group:item("mittens", 5)
    content.replace(group)
end

do
    -- unisex scarfs and fabric coverings
    local group = content.ItemGroup { id = "scarfs_unisex", kind = "distribution" }
    group:item("scarf_fur_long", 10)
    group:item("scarf_fur", 20)
    content.replace(group)
end

do
    -- unisex shirts
    local group = content.ItemGroup { id = "shirts_unisex", kind = "distribution" }
    group:item("turtleneck", 10)
    group:item("wool_hoodie", 10)
    content.replace(group)
end

do
    -- womens shirts
    local group = content.ItemGroup { id = "shirts_womens", kind = "distribution" }
    group:item("chestwrap_leather", 30)
    content.replace(group)
end

do
    -- unisex coats, jackets, cloaks, etc.
    local group = content.ItemGroup { id = "coats_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "cloak_wool", probability = 10 },
            { item = "cloak_leather", probability = 20 },
            { item = "cloak_fur", probability = 10 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "duster_leather", probability = 60 },
            { item = "duster_fur", probability = 5 },
            { item = "sleeveless_duster_leather", probability = 50 },
            { item = "sleeveless_duster_fur", probability = 20 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "trenchcoat_leather", probability = 60 },
            { item = "trenchcoat_fur", probability = 5 },
            { item = "sleeveless_trenchcoat_leather", probability = 30 },
            { item = "sleeveless_trenchcoat_fur", probability = 10 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "peacoat", probability = 10 },
            { item = "greatcoat", probability = 10 },
            { item = "coat_fur", probability = 10 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { item = "jacket_leather", probability = 50 },
            { item = "poncho", probability = 10 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "vest_leather", probability = 20 },
        },
        probability = 40,
    }
    content.replace(group)
end

do
    -- unisex shoes (there are no men's only shoes)
    local group = content.ItemGroup { id = "shoes_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "straw_sandals", probability = 20 },
            { item = "leathersandals", probability = 35 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "mocassins", probability = 10 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "clogs", probability = 20 },
            { item = "geta", probability = 10 },
        },
        probability = 70,
    }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "female_underwear_top", kind = "distribution" }
    group:item("null", 50)
    group:item("bikini_top_leather", 7)
    group:item("bikini_top_fur", 5)
    group:item("chestwrap_fur", 20)
    group:item("chestwrap_leather", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "female_underwear_bottom", kind = "distribution" }
    group:item("null", 40)
    group:item("loincloth_leather", 30)
    group:item("loincloth_fur", 30)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "male_underwear_top", kind = "distribution" }
    group:item("null", 80)
    group:item("chestwrap_fur", 20)
    group:item("chestwrap_leather", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "male_underwear_bottom", kind = "distribution" }
    group:item("null", 40)
    group:item("loincloth_leather", 30)
    group:item("loincloth_fur", 30)
    content.replace(group)
end
