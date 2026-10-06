local ccb = require("ccb")

local scenario = ccb.content.Scenario {
    id = "deadly_virus",
    name = ccb.content.text("Challenge - Deadly Virus Infection"),
    description = ccb.content.text("In the panic of a fleeing crowd, you were bitten by what you can only describe as a zombie.  A prickling sensation and a sense of doom washes over you, and you're not sure whether it's some kind of rabies or not.  Better seek out some antivirals just in case…"),
    start_name = ccb.content.text("In Town"),
    points = -8,
}
scenario:flag("CITY_START")
-- These are the starting locations previously inherited from infected.
for _, location in ipairs {
    "sloc_house",
    "sloc_house_boarded",
    "sloc_school",
    "sloc_grocery_store",
    "sloc_garage",
    "sloc_furniture_store",
    "sloc_library",
    "sloc_bookstore",
    "sloc_zoo_cafeteria",
    "sloc_golfcourse_mid_course",
    "sloc_golfcourse_clubhouse",
    "sloc_church",
    "sloc_cemetery",
    "sloc_town_hall",
    "sloc_hardware",
    "sloc_dojo",
    "sloc_gym",
    "sloc_clothes",
    "sloc_restaurant",
    "sloc_bar",
    "sloc_electronics",
    "sloc_arcade",
    "sloc_animalshelter",
    "sloc_laundromat",
    "sloc_stripclub",
    "sloc_sexshop",
    "sloc_candyshop",
    "sloc_bikeshop",
    "sloc_petstore",
} do
    scenario:location(location)
end
scenario:on_start("begin_deadly_virus")
ccb.content.add(scenario)
