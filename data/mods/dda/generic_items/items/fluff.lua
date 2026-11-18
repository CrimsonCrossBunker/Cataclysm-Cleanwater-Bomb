local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "magic_8_ball",
        category = "other",
        name = ccb.content.plural_text("Magic 8-Ball", "Magic 8-Balls"),
        description = ccb.content.text("A fortune-telling device from the 1950s.  The kind of moral support you didn't know you needed."),
        mass_milligrams = 40000,
        volume_ml = 150,
        longest_side_mm = 120,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "white",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("SLING_PROJECTILE")
    item:clear_use_actions()
    item:native_use("MAGIC_8_BALL")
    content.add(item)
end

do
    local item = content.Item {
        id = "polaroid_photo",
        category = "other",
        name = ccb.content.plural_text("polaroid photo", "polaroid photos"),
        description = ccb.content.text("A poorly-taken polaroid photo of a young man wearing bell-bottoms and a fedora.  It's pretty blurry."),
        mass_milligrams = 1000,
        volume_ml = 5,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "light_gray",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "jigsaw",
        category = "other",
        name = ccb.content.plural_text("Jigsaw puzzle", "Jigsaw puzzles"),
        description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a image of something, somewhere."),
        mass_milligrams = 410000,
        volume_ml = 2200,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
        variant_kind = "generic",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    item:variants {
        { id = "jigsaw_1", name = ccb.content.plural_text("White House jigsaw puzzle", "White House jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the main view of the White House in Washington, DC."), color = "blue", weight = 20 },
        { id = "jigsaw_2", name = ccb.content.plural_text("St. Basil's jigsaw puzzle", "St. Basil's jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the main view of the St. Basil's Cathedral at the Red Square in Moscow, Russia."), color = "blue", weight = 20 },
        { id = "jigsaw_3", name = ccb.content.plural_text("Big Ben jigsaw puzzle", "Big Ben jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Big Ben in London, United Kingdom."), color = "blue", weight = 20 },
        { id = "jigsaw_4", name = ccb.content.plural_text("Curitiba's Botanical Garden jigsaw puzzle", "Curitiba's Botanical Garden jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Curitiba's Botanical Garden in Curitiba, Brazil."), color = "blue", weight = 5 },
        { id = "jigsaw_5", name = ccb.content.plural_text("Christ Redeemer jigsaw puzzle", "Christ Redeemer jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the backside view of Christ Redeemer, the Copacabana Beach, and the Pao de Acucar in Rio de Janeiro, Brazil."), color = "blue", weight = 20 },
        { id = "jigsaw_6", name = ccb.content.plural_text("Machu Picchu jigsaw puzzle", "Machu Picchu jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the background view of the ancient village of Machu Picchu in Machu Picchu, Peru."), color = "blue", weight = 20 },
        { id = "jigsaw_7", name = ccb.content.plural_text("Pyramids of Giza jigsaw puzzle", "Pyramids of Giza jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Pyramids of Giza in Al Haram, Egypt."), color = "blue", weight = 20 },
        { id = "jigsaw_8", name = ccb.content.plural_text("Great Wall of China jigsaw puzzle", "Great Wall of China jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a beautiful horizontal view of the Great Wall of China in Northern China."), color = "blue", weight = 20 },
        { id = "jigsaw_9", name = ccb.content.plural_text("Roman Colosseum jigsaw puzzle", "Roman Colosseum jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Roman Colosseum in Roma, Italy."), color = "blue", weight = 20 },
        { id = "jigsaw_10", name = ccb.content.plural_text("Taj Mahal jigsaw puzzle", "Taj Mahal jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the background view of the Taj Mahal mausoleum in Agra, India."), color = "blue", weight = 20 },
        { id = "jigsaw_11", name = ccb.content.plural_text("Hanging Gardens of Babylon jigsaw puzzle", "Hanging Gardens of Babylon jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a possible accurate representation of the Hanging Gardens of Babylon."), color = "blue", weight = 20 },
        { id = "jigsaw_12", name = ccb.content.plural_text("Statue of Zeus jigsaw puzzle", "Statue of Zeus jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a theoretical representation of the Statue of Zeus, a wonder that used to be at Olympia, Greece."), color = "blue", weight = 20 },
        { id = "jigsaw_13", name = ccb.content.plural_text("Temple of Artemis jigsaw puzzle", "Temple of Artemis jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a historical representation of the Temple of Artemis, possibly located in present-day, pre-Cataclysm Turkey."), color = "blue", weight = 20 },
        { id = "jigsaw_14", name = ccb.content.plural_text("Mausoleum at Halicarnassus jigsaw puzzle", "Mausoleum at Halicarnassus jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a possibly historically-accurate representation of the Mausoleum at Halicarnassus, probably located in present-day, pre-Cataclysm Turkey."), color = "blue", weight = 20 },
        { id = "jigsaw_15", name = ccb.content.plural_text("Colossus of Rhodes jigsaw puzzle", "Colossus of Rhodes jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a representation of the Colossus of Rhodes in the island of same name, Greece, that may or may not be accurate."), color = "blue", weight = 20 },
        { id = "jigsaw_16", name = ccb.content.plural_text("Lighthouse of Alexandria jigsaw puzzle", "Lighthouse of Alexandria jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a historical representation of the Lighthouse of Alexandria, that was built in the ancient city of Alexandria, Egypt."), color = "blue", weight = 20 },
        { id = "jigsaw_17", name = ccb.content.plural_text("Stonehenge jigsaw puzzle", "Stonehenge jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the ancient Stonehenge in Salisbury, United Kingdom."), color = "blue", weight = 20 },
        { id = "jigsaw_18", name = ccb.content.plural_text("Great Barrier Reef jigsaw puzzle", "Great Barrier Reef jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the underwater view of the Great Barrier Reef in the coast of Queensland, Australia."), color = "blue", weight = 20 },
        { id = "jigsaw_19", name = ccb.content.plural_text("Mount Everest jigsaw puzzle", "Mount Everest jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the forms the horizontal view of the Mount Everest, located at the Himalayan Mountain Range."), color = "blue", weight = 20 },
        { id = "jigsaw_20", name = ccb.content.plural_text("Mount Fuji jigsaw puzzle", "Mount Fuji jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the horizontal view of Mount Fuji, at the Japanese island of Honshu."), color = "blue", weight = 20 },
        { id = "jigsaw_21", name = ccb.content.plural_text("Victoria Falls jigsaw puzzle", "Victoria Falls jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a magnificent upper view of the Victoria Falls at the border between Zambia and Zimbabwe."), color = "blue", weight = 20 },
        { id = "jigsaw_22", name = ccb.content.plural_text("Paricutín Volcano jigsaw puzzle", "Paricutín Volcano jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the natural view of the Paricutín Volcano, located in the Michoacán State, Mexico."), color = "blue", weight = 20 },
        { id = "jigsaw_23", name = ccb.content.plural_text("Angkor Wat jigsaw puzzle", "Angkor Wat jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms a interior view of the Angkor Wat temple complex in Cambodia."), color = "blue", weight = 20 },
        { id = "jigsaw_24", name = ccb.content.plural_text("Guanabara Bay jigsaw puzzle", "Guanabara Bay jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the natural view of the Guanabara Bay in Rio de Janeiro, Brazil."), color = "blue", weight = 20 },
        { id = "jigsaw_25", name = ccb.content.plural_text("Grand Canyon jigsaw puzzle", "Grand Canyon jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the rocky view of the Grand Canyon, at the State of Arizona."), color = "blue", weight = 20 },
        { id = "jigsaw_26", name = ccb.content.plural_text("Northern Lights jigsaw puzzle", "Northern Lights jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the otherworldly beautiful view of the Northern Lights (Aurora Borealis) which occur most often in the Arctic Circle and polar regions."), color = "blue", weight = 20 },
        { id = "jigsaw_27", name = ccb.content.plural_text("Acadia National Park jigsaw puzzle", "Acadia National Park jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the natural view of the entrance of the Acadia National Park, located in Maine."), color = "blue", weight = 20 },
        { id = "jigsaw_28", name = ccb.content.plural_text("Mark Twain House jigsaw puzzle", "Mark Twain House jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Mark Twain House in Connecticut."), color = "blue", weight = 20 },
        { id = "jigsaw_29", name = ccb.content.plural_text("Mount Rushmore jigsaw puzzle", "Mount Rushmore jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the front view of the Mount Rushmore National Memorial in South Dakota."), color = "blue", weight = 20 },
        { id = "jigsaw_30", name = ccb.content.plural_text("Portland Head Light jigsaw puzzle", "Portland Head Light jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the beautiful front view of the Portland Head Light in Maine.  Its picturesque setting overlooking the Atlantic Ocean is outstanding!"), color = "blue", weight = 20 },
        { id = "jigsaw_32", name = ccb.content.plural_text("Eiffel Tower jigsaw puzzle", "Eiffel Tower jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the beautiful front view of the Eiffel Tower in Paris, France."), color = "blue", weight = 20 },
        { id = "jigsaw_33", name = ccb.content.plural_text("The Statue of Liberty jigsaw puzzle", "The Statue of Liberty jigsaw puzzles"), description = ccb.content.text("A jigsaw puzzle cardboard box containing 1000 cardboard pieces that when connected together properly forms the unique, beautiful front view of the Statue of Liberty, in New York."), color = "blue", weight = 20 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "tic_tac",
        category = "other",
        name = ccb.content.plural_text("tic-tac-toe set", "tic-tac-toe sets"),
        description = ccb.content.text("Not really a set, just a sheet of paper with a big '#' drawn at the center, alongside three buttons of a specific color, three others from a different color and a proper container for storing it properly.  You can play tic tac toe indefinitely with that!"),
        mass_milligrams = 100000,
        volume_ml = 500,
        symbol = "?",
        color = "white",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_dominoes",
        category = "other",
        name = ccb.content.plural_text("makeshift dominoes set", "makeshift dominoes sets"),
        description = ccb.content.text("Twenty eight rectangular pieces of cardboard, with dots on them so you can use it to play dominoes.  It has also a proper container for storing them all in place."),
        mass_milligrams = 100000,
        volume_ml = 500,
        symbol = "?",
        color = "white",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "small_checkboard",
        category = "other",
        name = ccb.content.plural_text("compact checkerboard", "compact checkerboards"),
        description = ccb.content.text("A pair of smaller checkered wooden boards that together form a compact checkerboard.  Useful as timber or for crafting a smaller chess or checkers board."),
        mass_milligrams = 200000,
        volume_ml = 1000,
        longest_side_mm = 150,
        symbol = "?",
        color = "white",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    -- Based on folded volume of https://www.amazon.co.uk/Big-Game-Hunters-Portable-Wooden/dp/B07XVKG4YY/ref=sr_1_6?crid=1N6NEJ01S0U4V&keywords=chess+set&qid=1684582085&sprefix=chess+se%2Caps%2C117&sr=8-6
    local item = content.Item {
        id = "chess",
        category = "other",
        name = ccb.content.plural_text("chess set", "chess sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of chess."),
        mass_milligrams = 550000,
        volume_ml = 2400,
        longest_side_mm = 300,
        price_cents = 1600,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "small_chess",
        category = "other",
        name = ccb.content.plural_text("compact chess set", "compact chess sets"),
        description = ccb.content.text("A smaller and compact counterpart of the standard chess set, perfect for casual play and travel.  It contains all the pieces needed to play a game of chess."),
        mass_milligrams = 275000,
        volume_ml = 1200,
        longest_side_mm = 150,
        price_cents = 1600,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "checkers",
        category = "other",
        name = ccb.content.plural_text("checkers set", "checkers sets"),
        description = ccb.content.text("A wooden box containing a set of round tokens used to play checkers."),
        mass_milligrams = 788000,
        volume_ml = 1500,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "tangram",
        category = "other",
        name = ccb.content.plural_text("tangram set", "tangram sets"),
        description = ccb.content.text("A modest wooden box containing a square base, two small triangles, two large triangles, a parallelogram, and a rhombus, all painted in different colors to play the traditional Chinese puzzle of tangram.  At the box, there are several figures that you can make with the pieces."),
        mass_milligrams = 788000,
        volume_ml = 1500,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "chinese_checkers",
        category = "other",
        name = ccb.content.plural_text("Chinese checkers set", "Chinese checkers sets"),
        description = ccb.content.text("A wooden box containing a wooden board with a star-shaped pattern, ten holes in each of its six arms, and a set of round pegs used to play Chinese checkers.  In the box, there's a comprehensible explanation of how to play the game."),
        mass_milligrams = 2072000,
        volume_ml = 4720,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "mancala",
        category = "other",
        name = ccb.content.plural_text("mancala set", "mancala sets"),
        description = ccb.content.text("A somewhat large wooden box containing a rectangular wooden board with a series of small pits, as well as a number of game pieces that look like different colored beads.  The board features two rows of pits, with each player controlling the row of pits closest to them.  The game pieces are distributed evenly among the pits at the beginning of the game, and players take turns picking up and redistributing the pieces according to the rules.  In the box, there's a comprehensible step-by-step guide on how to play."),
        mass_milligrams = 1313000,
        volume_ml = 4668,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "connect_four",
        category = "other",
        name = ccb.content.plural_text("Four in a Row set", "Four in a Row sets"),
        description = ccb.content.text("A cardboard box containing a plastic grid with seven columns and six rows, and 42 colored discs, alongside a small booklet explaining how to play Four in a Row."),
        mass_milligrams = 680000,
        volume_ml = 600,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "rummy",
        category = "other",
        name = ccb.content.plural_text("Rummy-o set", "Rummy-o sets"),
        description = ccb.content.text("A cardboard box containing a grid, and various tiles akin to a classic deck of cards, alongside a booklet explaining how to play Rummy-o."),
        mass_milligrams = 907000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "othello",
        category = "other",
        name = ccb.content.plural_text("Reversi set", "Reversi sets"),
        description = ccb.content.text("A cardboard box containing a grid, and various round black and white pieces, alongside a booklet explaining how to play Reversi."),
        mass_milligrams = 900000,
        volume_ml = 1300,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "scrabble",
        category = "other",
        name = ccb.content.plural_text("Scrabble Letters set", "Scrabble Letters sets"),
        description = ccb.content.text("A board game cardboard box containing a proper board, and various letter tiles, meant to play Scrabble Letters alone or with friends."),
        mass_milligrams = 907000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "small_checkers",
        category = "other",
        name = ccb.content.plural_text("compact checkers set", "compact checkers sets"),
        description = ccb.content.text("A small and compact wooden box containing a set of round tokens used to play checkers.  Perfect for casual play and travel."),
        mass_milligrams = 394000,
        volume_ml = 750,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_checkers",
        category = "other",
        name = ccb.content.plural_text("makeshift checkers set", "makeshift checkers sets"),
        description = ccb.content.text("A piece of paper scribbled with a pattern identical to the checkerboard on a, well, checkerboard, along with all the necessary pieces and a container to store everything properly inside."),
        mass_milligrams = 100000,
        volume_ml = 500,
        price_cents = 1600,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "pictionary",
        category = "other",
        name = ccb.content.plural_text("Picturesque", "sets of Picturesque"),
        description = ccb.content.text("A game where one player draws an image, and the others attempt to guess what it is."),
        mass_milligrams = 350000,
        volume_ml = 500,
        price_cents = 1500,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "monopoly",
        category = "other",
        name = ccb.content.plural_text("Capitalism", "sets of Capitalism"),
        description = ccb.content.text("A game where players traverse around the board, buying property and swindling their friends."),
        mass_milligrams = 300000,
        volume_ml = 500,
        price_cents = 99,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "ouija",
        category = "other",
        name = ccb.content.plural_text("Ouija board", "Ouija boards"),
        description = ccb.content.text("A wooden board with the alphabet and numbers on its face.  Commonly used for communing with spirits of the dead.  A planchette is included in the set."),
        mass_milligrams = 357000,
        volume_ml = 1000,
        longest_side_mm = 360,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "red",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "dnd",
        category = "other",
        name = ccb.content.plural_text("Blobs and Bandits", "sets of Blobs and Bandits"),
        description = ccb.content.text("A roleplaying game set in the post-apocalypse, so you can pretend to survive the apocalypse while surviving the apocalypse."),
        mass_milligrams = 680000,
        volume_ml = 1250,
        price_cents = 12950,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "dnd_2",
        category = "other",
        name = ccb.content.plural_text("Wayfinder", "sets of Wayfinder"),
        description = ccb.content.text("A roleplaying game set in the a fantasy medieval world with goblins and orcs.  You can be a mage, a warrior, or a barbarian and go on epic adventures."),
        mass_milligrams = 680000,
        volume_ml = 1250,
        price_cents = 12950,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "dnd_3",
        category = "other",
        name = ccb.content.plural_text("Dawn of Man", "sets of Dawn of Man"),
        description = ccb.content.text("A roleplaying game set in the Stone Age.  There, you can choose different places in the world to start, select many different classes, and different species of hominids to survive the primitive world."),
        mass_milligrams = 680000,
        volume_ml = 1250,
        price_cents = 12950,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "g_warhammer",
        category = "other",
        name = ccb.content.plural_text("Battlehammer", "sets of Battlehammer"),
        description = ccb.content.text("A strategy game featuring a set of tiny figurines of fantasy creatures."),
        mass_milligrams = 680000,
        volume_ml = 1250,
        price_cents = 10880,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "g_warhammer40k",
        category = "other",
        name = ccb.content.plural_text("Battlehammer 20k", "sets of Battlehammer 20k"),
        description = ccb.content.text("A strategy game featuring a set of tiny figurines of space aliens and grotesque space marines."),
        mass_milligrams = 680000,
        volume_ml = 1250,
        price_cents = 10880,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "catan",
        category = "other",
        name = ccb.content.plural_text("Settlers of the Ranch", "sets of Settlers of the Ranch"),
        description = ccb.content.text("A strategy game where players build settlements and trade for supplies."),
        mass_milligrams = 804000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "agricola",
        category = "other",
        name = ccb.content.plural_text("Farmland", "sets of Farmland"),
        description = ccb.content.text("A fun strategy board game where players (or just a player, since you can play this alone as a solitaire board game) attempt to improve their farms by plowing fields, sowing crops, raising livestock, and expanding their families.  The game is set in the European farming community during the 17th century."),
        mass_milligrams = 904000,
        volume_ml = 1350,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "soyang",
        category = "other",
        name = ccb.content.plural_text("Soyang Farmers", "sets of Soyang Farmers"),
        description = ccb.content.text("A interesting strategy board game where players (or just a player, since you can play this alone as a solitaire board game) take roles of farmers in Ancient China, attempting to sell their crops at the market.  The game revolves around managing resources, fulfilling orders, and expanding the farm to become the most successful farmer."),
        mass_milligrams = 904000,
        volume_ml = 1350,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "friday",
        category = "other",
        name = ccb.content.plural_text("Survival Island", "sets of Survival Island"),
        description = ccb.content.text("A fun solo deck-building board game where a player takes on the role of Robinson Crusoe's mentor, trying to help him survive and escape from a deserted island.  This game is played in rounds, with the player using their deck-building skills to improve Robinson's abilities and combat various challenges that arise during his time on the island."),
        mass_milligrams = 708000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "nemo",
        category = "other",
        name = ccb.content.plural_text("Nemo's Sea", "sets of Nemo's Sea"),
        description = ccb.content.text("A thematic adventure board game designed for solo play.  It is based on Jules Verne's classic novel '20,000 Leagues Under the Sea' and allows players to step into the role of Captain Nemo as they navigate the oceans, encounter various challenges, and make critical decisions that impact their journey."),
        mass_milligrams = 904000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "knight_mage",
        category = "other",
        name = ccb.content.plural_text("Knight Mage", "sets of Knight Mage"),
        description = ccb.content.text("A highly strategic board game that combines elements of role-playing games with deck-building and traditional board game mechanics.  Players (or a solo player) take on the roles of powerful Knights Mages who explore the land, conquer cities, and engage in epic battles against various enemies.  The game features an intricate leveling system where players can enhance their characters' abilities and acquire new skills as they progress through the game."),
        mass_milligrams = 1120000,
        volume_ml = 1850,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "pandemic",
        category = "other",
        name = ccb.content.plural_text("Pathogen", "sets of Pathogen"),
        description = ccb.content.text("A intriguing and critically acclaimed cooperative board game where players (or just the player, as it can be played alone as a solitaire board game) take on different roles with unique abilities as members of a disease control team.  Their objective is to prevent global outbreaks and find cures for four deadly diseases before they escalate out of control."),
        mass_milligrams = 830000,
        volume_ml = 1300,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "scythe_game",
        category = "other",
        name = ccb.content.plural_text("Steam Gears", "sets of Steam Gears"),
        description = ccb.content.text("A strategy board game set in an alternate history, steampunk-themed world, where players assume the roles of workers, engineers, and factory owners in a fictional 1920's Eastern European country.  This game focuses on area control, engine building, and resource management, as players aim to achieve victory through various paths, such as military conquest, building up their factories, or completing secret objectives.  The best part?  You can play it alone too."),
        mass_milligrams = 964000,
        volume_ml = 1350,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "spirit_island",
        category = "other",
        name = ccb.content.plural_text("Deity Island", "sets of Deity Island"),
        description = ccb.content.text("A cooperative board game designed for 1-4 players, where each player takes on the role of a powerful deity defending an island from colonizing invaders.  Before the Cataclysm, inside the board gaming community, it was known for its deep strategic gameplay, thematic richness, and intricate mechanics."),
        mass_milligrams = 804000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    -- copy name and description from item
    local item = content.Item {
        id = "terraforming_mercury",
        category = "other",
        name = ccb.content.plural_text("Terraforming - Mercury", "sets of Terraforming - Mercury"),
        description = ccb.content.text("This board game is set in the 4300s, where corporations are working together to terraform the planet Mercury, the smallest and innermost planet in our solar system.  Each player (or just the player) will have unique abilities and resources at their disposal, and they will need to strategize and cooperate with one another to achieve their goals."),
        mass_milligrams = 1104000,
        volume_ml = 1500,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    item:variants {
        { id = "terraforming_mercury" },
        { id = "terraforming_mars", name = ccb.content.plural_text("Terraforming - Mars", "sets of Terraforming - Mars"), description = ccb.content.text("This board game is set in the 2400s, where corporations are working together to terraform the planet Mars and make it habitable for human life.  Players (or just a single player) take on the roles of these corporations and compete to contribute to the terraforming process by raising temperature, creating oceans, and cultivating greenery on the Martian surface.") },
        { id = "terraforming_venus", name = ccb.content.plural_text("Terraforming - Venus", "sets of Terraforming - Venus"), description = ccb.content.text("Another epic edition of the Terraforming board game series, it is set in the 2700s.  The player OR the players take on the role of corporations competing to transform Venus into a habitable planet by increasing its temperature, oxygen levels, and increasing the number of oceans.  The game progresses through several rounds, with each round consisting of various phases.") },
        { id = "terraforming_jupiter", name = ccb.content.plural_text("Terraforming - Jupiter", "sets of Terraforming - Jupiter"), description = ccb.content.text("The largest edition of Terraforming, this epic board game is set in the 5000s, where players (or just the player) take on the role of corporations competing to terraform and colonize the gas giant Jupiter and its moons (the Jovian System).  This game combines elements of strategy, resource management, and exploration as players work to transform the hostile environment of the Jovian System into a habitable zone for human civilization.") },
        { id = "terraforming_saturn", name = ccb.content.plural_text("Terraforming - Saturn", "sets of Terraforming - Saturn"), description = ccb.content.text("This board game is set in the 4600s, and there, the player or the players take on the role of corporations competing to terraform and/or colonize Saturn's moons, rings and Saturn itself, to make them habitable for human life.  The game combines elements of strategy, resource management, and area control, offering an immersive experience for players.") },
        { id = "terraforming_uranus", name = ccb.content.plural_text("Terraforming - Uranus", "sets of Terraforming - Uranus"), description = ccb.content.text("Another edition of the acclaimed board game Terraforming, this time set in the 3000s, where players or the player (again) take on the role of corporations working together to terraform the planet Uranus though various ways, such as increasing temperature, developing a proper atmosphere and development of oxygen.") },
        { id = "terraforming_neptune", name = ccb.content.plural_text("Terraforming - Neptune", "sets of Terraforming - Neptune"), description = ccb.content.text("This board game is set in the 2800s, and just like it's prequels, either a single player or players take on the roles of terraforming corporations, competing to transform the planet Neptune into a habitable environment for human life.") },
        { id = "terraforming_pluto", name = ccb.content.plural_text("Terraforming - Pluto", "sets of Terraforming - Pluto"), description = ccb.content.text("The smallest set of the Terraforming series, this board game is set in the 2700s in the outer reaches of our solar system.  In this game, players take on the roles of corporations competing to terraform and colonize the dwarf planet Pluto, utilizing resources, technology, and strategic decision-making to transform the icy world into a habitable environment.") },
        { id = "terraforming_earth", name = ccb.content.plural_text("Terraforming - Earth", "sets of Terraforming - Earth"), description = ccb.content.text("This board game is set in the 5000s, a distant future where Earth has become uninhabitable due to climate change, resource depletion, and overpopulation.  The player or players must work together to restore the planet's ecosystems, atmosphere, and climate while also competing for resources and prestige.") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "viticulture",
        category = "other",
        name = ccb.content.plural_text("Vigneto", "sets of Vigneto"),
        description = ccb.content.text("A fun strategy board game that simulates the experience of running a vineyard in Tuscany, Italy.  Players take on the roles of vineyard owners who must plant vines, harvest grapes, produce wine, and fulfill orders to earn victory points.  The game is played over several seasons, with players making strategic decisions about which actions to take each season to maximize their vineyard's productivity and efficiency."),
        mass_milligrams = 904000,
        volume_ml = 1350,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "feast_for_odin",
        category = "other",
        name = ccb.content.plural_text("For Odin", "sets of For Odin"),
        description = ccb.content.text("In this great strategy board game, players (or the player) assume the role of a Viking chieftain, aiming to expand their territory, amass wealth, and gain favor with the Norse gods.  Players take turns performing actions, such as exploring new territories, constructing buildings, raiding settlements, and trading goods."),
        mass_milligrams = 1004000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "fields_of_arle",
        category = "other",
        name = ccb.content.plural_text("Arle Lands", "sets of Arle Lands"),
        description = ccb.content.text("A great strategy board game set in the 18th century in the East Frisia region of Germany, where players (or the player) take on the roles of farmers who are developing their farms and expanding their resources."),
        mass_milligrams = 904000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "gloomhaven",
        category = "other",
        name = ccb.content.plural_text("Enigma Emporium", "sets of Enigma Emporium"),
        description = ccb.content.text("A great cooperation-focused fantasy board game set in a dark and evolving fantasy world where players take on the roles of mercenaries seeking fortune and glory in the city of Emporium and its surrounding areas.  This game is characterized by its legacy-style gameplay, which means that decisions made during one play session can have lasting effects on future sessions.  Players must work together to explore dungeons, battle monsters, complete quests, and make choices that shape the narrative and outcome of their campaign."),
        mass_milligrams = 904000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "le_havre",
        category = "other",
        name = ccb.content.plural_text("Le Pourt: The Inland Port", "sets of Le Pourt: The Inland Port"),
        description = ccb.content.text("A strategy board game where players (or the player) aim to amass wealth and construct buildings to expand their harbors while carefully managing their resources in the fictitious French region of Le Pourt.  This game involves strategic decision-making as players must balance their investments in buildings, ships, and resources to maximize their profits."),
        mass_milligrams = 904000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "mansions_of_madness",
        category = "other",
        name = ccb.content.plural_text("Crazy Mansions", "sets of Crazy Mansions"),
        description = ccb.content.text("A cooperative horror board game set in the Lovecraftian Universe.  It offers an immersive gameplay experience where players work together to solve mysteries and confront otherworldly horrors.  This game is scenario-based, with each scenario presenting a unique narrative and set of challenges for the players to overcome.  Players must explore the game board, gather clues, solve puzzles, and engage in combat encounters while uncovering the secrets hidden within the mansion or other eerie locations."),
        mass_milligrams = 804000,
        volume_ml = 1250,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "world_nations",
        category = "other",
        name = ccb.content.plural_text("World Nations", "sets of World Nations"),
        description = ccb.content.text("A strategic board game that simulates the rise and fall of nations.  A great civilization-building game designed for 1-4 players.  Each player takes on the role of leading an ancient civilization, making strategic decisions to develop their nation over the course of several ages.  This game involves managing resources, constructing buildings, and competing with other players to achieve dominance in various aspects such as military strength, culture, and economy."),
        mass_milligrams = 904000,
        volume_ml = 1260,
        price_cents = 7050,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "light_blue",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "senet",
        category = "other",
        name = ccb.content.plural_text("senet set", "senet sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of senet, along with a rule booklet.  A board game from ancient Egypt, Senet plays like modern chess with a 3x10 grid and a smaller amount of pieces."),
        mass_milligrams = 800000,
        volume_ml = 2630,
        price_cents = 4300,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "mahjong",
        category = "other",
        name = ccb.content.plural_text("mahjong set", "mahjong sets"),
        description = ccb.content.text("A very beautiful, and really huge plastic box, containing all the pieces needed to play a game of mahjong, along with a poorly-translated but comprehensible rule booklet.  Mahjong is a tile-based game where you need to match pieces into winning hands to earn points."),
        mass_milligrams = 4000000,
        volume_ml = 4345,
        price_cents = 3600,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "chaturanga",
        category = "other",
        name = ccb.content.plural_text("chaturanga chess set", "chaturanga chess sets"),
        description = ccb.content.text("A polished wooden box containing all the pieces needed to play a game of chaturanga chess, along with a rule booklet.  Chaturanga is an ancient Indian strategy game, the ancestor of many other chess variations - European, Chinese, Japanese, and other regional variants of chess owe it their origin."),
        mass_milligrams = 2593000,
        volume_ml = 5719,
        price_cents = 4500,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "backgammon",
        category = "other",
        name = ccb.content.plural_text("backgammon set", "backgammon sets"),
        description = ccb.content.text("A very nice dark wooden box containing all the pieces needed to play a game of backgammon, along with a handwritten set of rules.  The objective of the game is to be the first to remove all fifteen of your own pieces from the board."),
        mass_milligrams = 1560000,
        volume_ml = 3073,
        price_cents = 2850,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "dark_gray",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "latrunculi",
        category = "other",
        name = ccb.content.plural_text("latrunculi set", "latrunculi sets"),
        description = ccb.content.text("A small wooden box containing all the pieces needed to play a game of latrunculi, along with a rule booklet.  Latrunculi was played throughout the Roman Empire, and requires a lot of tactics and strategy."),
        mass_milligrams = 350000,
        volume_ml = 1977,
        price_cents = 2680,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("paper", 2)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "go",
        category = "other",
        name = ccb.content.plural_text("go set", "go sets"),
        mass_milligrams = 780000,
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of go, along with a bilingual English/Mandarin rule booklet.  Go is a two-player game where each player tries to grab more territory than their opponent."),
        volume_ml = 1299,
        price_cents = 4670,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "shogi",
        category = "other",
        name = ccb.content.plural_text("shogi set", "shogi sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of shogi, along with a bilingual English/Japanese rule booklet.  Also known as Japanese chess, shogi was one of the most popular board games in Japan before the Cataclysm.  The main objective is to tsumi (checkmate) the opponent's osho (king)."),
        mass_milligrams = 2571000,
        volume_ml = 3033,
        price_cents = 5900,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "hnefatafl",
        category = "other",
        name = ccb.content.plural_text("hnefatafl set", "hnefatafl sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of hnefatafl, along with a rule booklet that features heavy use of Norse runes.  Also called 'Viking Chess', it was a popular game in medieval Scandinavia.  The player controlling the attackers (located on the sides of the board), wins by capturing the defender's king, while the defender wins by getting the king to one of the four corners of the board."),
        mass_milligrams = 900000,
        volume_ml = 5420,
        price_cents = 4000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "alquerque",
        category = "other",
        name = ccb.content.plural_text("alquerque set", "alquerque sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of alquerque, along with a rule booklet.  Alquerque is of Middle Eastern origin, and is an ancestor to checkers and Fanorona."),
        mass_milligrams = 880000,
        volume_ml = 2774,
        price_cents = 2500,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "domino",
        category = "other",
        name = ccb.content.plural_text("dominoes set", "dominoes sets"),
        description = ccb.content.text("A wooden box containing all the pieces needed to play a game of dominoes.  The pieces of this one are perfectly handmade in light wood."),
        mass_milligrams = 120000,
        volume_ml = 241,
        price_cents = 50,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "jackstraws",
        category = "other",
        name = ccb.content.plural_text("jackstraws set", "jackstraws sets"),
        description = ccb.content.text("A cardboard tube containing 60 pieces in various colors for playing a casual pick-up sticks game alone or with friends.  The rules and different values of each color are printed on the tube."),
        mass_milligrams = 82000,
        volume_ml = 798,
        price_cents = 50,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("wood", 1)
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "snakesnladders",
        category = "other",
        name = ccb.content.plural_text("Snakes and Ladders", "Snakes and Ladders"),
        description = ccb.content.text("A board game for two or more players, regarded before the Cataclysm as a worldwide classic.  The objective of the game is to navigate one's game piece to the goal on the board, helped by climbing ladders but hindered by sliding down snakes."),
        mass_milligrams = 300000,
        volume_ml = 1800,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "green",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "ludo",
        category = "other",
        name = ccb.content.plural_text("Ludo", "Ludos"),
        description = ccb.content.text("A strategy board game for two to four players, in which the players race their four tokens from start to finish according to the rolls of a single die."),
        mass_milligrams = 420000,
        volume_ml = 2981,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "white",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "poppirate",
        category = "other",
        name = ccb.content.plural_text("Pop-up Pirate", "Pop-up Pirates"),
        description = ccb.content.text("A game of chance featuring a silly-looking pirate inside a spring-loaded barrel.  Players take turns inserting plastic swords into slots in the barrel, hoping to avoid the trigger slot that causes the pirate to be launched out of the barrel."),
        mass_milligrams = 1500000,
        volume_ml = 8519,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "ambush",
        category = "other",
        name = ccb.content.plural_text("Ambuscade!", "Ambuscade!"),
        description = ccb.content.text("A board wargame that can be played alone or with friends.  When playing alone, the opponent's actions are chosen via tables, charts, and a 'paragraph book'."),
        mass_milligrams = 1020000,
        volume_ml = 3363,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "green",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "ranger",
        category = "other",
        name = ccb.content.plural_text("Patrol Leader", "Patrol Leader"),
        description = ccb.content.text("A tactical solitaire board game.  The player is put in the role of a patrol leader in different modern battlefield scenarios, performing missions, capturing or killing enemies, protecting their teammates, and advancing on the map."),
        mass_milligrams = 1090000,
        volume_ml = 5112,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "openfire",
        category = "other",
        name = ccb.content.plural_text("War Tanks", "War Tanks"),
        description = ccb.content.text("A tactical solitaire board game.  The player controls a platoon of tanks in six different scenarios with various victory conditions.  The player travels across the map, entering combat when an 'event marker' comes into their line of sight."),
        mass_milligrams = 840000,
        volume_ml = 3660,
        price_cents = 25,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "battleship",
        category = "other",
        name = ccb.content.plural_text("Warships", "sets of Warships"),
        description = ccb.content.text("A game where players try to guess where the opponent placed their ships on the board."),
        mass_milligrams = 450000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "blue",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "clue",
        category = "other",
        name = ccb.content.plural_text("Murder Mystery", "sets of Murder Mystery"),
        description = ccb.content.text("A game where players try to figure out who murdered the butler."),
        mass_milligrams = 370000,
        volume_ml = 500,
        price_cents = 2480,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "blue",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    content.add(item)
end

do
    local item = content.Item {
        id = "cigar_cutter",
        category = "other",
        name = ccb.content.plural_text("cigar cutter", "cigar cutters"),
        description = ccb.content.text("A set of small blades that pinch together to cut the end off of a cigar."),
        mass_milligrams = 52000,
        volume_ml = 13,
        longest_side_mm = 90,
        price_cents = 2200,
        price_postapoc_cents = 5,
        symbol = "-",
        color = "yellow",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "cigar_punch",
        category = "other",
        name = ccb.content.plural_text("cigar punch", "cigar punches"),
        description = ccb.content.text("A small tube meant to cut a hole in the end of a cigar."),
        mass_milligrams = 25000,
        volume_ml = 20,
        price_cents = 1200,
        price_postapoc_cents = 0,
        symbol = "o",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_microphone",
        name = ccb.content.plural_text("NRE microphone", "NRE microphones"),
        description = ccb.content.text("A squat tripod supports what appears to be a rather long microphone encased within a glass ampoule.  You can't tell whether it's meant to record audio, or something else entirely."),
        symbol = "i",
        color = "dark_gray",
        volume_ml = 2100,
        mass_milligrams = 745000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ruler",
        name = ccb.content.plural_text("ruler", "rulers"),
        description = ccb.content.text("A plastic ruler used to measure lengths of smaller objects.  This one measures 15 cm."),
        mass_milligrams = 9000,
        volume_ml = 10,
        longest_side_mm = 160,
        price_cents = 500,
        price_postapoc_cents = 10,
        symbol = "I",
        color = "cyan",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "eraser",
        name = ccb.content.plural_text("eraser", "erasers"),
        description = ccb.content.text("A small eraser used to clear up unwanted pencil handwriting."),
        mass_milligrams = 4000,
        volume_ml = 10,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "white",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sharpener",
        name = ccb.content.plural_text("pencil sharpener", "pencil sharpeners"),
        description = ccb.content.text("A small sharpener used to keep pencils in working order."),
        mass_milligrams = 7000,
        volume_ml = 10,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "light_gray",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "doormat",
        name = ccb.content.plural_text("doormat", "doormats"),
        description = ccb.content.text("A non-slip mat with a welcoming message.  Once used to keep a house clean and inviting."),
        mass_milligrams = 1500000,
        volume_ml = 3000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "_",
        color = "brown",
    }
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "LIXA_lab_file",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("LIXA on-site staff notice", "LIXA on-site staff notices"),
        snippet_category = "LIXA_lab_files",
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A brief with the word LIXA on the official letterhead, for distribution to the onsite staff."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "LIXA_generic_file",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("LIXA data file", "LIXA data files"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheaf of papers containing a truly dizzying assortment of graphs, diagrams, and equations, on LIXA letterhead."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "LIXA_mil_file",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("LIXA military notice", "LIXA military notices"),
        snippet_category = "LIXA_mil_files",
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A signed and serialed notice distributed to LIXA's onsite military police."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_book",
        name = ccb.content.plural_text("battered glass storybook", "battered glass storybooks"),
        description = ccb.content.text("A black glass model of an old, tattered little book with a broken spine.  To your surprise, it can be opened to a place in the middle.  Inside, the pages are blank and perfectly reflective."),
        category = "other",
        mass_milligrams = 600000,
        volume_ml = 400,
        looks_like = "philosophy_book",
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "dark_gray",
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_apple",
        name = ccb.content.plural_text("withered glass apple", "withered glass apples"),
        description = ccb.content.text("A glass model of an apple that has begun to rot.  In places, it sags away from the core.  Inside, the seeds are still pristine."),
        category = "other",
        mass_milligrams = 150000,
        volume_ml = 100,
        looks_like = "apple",
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "dark_gray",
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_boat",
        name = ccb.content.plural_text("broken glass boat", "broken glass boats"),
        description = ccb.content.text("A black glass model of an old sailing ship, with a gaping hole smashed in the side of the hull.  It's certainly no longer suited for long voyages."),
        category = "other",
        mass_milligrams = 350000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "dark_gray",
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "black_glass_shard",
        symbol = ",",
        color = "black",
        name = ccb.content.plural_text("black glass shard", "black glass shards"),
        category = "other",
        description = ccb.content.text("A shard of black glass that is almost impossible to touch without cutting yourself.  It doesn't reflect anything, but sometimes you think you catch a glimpse of something in it anyway."),
        mass_milligrams = 75000,
        volume_ml = 30,
        melee_to_hit = -5,
        weapon_categories = { "SHIVS" },
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "sketch",
        copy_from = "paper",
        looks_like = "paper",
        category = "other",
        name = ccb.content.plural_text("sketch", "sketches"),
        description = ccb.content.text("A piece of graphite-based artwork someone has drawn on a spare sheet of paper."),
        price_cents = 0,
        price_postapoc_cents = 5,
    }
    item:variants {
        { id = "sketch_goofy_doodles", name = ccb.content.plural_text("goofy doodle", "goofy doodles"), description = ccb.content.text("This one is a collection of assorted doodles of goofy cartoon characters in varying styles."), append = true, weight = 10 },
        { id = "sketch_dark_doodles", name = ccb.content.plural_text("disturbing sketch", "disturbing sketches"), description = ccb.content.text("This one is a collection of assorted doodles, many have dark imagery and shadowy figures.  It's kind of disturbing."), append = true, weight = 2 },
        { id = "sketch_dark_character_doodles", name = ccb.content.plural_text("disturbing sketch", "disturbing sketches"), description = ccb.content.text("This one is a <sketch_concept_description> <random_character_pose_dark>.  <artist_identifying_info>.  It gives off a sense of unease."), append = true, expand_snippets = true, weight = 2 },
        { id = "sketch_concept_doodles", name = ccb.content.plural_text("concept sketch", "concept sketches"), description = ccb.content.text("This one is a <sketch_concept_description> <random_character_pose>.  <artist_identifying_info>.  It would appear that this is some sort of concept art."), append = true, expand_snippets = true, weight = 7 },
    }
    content.add(item)
end

do
    -- This is a moreso side project someone made, rather than an official project.
    local item = content.Item {
        id = "painting",
        copy_from = "sheet_canvas",
        looks_like = "sheet_canvas",
        category = "other",
        name = ccb.content.plural_text("painting", "paintings"),
        description = ccb.content.text("A painting that someone has made."),
        price_cents = 10000,
        price_postapoc_cents = 100,
    }
    item:variants {
        { id = "painting_character", name = ccb.content.plural_text("character portrait", "character portraits"), description = ccb.content.text("This painting depicts a <sketch_concept_description> <random_character_pose>.  It seems to have been <painting_type_with_style>.  <artist_identifying_info>."), append = true, expand_snippets = true, weight = 5 },
        { id = "painting_landscape", name = ccb.content.plural_text("landscape painting", "landscape paintings"), description = ccb.content.text("This painting depicts a <landscape_description>.  It seems to have been <painting_type_with_style>.  <artist_identifying_info>."), append = true, expand_snippets = true, weight = 10 },
        { id = "painting_abstract", name = ccb.content.plural_text("abstract painting", "abstract paintings"), description = ccb.content.text("This painting depicts <abstract_art_type>.  It seems to have been <painting_type>.  <artist_identifying_info>."), append = true, expand_snippets = true, weight = 7 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sculpture_rock",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("stone sculpture", "stone sculptures"),
        description = ccb.content.text("A medium-sized stone sculpture."),
        category = "other",
        mass_milligrams = 7884000,
        volume_ml = 20813,
        longest_side_mm = 300,
        price_cents = 100000,
        price_postapoc_cents = 100,
    }
    item:material("stone", 1)
    item:variants {
        { id = "statue_person", name = ccb.content.plural_text("stone statue", "stone statues"), description = ccb.content.text("This statue depicts a <sculpture_person_description> <random_character_pose_statue>."), append = true, expand_snippets = true, weight = 10 },
        { id = "statue_releif", name = ccb.content.plural_text("abstract stone statue", "abstract stone statues"), description = ccb.content.text("This statue depicts <abstract_statue_type>."), append = true, expand_snippets = true, weight = 7 },
        { id = "sculpture_releif", name = ccb.content.plural_text("stone relief", "stone reliefs"), description = ccb.content.text("This relief depicts a <sketch_concept_description> <random_character_pose_statue>."), append = true, expand_snippets = true, weight = 8 },
        { id = "sculpture_releif", name = ccb.content.plural_text("stone landscape relief", "stone landscape reliefs"), description = ccb.content.text("This relief depicts a <landscape_description>."), append = true, expand_snippets = true, weight = 8 },
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    -- inherit name from item
    local item = content.Item {
        id = "sculpture_clay",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("clay sculpture", "clay sculptures"),
        description = ccb.content.text("A small clay sculpture."),
        category = "other",
        mass_milligrams = 150000,
        volume_ml = 94,
        longest_side_mm = 300,
        price_cents = 80000,
        price_postapoc_cents = 25,
    }
    item:material("clay", 1)
    item:variants {
        { id = "statue_person", description = ccb.content.text("This statue depicts a <sculpture_person_description> <random_character_pose_statue>."), append = true, expand_snippets = true, weight = 10 },
        { id = "statue_releif", name = ccb.content.plural_text("abstract clay sculpture", "abstract clay sculptures"), description = ccb.content.text("This statue depicts <abstract_statue_type>."), append = true, expand_snippets = true, weight = 7 },
        { id = "sculpture_releif", name = ccb.content.plural_text("clay relief", "clay reliefs"), description = ccb.content.text("This relief depicts a <sketch_concept_description> <random_character_pose_statue>."), append = true, expand_snippets = true, weight = 8 },
        { id = "sculpture_releif", name = ccb.content.plural_text("clay landscape relief", "clay landscape reliefs"), description = ccb.content.text("This relief depicts a <landscape_description>."), append = true, expand_snippets = true, weight = 8 },
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "butterfly_net_makeshift",
        name = ccb.content.plural_text("butterfly net", "butterfly nets"),
        description = ccb.content.text("A piece of canvas stretched over a stick.  Used to catch bugs or fish, but might not be as useful for the mutated ones."),
        mass_milligrams = 376000,
        volume_ml = 865,
        longest_side_mm = 920,
        color = "brown",
        symbol = "P",
        melee_to_hit = 1,
        price_cents = 1800,
        price_postapoc_cents = 5,
    }
    item:material("wood", 7)
    item:material("canvas", 3)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    -- Stats from a 10/22 lock I had laying about.  If the length or volume seems weird, the cable doesn't fold all the way so it's an odd shape.
    local item = content.Item {
        id = "gun_lock",
        name = ccb.content.plural_text("gun cable lock", "gun cable locks"),
        description = ccb.content.text("A set with a key and a small lock, resembling a padlock if the shackle was replaced by a steel cable.  This design allows the cable to fit into the chamber of a firearm and lock, preventing the firearm from functioning.  An important part of gun safety, it is required by law to be sold with any firearm."),
        mass_milligrams = 83000,
        volume_ml = 53,
        longest_side_mm = 90,
        color = "dark_gray",
        symbol = "P",
        price_cents = 1499,
        price_postapoc_cents = 5,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "alien_leaves",
        copy_from = "leaves",
        name = ccb.content.plural_text("handful of alien leaves", "handfuls of alien leaves"),
        looks_like = "withered",
        description = ccb.content.text("A handful of dry leaves(?) from an alien plant.  Despite their otherworldly origin, they have very few uses and are thus (almost) only good for burning."),
        color = "red",
        symbol = ",",
        stackable = true,
    }
    content.add(item)
end
