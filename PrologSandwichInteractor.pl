/* Program begins when ask(0) command is entered */
ask(0):-
    write("********************************************************************************************************************"),nl,
    nl, write("Hello there ^_^! Welcome to Subway Sandwich! Please choose a meal(Select the number corresponding to the meal):"),nl,
    write("\n1 Regular Meal \n2 Healthy Meal \n3 Value Meal \n4 Veggie Meal \n5 Vegan Meal"),nl,
    write("Write your choice here ==>"),                              % Prompt user for meal type
    read(Choosen),                                                    % Take in user input for meal type
    assertz(meal_selected(Choosen)),                                  % Assert user input and store in database
    meal_choosen(0).                                                  % Calls the meal_choosen(0) predicate and the appropriate                                                                              meal_selected() option choosen by user will be called

/* Lists of different ingredients, i.e, bread, meat, vegetable, sauce, topup, cookie and drink */
bread([wheat, honey_oat, italian, hearty_italian, flatbread, wrap]).
meat([chicken, turkey, salmon, tuna, beef, ham, bacon]).
vegetable([avocado, cucumbers, lettuce, tomatoes, onions, green_peppers, olives, pickles]).
sauce([chipotle, bbq, ranch, sweet_chilli, mayo, ketchup, honey_mustard, sweet_onion, red_wine_vinegar, chilli]).
topup([american_cheese, cheddar, egg_mayo, mushroom_slices]).
cookie([whitechip_macadamianut, double_chocolatechip, chocolate_chip ,peanutbutter]).
drink([sprite, cola, fanta, pepsi, orange_juice, passion_fruit]).

/* Lists of different ingredients for the different meals available such as healthy, value, vegan and veggie meals. */
healthy([wheat, honey_oat, italian, hearty_italian, flatbread, wrap,chicken, turkey, salmon, tuna, beef, ham, bacon, avocado, cucumbers, lettuce, tomatoes, onions, green_peppers, olives, pickles, honey_mustard, sweet_onion, red_wine_vinegar, chilli, american_cheese,cheddar, egg_mayo, mushroom_slices, orange_juice, passion_fruit]).
value([wheat, honey_oat, italian, hearty_italian, flatbread, wrap,chicken, ham, avocado, cucumbers, lettuce, tomatoes, onions, green_peppers, olives, pickles,chipotle, bbq, ranch, sweet_chilli, mayo, ketchup,honey_mustard, sweet_onion, red_wine_vinegar, chilli]).
vegan([wheat, honey_oat, italian, hearty_italian, flatbread, wrap,avocado, cucumbers, lettuce, tomatoes, onions, green_peppers, olives, pickles,bbq, sweet_chilli, ketchup,honey_mustard, sweet_onion, red_wine_vinegar, chilli, mushroom_slices, whitechip_macadamianut, double_chocolatechip, chocolate_chip ,peanutbutter,sprite, cola, fanta, pepsi, orange_juice, passion_fruit]).
veggies([wheat, honey_oat, italian, hearty_italian, flatbread, wrap, avocado, cucumbers, lettuce, tomatoes, onions, green_peppers, olives, pickles,honey_mustard, sweet_onion, red_wine_vinegar, chilli, chipotle, bbq, ranch, sweet_chilli, mayo, ketchup, cheddar, american_cheese, mushroom_slices, whitechip_macadamianut, double_chocolatechip, chocolate_chip ,peanutbutter, sprite, cola, fanta, pepsi, orange_juice, passion_fruit]).

/* This predicate enables users to select more vegetables through recursion. If user inputs 'y', they can select more veggies and the same predicate will be called once again. If user inputs 'n', they will exit the loop. However, if user does not respond with either 'y' or 'n', the same predicate will be called to prompt correct user input.*/
vegetables_selected(VegSel):-
     print_options(VegSel), nl,                           % prints the veggie list available
     read(SelectedVeg),                                   % takes in user's selection of veggie
     assert(veg_selected(SelectedVeg)),                   % assert user's selection of veggie into the DB
     write("Do you wish to add more veggies? (y/n)"), nl, % ask user if they want to add more veggies
     read(AddMore),                                       % Take in user's reply (y=yes and n=no)
     (AddMore == y -> vegetables_selected(VegSel);        % if user replies with 'y' recall the same predicate
     AddMore == n -> write("Okay great, your veggie order has been done!"), nl; % if user replies with 'n' print statement, exit                                                                                       loop and return to main program
      vegetables_selected(VegSel)).                       % if user does not respond with 'y' or 'n', call the same predicate to                                                                 prompt user for appropriate response.

/* Prints elements in the list. This recursive predicate prints the head element, calls itself with the tail element. This continues till the list is empty */
print_options([A|B]):- write(A), nl, print_options(B).
print_options([]).

/* Main rule of the program. Accordingly, calls the meal_selected() choosen by the user. Example: if user inputs '1' in ask(0), meal_selected(1) will run. */
meal_choosen(0):- (

    /* Regular Meal */
   meal_selected(1) ->
        bread(BreadList), meat(MeatList), vegetable(VegList), cookie(CookiesList),sauce(SauceList),drink(DrinksList), topup(TopupList),  % assigns the elements of the different ingredient's list to their respective variable, i.e, BreadList, MeatList, VegList, CookieList etc.

        nl, write("-------Please select a bread: -------"), nl,
	print_options(BreadList), nl,                                % Prints the Bread List
        read(BreadSelected),                                         % Take in user input
        assert(bread_selected(BreadSelected)),                       % Assert user input and store value in database (so                                                                                    bread_selected() will contain the bread type choosen by user)

        nl, write("-------Please select a meat-------"), nl,
        print_options(MeatList), nl,                                 % Prints the Meat List
        read(SelectedMeat),                                          % Take in user input
        assert(meat_selected(SelectedMeat)),                         % Add meat_selected(SelectedMeat)to DB

        nl, write("-------Please select your veggie(s)-------"), nl,
        vegetables_selected(VegList),                                % Call vegetables_selected():- predicate

        nl, write("--------Please select a sauce: -------"), nl,
        print_options(SauceList), nl,                                % Prints the Sauce List
        read(SelectedSauce),                                         % Take in user input
        assert(sauce_selected(SelectedSauce)),                       % Add sauce_selected(SelectedSauce)to DB

        nl, write("--------Do you want a top up?-------"), nl,
        read(NeedTopup),                                                    % Take in user input of either 'y' or 'n'
        (NeedTopup == n -> write("Okay noted!");                            % If user input is 'n', exit.
         NeedTopup == y -> print("-------Please Select a topup:-------"),nl,% If user input is 'y', print TopupList, read user
         print_options(TopupList),                                          % input and assert value of topup_selected(SelectedTopup)
         read(SelectedTopup),
         assert(topup_selected(SelectedTopup))),

        nl, write("-------Now, please select a cookie: ------- "), nl,
        print_options(CookiesList), nl,                                % Prints the Cookie List
        read(SelectedCookies),                                         % Take in user input
        assert(cookie_selected(SelectedCookies)),                      % Add cookie_selected(SelectedCookies)to DB

        nl, write("-------Finally, please choose a drink: -------"), nl,
        print_options(DrinksList), nl,                                 % Prints the Drink List
        read(SelectedDrinks),                                          % Take in user input
        assert(drink_selected(SelectedDrinks)),                        % Add drink_selected(SelectedDrinks)to DB

    orderDone(1) % displays user's order
    ;


    /* Healthy Meal */
    meal_selected(2) ->
        bread(BreadList), meat(MeatList), vegetable(VegList), sauce(SauceList),drink(DrinksList), topup(TopupList), healthy(HealthyList), % assigns the elements of the different ingredient's list to their respective variable, i.e, BreadList, MeatList, VegList, CookieList etc.

        % findall compares the elements in each ingredient list (Eg: BreadList, VegList etc) with the meal type list (Healthy List)
        % and elements existing in both these lists will be put into another list (Eg: FilteredBread, FilteredVeg etc).
        findall(A, ( member(A, BreadList), member(A, HealthyList) ), FilteredBread ),
        findall(B, ( member(B, VegList), member(B, HealthyList) ), FilteredVegetables ),
        findall(C, ( member(C, DrinksList), member(C, HealthyList) ), FilteredDrinks ),
        findall(D, ( member(D, SauceList), member(D, HealthyList) ), FilteredSauce ),
        findall(E, ( member(E, TopupList), member(E, HealthyList) ), FilteredTopup ),
        findall(F, ( member(F, MeatList), member(F, HealthyList) ), FilteredMeat ),

        nl, write("-------Please select a bread: -------"), nl,
	print_options(FilteredBread), nl,                                    % Prints the Bread List
        read(BreadSelected),                                                 % Take in user input
        assert(bread_selected(BreadSelected)),                               % Add drink_selected(BreadSelected)to DB

        nl, write("-------Please select a meat-------"), nl,
        print_options(FilteredMeat), nl,
        read(SelectedMeat),
        assert(meat_selected(SelectedMeat)),

        nl, write("-------Please select your veggie(s)-------"), nl,
        vegetables_selected(FilteredVegetables),                            % Call vegetables_selected():- predicate

        nl, write("--------Please select a sauce: -------"), nl,
        print_options(FilteredSauce), nl,
        read(SelectedSauce),
        assert(sauce_selected(SelectedSauce)),

         nl, write("--------Do you want a top up? (y/n): -------"),nl,
        read(NeedTopup),                                                     % Take in user input of either 'y' or 'n'
        (NeedTopup == y -> write("-------Please Select a topup:-------"),nl, % If user input is 'y,
         print_options(FilteredTopup),                                       % Print Topup List
         read(SelectedTopup),                                                % Read user input
         assert(topup_selected(SelectedTopup));                              % Add topup_selected(SelectedTopup)to DB
         NeedTopup == n -> write("Okay noted!"),nl),                         % Else, if user input is 'n', exit.

        nl, write("-------Finally, please choose a drink: -------"), nl,
        print_options(FilteredDrinks), nl,
        read(SelectedDrinks),
        assert(drink_selected(SelectedDrinks)),

    orderDone(1)  % displays user's order
        ;

    /* Value Meal */
     meal_selected(3) ->
        bread(BreadList), meat(MeatList), vegetable(VegList), sauce(SauceList), value(ValueList),
        % assigns the elements of the different ingredient's list to their respective variable, i.e, BreadList, MeatList, VegList,             CookieList etc.

        % findall compares the elements in each ingredient list (Eg: BreadList, VegList etc) with the meal type list (Value List)
        % and elements existing in both these lists will be put into another list (Eg: FilteredBread, FilteredVeg etc).
        findall(A, ( member(A, BreadList), member(A, ValueList) ), FilteredBread ),
        findall(B, ( member(B, VegList), member(B, ValueList) ), FilteredVegetables ),
        findall(C, ( member(C, SauceList), member(C, ValueList) ), FilteredSauce ),
        findall(D, ( member(D, MeatList), member(D, ValueList) ), FilteredMeat ),

        nl, write("------Please select a bread: ------"), nl,
	print_options(FilteredBread), nl,                                       % Prints the Bread List
        read(BreadSelected),                                                    % Take in user input
        assert(bread_selected(BreadSelected)),                                  % Add drink_selected(BreadSelected)to DB

        nl, write("-------Please select a meat-------"), nl,
        print_options(FilteredMeat), nl,
        read(SelectedMeat),
        assert(meat_selected(SelectedMeat)),

        nl, write("-------Please select your veggie(s)-------"), nl,
        vegetables_selected(FilteredVegetables),                                % Call vegetables_selected():- predicate

        nl, write("-------Finally, please select a sauce: -------"), nl,
        print_options(FilteredSauce), nl,
        read(SelectedSauce),
        assert(sauce_selected(SelectedSauce)),

    orderDone(1) % displays user's order
      ;

    /* Veggie Meal */
     meal_selected(4) ->
        bread(BreadList), vegetable(VegList), sauce(SauceList),drink(DrinksList), cookie(CookiesList), topup(TopupList), veggies(VeggiesList),    % assigns the elements of the different ingredient's list to their respective variable, i.e, BreadList, MeatList, VegList, CookieList etc.

        % findall compares the elements in each ingredient list (Eg: BreadList, VegList etc) with the meal type list (Veggie List)
        % and elements existing in both these lists will be put into another list (Eg: FilteredBread, FilteredVeg etc).
        findall(A, ( member(A, BreadList), member(A, VeggiesList) ), FilteredBread ),
        findall(B, ( member(B, VegList), member(B, VeggiesList) ), FilteredVegetables ),
        findall(C, ( member(C, DrinksList), member(C, VeggiesList) ), FilteredDrinks ),
        findall(D, ( member(D, SauceList), member(D, VeggiesList) ), FilteredSauce ),
        findall(E, ( member(E, TopupList), member(E, VeggiesList) ), FilteredTopup ),
        findall(F, ( member(F, CookiesList), member(F, VeggiesList) ), FilteredCookies ),


        nl, write("-------Please select a bread: -------"), nl,
	print_options(FilteredBread), nl,                                          % Prints the Bread List
        read(BreadSelected),                                                       % Take in user input
        assert(bread_selected(BreadSelected)),                                     % Add drink_selected(BreadSelected)to DB

        nl, write("-------Please select your veggie(s)-------"), nl,
        vegetables_selected(FilteredVegetables),                                   % Call vegetables_selected():- predicate

        nl, write("--------Please select a sauce: -------"), nl,
        print_options(FilteredSauce), nl,
        read(SelectedSauce),
        assert(sauce_selected(SelectedSauce)),

        nl, write("--------Do you want a top up? (y/n): -------"), nl,
        read(NeedTopup),                                                           % Take in user input of either 'y' or 'n'
        (NeedTopup == y -> write("-------Please Select a topup:-------"),nl,       % If user input is 'y,
         print_options(FilteredTopup),                                             % Print Topup List
         read(SelectedTopup),                                                      % Read user input
         assert(topup_selected(SelectedTopup));                                    % Add topup_selected(SelectedTopup) to DB
        NeedTopup == n -> write("Okay noted!"),nl),                                % Else, if user input is 'n', exit.

        nl, write("-------Now, please select a cookie: ------- "), nl,
        print_options(FilteredCookies), nl,
        read(SelectedCookies),
        assert(cookie_selected(SelectedCookies)),

        nl, write("-------Finally, please choose a drink: -------"), nl,
        print_options(FilteredDrinks), nl,
        read(SelectedDrinks),
        assert(drink_selected(SelectedDrinks)),

    orderDone(1) % displays user's order
    ;

    /* Vegan Meal */
    meal_selected(5) ->
        bread(BreadList), vegetable(VegList), sauce(SauceList),drink(DrinksList), cookie(CookiesList),topup(TopupList), vegan(VeganList), % assigns the elements of the different ingredient's list to their respective variable, i.e, BreadList, MeatList, VegList, CookieList etc.

        % findall compares the elements in each ingredient list (Eg: BreadList, VegList etc) with the meal type list (Vegan List)
        % and elements existing in both these lists will be put into another list (Eg: FilteredBread, FilteredVeg etc).
        findall(A, ( member(A, BreadList), member(A, VeganList) ), FilteredBread ),
        findall(B, ( member(B, VegList), member(B, VeganList) ), FilteredVegetables ),
        findall(C, ( member(C, DrinksList), member(C, VeganList) ), FilteredDrinks ),
        findall(D, ( member(D, CookiesList), member(D, VeganList) ), FilteredCookies ),
        findall(E, ( member(E, SauceList), member(E, VeganList) ), FilteredSauce ),
        findall(F, ( member(F, TopupList), member(F, VeganList) ), FilteredTopup ),

        nl, write("-------Please select a bread: -------"), nl,
	print_options(FilteredBread), nl,                                         % Prints the Bread List
        read(BreadSelected),                                                      % Take in user input
        assert(bread_selected(BreadSelected)),                                    % Add drink_selected(BreadSelected)to DB

        nl, write("-------Please select your veggie(s)--------"), nl,
        vegetables_selected(FilteredVegetables),                                  % Call vegetables_selected():- predicate

        nl,write("--------Please select a sauce: -------"), nl,
        print_options(FilteredSauce), nl,
        read(SelectedSauce),
        assert(sauce_selected(SelectedSauce)),

         nl, write("--------Do you want a top up? (y/n): -------"), nl,
        read(NeedTopup),                                                          % Take in user input of either 'y' or 'n'
        (NeedTopup == y -> write("-------Please Select a topup:-------"),nl,      % If user input is 'y,
         print_options(FilteredTopup),                                            % Print Topup List
         read(SelectedTopup),                                                     % Read user input
         assert(topup_selected(SelectedTopup));                                   % Add topup_selected(SelectedTopup) to DB
         NeedTopup == n -> write("Okay noted!"),nl),                              % Else, if user input is 'n', exit.


        nl, write("-------Now, please select a cookie: ------- "), nl,
        print_options(FilteredCookies), nl,
        read(SelectedCookies),
        assert(cookie_selected(SelectedCookies)),

        nl, write("-------Finally, please choose a drink: -------"), nl,
        print_options(FilteredDrinks), nl,
        read(SelectedDrinks),
        assert(drink_selected(SelectedDrinks)),

    orderDone(1);  % displays user's order
    ask(0)         % If user did not select any of the 5 meal options, they will be redirected back to ask(0), i.e, start of program

).

/* Prints all the ingredients user has selected */
orderDone(1):-

    nl, write("*****Enjoy your meal! You have ordered the following:*****"), nl, nl,
     % If bread selected by user is not within the Bread list or bread is not choosen, display "No Bread Selected"
    (\+ ( bread_selected(B), bread(Bread), member(B, Bread) ) -> write("** No bread selected."), nl;
     % If bread selected by user is within the Bread list, display the name of bread selected
    ( write("** Selected bread: "), bread_selected(B), bread(Bread), member(B, Bread), write(B), nl )),

    (\+ ( meat_selected(M), meat(Meat), member(M, Meat) ) -> write("** No meat selected."), nl;
    ( write("** Selected meat: "), meat_selected(M), meat(Meat), member(M, Meat), write(M), nl )),

    (\+ veg_selected(_) -> write("** No veggie selected."), nl;
    ( vegetable(VegList), findall(V,(veg_selected(V), member(V, VegList)), List), write("** Selected veggie: "), nl ,print_options(List) )),

    (\+ ( topup_selected(T), topup(Topping), member(T, Topping)) -> write("** No topup selected."), nl;
    ( write("** Selected topup: "), topup_selected(T), topup(Topping), member(T, Topping), write(T), nl )),

    (\+ ( sauce_selected(S), sauce(Sauce), member(S, Sauce) ) -> write("** No sauce selected."), nl;
    ( write("** Selected sauce: "), sauce_selected(S), sauce(Sauce), member(S, Sauce), write(S), nl )),

    (\+ ( cookie_selected(C), cookie(Cookie), member(C, Cookie) ) -> write("** No cookie selected."), nl;
    ( write("** Selected cookie: "), cookie_selected(C), cookie(Cookie), member(C, Cookie), write(C), nl )),

    (\+ ( drink_selected(D), drink(Drink), member(D, Drink) ) -> write("** No drink selected."), nl;
    ( write("** Selected drink: "), drink_selected(D), drink(Drink), member(D, Drink), write(D), nl )),nl,nl,

    % rettractall predicate removes all previously asserted clauses in the database
    % This is done so that when the user runs the program again, new user input values are displayed instead of the old values.
    retractall(bread_selected(_)),
    retractall(veg_selected(_)),
    retractall(meat_selected(_)),
    retractall(sauce_selected(_)),
    retractall(topup_selected(_)),
    retractall(cookie_selected(_)),
    retractall(drink_selected(_)),
    retractall(meal_selected(_)),
    abort.    % Terminate program

/* Initialize each ingredient and meal_selected() option */
bread_selected(nothing).
meat_selected(nothing).
veg_selected(nothing).
sauce_selected(nothing).
topup_selected(nothing).
cookie_selected(nothing).
drink_selected(nothing).
meal_selected(nothing).













