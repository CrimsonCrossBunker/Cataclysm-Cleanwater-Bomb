local content = require("ccb").content

do
    local group = content.ItemGroup { id = "sugar_various", kind = "distribution" }
    group:group("sugar_bottle_plastic_small", 18)
    group:group("sugar_bottle_glass_small", 18)
    group:group("sugar_bottle_plastic", 2)
    group:group("sugar_pound", 2)
    group:group("sugar_bottle_glass", 2)
    group:group("sugar_bag_plastic", 4)
    group:group("sugar_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_various_full", kind = "distribution" }
    group:group("sugar_bottle_plastic_small_full", 10)
    group:group("sugar_bottle_glass_small_full", 10)
    group:group("sugar_bottle_plastic_full", 4)
    group:group("sugar_bottle_glass_full", 4)
    group:group("sugar_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bulk", kind = "distribution" }
    group:group("sugar_bottle_plastic", 20)
    group:group("sugar_bottle_glass", 20)
    group:group("sugar_bag_plastic", 5)
    group:group("sugar_bag_paper", 42)
    group:group("sugar_bag_paper_bulk", 16)
    group:group("sugar_bag_paper_50lb", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_jar_glass_sealed_10_140",
        kind = "collection",
        container = "jar_glass_sealed",
        overflow = "spill",
    }
    group:entry { item = "sugar", count = { 10, 140 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "sugar", count = { 40, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "sugar", count = { 40, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "sugar", count = { 80, 80 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bottle_glass_full", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "sugar", count = { 80, 80 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "sugar", count = { 400, 400 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "sugar", count = { 5, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sugar_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "sugar", count = { 5, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bottle_plastic", kind = "collection", container = "bottle_plastic_seasoning" }
    group:entry { item = "sugar", count = { 10, 80 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "sugar", count = { 10, 80 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "sugar", count = { 10, 80 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_50", kind = "collection", container = "bag_plastic" }
    group:entry { item = "sugar", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "sugar", count = { 25, 400 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "sugar", count = { 30, 1600 }, container = "null" }
    content.add(group)
end

do
    -- one pound of sugar in a paper bag.
    local group = content.ItemGroup { id = "sugar_pound", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "sugar", count = { 71, 71 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_bag_paper_50lb", kind = "collection", container = "bag_paper_powder_50lb" }
    group:entry { item = "sugar", count = { 121, 4700 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "artificial_sweetener_box_small_71", kind = "collection", container = "box_small" }
    group:entry { item = "artificial_sweetener", count = { 71, 71 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_various", kind = "distribution" }
    group:group("salt_bottle_plastic_small", 18)
    group:group("salt_bottle_glass_small", 18)
    group:group("salt_bottle_plastic", 2)
    group:group("salt_bottle_glass", 2)
    group:group("salt_bag_plastic", 4)
    group:group("salt_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_various_full", kind = "distribution" }
    group:group("salt_bottle_plastic_small_full", 10)
    group:group("salt_bottle_glass_small_full", 10)
    group:group("salt_bottle_plastic_full", 4)
    group:group("salt_bottle_glass_full", 4)
    group:group("salt_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bulk", kind = "distribution" }
    group:group("salt_bottle_plastic", 20)
    group:group("salt_bottle_glass", 20)
    group:group("salt_bag_plastic", 5)
    group:group("salt_bag_paper", 17)
    group:group("salt_bag_paper_bulk", 9)
    group:group("salt_bag_paper_50lb", 3)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "salt_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "salt", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "salt_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "salt", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "salt_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "salt", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bottle_glass_full", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "salt", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "salt", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "salt_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "salt", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "salt_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "salt", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bottle_plastic", kind = "collection", container = "bottle_plastic_seasoning" }
    group:entry { item = "salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "salt", count = { 25, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "salt", count = { 25, 2000 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salt_bag_paper_50lb", kind = "collection", container = "bag_paper_powder_50lb" }
    group:entry { item = "salt", count = { 125, 6480 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_various", kind = "distribution" }
    group:group("seasoning_salt_bottle_plastic_small", 18)
    group:group("seasoning_salt_bottle_glass_small", 18)
    group:group("seasoning_salt_bottle_plastic", 6)
    group:group("seasoning_salt_bottle_glass", 6)
    group:group("seasoning_salt_bag_plastic", 2)
    group:group("seasoning_salt_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_various_full", kind = "distribution" }
    group:group("seasoning_salt_bottle_plastic_small_full", 10)
    group:group("seasoning_salt_bottle_glass_small_full", 10)
    group:group("seasoning_salt_bottle_plastic_full", 4)
    group:group("seasoning_salt_bottle_glass_full", 4)
    group:group("seasoning_salt_bag_plastic_full", 1)
    group:group("seasoning_salt_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_bulk", kind = "distribution" }
    group:group("seasoning_salt_bottle_plastic", 20)
    group:group("seasoning_salt_bottle_glass", 20)
    group:group("seasoning_salt_bag_plastic", 5)
    group:group("seasoning_salt_bag_paper", 10)
    group:group("seasoning_salt_bag_paper_bulk", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "seasoning_salt", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "seasoning_salt", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "seasoning_salt", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_glass_full",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "seasoning_salt", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "seasoning_salt", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "seasoning_salt", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "seasoning_salt", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "seasoning_salt", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "seasoning_salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bottle_glass",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "seasoning_salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "seasoning_salt", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_salt_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "seasoning_salt", count = { 20, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_salt_bag_paper_bulk",
        kind = "collection",
        container = "bag_paper_powder_bulk",
    }
    group:entry { item = "seasoning_salt", count = { 30, 2000 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_italian_various", kind = "distribution" }
    group:group("seasoning_italian_bottle_plastic_small", 18)
    group:group("seasoning_italian_bottle_glass_small", 18)
    group:group("seasoning_italian_bottle_plastic", 6)
    group:group("seasoning_italian_bottle_glass", 6)
    group:group("seasoning_italian_bag_plastic", 2)
    group:group("seasoning_italian_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_italian_various_full", kind = "distribution" }
    group:group("seasoning_italian_bottle_plastic_small_full", 10)
    group:group("seasoning_italian_bottle_glass_small_full", 10)
    group:group("seasoning_italian_bottle_plastic_full", 4)
    group:group("seasoning_italian_bottle_glass_full", 4)
    group:group("seasoning_italian_bag_paper_full", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_italian_bulk", kind = "distribution" }
    group:group("seasoning_italian_bottle_plastic", 20)
    group:group("seasoning_italian_bottle_glass", 20)
    group:group("seasoning_italian_bag_plastic", 5)
    group:group("seasoning_italian_bag_paper", 10)
    group:group("seasoning_italian_bag_paper_bulk", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "seasoning_italian", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "seasoning_italian", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "seasoning_italian", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_glass_full",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "seasoning_italian", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bag_paper_full",
        kind = "collection",
        container = "bag_paper_powder",
    }
    group:entry { item = "seasoning_italian", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "seasoning_italian", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "seasoning_italian", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "seasoning_italian", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bottle_glass",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "seasoning_italian", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_italian_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "seasoning_italian", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seasoning_italian_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "seasoning_italian", count = { 20, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "seasoning_italian_bag_paper_bulk",
        kind = "collection",
        container = "bag_paper_powder_bulk",
    }
    group:entry { item = "seasoning_italian", count = { 30, 2000 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "curry_powder_various", kind = "distribution" }
    group:group("curry_powder_bottle_plastic_small", 18)
    group:group("curry_powder_bottle_glass_small", 18)
    group:group("curry_powder_bottle_plastic", 2)
    group:group("curry_powder_bottle_glass", 2)
    group:group("curry_powder_bag_plastic", 4)
    group:group("curry_powder_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "curry_powder_various_full", kind = "distribution" }
    group:group("curry_powder_bottle_plastic_small_full", 10)
    group:group("curry_powder_bottle_glass_small_full", 10)
    group:group("curry_powder_bottle_plastic_full", 4)
    group:group("curry_powder_bottle_glass_full", 4)
    group:group("curry_powder_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "curry_powder", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "curry_powder", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "curry_powder", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_glass_full",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "curry_powder", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "curry_powder_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "curry_powder", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "curry_powder", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "curry_powder", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "curry_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "curry_powder_bottle_glass",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "curry_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "curry_powder_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "curry_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "curry_powder_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "curry_powder", count = { 25, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_various", kind = "distribution" }
    group:group("pepper_bottle_plastic_small", 18)
    group:group("pepper_bottle_glass_small", 18)
    group:group("pepper_bottle_plastic", 6)
    group:group("pepper_bottle_glass", 6)
    group:group("pepper_bag_plastic", 2)
    group:group("pepper_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_various_full", kind = "distribution" }
    group:group("pepper_bottle_plastic_small_full", 10)
    group:group("pepper_bottle_glass_small_full", 10)
    group:group("pepper_bottle_plastic_full", 4)
    group:group("pepper_bottle_glass_full", 4)
    group:group("pepper_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bulk", kind = "distribution" }
    group:group("pepper_bottle_plastic", 20)
    group:group("pepper_bottle_glass", 20)
    group:group("pepper_bag_plastic", 5)
    group:group("pepper_bag_paper", 10)
    group:group("pepper_bag_paper_bulk", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pepper_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "pepper", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pepper_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "pepper", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bottle_glass_full", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "pepper", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "pepper", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pepper_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "pepper", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pepper_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "pepper", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bottle_plastic", kind = "collection", container = "bottle_plastic_seasoning" }
    group:entry { item = "pepper", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "pepper", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "pepper", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "pepper", count = { 20, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pepper_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "pepper", count = { 30, 2000 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilly-p_various", kind = "distribution" }
    group:group("chilly-p_bottle_plastic_small", 18)
    group:group("chilly-p_bottle_glass_small", 18)
    group:group("chilly-p_bottle_plastic", 2)
    group:group("chilly-p_bottle_glass", 2)
    group:group("chilly-p_bag_plastic", 4)
    group:group("chilly-p_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chilly_p_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "chilly-p", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chilly-p_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "chilly-p", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chilly-p_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "chilly-p", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chilly-p_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "chilly-p", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilly-p_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "chilly-p", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilly-p_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "chilly-p", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilly-p_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "chilly-p", count = { 25, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "garlic_powder_various", kind = "distribution" }
    group:group("garlic_powder_bottle_plastic_small", 18)
    group:group("garlic_powder_bottle_glass_small", 18)
    group:group("garlic_powder_bottle_plastic", 2)
    group:group("garlic_powder_bottle_glass", 2)
    group:group("garlic_powder_bag_plastic", 4)
    group:group("garlic_powder_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "garlic_powder_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "garlic_powder", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "garlic_powder_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "garlic_powder", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "garlic_powder_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "garlic_powder", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "garlic_powder_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "garlic_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "garlic_powder_bottle_glass",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "garlic_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "garlic_powder_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "garlic_powder", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "garlic_powder_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "garlic_powder", count = { 25, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_various", kind = "distribution" }
    group:group("cinnamon_bottle_plastic_small", 18)
    group:group("cinnamon_bottle_glass_small", 18)
    group:group("cinnamon_bottle_plastic", 2)
    group:group("cinnamon_bottle_glass", 2)
    group:group("cinnamon_bag_plastic", 4)
    group:group("cinnamon_bag_paper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_various_full", kind = "distribution" }
    group:group("cinnamon_bottle_plastic_small_full", 10)
    group:group("cinnamon_bottle_glass_small_full", 10)
    group:group("cinnamon_bottle_plastic_full", 4)
    group:group("cinnamon_bottle_glass_full", 4)
    group:group("cinnamon_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "cinnamon", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "cinnamon", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "cinnamon", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_glass_full",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "cinnamon", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "cinnamon", count = { 500, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "cinnamon", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "cinnamon", count = { 10, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cinnamon_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "cinnamon", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "cinnamon", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cinnamon", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cinnamon_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "cinnamon", count = { 25, 500 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sprinkles_bottle_plastic_small_62",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "sprinkles", count = { 62, 62 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "thyme_bowl_plastic_full", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "thyme", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mustard_powder_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "mustard_powder", count = { 50, 50 }, container = "null" }
    content.add(group)
end
