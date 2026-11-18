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
