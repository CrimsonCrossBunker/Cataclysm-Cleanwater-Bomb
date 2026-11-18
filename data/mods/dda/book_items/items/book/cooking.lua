local content = require("ccb").content

do
    local book = content.Item {
        id = "cookbook",
        category = "manuals",
        name = content.plural_text("Cooking on a Budget", "copies of Cooking on a Budget"),
        description = content.text("A nice cookbook that goes beyond recipes and into the chemistry of food."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 1900,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_baking", time_factor = 0.25, fail_factor = 0.2 },
            { id = "prof_baking_bread", time_factor = 0.25, fail_factor = 0.2 },
            { id = "prof_baking_desserts_1", time_factor = 0.25, fail_factor = 0.2 },
            { id = "prof_fermenting", time_factor = 0.05, fail_factor = 0.1 },
            { id = "prof_lactofermenting", time_factor = 0.05, fail_factor = 0.1 },
        },
    }
    content.add(book)
end

do
    -- Wasn't commercially traded.  ('Parody' only covers so much.)  Should get a serious price modifier for non-Cannibals.
    local book = content.Item {
        id = "cookbook_human",
        category = "manuals",
        name = content.plural_text("To Serve Man", "copies of To Serve Man"),
        description = content.text("It's… it's a cookbook!"),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 40000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "cookbook",
        color = "blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 4,
        read_time_turns = 600,
        fun = -5,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_italian",
        category = "manuals",
        name = content.plural_text("Cucina Italiana", "copies of Cucina Italiana"),
        description = content.text("This cookbook is written in Italian, but handily illustrated with step-by-step photo instructions."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 6,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_mexican",
        category = "manuals",
        name = content.plural_text("La Vida Deliciosa: Definitive Mexican Cuisine", "copies of La Vida Deliciosa: Definitive Mexican Cuisine"),
        description = content.text("This cookbook has lots of colorful pictures of finished dishes and features personal tips from the author/chef on nearly every recipe.  On the back cover are two joyful photos of the author in the kitchen with their parents: one as a child and one as an adult."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "red",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 4,
        intelligence = 5,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_sushi",
        category = "manuals",
        name = content.plural_text("Sushi Made Easy", "copies of Sushi Made Easy"),
        description = content.text("A simple text for the aspiring sushi lover, this easy-to-read guide is filled with lots of helpful illustrations for everything from basic rice preparation to setting a proper Japanese table."),
        mass_milligrams = 921000,
        volume_ml = 750,
        price_cents = 3500,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_green",
        looks_like = "cookbook",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 1,
        maximum_level = 4,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "family_cookbook",
        category = "manuals",
        name = content.plural_text("family cookbook", "family cookbooks"),
        description = content.text("A big binder full of somebody's family recipes.  The well-turned pages and creased corners speak volumes of the culinary knowledge contained within.  You could probably learn a lot about cooking from studying this domestic artifact."),
        mass_milligrams = 1540000,
        volume_ml = 1400,
        price_cents = 1950,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_gray",
        looks_like = "cookbook",
    }
    book:material("leather", 10)
    book:material("paper", 90)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 1,
        maximum_level = 5,
        intelligence = 7,
        read_time_turns = 1800,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_baking", time_factor = 0.1, fail_factor = 0.4 },
            { id = "prof_baking_bread", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_baking_desserts_1", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_frying", time_factor = 0.1, fail_factor = 0.2 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_glam",
        category = "manuals",
        name = content.plural_text("Glamopolitan", "issues of Glamopolitan"),
        description = content.text("A full-size glossy women's magazine.  There are a few unoriginal recipes and some simple cooking tips somewhere in between the fashion photos and the sex advice columns."),
        mass_milligrams = 160000,
        volume_ml = 500,
        price_cents = 450,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 1440,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    -- That would translate out to The Scottish Book of Cookery, or The Scottish Cookbook.
    local book = content.Item {
        id = "scots_cookbook",
        category = "manuals",
        name = content.plural_text("Ye Scots Beuk o Cuikery", "copies of Ye Scots Beuk o Cuikery"),
        description = content.text("A semi-translated Gaelic cookbook from sixteenth century Scotland.  While a bit difficult to read, as there are a disquieting number of illustrations of people stabbing each other mixed with rants about 'True Scotsmen', it provides insights into medieval Scottish cuisine and culture."),
        mass_milligrams = 1887000,
        volume_ml = 1250,
        price_cents = 1950,
        price_postapoc_cents = 2000,
        symbol = "?",
        color = "light_gray",
        looks_like = "cookbook",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "vinegar_maker",
        category = "manuals",
        name = content.plural_text("The Vinegar Maker's Handbook", "copies of Vinegar Maker's Handbook"),
        description = content.text("This book describes in detail all the ways that one can make vinegar.  You would have thought that there wasn't much to making vinegar, but the girth of this book tells you otherwise."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 1900,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_fermenting", time_factor = 0.1, fail_factor = 0.4 },
            { id = "prof_distilling", time_factor = 0.1, fail_factor = 0.3 },
            { id = "prof_brewing", time_factor = 0.05, fail_factor = 0.1 },
            { id = "prof_winemaking", time_factor = 0.05, fail_factor = 0.2 },
        },
    }
    content.add(book)
end

do
    -- Later on add mead transforms that don't require distilling to this book that match the source book. Possibly wait til beekeeping is added.
    local book = content.Item {
        id = "preserving_juice",
        name = content.plural_text("Drink the Harvest", "copies of Drink the Harvest"),
        description = content.text("Canning foods doesn't have to stop with jam and pickles.  This book provides a plethora of juices that can be preserved."),
        copy_from = "brewing_cookbook",
        looks_like = "brewing_cookbook",
    }
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_preservation", time_factor = 0.1, fail_factor = 0.1 },
            { id = "prof_food_canning", time_factor = 0.1, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "offalcooking",
        category = "manuals",
        name = content.plural_text("Offal Holiday Cooking", "copies of Offal Holiday Cooking"),
        description = content.text("Offal Holiday Cooking, by Evelyn Turncoat, is a book of holiday recipes that utilize organ meats from various animals.  For the true nose-to-tail cook."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 1900,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_frying", time_factor = 0.1, fail_factor = 0.2 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "dairy_book",
        category = "manuals",
        name = content.plural_text("Things to Do with Milk", "copies of Things to Do with Milk"),
        description = content.text("Whatever you want to do with milk, you will probably find it in this book."),
        mass_milligrams = 478000,
        volume_ml = 1000,
        price_cents = 1900,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "white",
    }
    book:material("paper", 1)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 4,
        read_time_turns = 840,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_cheesemaking_1", time_factor = 0.1, fail_factor = 0.4 },
            { id = "prof_cheesemaking_2", time_factor = 0.1, fail_factor = 0.1 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "winemaking_beginner",
        category = "manuals",
        name = content.plural_text("Winemaking for Beginners", "copies of Winemaking for Beginners"),
        description = content.text("Winemaking is an art form.  This book teaches you how to crayon within the lines."),
        mass_milligrams = 454000,
        volume_ml = 1000,
        price_cents = 4000,
        price_postapoc_cents = 1000,
        symbol = "?",
        looks_like = "cookbook",
        color = "red",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 2)
    book:book {
        required_level = 1,
        maximum_level = 2,
        intelligence = 7,
        read_time_turns = 720,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_fermenting", time_factor = 0.1, fail_factor = 0.5 },
            { id = "prof_brewing", time_factor = 0.1, fail_factor = 0.1 },
            { id = "prof_winemaking", time_factor = 0.25, fail_factor = 0.3 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_canning",
        name = content.plural_text("You Can Can at Home", "copies of You Can Can at Home"),
        description = content.text("This entry-level guide to home canning talks about the importance of acidity and food contents in preservation, and how to avoid contaminants in your canning batches."),
        price_postapoc_cents = 1500,
        copy_from = "mag_cooking",
        looks_like = "mag_cooking",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_preservation", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_food_canning", time_factor = 0.2, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_sealing",
        name = content.plural_text("Can Sealer Instructions", "copies of Can Sealer Instructions"),
        description = content.text("This dry guide to a home-use tin can sealer goes into clear detail on everything you can seal with the device and how to do it safely, and includes some basic recipes."),
        price_postapoc_cents = 1500,
        copy_from = "mag_cooking",
        looks_like = "mag_cooking",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_preservation", time_factor = 0.05, fail_factor = 0.1 },
            { id = "prof_food_canning", time_factor = 0.05, fail_factor = 0.3 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "vacuum_sealing",
        name = content.plural_text("Vacuum Sealer Instructions", "copies of Vacuum Sealer Instructions"),
        description = content.text("This dry guide to a home-use vacuum sealer goes into clear detail on everything you can seal with the device and how to do it safely, and includes some basic recipes."),
        price_postapoc_cents = 1500,
        copy_from = "mag_cooking",
        looks_like = "mag_cooking",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_preservation", time_factor = 0.05, fail_factor = 0.1 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "baking_book",
        category = "manuals",
        name = content.plural_text("The Baker's Companion", "copies of The Baker's Companion"),
        description = content.text("This book promises to teach you the ways of baking, from cakes to souffles."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 4950,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "cookbook",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 2,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_baking", time_factor = 0.1, fail_factor = 0.5 },
            { id = "prof_baking_bread", time_factor = 0.1, fail_factor = 0.5 },
            { id = "prof_baking_desserts_1", time_factor = 0.1, fail_factor = 0.5 },
            { id = "prof_baking_desserts_2", time_factor = 0.1, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "fermenting_book",
        category = "manuals",
        name = content.plural_text("Fermenting Culture", "copies of Fermenting Culture"),
        description = content.text("Fermenting as a cooking practice only recently came back into vogue before the Cataclysm.  Here is a book with dozens of recipes, many of which you are unlikely to ever see the ingredients for again."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 4950,
        price_postapoc_cents = 500,
        symbol = "?",
        looks_like = "cookbook",
        color = "green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_fermenting", time_factor = 0.25, fail_factor = 0.3 },
            { id = "prof_lactofermenting", time_factor = 0.2, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "distilling_cookbook",
        category = "manuals",
        name = content.plural_text("Out of the Holler and into the Home: A guide to home distillation", "copies of Out of the Holler"),
        description = content.text("A book describing the history of at-home distillation.  Each chapter is named after a different type of liquor, and contains a complete recipe for its namesake."),
        mass_milligrams = 454000,
        volume_ml = 619,
        price_cents = 1950,
        price_postapoc_cents = 1500,
        symbol = "?",
        looks_like = "cookbook",
        color = "blue",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 3,
        maximum_level = 5,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_fermenting", time_factor = 0.05, fail_factor = 0.05 },
            { id = "prof_brewing", time_factor = 0.05, fail_factor = 0.1 },
            { id = "prof_winemaking", time_factor = 0.05, fail_factor = 0.1 },
            { id = "prof_distilling", time_factor = 0.2, fail_factor = 0.2 },
            { id = "prof_beverage_distilling", time_factor = 0.3, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "sweets_book",
        category = "manuals",
        name = content.plural_text("Sweets for your Sweet Child", "copies of Sweets for Sweet"),
        description = content.text("Sweets for your Sweet Child is a best-selling cookbook marketed to the parents of young children.  Every recipe uses oversized text, easy words and diagram instructions for children learning to cook with their parents."),
        mass_milligrams = 600000,
        volume_ml = 800,
        price_cents = 1050,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "cookbook",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 4,
        read_time_turns = 540,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_baking", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_baking_desserts_1", time_factor = 0.1, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    -- Statistics derived from a real book.
    local book = content.Item {
        id = "cookbook_native",
        category = "manuals",
        name = content.plural_text("The Sioux Chef", "copies of The Sioux Chef"),
        description = content.text("A thick hardcover book about the history and future of Native American cuisine.  As much recipe collection as manifesto."),
        mass_milligrams = 2950000,
        volume_ml = 3215,
        price_cents = 6000,
        price_postapoc_cents = 750,
        color = "blue",
        symbol = "?",
        looks_like = "cookbook",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 540,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_forage_cooking", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_frying_bread", time_factor = 0.1, fail_factor = 0.4 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_turkish",
        category = "manuals",
        name = content.plural_text("The Turkish Cookbook", "copies of The Turkish Cookbook"),
        description = content.text("The definitive cookbook of hearty, healthy Turkish cuisine."),
        mass_milligrams = 600000,
        volume_ml = 800,
        price_cents = 1050,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "cookbook",
        color = "red",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 4,
        read_time_turns = 540,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_useless",
        category = "manuals",
        name = content.plural_text("The Generic Cookbook", "copies of The Generic Cookbook"),
        description = content.text("Just your standard cookbook filled with recipes that you could almost certainly come up with on your own."),
        symbol = "?",
        looks_like = "cookbook",
        color = "red",
        copy_from = "book_nonf_soft_tpl",
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    book:variants {
        {
            id = "cookbook_useless_main_salads",
            name = content.plural_text("Main Course Salads", "copies of Main Course Salads"),
            description = content.text("A classic cookbook filled with recipes for hearty salads."),
            weight = 1,
        },
        {
            id = "cookbook_useless_cook_everything",
            name = content.plural_text("How to Cook Everything", "copies of How to Cook Everything"),
            description = content.text("An introductory cookbook containing a few simple recipes from every type of cuisine."),
            weight = 1,
        },
        {
            id = "cookbook_useless_simple_food",
            name = content.plural_text("The Art of Simple Food", "copies of The Art of Simple Food"),
            description = content.text("A cookbook with a variety of recipes, mostly focusing on vegetables."),
            weight = 1,
        },
        {
            id = "cookbook_useless_better_homes_gardens",
            name = content.plural_text("The Better Homes & Gardens Cook Book", "copies of The Better Homes & Gardens Cook Book"),
            description = content.text("Its red and white cover famous across America, this cookbook contains recipes for all sorts of staple foods."),
            weight = 2,
        },
        {
            id = "cookbook_useless_sad_bastard",
            name = content.plural_text("The Sad Bastard Cookbook: Food You Can Make So You Don't Die", "copies of The Sad Bastard Cookbook: Food You Can Make So You Don't Die"),
            description = content.text("When your cooking is limited to 'microwave TV dinners', you need a book like this to elevate you to boiling water without burning it."),
            weight = 1,
        },
        {
            id = "cookbook_useless_boil_water",
            name = content.plural_text("How to Boil Water", "copies of How to Boil Water"),
            description = content.text("A cookbook for a complete beginner who's probably never turned a stove on before."),
            weight = 1,
        },
        {
            id = "cookbook_useless_everyday_cook",
            name = content.plural_text("EveryDayCook: A Cookbook", "copies of EveryDayCook: A Cookbook"),
            description = content.text("A cookbook with simple recipes, organized by time of day and meal rather than type of food."),
            weight = 1,
        },
        {
            id = "cookbook_useless_dont_feel_like_cooking",
            name = content.plural_text("What to Cook When You Don't Feel Like Cooking", "copies of What to Cook When You Don't Feel Like Cooking"),
            description = content.text("Based on a popular blog, this book focuses on using minimal ingredients to make simple recipes."),
            weight = 1,
        },
        {
            id = "cookbook_useless_college_cookbook_beginners",
            name = content.plural_text("College Cookbook for Beginners", "copies of College Cookbook for Beginners"),
            description = content.text("A cookbook for students finally unleashed into their own kitchens."),
            weight = 1,
        },
        {
            id = "cookbook_useless_super_easy_cookbook_beginners",
            name = content.plural_text("Super Easy Cookbook for Beginners: 5-Ingredient Recipes and Essential Techniques to Get You Started in the Kitchen", "copies of Super Easy Cookbook for Beginners: 5-Ingredient Recipes and Essential Techniques to Get You Started in the Kitchen"),
            description = content.text("A cookbook for beginners focused on recipes that only require five ingredients."),
            weight = 1,
        },
        {
            id = "cookbook_useless_five_ingredients_bro",
            name = content.plural_text("5 Ingredients, Bro! A No-Stress Cookbook for Teens", "copies of 5 Ingredients, Bro! A No-Stress Cookbook for Teens"),
            description = content.text("A cookbook for beginners focused on recipes that only require five ingredients, designed for teenagers."),
            weight = 1,
        },
        {
            id = "cookbook_useless_the_beginners_cookbook_easy_delicious",
            name = content.plural_text("The Beginner's Cookbook: Simple - Easy - Delicious", "copies of The Beginner's Cookbook: Simple - Easy - Delicious"),
            description = content.text("A cookbook with a variety of simple recipes like pizza, roast chicken, and risotto."),
            weight = 1,
        },
        {
            id = "cookbook_useless_five_ingredient_college",
            name = content.plural_text("The 5-Ingredient College Cookbook: Recipes to Survive the Next Four Years", "copies of The 5-Ingredient College Cookbook: Recipes to Survive the Next Four Years"),
            description = content.text("Another of the 'five-ingredient' genre of cookbooks, this one focused on college students."),
            weight = 1,
        },
        {
            id = "cookbook_useless_the_beginners_cookbook_easy_delicious",
            name = content.plural_text("Quick and Delicious: 100 Recipes to Cook in 30 Minutes or Less", "copies of Quick and Delicious: 100 Recipes to Cook in 30 Minutes or Less"),
            description = content.text("Gordon Ramsey's cookbook of simple recipes you can make with things you (hopefully) already have in your kitchen."),
            weight = 1,
        },
        {
            id = "cookbook_useless_complete_for_beginners",
            name = content.plural_text("The Complete Cookbook for Beginners : Essential Skills and Step-by-Step Techniques", "copies of The Complete Cookbook for Beginners : Essential Skills and Step-by-Step Techniques"),
            description = content.text("A cookbook with 101 simple recipes, including tips for setting up a kitchen."),
            weight = 1,
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "brewing_cookbook",
        category = "manuals",
        name = content.plural_text("The Homebrewer's Bible", "copies of The Homebrewer's Bible"),
        description = content.text("A book full of easy-to-follow recipes and useful advice on homebrewing, malting, and fermenting.  It even smells faintly of booze."),
        mass_milligrams = 1587000,
        volume_ml = 1500,
        price_cents = 4950,
        price_postapoc_cents = 1500,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 4)
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 8,
        read_time_turns = 900,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
        proficiencies = {
            { id = "prof_fermenting", time_factor = 0.1, fail_factor = 0.25 },
            { id = "prof_brewing", time_factor = 0.25, fail_factor = 0.5 },
            { id = "prof_winemaking", time_factor = 0.1, fail_factor = 0.25 },
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_cooking",
        category = "manuals",
        name = content.plural_text("Bon Appetit", "issues of Bon Appetit"),
        description = content.text("Exciting recipes and restaurant reviews.  Full of handy tips about cooking."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_liverforkids",
        category = "manuals",
        name = content.plural_text("Liver-Licious Recipes Your Kids Will Love", "copies of Liver-Licious Recipes"),
        description = content.text("This cookbook is written by liver enthusiast Tamsyn Beckerleg.  Inside you'll find a great deal of anecdotes about the near-certain ruination of children who refuse to eat their liver."),
        mass_milligrams = 600000,
        volume_ml = 800,
        price_cents = 1999,
        price_postapoc_cents = 500,
        copy_from = "book_nonf_hard_cook_tpl",
    }
    book:book {
        required_level = 1,
        maximum_level = 2,
        intelligence = 5,
        read_time_turns = 600,
        fun = 0,
        chapters = 12,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_bloodforgood",
        category = "manuals",
        name = content.plural_text("Blood for the Greater Good", "copies of Blood for the Greater Good"),
        description = content.text("A recipe book compiled by blood-as-food advocate Alžbeta Bátoriová.  The consumption of blood is a taboo among members of many Abrahamic religions, but they aren't going to stop you now.  This book has bonus material for those with particular tastes."),
        mass_milligrams = 600000,
        volume_ml = 800,
        price_cents = 1999,
        price_postapoc_cents = 500,
        copy_from = "book_nonf_hard_cook_tpl",
    }
    book:book {
        required_level = 1,
        maximum_level = 2,
        intelligence = 5,
        read_time_turns = 600,
        fun = 0,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_daintydishes",
        name = content.plural_text("Dainty Dishes Fit for a King", "copies of Dainty Dishes"),
        description = content.text("This cookbook contains many fanciful recipes.  Some of them are even worth the trouble to actually prepare.  Lovely pen and ink illustrations of overweight knights and gluttonous monks line the pages."),
        volume_ml = 900,
        price_cents = 3000,
        price_postapoc_cents = 750,
        copy_from = "cookbook_liverforkids",
        looks_like = "cookbook_liverforkids",
    }
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 5,
        read_time_turns = 720,
        fun = 1,
        chapters = 12,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_eatyrway",
        category = "manuals",
        name = content.plural_text("Eat Your Way to a Fit Physique", "copies of Eat Your Way"),
        description = content.text("This self-help book, by \"acclaimed nutrition and health guru Amar de Freitas,\" is as dubious as its title.  Worse, it is boring.  It does, however, contain a few basic cooking instructions."),
        volume_ml = 1100,
        price_cents = 2500,
        price_postapoc_cents = 750,
        copy_from = "book_nonf_soft_cook_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 4,
        read_time_turns = 840,
        fun = -1,
        chapters = 14,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_foodfashions",
        name = content.plural_text("Food Fashions for Young Moderns", "copies of Food Fashions"),
        description = content.text("A cookbook professing itself to be for those seeking \"daring and sophisticated flavors.\"  The book exhorts the reader to defy convention and break the rules, and then presents a number of useful rules and conventions for preparing food."),
        price_cents = 3999,
        price_postapoc_cents = 750,
        copy_from = "cookbook_liverforkids",
        looks_like = "cookbook_liverforkids",
    }
    book:book {
        required_level = 2,
        maximum_level = 4,
        intelligence = 7,
        read_time_turns = 600,
        fun = 0,
        chapters = 12,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    -- Statistics derived from a real book.
    local book = content.Item {
        id = "cookbook_indian",
        category = "manuals",
        name = content.plural_text("Tasting India", "copies of Tasting India"),
        description = content.text("A thick hardcover book as much about Indian culture as it is a cookbook, clearly written with adoration."),
        mass_milligrams = 2950000,
        volume_ml = 3215,
        price_cents = 6000,
        price_postapoc_cents = 750,
        color = "yellow",
        looks_like = "cookbook",
        copy_from = "book_nonf_hard_cook_tpl",
    }
    book:clear_melee_damage()
    book:melee_damage("bash", 7)
    book:book {
        required_level = 1,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 1,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "cookbook_curry",
        category = "manuals",
        name = content.plural_text("Curry cookbook", "copies of Curry cookbook"),
        description = content.text("A book for making curry, the greatest of all meals."),
        symbol = "?",
        color = "green",
        copy_from = "book_nonf_soft_tpl",
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 18,
        scannable = true,
        skill = "cooking",
    }
    book:variants {
        {
            id = "cookbook_curry_fifty_great",
            name = content.plural_text("50 Great Curries of India", "copies of 50 Great Curries of India"),
            description = content.text("This best-selling cookbook contains 50 curry recipes, ranging from classics like Goa lamb vindaloo or rogan josh to less well-known ones like mango and yogurt curry."),
            weight = 1,
        },
        {
            id = "cookbook_curry_easy_indian_curries",
            name = content.plural_text("Easy Indian Curry Recipes for Beginners", "copies of Easy Indian Curry Recipes for Beginners"),
            description = content.text("A curry cookbook designed for first-time curry makers, including ingredient substitutions and a guide to commonly-used spices."),
            weight = 1,
        },
        {
            id = "cookbook_curry_home_kitchens",
            name = content.plural_text("Curry: Recipes From Indian Home Kitchens", "copies of Curry: Recipes From Indian Home Kitchens"),
            description = content.text("A curry cookbook with a variety of curries from across India."),
            weight = 1,
        },
        {
            id = "cookbook_curry_easy_simple_guide",
            name = content.plural_text("Easy Curry Cookbook: Cook Delicious Curries with this Simple Guide", "copies of Easy Curry Cookbook: Cook Delicious Curries with this Simple Guide"),
            description = content.text("A simple cookbook designed for curry beginners."),
            weight = 1,
        },
        {
            id = "cookbook_curry_easy_indian_curries",
            name = content.plural_text("The Greatest Indian Curries Ever Created!: A Cookbook of 50 Delicious Curry Recipes Direct from India", "copies of The Greatest Indian Curries Ever Created!: A Cookbook of 50 Delicious Curry Recipes Direct from India"),
            description = content.text("This cookbook contains a variety of recipes to suit any taste."),
            weight = 1,
        },
        {
            id = "cookbook_curry_just_chicken_curries",
            name = content.plural_text("No Worries, Just Chicken Curries: Over 70 incredible Indian chicken recipes", "copies of No Worries, Just Chicken Curries: Over 70 incredible Indian chicken recipes"),
            description = content.text("Not just chicken curry, this contains recipes for sauces and vegetable sides as well."),
            weight = 1,
        },
        {
            id = "cookbook_curry_indian_restaurant_at_home",
            name = content.plural_text("Indian Restaurant Curries at Home, Volume 1", "copies of Indian Restaurant Curries at Home, Volume 1"),
            description = content.text("A cookbook filled with recipes that replicate curries served in famous British restaurants."),
            weight = 1,
        },
        {
            id = "cookbook_curry_ultimate_curry_cookbook",
            name = content.plural_text("The Ultimate Curry Cookbook: Mouth-Watering and Soul Satisfying Curries", "copies of The Ultimate Curry Cookbook: Mouth-Watering and Soul Satisfying Curries"),
            description = content.text("This cookbook has 50 curry recipes from around the world, created using simple ingredients."),
            weight = 1,
        },
        {
            id = "cookbook_curry_thai",
            name = content.plural_text("Thai Curry Cookbook - Exploring Thailand’s Rich and Spicy Curry Traditions", "copies of Thai Curry Cookbook - Exploring Thailand’s Rich and Spicy Curry Traditions"),
            description = content.text("A cookbook with a variety of Thai curries, from regional specialties to street food."),
            weight = 1,
        },
        {
            id = "cookbook_curry_thai_simple",
            name = content.plural_text("The Good Old Thai Curry Cookbook: Classic Thai Recipes Featuring Red, Green, and Yellow Curries", "copies of The Good Old Thai Curry Cookbook: Classic Thai Recipes Featuring Red, Green, and Yellow Curries"),
            description = content.text("A cookbook focused on breaking down red, green, and yellow curries with step-by-step instructions.  You're not sure the cutesy names for all the curries are authentic, though."),
            weight = 1,
        },
    }
    content.add(book)
end
