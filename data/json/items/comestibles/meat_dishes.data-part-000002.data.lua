local ccb = require("ccb")

ccb.content.define_item {
    id = "can_sardine",
    name = ccb.content.plural_text("canned sardine", "canned sardine"),
    mass = "200 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Salty little fish.  They'll make you thirsty."),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -8,
        calories = 340,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 40 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Semi-arbitrary spoilage of 48 hours set: pretty confident sausage gravy goes bad.
ccb.content.define_item {
    id = "sausagegravy",
    name = ccb.content.plural_text("sausage gravy", "sausage gravy"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Mannwurst gravy", "Mannwurst gravy"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("killbasa gravy", "killbasa gravy"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("ghastly %s", "ghastly %s"),
        },
    },
    mass = "60 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Biscuits, meat, and delicious mushroom soup all crammed together into a wonderfully greasy and tasty mush."),
    price = "10 USD",
    survival_price = "2 USD",
    materials = { "flesh", "wheat", "mushroom" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = 6,
        calories = 363,
        fun = 9,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pemmican",
    name = ccb.content.plural_text("pemmican", "pemmican"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "106 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat, tallow, and edible berries, it provides excellent nutrition in an easy to carry form."),
    price = "6 USD",
    survival_price = "3 USD 50 cent",
    materials = { "flesh", "fruit" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 440,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 21 },
            { id = "meat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "pemmican_veggy",
    name = ccb.content.plural_text("pemmican", "pemmican"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "106 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat, tallow, and edible plants or mushrooms, it provides excellent nutrition in an easy to carry form."),
    price = "5 USD 99 cent",
    survival_price = "3 USD 50 cent",
    materials = { "flesh", "veggy" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 440,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 21 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "pemmican_meat",
    name = ccb.content.plural_text("pemmican (meat only)", "pemmican (meat only)"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "100 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat and tallow, it provides excellent nutrition in an easy to carry form.  Contains no fruits or veggies."),
    price = "5 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "110 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -3,
        calories = 400,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 20 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "macaroni_helper",
    name = ccb.content.plural_text("hamburger helper", "hamburger helper"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("hobo helper", "hobo helper"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("halfling helper", "halfling helper"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("heinous %s", "heinous %s"),
        },
    },
    mass = "170 g",
    color = "red",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Some mac and cheese with ground meat added, enhancing the flavor and nutritional value."),
    price = "4 USD 90 cent",
    survival_price = "2 USD",
    materials = { "wheat", "flesh", "milk" },
    volume = "250 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 13,
        calories = 393,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 32 },
            { id = "iron", amount = 20 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ravioli",
    name = ccb.content.plural_text("ravioli", "ravioli"),
    mass = "170 g",
    color = "light_red",
    symbol = "%",
    description = ccb.content.text("Meat encased in little dough satchels.  Tastes fine straight from the can."),
    price = "125 cent",
    survival_price = "1 USD",
    materials = { "flesh", "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 393,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 27 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chili",
    name = ccb.content.plural_text("chili con carne", "chili con carne"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("chili con Cabron", "chili con Cabron"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("chili con Sindar", "chili con Sindar"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("chili con chupacabra", "chili con chupacabra"),
        },
    },
    mass = "253 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A spicy stew containing chili peppers, meat, tomatoes and beans."),
    display_type = "BY_WEIGHT",
    price = "145 cent",
    survival_price = "250 cent",
    phase = "liquid",
    materials = { "flesh", "veggy", "bean", "tomato" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 299,
        servings = 1,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 7 },
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 27 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pork_beans",
    name = ccb.content.plural_text("pork and beans", "pork and beans"),
    mass = "267 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Greasy Prospector brand improved pork and beans with hickory smoked pig fat chunks."),
    display_type = "BY_WEIGHT",
    price = "1 USD",
    survival_price = "150 cent",
    phase = "liquid",
    materials = { "flesh", "bean" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -8,
        calories = 283,
        servings = 1,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 14 },
            { id = "iron", amount = 32 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_tuna",
    name = ccb.content.plural_text("canned tuna fish", "canned tuna fish"),
    mass = "154 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Now with 95 percent fewer dolphins!"),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 305,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_salmon",
    name = ccb.content.plural_text("canned salmon", "canned salmon"),
    mass = "200 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("Bright pink fish-paste from a can."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 276,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 9 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_chicken",
    name = ccb.content.plural_text("canned chicken", "canned chicken"),
    mass = "217 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("Off-white chicken-paste from a can."),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 400,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 18 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_herring",
    name = ccb.content.plural_text("pickled herring", "pickled herring"),
    mass = "232 g",
    color = "white",
    default_container = "jar_glass_sealed",
    symbol = "%",
    description = ccb.content.text("Fish fillets pickled in some sort of tangy white sauce."),
    display_type = "BY_WEIGHT",
    price = "155 cent",
    survival_price = "350 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        calories = 465,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 34 },
            { id = "iron", amount = 34 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_clams",
    name = ccb.content.plural_text("canned clam", "canned clam"),
    mass = "169 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Chopped quahog clams in water."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 1,
        calories = 240,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 11 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_chowder",
    name = ccb.content.plural_text("clam chowder", "clam chowder"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "meat",
            name = ccb.content.plural_text("meat chowder", "meat chowder"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster chowder", "monster chowder"),
        },
    },
    mass = "253 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Delicious, lumpy, white soup made of meat (traditionally clams) and potatoes in a milk base.  A taste of the lost glory of New England."),
    display_type = "BY_VOLUME",
    price = "2 USD",
    survival_price = "2 USD",
    phase = "liquid",
    materials = { "flesh", "milk" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 2,
        calories = 142,
        servings = 1,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 14 },
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

-- One beans + one protein = 2 servings
ccb.content.define_item {
    id = "deluxe_beans",
    name = ccb.content.plural_text("baked beans", "baked beans"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("ork and beans", "ork and beans"),
        },
    },
    mass = "293 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slow-cooked beans with meat.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "350 cent",
    survival_price = "2 USD",
    materials = { "bean", "flesh" },
    volume = "500 ml",
    phase = "liquid",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 373,
        servings = 1,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 51 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- One rice + one protein/veg = 2 servings
ccb.content.define_item {
    id = "deluxe_rice",
    name = ccb.content.plural_text("meat fried rice", "meat fried rice"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("mutant fried rice", "mutant fried rice"),
        },
    },
    mass = "187 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Delicious fried rice with meat.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "350 cent",
    survival_price = "2 USD",
    materials = { "veggy", "flesh" },
    volume = "500 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 313,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 40 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_beansnrice",
    name = ccb.content.plural_text("deluxe beans and rice", "deluxe beans and rice"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("\"deluxe\" beans and rice", "\"deluxe\" beans and rice"),
        },
    },
    mass = "312 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slow-cooked beans and rice with meat and seasonings.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "375 cent",
    survival_price = "2 USD",
    materials = { "veggy", "bean", "flesh" },
    volume = "187 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 414,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pie_meat",
    name = ccb.content.plural_text("slice of meat pie", "slices of meat pie"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("slice of prick pie", "slices of prick pie"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("slice of talking animal pie", "slices of talking animal pie"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("malignant %s", "malignant %s"),
        },
    },
    mass = "189 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious slice of baked pie with a hearty meat filling."),
    price = "168 cent",
    survival_price = "250 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        quench = 5,
        calories = 400,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pizza_meat",
    name = ccb.content.plural_text("slice of meat pizza", "slices of meat pizza"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("slice of poser pizza", "slices of poser pizza"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("slice of protesting pizza", "slices of protesting pizza"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("miserable %s", "miserable %s"),
        },
    },
    mass = "230 g",
    color = "light_red",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A slice of meat pizza, for all the carnivores out there.  Chock-full of minced meat and heavily seasoned."),
    price = "272 cent",
    survival_price = "250 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 566,
        fun = 10,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 44 },
            { id = "iron", amount = 36 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pizza_supreme",
    name = ccb.content.plural_text("slice of supreme pizza", "slices of supreme pizza"),
    copy_from = "pizza_meat",
    color = "light_red",
    mass = "300 g",
    description = ccb.content.text("A slice of supreme pizza with ALL the toppings."),
    price = "15 USD",
    survival_price = "15 USD",
    materials = { "wheat", "flesh", "veggy", "milk" },
    comestible = {
        calories = 641,
        fun = 11,
        vitamins = {
            { id = "vitC", amount = 20 },
            { id = "calcium", amount = 32 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_eggs",
    name = ccb.content.plural_text("deluxe scrambled eggs", "deluxe scrambled eggs"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("deluxe scrambled eggheads", "deluxe scrambled eggheads"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("birdman's scrambled eggs", "birdman's scrambled eggs"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("\"deluxe\" scrambled eggs", "\"deluxe\" scrambled eggs"),
        },
    },
    mass = "198 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Fluffy and delicious scrambled eggs made even better with the addition of tasty meat or fish."),
    price = "233 cent",
    survival_price = "150 cent",
    materials = { "egg", "flesh" },
    volume = "83 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 279,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 39 },
            { id = "meat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_canned",
    name = ccb.content.plural_text("canned meat", "canned meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent slice", "soylent slice"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient slice", "sapient slice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "red",
    default_container = "can_food",
    description = ccb.content.text("Low-sodium boiled and canned meat.  Contains most of the nutrition, but little of the savor of cooked meat."),
    price = "2 USD 50 cent",
    survival_price = "2 USD 50 cent",
    flags = { "EATEN_HOT" },
    sealed_container = true,
    comestible = { shelf_life = "1 day 16 hours", fun = 2 },
}

ccb.content.define_item {
    id = "meat_salted",
    name = ccb.content.plural_text("vacuum-packed meat", "vacuum-packed meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("vacuum-packed human meat", "vacuum-packed human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("vacuum-packed demihuman meat", "vacuum-packed demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "red",
    default_container = "plastic_bag_vac",
    description = ccb.content.text("Cooked meat sealed in a vacuum bag to slow spoilage.  Its listed shelf life applies once exposed to air; an intact vacuum seal slows decay by half again."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD",
    materials = { { id = "flesh" } },
    comestible = { shelf_life = "42 days", fun = 2, vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "spaghetti_bolognese",
    name = ccb.content.plural_text("spaghetti bolognese", "spaghetti bolognese"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("scoundrel spaghetti", "scoundrel spaghetti"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("speaking spaghetti", "speaking spaghetti"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("gnarly %s", "gnarly %s"),
        },
    },
    mass = "150 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Spaghetti covered with a thick meat sauce.  Yum!"),
    price = "125 cent",
    survival_price = "150 cent",
    materials = { "wheat", "flesh" },
    volume = "218 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 226,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 9 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lasagne",
    name = ccb.content.plural_text("lasagne", "lasagne"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Luigi %s", "Luigi %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Lab %s", "Lab %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster %s", "monster %s"),
        },
    },
    mass = "255 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A very old type of pasta made with several layers of lasagne sheets alternated with cheese, sauce and meat."),
    price = "125 cent",
    survival_price = "37 cent",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
    },
    volume = "250 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days 16 hours",
        kind = "FOOD",
        quench = 5,
        calories = 226,
        fun = 15,
        vitamins = {
            { id = "vitC", amount = 6 },
            { id = "calcium", amount = 22 },
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fried_spam",
    name = ccb.content.plural_text("fried SPAM", "fried SPAM"),
    copy_from = "can_spam",
    color = "red",
    description = ccb.content.text("Now that it's been fried, this SPAM is actually pretty tasty."),
    price = "5 USD",
    materials = { "flesh" },
    flags = { "EATEN_HOT" },
    comestible = { quench = -6, fun = 8, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "cheeseburger",
    name = ccb.content.text("cheeseburger"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("chump %s", "chump %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("elf %s", "elf %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("chilling %s", "chilling %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "egg",
            name = ccb.content.text("breakfast cheeseburger"),
        },
    },
    mass = "333 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich of minced meat and cheese with condiments.  A simple favorite of the people before the Cataclysm."),
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
    },
    volume = "300 ml",
    flags = { "EATEN_HOT", "ALLERGEN_MILK" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 380,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_cheeseburger",
    copy_from = "cheeseburger",
    name = ccb.content.text("deluxe cheeseburger"),
    mass = "380 g",
    description = ccb.content.text("A cheeseburger with more vegetables and condiments.  This is the apex of pre-Cataclysm culinary achievement."),
    survival_price = "3 USD",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
        { id = "veggy", portions = 1 },
        { id = "tomato", portions = 1 },
    },
    volume = "350 ml",
    comestible = {
        calories = 500,
        fun = 7,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 60 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hamburger",
    name = ccb.content.text("hamburger"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("bobburger") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("Moreauburger") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("horrible %s", "horrible %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "egg",
            name = ccb.content.text("breakfast burger"),
        },
    },
    mass = "300 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich of minced meat with condiments."),
    price = "9 USD",
    survival_price = "2 USD",
    materials = { "flesh", "wheat" },
    volume = "300 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 258,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sloppyjoe",
    name = ccb.content.text("sloppy joe"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("sloppy Joseph") },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("manfriendwich", "manfriendwiches"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("suspicious %s", "suspicious %s"),
        },
    },
    mass = "313 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich consisting of ground meat and tomato sauce served on bread."),
    price = "9 USD",
    survival_price = "2 USD 50 cent",
    materials = { "flesh", "tomato", "wheat" },
    volume = "300 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 391,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "taco",
    name = ccb.content.text("taco"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("tio %s", "tio %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking %s", "talking %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("terrifying %s", "terrifying %s"),
        },
    },
    mass = "102 g",
    color = "yellow",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A traditional Mexican dish composed of a corn tortilla folded or rolled around a meat filling."),
    price = "2 USD 10 cent",
    survival_price = "1 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -5,
        calories = 210,
        fun = 8,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 15 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ndn_taco",
    name = ccb.content.text("Indian taco"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("tio %s", "tio %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking %s", "talking %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("terrifying %s", "terrifying %s"),
        },
    },
    mass = "265 g",
    color = "yellow",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("Frybread topped with beans, meat, and lettuce.  Originally conceived by the Navajo in the 19th century, only having available basic foodstuffs provided by the US-government after forced expulsion from their homelands, this dish became popular with many Native Americans and is often served at Powwows or other festivities."),
    price = "2 USD 10 cent",
    survival_price = "1 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -5,
        calories = 365,
        fun = 8,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 15 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_pickled",
    name = ccb.content.plural_text("pickled meat", "pickled meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("pickled punk", "pickled punk"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("pickled anthro", "pickled anthro"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "pink",
    default_container = "jar_glass_sealed",
    description = ccb.content.text("A serving of crisply brined and canned meat.  Tasty and nutritious."),
    price = "2 USD 50 cent",
    survival_price = "3 USD",
    comestible = { shelf_life = "4 days", fun = 6 },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "dehydrated_cured_meat",
    name = ccb.content.plural_text("dehydrated cured meat", "dehydrated cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("dehydrated cured human meat", "dehydrated cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("dehydrated cured demihuman meat", "dehydrated cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "raw_cured_meat",
    mass = "85 g",
    volume = "125 ml",
    color = "brown",
    description = ccb.content.text("Raw cured meat dried until nearly all moisture is gone.  It will keep indefinitely, but is extremely salty and must be washed before normal cooking."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "4 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    flags = { "RAW", "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = 0,
        quench = -15,
        fun = -6,
        smoking_result = "null",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "washed_cured_meat",
    name = ccb.content.plural_text("washed cured meat", "washed cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("washed cured human meat", "washed cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("washed cured demihuman meat", "washed cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "raw_cured_meat",
    mass = "275 g",
    volume = "250 ml",
    color = "light_red",
    description = ccb.content.text("Raw cured meat soaked and rinsed to remove its excess salt.  It spoils quickly again, but can now be used anywhere ordinary raw red meat is called for."),
    display_type = "BY_WEIGHT",
    price = "7 USD",
    survival_price = "2 USD",
    materials = { { id = "flesh" } },
    flags = { "RAW" },
    comestible = {
        shelf_life = "3 days",
        quench = 0,
        fun = -6,
        cooked_item = "cooked_cured_meat",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cooked_cured_meat",
    name = ccb.content.plural_text("cooked cured meat", "cooked cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("cooked cured human meat", "cooked cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("cooked cured demihuman meat", "cooked cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    description = ccb.content.text("Cured meat that has been rinsed of excess salt and cooked.  It is savory and ready to eat, but no longer keeps like its heavily salted form."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 1 }, { id = "flesh", portions = 3 } },
    comestible = { shelf_life = "3 days", fun = 6, vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "dry_meat",
    name = ccb.content.plural_text("dehydrated meat", "dehydrated meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("%s, human", "%s, human"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    mass = "85 g",
    color = "red",
    description = ccb.content.text("Dehydrated meat flakes.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        quench = -3,
        fun = -2,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

-- Froglegs are 87 percent water
ccb.content.define_item {
    id = "dry_froglegs",
    name = ccb.content.plural_text("dehydrated frog legs (pair)", "dehydrated frog legs (pair)"),
    copy_from = "froglegs_cooked",
    mass = "13 g",
    color = "red",
    description = ccb.content.text("A pair of dehydrated frog legs.  With proper storage, this dried food will remain edible for an incredibly long time."),
    price = "6 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -1, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "dry_poultry",
    name = ccb.content.plural_text("dehydrated chicken", "dehydrated chicken"),
    copy_from = "dry_meat",
    color = "white",
    description = ccb.content.text("Dehydrated flakes of bird meat.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    comestible = { calories = 220, fun = 0 },
}

ccb.content.define_item {
    id = "rehydrated_froglegs",
    name = ccb.content.text("rehydrated frog leg"),
    copy_from = "froglegs_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted frog legs, which are much more enjoyable to eat now that they have been rehydrated."),
    price = "6 USD",
    survival_price = "3 USD",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "rehydrated_poultry",
    name = ccb.content.plural_text("rehydrated chicken", "rehydrated chicken"),
    copy_from = "poultry_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted bird meat, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "6 USD",
    survival_price = "3 USD",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "rehydrated_meat",
    name = ccb.content.plural_text("rehydrated meat", "rehydrated meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("%s, human", "%s, human"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted meat flakes, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "1 USD",
    comestible = { fun = 2 },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

-- That's whisky without an 'e' because we're talking about Scotch whisky.
ccb.content.define_item {
    id = "haggis",
    name = ccb.content.plural_text("haggis", "haggises"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("human %s", "human %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
    },
    mass = "156 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("This traditional Scottish savory pudding is made of meat and offal mixed with oatmeal, sewn into an animal's stomach and boiled.  Surprisingly tasty and quite filling, it is best served with boiled root vegetables and strong whisky."),
    price = "7 USD 50 cent",
    survival_price = "2 USD 50 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        quench = 2,
        calories = 979,
        fun = 2,
        vitamins = {
            { id = "vitC", amount = 21 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 29 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sushi_fishroll",
    name = ccb.content.plural_text("fish makizushi", "fish makizushi"),
    mass = "159 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("Delicious slivers of thinly-sliced raw fish, wrapped in tasty sushi rice and rolled up in a healthy green vegetable."),
    price = "116 cent",
    survival_price = "1 USD",
    materials = { "veggy", "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "12 hours",
        kind = "FOOD",
        calories = 378,
        fun = 14,
        vitamins = {
            { id = "vitC", amount = 23 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sushi_meatroll",
    name = ccb.content.plural_text("meat temaki", "meat temaki"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("troubling %s", "troubling %s"),
        },
    },
    mass = "273 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("Delicious slivers of raw meat, wrapped in tasty sushi rice and rolled up in a healthy green vegetable."),
    price = "185 cent",
    survival_price = "150 cent",
    materials = { "veggy", "flesh" },
    volume = "500 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 417,
        fun = 13,
        vitamins = {
            { id = "vitC", amount = 36 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 37 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sashimi",
    name = ccb.content.plural_text("sashimi", "sashimi"),
    copy_from = "fish_cooked",
    color = "white",
    description = ccb.content.text("Delicious slivers of thinly sliced raw fish, served with tasty vegetables."),
    price = "6 USD",
    survival_price = "3 USD",
    materials = { "veggy", "flesh" },
    comestible = {
        shelf_life = "12 hours",
        calories = 160,
        fun = 7,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}
