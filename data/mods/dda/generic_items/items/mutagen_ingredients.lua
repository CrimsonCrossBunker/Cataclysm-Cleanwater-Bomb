local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "alpha_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("alpha sample", "alpha samples"),
        description = ccb.content.text("A slurry of superiority."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("hflesh", 1)
    item:material("hblood", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "batrachian_sample",
        copy_from = "mutagen_sample",
        color = "green",
        name = ccb.content.plural_text("frog sample", "frog samples"),
        description = ccb.content.text("A slurry of simplicity."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("slime", 1)
    item:material("blood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "beast_sample",
        copy_from = "mutagen_sample",
        color = "light_red",
        name = ccb.content.plural_text("beast sample", "beast samples"),
        description = ccb.content.text("A slurry of might."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("blood", 1)
    item:material("bone", 1)
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bird_sample",
        copy_from = "mutagen_sample",
        color = "cyan",
        name = ccb.content.plural_text("bird sample", "bird samples"),
        description = ccb.content.text("A slurry of freedom."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cattle_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("cattle sample", "cattle samples"),
        description = ccb.content.text("A slurry of tranquility."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("gutskin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cephalopod_sample",
        copy_from = "mutagen_sample",
        color = "dark_gray",
        name = ccb.content.plural_text("cephalopod sample", "cephalopod samples"),
        description = ccb.content.text("A slurry of curiosity."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("slime", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chimera_sample",
        copy_from = "mutagen_sample",
        color = "white",
        name = ccb.content.plural_text("chimera sample", "chimera samples"),
        description = ccb.content.text("A slurry of adaptation."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("gutskin", 1)
    item:material("bone", 1)
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "elfa_sample",
        copy_from = "mutagen_sample",
        color = "light_green",
        name = ccb.content.plural_text("Elf-A sample", "Elf-A samples"),
        description = ccb.content.text("A slurry of responsibility."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("veggy", 1)
    item:material("hblood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "feline_sample",
        copy_from = "mutagen_sample",
        color = "light_gray",
        name = ccb.content.plural_text("feline sample", "feline samples"),
        description = ccb.content.text("A slurry of flexibility."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("fur", 1)
    item:material("blood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fish_sample",
        copy_from = "mutagen_sample",
        color = "yellow",
        name = ccb.content.plural_text("fish sample", "fish samples"),
        description = ccb.content.text("A slurry of transformation."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("blood", 1)
    item:material("water", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "gastropod_sample",
        copy_from = "mutagen_sample",
        color = "brown_cyan",
        name = ccb.content.plural_text("snail sample", "snail samples"),
        description = ccb.content.text("A slurry of steadfastness."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("chitin", 1)
    item:material("slime", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "human_sample",
        copy_from = "mutagen_sample",
        color = "black_red",
        name = ccb.content.plural_text("human sample", "human samples"),
        description = ccb.content.text("A slurry of purity."),
        looks_like = "medical_sample",
    }
    item:material("hflesh", 1)
    item:material("hblood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "insect_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("insect sample", "insect samples"),
        description = ccb.content.text("A slurry of stability."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("iflesh", 1)
    item:material("chitin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lizard_sample",
        copy_from = "mutagen_sample",
        color = "green_cyan",
        name = ccb.content.plural_text("lizard sample", "lizard samples"),
        description = ccb.content.text("A slurry of healing."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("blood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "lupine_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("lupine sample", "lupine samples"),
        description = ccb.content.text("A slurry of community."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("fur", 1)
    item:material("flesh", 1)
    item:material("blood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "medical_sample",
        copy_from = "mutagen_sample",
        color = "magenta",
        name = ccb.content.plural_text("medical sample", "medical samples"),
        description = ccb.content.text("A slurry of satisfaction."),
        stackable = true,
    }
    item:material("hflesh", 1)
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mouse_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("mouse sample", "mouse samples"),
        description = ccb.content.text("A slurry of experimentation."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plant_sample",
        copy_from = "mutagen_sample",
        color = "green",
        name = ccb.content.plural_text("plant sample", "plant samples"),
        description = ccb.content.text("A slurry of peace."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("veggy", 1)
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rabbit_sample",
        copy_from = "mutagen_sample",
        color = "light_gray",
        name = ccb.content.plural_text("rabbit sample", "rabbit samples"),
        description = ccb.content.text("A slurry of luck."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rat_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("rat sample", "rat samples"),
        description = ccb.content.text("A slurry of survival."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("fur", 1)
    item:material("bone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "slime_sample",
        copy_from = "mutagen_sample",
        color = "light_green",
        name = ccb.content.plural_text("slime sample", "slime samples"),
        description = ccb.content.text("A slurry of sharing."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("slime", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spider_sample",
        copy_from = "mutagen_sample",
        color = "dark_gray",
        name = ccb.content.plural_text("spider sample", "spider samples"),
        description = ccb.content.text("A slurry of sustainability."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("chitin", 1)
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ursine_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("ursine sample", "ursine samples"),
        description = ccb.content.text("A slurry of toughness."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("fur", 1)
    item:material("gutskin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "crustacean_sample",
        copy_from = "mutagen_sample",
        color = "red",
        name = ccb.content.plural_text("crustacean sample", "crustacean samples"),
        description = ccb.content.text("A slurry of toughness."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("flesh", 1)
    item:material("chitin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chiropteran_sample",
        copy_from = "mutagen_sample",
        color = "brown",
        name = ccb.content.plural_text("chiropteran sample", "chiropteran samples"),
        description = ccb.content.text("A slurry of silence."),
        looks_like = "medical_sample",
        stackable = true,
    }
    item:material("bone", 1)
    item:material("blood", 1)
    content.add(item)
end
