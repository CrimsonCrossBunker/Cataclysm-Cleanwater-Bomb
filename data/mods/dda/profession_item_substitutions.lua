local ccb = require("ccb")
local content = ccb.content

-- Native profession item substitutions
do
local definition = content.ProfessionItemSubstitution { item = "blazer" }
definition:when({ present = { "WOOLALLERGY" } }, { "jacket_leather" })
definition:when({ present = { "VEGAN" } }, { "jacket_light" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "hat_hunting" }
definition:when({ present = { "WOOLALLERGY", "VEGAN" } }, { "hat_cotton" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "hat_newsboy" }
definition:when({ present = { "WOOLALLERGY", "VEGAN" } }, { "hat_cotton" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "peacoat" }
definition:when({ present = { "WOOLALLERGY", "VEGAN" } }, { "jacket_flannel" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "sweater" }
definition:when({ present = { "WOOLALLERGY", "VEGAN" } }, { "sweatshirt" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "boots_winter" }
definition:when({ present = { "WOOLALLERGY" } }, { "boots_fur" })
definition:when({ present = { "VEGAN" } }, { "boots_faux_fur" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "cloak_wool" }
definition:when({ present = { "WOOLALLERGY" } }, { "cloak_leather" })
definition:when({ present = { "VEGAN" } }, { "cloak" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "gloves_wool" }
definition:when({ present = { "WOOLALLERGY" } }, { "gloves_leather" })
definition:when({ present = { "VEGAN" } }, { "gloves_light" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "socks_wool" }
definition:when({ present = { "VEGAN" } }, { "socks" })
definition:when({ present = { "WOOLALLERGY" } }, { "socks" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "mask_ski" }
definition:when({ present = { "WOOLALLERGY", "VEGAN" } }, { "balclava" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "kilt" }
definition:when({ present = { "WOOLALLERGY" } }, { "kilt_leather" })
definition:when({ present = { "VEGAN" } }, { "kilt_utility" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "dress_shoes" }
definition:when({ present = { "VEGAN" } }, { "espadrilles" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "sunglasses" }
definition:when({ present = { "HYPEROPIC", "MYOPIC" } }, { "fitover_sunglasses" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "hardtack" }
definition:when({ present = { "ANTIWHEAT" }, absent = { "MEATARIAN" } }, { "cornbread" })
definition:when({ present = { "ANTIWHEAT", "MEATARIAN" } }, { { item = "meat_cooked", ratio = 0.72 } })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "sandwich_pbj" }
definition:when({ present = { "ANTIFRUIT" }, absent = { "ANTIWHEAT" } }, { "sandwich_pbh" })
definition:when({ present = { "ANTIWHEAT" }, absent = { "VEGETARIAN" } }, { { item = "cracklins", ratio = 5.625 } })
definition:when({ present = { "ANTIWHEAT", "VEGETARIAN" } }, { "boiled_egg" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "granola" }
definition:when({ present = { "ANTIFRUIT" }, absent = { "MEATARIAN" } }, { { item = "pemmican", ratio = 0.838 } })
definition:when({ present = { "ANTIFRUIT", "MEATARIAN" } }, { { item = "jerky", ratio = 4 } })
definition:when({ present = { "ANTIWHEAT" }, absent = { "ANTIFRUIT" } }, { { item = "boiled_egg", ratio = 0.818 } })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "juice" }
definition:when({ present = { "ANTIFRUIT" }, absent = { "ANTIJUNK" } }, { "lemonlime" })
definition:when({ present = { "ANTIFRUIT", "ANTIJUNK" } }, { { item = "water_clean", ratio = 0.4 } })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "cheeseburger" }
definition:when({ present = { "ANTIWHEAT" }, absent = { "ANTIJUNK" } }, { { item = "fries", ratio = 4 } })
definition:when({ present = { "ANTIWHEAT", "ANTIJUNK" }, absent = { "MEATARIAN" } }, { "veggy_salad", "fork" })
definition:when({ present = { "ANTIWHEAT", "ANTIJUNK", "MEATARIAN" } }, { "fried_spam", "fork" })
definition:when({ present = { "LACTOSE" }, absent = { "ANTIWHEAT", "VEGETARIAN" } }, { "hamburger" })
definition:when({ present = { "LACTOSE", "VEGETARIAN" }, absent = { "ANTIWHEAT" } }, { "sandwich_veggy" })
definition:when({ present = { "VEGAN" }, absent = { "ANTIWHEAT" } }, { "sandwich_veggy" })
definition:when({ present = { "VEGETARIAN" }, absent = { "ANTIWHEAT", "LACTOSE" } }, { { item = "sandwich_cheese_grilled", ratio = 0.5 } })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "pizza_meat" }
definition:when({ present = { "VEGETARIAN" }, absent = { "ANTIWHEAT" } }, { "pizza_veggy" })
definition:when({ present = { "VEGAN" }, absent = { "ANTIWHEAT" } }, { "pizza_veggy" })
definition:when({ present = { "VEGETARIAN", "ANTIWHEAT" } }, { "veggy_salad", "fork" })
definition:when({ present = { "VEGAN", "ANTIWHEAT" } }, { "veggy_salad", "fork" })
definition:when({ present = { "ANTIWHEAT" }, absent = { "VEGETARIAN", "ANTIJUNK" } }, { { item = "fchicken", ratio = 1 } })
definition:when({ present = { "ANTIWHEAT", "ANTIJUNK" }, absent = { "VEGETARIAN" } }, { { item = "fish_fried", ratio = 1 }, { item = "fork", ratio = 0.5 } })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "pizza_veggy" }
definition:when({ present = { "ANTIWHEAT", "VEGETARIAN" } }, { "veggy_salad", "fork" })
definition:when({ present = { "ANTIWHEAT", "VEGAN" } }, { "veggy_salad", "fork" })
definition:when({ present = { "ANTIWHEAT" }, absent = { "VEGETARIAN", "ANTIJUNK" } }, { { item = "fchicken", ratio = 1 } })
definition:when({ present = { "ANTIWHEAT", "ANTIJUNK" }, absent = { "VEGETARIAN" } }, { { item = "fish_fried", ratio = 1 }, { item = "fork", ratio = 0.5 } })
definition:when({ present = { "MEATARIAN" }, absent = { "ANTIWHEAT" } }, { "pizza_meat" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "pudding" }
definition:when({ present = { "ANTIJUNK" }, absent = { "LACTOSE" } }, { "yoghurt" })
definition:when({ present = { "ANTIWHEAT" }, absent = { "ANTIJUNK" } }, { "neccowafers" })
definition:when({ present = { "ANTIJUNK", "LACTOSE" } }, { "boiled_egg" })
content.add(definition)
end
do
local definition = content.ProfessionItemSubstitution { item = "can_beans" }
definition:when({ present = { "MEATARIAN" } }, { "can_spam" })
content.add(definition)
end
