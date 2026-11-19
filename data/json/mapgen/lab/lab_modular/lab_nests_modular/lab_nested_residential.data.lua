local ccb = require("ccb")

-- A nested map for small residential areas. For extra population.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_12x12_small_rooms_A",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "@@ d|||d @@|",
            "s   +,+   s|",
            "T  R|,|R  T|",
            "|||||,||||||",
            "    +,+    |",
            "9|St|,|tS|9|",
            "|||||,||||||",
            "@s R|,|R s@|",
            "@   +,+   @|",
            "T  d|,|d  T|",
            "|||||,||||||",
            "U+,,,,,,,+w|",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for small residential areas. For extra population.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_12x12_small_rooms_B",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|@@ d|||d @@",
            "|s   +,+   s",
            "|T  R|,|R  T",
            "||||||,|||||",
            "|    +,+    ",
            "|9|St|,|tS|9",
            "||||||,|||||",
            "|@s R|,|R s@",
            "|@   +,+   @",
            "|T  d|,|d  T",
            "||||||,|||||",
            "|U+,,,,,,,+w",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}
