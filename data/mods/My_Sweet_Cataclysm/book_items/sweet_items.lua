local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "sugarkin_flyer",
        name = ccb.content.plural_text("SugarKin flyer", "SugarKin flyers"),
        description = ccb.content.text("A flyer for some kind of candy.  It shows a picture of a gleaming human made of smooth candy looking at you in terror.  \"SugarKin the first life-size human candy!  Are you a real monster?  Will you be able to devour it?\"\n On the back of the flyer you can see some hastily scribbled words:\n \"Hello, my child, welcome to this world.  A world where you'll be able to thrive if you follow a few rules:\n1) Never ever get into contact with water, it would melt you!\n2) Avoid humans with clear eyes they are very dangerous!  (You can ignore the ones with black eyes they are harmless to you.)\n3) Learn how to make caramel ointment, it's the only way to fix your body if you get hurt.\n There are many more things I'd like to tell you but I must leave before it's too late.  I've made you a friend to keep you company, be kind to it.\n I love you,\n - F.  \"."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
