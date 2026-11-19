local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_backpack_rockets",
    name = ccb.content.text("U38m munitions carrier"),
    description = ccb.content.text("A large carrying frame designed to hold up to 10 rockets or similarly shaped munitions on your back.  Most often used in conjunction with a lifting frame to manage the weight."),
    mass = "4 kg",
    volume = "18000 ml",
    price = "1 kUSD",
    survival_price = "1 kUSD",
    materials = { "nylon", "aluminum" },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
    },
    flags = { "BELTED", "WATERPROOF" },
    max_worn = 1,
    armor = {
        warmth = 10,
        thickness = 2,
        portions = {
            {
                encumbrance = { 3, 12 },
                volume_encumbrance = 0.2,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back", "torso_waist" },
            },
        },
    },
}
