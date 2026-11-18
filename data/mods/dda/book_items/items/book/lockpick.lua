local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_lockpick",
        category = "manuals",
        name = ccb.content.plural_text("MIT Guide to Lock Picking", "copies of MIT Guide to Lock Picking"),
        description = ccb.content.text("A home-made booklet with large black-and-white pictures of several types of modern locks and general information on how to crack them open."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 100,
        price_postapoc_cents = 5000,
        symbol = "?",
        looks_like = "pocket_firstaid",
        color = "green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    book:variants {
        {
            id = "book_lockpick",
            name = ccb.content.plural_text("MIT Guide to Lock Picking", "copies of MIT Guide to Lock Picking"),
            description = ccb.content.text("A home-made booklet with large black-and-white pictures of several types of modern locks and general information on how to crack them open."),
        },
        -- 978-1420957556
        {
            id = "book_lockpick_1",
            name = ccb.content.plural_text("The CIA Lockpicking Manual", "copies of The CIA Lockpicking Manual"),
            description = ccb.content.text("It says it is a reproduction of the United States Central Intelligence Agency's Field Operative Training Manual that describes how to lockpick.  For such a big name it has a surprisingly small amount of information, only covering the topic on a very basic level."),
        },
        -- 978-1597499835
        {
            id = "book_lockpick_2",
            name = ccb.content.plural_text("Keys To The Kingdom", "copies of Keys To The Kingdom"),
            description = ccb.content.text("This book contain lots of information for experienced lockpickers, like possible tools that can be used, different types of locks that were produced, and even some tips to avoid lockpicking - sometimes it's easier to break a lock, door, or even wall itself."),
        },
        -- no info
        {
            id = "book_lockpick_3",
            name = ccb.content.plural_text("E-Z Picking Manual", "copies of E-Z Picking Manual"),
            description = ccb.content.text("The combined experience of a few different locksmiths of how to do it properly, what skillset is required, and where it is legal to use it.  It says it comes with a DVD, but you can't find it anywhere nearby."),
        },
        -- 0-398-07079-2
        {
            id = "book_lockpick_4",
            name = ccb.content.plural_text("Locks, Safes, and Security", "copies of Locks, Safes, and Security"),
            description = ccb.content.text("This book is a reference work intended for criminal investigators, locksmiths, security personnel, and similar professionals.  It details the history, development, and design of various forms of locks, keys, and other security equipment."),
        },
    }
    content.add(book)
end
