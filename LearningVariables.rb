class TicTacToeContainer
    
    include Enumerable
    
    def initialize (size = 3, defaultPossitionValue = "#")
        @size = size
        @ticTacToeArray = Array.new(size){ Array.new(size){defaultPossitionValue} }
        @Player = "X"
        @gameWon = false
    end
    
    #swaps player between X and O
    def SwapPlayer
        if @Player.to_s == "X"
            @Player = "O"
        else
            @Player = "X"
        end
        puts "Now for the #{@Player} player"
    end

    #this is used to determine that the data is both a number, and within the specified range
    def ValidateIsPositiveNumber(x, range = 100, max_attempts = 5, attempt_number = 0)
        attempt_number = attempt_number+1
        x = x.to_i 
        if x <= 0 || x > range
            if attempt_number < max_attempts
                puts ("\n" + (max_attempts - attempt_number).to_s + " attempts remaining\nplease input a whole number greater than 0, and smaller than " + range.to_s + "\n")
                x = ValidateIsPositiveNumber(gets.chomp, range, max_attempts, attempt_number)
            else
                abort("program terminating")
            end
        end
        return x
    end

    #prints the current state of play to the console
    def PrintGame
        yCoOrd = 0
        while yCoOrd < @size do
            xCoOrd = 0
            outputLine = ""
            while xCoOrd < @size do
                outputLine += @ticTacToeArray[xCoOrd][yCoOrd].to_s
                xCoOrd +=1
            end 
            puts outputLine
            yCoOrd += 1
        end
    end

    def PlayGame
        @gameWon = false
        while !@gameWon do
            self.PrintGame
            self.UpdatePossiton
            self.SwapPlayer
        end
    end 

    def UpdatePossiton()
        updating = true
        
        while updating == true do
            coOrds = self.TakeGameInput
            invertYCoOrds = ((@size-1) - (coOrds[1]-1))
            puts "inverted Y == #{@size-1} - #{coOrds[1]-1} = #{invertYCoOrds}"
            if @ticTacToeArray[coOrds[0]-1][invertYCoOrds].to_s == "#"
                @ticTacToeArray[coOrds[0]-1][invertYCoOrds] = @Player.to_s
                updating = false
            else
                puts ("You may not use a space that is already taken, #{coOrds[0].to_s}, #{coOrds[1].to_s}, currently reads as: #{@ticTacToeArray[coOrds[0]-1][invertYCoOrds].to_s}")
            end
        end
    end


    def TakeGameInput ()
        updateX = nil
        updateY = nil
        puts ("Player #{@Player}, input your X possition as a possitive number between 1 and " + @size.to_s)
        updateX = ValidateIsPositiveNumber(gets.chomp, @size)
        puts ("Now input your Y possition as a possitive number between 1 and " + @size.to_s)
        updateY = ValidateIsPositiveNumber(gets.chomp, @size)
        return updateX, updateY
    end
end


numerical_variable = 1000
subject_variable = "picture"
game = TicTacToeContainer.new

puts "\"a picture is worth 1000 words\""
puts "could also be written using a variable for the number and subject. for example:"
subject_variable = subject_variable.upcase()
puts ("\"a " +subject_variable+ " is worth " + numerical_variable.to_s + " words\"" )

puts "and inside these words we can look for smaller words"
string_variable = "a beatiful rainbow for some means rain for another."
puts ("inside the phrase \"" + string_variable + "\" we see the word \"rain\", corrrect? " + (string_variable.include? "rain").to_s )
puts "speaking of others, what's your name friend?"
username_variable = gets.chomp
puts "Hi there #{username_variable}! it's nice to meet you!"
puts "And how old are you #{username_variable}?"
userAge_variable = game.ValidateIsPositiveNumber(gets.chomp)
puts "Awesome #{username_variable}, so you are #{userAge_variable} years old"
puts "\n we are going to play Tic Tac Toe #{username_variable}"

game.PlayGame