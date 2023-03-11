class TicTacToeContainer
    
    include Enumerable
    
    def initialize (size = 3, defaultPossitionValue = "#")
        @size = size
        @ticTacToeArray = Array.new(size){ Array.new(size){defaultPossitionValue} }
        @Player = "X"
        @Wincount = (2 + (size/3)).to_i
        @gameWon = false
        puts "the Array has an X size of #{@ticTacToeArray.size} and a Y size of #{@ticTacToeArray[0].size}" 
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
            if self.CheckWinConditon
                @gameWon = true
                puts "The #{@Player} Player wins!"
                return
            end
            self.SwapPlayer
        end
    end 

    def UpdatePossiton
        updating = true
        
        while updating == true do
            coOrds = self.TakeGameInput
            #invery the Y co-ords as consoles consider top to bottom, and humans consider bottom to top
            if @ticTacToeArray[coOrds[0]-1][coOrds[1]-1].to_s == "#"
                @ticTacToeArray[coOrds[0]-1][coOrds[1]-1] = @Player.to_s
                updating = false
            else
                puts ("You may not use a space that is already taken, #{coOrds[0].to_s}, #{coOrds[1].to_s}, currently reads as: #{@ticTacToeArray[coOrds[0]-1][coOrds[1]-1].to_s}")
            end
        end
    end


    def TakeGameInput
        updateX = nil
        updateY = nil
        puts ("Player #{@Player}, input your X possition as a possitive number between 1 and " + @size.to_s)
        updateX = ValidateIsPositiveNumber(gets.chomp, @size)
        puts ("Now input your Y possition as a possitive number between 1 and " + @size.to_s)
        updateY = ValidateIsPositiveNumber(gets.chomp, @size)
        return updateX, updateY
    end
    def SameSymbolCountHorizontal (currentSymbol = "X", xCoOrd = 0, yCoOrd = 0, currentCount = 0, winningCount = @Wincount)        
        #win detection
        if currentCount == winningCount
            return true
        end
        #guard statements
        if xCoOrd+1 > @size
            return false
        end
        if yCoOrd + 1 > @size
            return false
        end
        #new line or all spaces investigated check
        if xCoOrd+1 == @size
            if yCoOrd + 1 == @size
                return false
            end
            return self.SameSymbolCountHorizontal(currentSymbol,0, yCoOrd+1, 0, winningCount) 
        end

        if @ticTacToeArray[xCoOrd][yCoOrd].to_s != currentSymbol
            return self.SameSymbolCountHorizontal(currentSymbol,xCoOrd+1, yCoOrd, 0, winningCount)
        end

        return self.SameSymbolCountHorizontal(currentSymbol, xCoOrd+1, yCoOrd, currentCount + 1, winningCount)
    end

    def SameSymbolCountVertical (currentSymbol = "X", xCoOrd = 0, yCoOrd = 0, currentCount = 0, winningCount = @Wincount)
        #win detection
        if currentCount == winningCount
            return true
        end
        #guard statements
        if xCoOrd+1 > @size
            return false
        end
        if yCoOrd + 1 > @size
            return false
        end
        #new column or all spaces investigated check
        if yCoOrd+1 == @size
            if xCoOrd + 1 == @size
                return false
            end
            return self.SameSymbolCountVertical(currentSymbol, xCoOrd+1, 0, 0, winningCount) 
        end

        if @ticTacToeArray[xCoOrd][yCoOrd].to_s != currentSymbol
            return self.SameSymbolCountVertical(currentSymbol, xCoOrd, yCoOrd+1, 0, winningCount)
        end
        return self.SameSymbolCountVertical(currentSymbol, xCoOrd, yCoOrd+1, currentCount + 1, winningCount)
    end
    
    def SameSymbolCountDiagonalLeftToRight (currentSymbol = "X", xCoOrd = 0, yCoOrd = 0, currentCount = 0, winningCount = @Wincount)
        #win detection
        if currentCount == winningCount
            return true
        end
        #guard statements
        if xCoOrd+1 > @size
            return false
        end
        if yCoOrd + 1 > @size
            return false
        end
        #new column or all spaces investigated check
        if yCoOrd+1 == @size
            if xCoOrd + 1 == @size
                return false
            end
            return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd+1, 0, 0, winningCount) 
        end

        if @ticTacToeArray[xCoOrd][yCoOrd].to_s != currentSymbol
            return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd, yCoOrd+1, 0, winningCount)
        end 
        
        if self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd+1, yCoOrd+1, currentCount + 1, winningCount)
            return true
        end
        
        return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd, yCoOrd+1, 0, winningCount)
    end

    def SameSymbolCountDiagonalRightToLeft (currentSymbol = "X", xCoOrd = 0, yCoOrd = 0, currentCount = 0, winningCount = @Wincount)
        #win detection
        if currentCount == winningCount
            return true
        end
        #guard statements
        if xCoOrd+1 > @size
            return false
        end
        if yCoOrd + 1 > @size
            return false
        end
        if yCoOrd < 0
            return false
        end
        #new column or all spaces investigated check
        if yCoOrd+1 == @size
            if xCoOrd + 1 == @size
                return false
            end
            return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd+1, 0, 0, winningCount) 
        end

        if @ticTacToeArray[xCoOrd][yCoOrd].to_s != currentSymbol
            return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd, yCoOrd+1, 0, winningCount)
        end 
        
        if self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd+1, yCoOrd-1, currentCount + 1, winningCount)
            return true
        end
        
        return self.SameSymbolCountDiagonalLeftToRight(currentSymbol, xCoOrd, yCoOrd+1, 0, winningCount)
    end

    def CheckWinConditon
        if self.SameSymbolCountHorizontal(@Player.to_s) 
            return true
        end
        if self.SameSymbolCountVertical(@Player.to_s)
            return true
        end 
        if self.SameSymbolCountDiagonalLeftToRight(@Player.to_s)
            return true
        end
        if self.SameSymbolCountDiagonalRightToLeft(@Player.to_s)
            return true
        end
        return false
    end
end


numerical_variable = 1000
subject_variable = "picture"
game = TicTacToeContainer.new(6)

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
