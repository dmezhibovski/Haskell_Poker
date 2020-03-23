module Poker where
    import Data.List
    

    -- deal cards =  

    --work on this later ->>> deal cards =  
       

    -- List shifting (simple notation is the notation provide by the prof, standard notation is the one we will be working on in this program)
    shiftToSimpleNotationFunc x = do
        if suit x ==  1 then x+11
        else x-2
    shiftToSimpleNotation list = map shiftToSimpleNotationFunc list
    shiftToStandardNotationFunc x = do
        if suit x == 12 then x-11
        else x+2
    shiftToStandardNotation list = map shiftToStandardNotationFunc list
    
    --card operations (assumes standard notation)
    suit x = div x 13
    value x = mod x 13

   
    ---------------Helper functions-------------------

    --hand is the list that you are serching
    --value is the value you are looking for
    --func is the func by which the card is evaluated to(pass in suit or value)
    containsValueWithFunc hand value func 
        | hand == [] = False
        | func ((head) hand) == value = True
        | otherwise = containsValueWithFunc ((tail) hand) value func
    
    --returns true is card1 is larger or equal to card 2(same for sort by suit)
    sortByValue card1 card2 = do
        if value card1 > value card2 then True
        else if value card1 < value card2 then False
        else if suit card1 < suit card2 then False
        else True

    sortBySuit card1 card2 = do
        if suit card1 > suit card2 then True
        else if suit card1 < suit card2 then False
        else if value card1 < value card2 then False
        else True
    
    sortHandByMethod unsorted sorted func
        | length unsorted == 1 = sorted ++ unsorted
        | ((func) ((head) unsorted) (unsorted !! 1)) == False = do
            let eleToSwapUp = head unsorted
            let eleToSwapDown = unsorted !! 1
            let partiallySorted = (sorted) ++ [eleToSwapDown,eleToSwapUp] ++ (tail ((tail) unsorted))
            sortHandByMethod partiallySorted [] func
        | otherwise = sortHandByMethod (tail unsorted) (sorted ++ [((head) unsorted)]) func
<<<<<<< HEAD

=======
>>>>>>> 4939f3e311ee6afebd28227a5768b85587bc6d6f

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Daniels Side


    sortByVal hand = sortBy (\a b -> compare ((value) a) ((value) b)) hand
    sortBySuit hand = sortBy(\a b -> compare ((suit) a) ((suit) b)) hand
    
    getHands cards h1 h2 = do
        if null cards then [(reverse)h1,(reverse)h2]
        else if mod (length cards) 2 == 0 then (getHands ((tail) cards) ((head cards) : h1) h2)
        else getHands ((tail) cards) h1 ((head cards) : h2)


    --Tie breaker funcs
    highestRank h1 h2 = highestRankRev ((reverse) h1) ((reverse) h2) ((reverse) h1) ((reverse) h2)

    highestRankRev h1 h2 a b= do
        if null a then highestSuit h1 h2
        else do
            let v1 =(value (head a))
            let v2 = (value (head b)) 
            if v1 == v2  then highestRankRev h1 h2 (tail a) (tail b)
            else if v1 > v2 then reverse h1
            else reverse h2

    highestSuit h1 h2 = [1]

    tieThreePlus h1 h2 = do 
        if (h1 !! 2) > (h2 !! 2) then h1
        else h2
    
    tieTwoPairs h1 h2 = do
        let av1 = value (h1 !! 1)
        let bv1 = value (h2 !! 1)
        let av2 = value (h1 !! 3)
        let bv2 = value (h2 !! 3)
        if av2 > bv2 then h1
        else if av2 < bv2 then h2
        else if av1 > bv1 then h1
        else if av1 < bv1 then h2
        else highestSuit h1 h2
    
    -- tiePair h1 h2 = do 
