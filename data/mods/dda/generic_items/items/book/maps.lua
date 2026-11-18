local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "labmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("handwritten note", "handwritten notes"),
        description = ccb.content.text("A small, meticulously folded piece of paper, filled with tiny handwriting and some surprisingly precise diagrams of subway tunnels, ventilation shafts, and… guard shifts?  You have the feeling they weren't supposed to write any of this stuff down."),
        color = "blue",
        volume_ml = 10,
        mass_milligrams = 10000,
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add the hidden stations to your map"),
        terrains = {
            { id = "lab_subway" },
            { id = "microlab_sub_connector" },
            { id = "microlab_sub_station" },
            { id = "underground_lab_cargo_stationA" },
        },
    }
    item:clear_flags()
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:flag("PAPER_SHAPED")
    item:flag("PRESERVE_SPAWN_LOC")
    content.add(item)
end

do
    local item = content.Item {
        id = "militarymap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("military operations map", "military operations maps"),
        description = ccb.content.text("A printed topographical map of the local area.  Originally of military origin, it details the locations of evacuation centers and military facilities.  Using it will add points of interest to your map."),
        color = "green",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 135,
        message = ccb.content.text("You add roads and facilities to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "fema_entrance" },
            { id = "bunker", match = "TYPE" },
            { id = "helipad_nw" },
            { id = "outpost", match = "TYPE" },
            { id = "silo", match = "TYPE" },
            { id = "shelter", match = "PREFIX" },
            { id = "police" },
            { id = "mil_base_road_entrance" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "survivormap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("survivor's map", "survivor's maps"),
        description = ccb.content.text("A hand-drawn map of the local area.  Whoever created it has marked down the locations of nearby supply sources including gun stores and gas stations.  Using it will add points of interest to your map."),
        color = "white",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and possible supply points to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "s_pharm" },
            { id = "s_gun" },
            { id = "s_grocery" },
            { id = "s_hunting" },
            { id = "mil_surplus" },
            { id = "Gas Station" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "roadmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("road map", "road maps"),
        description = ccb.content.text("A road map for the local area.  Listing information on civic sites like hospitals and police stations, it can be used to add points of interest to your map."),
        color = "yellow",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and points of interest to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "hw", match = "PREFIX" },
            { id = "s_gas", match = "TYPE" },
            { id = "s_gas_rural", match = "TYPE" },
            { id = "roadstop" },
            { id = "bridge" },
            { id = "hospital" },
            { id = "school" },
            { id = "police" },
            { id = "sub_station", match = "TYPE" },
            { id = "bank" },
            { id = "town_hall" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "subwaymap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("subway maintenance map", "subway maintenance maps"),
        looks_like = "roadmap",
        description = ccb.content.text("A map of subway tunnels formerly used by public maintenance workers.  Using it will add subway lines and underground stations to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add subway lines and underground stations to your map."),
        terrains = { { id = "subway", match = "TYPE" }, { id = "underground_sub_station", match = "TYPE" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "subwaystationmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("subway map", "subway maps"),
        looks_like = "roadmap",
        description = ccb.content.text("A schematic diagram of local subway networks, too stylized to garter much useful information.  Using it will add subway stations to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add subway stations to your map."),
        terrains = { { id = "sub_station", match = "TYPE" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sewermap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("drainage system map", "drainage system maps"),
        looks_like = "roadmap",
        description = ccb.content.text("A map of sewers formerly used by public maintenance workers.  Using it will add sewer systems and facilities to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add sewer systems and facilities to your map."),
        terrains = {
            { id = "sewer", match = "TYPE" },
            { id = "cs_open_sewer" },
            { id = "sewage_treatment" },
            { id = "manhole" },
            { id = "pump_station" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "trailmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("trail guide", "trail guides"),
        description = ccb.content.text("A printed guide to the best local trails.  It has general details about the trails, trailhead amenities, suggestions for the best thru-hikes, and advice on interacting with local wildlife in a responsible and respectful manner."),
        color = "green",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add trails and trailheads to your map."),
        terrains = { { id = "forest_trail" }, { id = "trailhead" }, { id = "trail_intersection" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "touristmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("tourist guide", "tourist guides"),
        description = ccb.content.text("This is glossy printed pamphlet for tourists that details local hotels and attractions."),
        color = "blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and tourist attractions to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "hotel_tower" },
            { id = "s_restaurant" },
            { id = "cathedral" },
            { id = "s_restaurant_fast" },
            { id = "megastore" },
            { id = "museum" },
            { id = "zoo" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "restaurantmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("restaurant guide", "restaurant guides"),
        description = ccb.content.text("This is glossy printed pamphlet that details dining establishments in the local area.  Printed by the Chamber of Commerce, it lists the addresses of all the best diners and bars.  Using it will add points of interest to your map."),
        color = "pink",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and restaurants to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "s_restaurant_coffee" },
            { id = "s_restaurant" },
            { id = "bar", match = "PREFIX" },
            { id = "s_pizza_parlor" },
            { id = "s_diner" },
            { id = "s_restaurant_fast" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "satellitemap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("satellite map", "satellite maps"),
        description = ccb.content.text("A printed satellite map of the local area.  Due to it's low quality and lack of map legend, you are unable to recognize most buildings.  Using it will add terrain and roads to your map."),
        color = "light_gray",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add terrain and roads to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "lake" },
            { id = "river", match = "PREFIX" },
            { id = "ocean", match = "PREFIX" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "urbexmap",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("urban explorer's map", "urban explorer's maps"),
        description = ccb.content.text("A printout of a local road map, with several buildings circled in red.  Using it will add roads and abandoned buildings to your map."),
        color = "white",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and abandoned buildings to your map."),
        terrains = {
            { id = "road", match = "PREFIX" },
            { id = "bridge" },
            { id = "desolatebarn" },
            { id = "shoppingplaza" },
            { id = "abandonedwarehouse", match = "TYPE" },
            { id = "abstorefront", match = "TYPE" },
            { id = "derelict_property", match = "TYPE" },
            { id = "abandoned_textile_mill_0_1", match = "TYPE" },
            { id = "abandoned_textile_mill_0_2", match = "TYPE" },
            { id = "abandoned_textile_mill_0_3", match = "TYPE" },
            { id = "abandoned_textile_mill_b_0_1", match = "TYPE" },
            { id = "abandoned_textile_mill_b_0_2", match = "TYPE" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "restaurantbrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("restaurant advertising brochure", "restaurant advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local restaurants with an address below each entry.  Using it will add roads and local restaurants, diners, and bars to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and local restaurants, diners, and bars to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "s_restaurant_coffee" },
            { id = "s_restaurant_fast" },
            { id = "s_restaurant" },
            { id = "s_pizza_parlor" },
            { id = "s_diner" },
            { id = "bar", match = "PREFIX" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "grocerybrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("food shopping advertising brochure", "food shopping advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local food shopping possibilities with an address below each entry.  Using it will add roads, local grocery and convenience stores, and bakeries to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, local grocery and convenience stores as well as bakeries to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "s_grocery" },
            { id = "trailer_commercial" },
            { id = "bakery" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "buylocalpamphlet",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("buy local pamphlet", "buy local pamphlets"),
        description = ccb.content.text("A small pamphlet advertising local goods and produce and places to purchase them.  Using it will add roads, markets, butchers, bakers and craft shops to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, markets, butchers, bakers and craft shops to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "bakery" },
            { id = "s_butcher" },
            { id = "craft_shop" },
            { id = "cs_market" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "getactivepamphlet",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("get active pamphlet", "get active pamphlets"),
        description = ccb.content.text("A small pamphlet advertising various local businesses encouraging you to get fit.  Using it will add roads, gyms, and pools along with shops where you can buy sporting gear to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, gyms, and pools along with shops where you can buy sporting gear to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "s_bike_shop" },
            { id = "gym_fitness" },
            { id = "gym" },
            { id = "dojo" },
            { id = "pool" },
            { id = "s_dive_shop" },
            { id = "s_sports" },
            { id = "tennis_court" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "petpamphlet",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("pet pamphlet", "pet pamphlets"),
        description = ccb.content.text("A small pamphlet advertising the benefits of different pets and local pet related facilities and shops.  Using it will add roads, pet shops, animal shelters, parks, trailheads, and vets to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, pet shops, animal shelters, parks, trailheads, and vets to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "park", match = "PREFIX" },
            { id = "veterinarian" },
            { id = "NatureTrail" },
            { id = "trailhead" },
            { id = "s_petstore" },
            { id = "animalshelter" },
            { id = "dog_park" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "nightlifepamphlet",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("nightlife pamphlet", "nightlife pamphlets"),
        description = ccb.content.text("A small pamphlet advertising local nightlife options.  Using it will add roads, bars, music venues, movie theaters, and gambling halls to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, bars, music venues, movie theaters, and gambling halls to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "bar", match = "PREFIX" },
            { id = "music_venue" },
            { id = "movietheater" },
            { id = "car_theater" },
            { id = "gambling_hall" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunnutpamphlet",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("gun nut pamphlet", "gun nut pamphlets"),
        description = ccb.content.text("A small pamphlet advertising current shooting related events and giving directions to local shooting facilities and gun stores funded by Remington.  Using it will add roads, gun stores, shooting ranges, outdoorsman stores, and any shows to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, gun stores, shooting ranges, outdoorsman stores, and any shows to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "s_gun" },
            { id = "s_hunting" },
            { id = "s_camping" },
            { id = "shootingrange" },
            { id = "gun show" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "historybrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("history advertising brochure", "history advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local museums, libraries and antique stores with an address below each entry.  Using it will add roads, local museums, libraries, and antique stores to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads, local museums, libraries, and antique stores to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "museum", match = "TYPE" },
            { id = "s_antique" },
            { id = "s_library" },
            { id = "fort", match = "PREFIX" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mallbrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("mall advertising brochure", "mall advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local malls with an address below each entry.  Using it will add roads, local malls, and strip malls to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 135,
        message = ccb.content.text("You add roads, local malls, and strip malls to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "mall_a_1" },
            { id = "mall_a_2" },
            { id = "mall_a_3" },
            { id = "mall_a_4" },
            { id = "mall_a_5" },
            { id = "mall_a_6" },
            { id = "mall_a_7" },
            { id = "mall_a_8" },
            { id = "mall_a_9" },
            { id = "strip_mall" },
            { id = "megastore_0_0_0" },
            { id = "megastore_1_0_0" },
            { id = "megastore_2_0_0" },
            { id = "megastore_0_1_0" },
            { id = "megastore_1_1_0" },
            { id = "megastore_2_1_0" },
            { id = "megastore_0_2_0" },
            { id = "megastore_1_2_0" },
            { id = "megastore_2_2_0" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "furniturebrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("furniture advertising brochure", "furniture advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local home improvement stores and with an address below each entry.  Using it will add roads, and local furniture, home improvement, and gardening stores to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and local furniture, home improvement and gardening stores to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "furniture" },
            { id = "home_improvement" },
            { id = "hdwr_large_1_2_0" },
            { id = "hdwr_large_0_2_0" },
            { id = "hdwr_large_1_1_0" },
            { id = "hdwr_large_0_1_0" },
            { id = "hdwr_large_1_0_0" },
            { id = "hdwr_large_0_0_0" },
            { id = "s_gardening", match = "TYPE" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "technologybrochure",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("technology advertising brochure", "technology advertising brochures"),
        description = ccb.content.text("A small brochure advertising for local electronic and hardware stores as well as arcades and internet cafes with an address below each entry.  Using it will add roads and local electronic and hardware stores as well as arcades and internet cafes to your map."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 90,
        message = ccb.content.text("You add roads and local electronic and hardware stores as well as arcades and internet cafes to your map."),
        terrains = {
            { id = "bridge" },
            { id = "road", match = "PREFIX" },
            { id = "s_electronicstore" },
            { id = "s_electronics" },
            { id = "s_hardware" },
            { id = "s_arcade" },
            { id = "cs_internet_cafe" },
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_field_notes_used",
        name = ccb.content.plural_text("field notebook (used)", "field notebooks (used)"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("A small notebook with \"X.E.D.R.A\" embossed on the cover.  It's filled with notes scribbled by pencil.  You've already searched it for useful information."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 90000,
        volume_ml = 150,
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note_used",
        name = ccb.content.plural_text("leather notebook (used)", "leather notebooks (used)"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("An absolutely ancient-looking, leather-bound journal.  The pages are gilded at the edges.  You've already searched it for useful information."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note_2_used",
        name = ccb.content.plural_text("sketched map (used)", "sketched maps (used)"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("An old scrap of yellow, lined paper.  On it, a very detailed map has been sketched.  You've already searched it for useful information."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note_3_used",
        name = ccb.content.plural_text("strange subway map (used)", "strange subway maps (used)"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("A subway map covered in strange symbols and sketches.  You've already searched it for useful information."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "godco_flier",
        copy_from = "abstractmap",
        name = ccb.content.plural_text("religious salvation flier", "religious salvation fliers"),
        description = ccb.content.text("A small flier describing the coming end of the world and a promises of an Ark that will save those within it from 'the Second Flood'. There's an address written on the flier, leading to something called the New England Community Church."),
        color = "light_blue",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 150,
        message = ccb.content.text("You add the location of the church to your map."),
        terrains = {
            { id = "godco_enter" },
            { id = "godco_1" },
            { id = "godco_2" },
            { id = "godco_3" },
            { id = "godco_4" },
            { id = "godco_5" },
            { id = "godco_6" },
            { id = "godco_7" },
            { id = "godco_8" },
            { id = "godco_9" },
        },
    }
    content.add(item)
end
