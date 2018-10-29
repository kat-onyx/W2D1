require 'byebug'
# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    nil
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue StandardError
    retry if maybe_fruit == "coffee"
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    begin
      # debugger
      @name = name
      @fav_pastime = fav_pastime
      @yrs_known = yrs_known
      raise YearsTooFew, "you must be friends for at least 5 years" if @yrs_known < 5
      raise EmptyName, "@name is empty" if @name.empty?
      raise EmptyPasttime, "@fav_pastime is empty" if @fav_pastime.empty?
    rescue YearsTooFew, EmptyName, EmptyPasttime => error_message
      puts error_message
    end

  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end

  class YearsTooFew < StandardError; end;
  class EmptyName < StandardError; end;
  class EmptyPasttime < StandardError; end;
end
