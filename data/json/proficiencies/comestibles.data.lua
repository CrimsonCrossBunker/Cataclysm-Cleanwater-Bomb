local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_food_prep",
    category = "prof_food",
    name = ccb.content.text("Food Preparation"),
    description = ccb.content.text("You've done enough cooking to know the basics about how to quickly and efficiently sort your ingredients."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_knife_skills",
    category = "prof_food",
    name = ccb.content.text("Knife Skills"),
    description = ccb.content.text("You're quite skilled at culinary knife work, making you noticeably faster at preparing meals that involve a lot of chopping."),
    can_learn = true,
    time_multiplier = 1.25,
    skill_penalty = 0,
    time_to_learn = "10 h",
    requires = { "prof_food_prep" },
}

ccb.content.define_proficiency {
    id = "prof_baking",
    category = "prof_food",
    name = ccb.content.text("Principles of Baking"),
    description = ccb.content.text("You know the basics of baking - proportions, leavening, and things - and are less likely to make a dramatic mistake when working from memory."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_baking_bread",
    category = "prof_food",
    name = ccb.content.text("Breadmaking"),
    description = ccb.content.text("You've baked enough bread to consider yourself an expert.  May your yeast be ever frothy."),
    can_learn = true,
    time_multiplier = 1.25,
    skill_penalty = 0.25,
    time_to_learn = "6 h",
    requires = { "prof_baking" },
}

ccb.content.define_proficiency {
    id = "prof_baking_desserts_1",
    category = "prof_food",
    name = ccb.content.text("Dessert Baking"),
    description = ccb.content.text("Anyone can make a cookie, but you can make it look amazing.  Cakes and other fluffies are also no longer a barrier."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    time_to_learn = "4 h",
    requires = { "prof_baking" },
}

ccb.content.define_proficiency {
    id = "prof_baking_desserts_2",
    category = "prof_food",
    name = ccb.content.text("Patisserie Expert"),
    description = ccb.content.text("You could have been a professional baker before the Cataclysm.  Your profiteroles are the envy of the wastelands."),
    can_learn = true,
    time_multiplier = 1.25,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
    requires = { "prof_baking_desserts_1" },
}

ccb.content.define_proficiency {
    id = "prof_frying",
    category = "prof_food",
    name = ccb.content.text("Principles of Frying"),
    description = ccb.content.text("Anyone can toss stuff into deep fryer oil.  You know more about selecting oil, keeping the food from burning, and the like."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.1,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_frying_bread",
    category = "prof_food",
    name = ccb.content.text("Breading & Battering"),
    description = ccb.content.text("You know enough about deep frying breads and batters to do it easily without thinking about it."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.1,
    time_to_learn = "4 h",
    requires = { "prof_frying" },
}

ccb.content.define_proficiency {
    id = "prof_frying_dessert",
    category = "prof_food",
    name = ccb.content.text("Fried Desserts"),
    description = ccb.content.text("You know the vaunted secrets of creating delicious deep fried sweets."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.1,
    time_to_learn = "4 h",
    requires = { "prof_frying", "prof_baking_desserts_1" },
}

ccb.content.define_proficiency {
    id = "prof_fermenting",
    category = "prof_food",
    name = ccb.content.text("Culinary Fermentation"),
    description = ccb.content.text("The basics of fermenting for human consumption, including sanitary technique, avoiding harmful molds, and identifying common problems."),
    can_learn = true,
    time_multiplier = 1.25,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_beverage_distilling",
    category = "prof_food",
    name = ccb.content.text("Beverage Distillation"),
    description = ccb.content.text("Applying the science of distillation to alcoholic beverages to get something tasty."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
    requires = { "prof_distilling" },
}

ccb.content.define_proficiency {
    id = "prof_brewing",
    category = "prof_food",
    name = ccb.content.text("Brewing"),
    description = ccb.content.text("The fine art of brewing grains into beers."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_fermenting" },
}

ccb.content.define_proficiency {
    id = "prof_winemaking",
    category = "prof_food",
    name = ccb.content.text("Winemaking"),
    description = ccb.content.text("The knowledge of how to turn sugary fruits, and occasionally vegetables, into fermented beverages."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_fermenting" },
}

ccb.content.define_proficiency {
    id = "prof_lactofermenting",
    category = "prof_food",
    name = ccb.content.text("Lactofermentation"),
    description = ccb.content.text("The microbiology of most non-alcoholic fermented edibles, from sauerkraut to sourdough."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
    requires = { "prof_fermenting" },
}

ccb.content.define_proficiency {
    id = "prof_cheesemaking_1",
    category = "prof_food",
    name = ccb.content.text("Principles of Cheesemaking"),
    description = ccb.content.text("The basics of curdling and coagulating milk and similar things without the wrong kinds of bacteria and mold winning out."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_cheesemaking_2",
    category = "prof_food",
    name = ccb.content.text("Cheesemaking Expert"),
    description = ccb.content.text("Taking the basics of curdled milk and making it delicious."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
    requires = { "prof_cheesemaking_1" },
}

ccb.content.define_proficiency {
    id = "prof_preservation",
    category = "prof_food",
    name = ccb.content.text("Food Preservation"),
    description = ccb.content.text("The basic knowledge of ways to keep food safe for long periods of time in a post-refrigeration world."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_food_curing",
    category = "prof_food",
    name = ccb.content.text("Curing and Drying Food"),
    description = ccb.content.text("Using salt, smoke, and similar agents to cure or dehydrate food."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
    requires = { "prof_preservation" },
}

ccb.content.define_proficiency {
    id = "prof_food_canning",
    category = "prof_food",
    name = ccb.content.text("Canning Food"),
    description = ccb.content.text("Using pressure canning or tinning to safely store food in sealed containers."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
    requires = { "prof_preservation" },
}

ccb.content.define_proficiency {
    id = "prof_scav_cooking",
    category = "prof_food",
    name = ccb.content.text("Scavenger Cooking"),
    description = ccb.content.text("You know the secrets of cooking tasty food using strange substitutions and weird things you found in a cabinet in an abandoned house."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.1,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_forage_cooking",
    category = "prof_food",
    name = ccb.content.text("Forager Cooking"),
    description = ccb.content.text("Cooking with foraged ingredients that you wouldn't find in most cookbooks."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.1,
    time_to_learn = "8 h",
}
