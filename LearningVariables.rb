class TicTacToeContainer
    
    include Enumerable
    
    def initialize (size = 5, defaultPossitionValue = "#")
        @ticTacToeArray = Array.new(size)
        for x in size do
            temp = Array.new(size)
            temp.each = defaultPossitionValue
            # .each is equivilant to:
            # for y in size do
            #     temp[y] = defaultPossitionValue
            # end
            ticTacToeArray.push temp
        end
    end

    def print
        puts (self.ticTacToeArray.each.to_s + " ")
    end
end

            


def ValidateIsPositiveNumber(x, max_attempts = 5, attempt_number = 0)
    attempt_number = attempt_number+1
    x = x.to_i 
    if x <= 0
        if attempt_number < max_attempts
            puts ("\n" + (max_attempts - attempt_number).to_s + " attempts remaining\nplease input a whole number greater than 0.\n")
            x = ValidateIsPositiveNumber(gets.chomp, max_attempts, attempt_number)
        else
            abort("program terminating")
        end
    end
    return x
end


numerical_variable = 1000
subject_variable = "picture"
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
userAge_variable = ValidateIsPositiveNumber(gets.chomp)
puts "Awesome #{username_variable}, so you are #{userAge_variable} years old"
puts "\n we are going to play Tic Tac Toe #{username_variable}"

game = TicTacToeContainer.new

game.print


