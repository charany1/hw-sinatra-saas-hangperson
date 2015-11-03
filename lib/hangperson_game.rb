class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word,:guesses,:wrong_guesses
  
  def initialize(word)
    
    @word = word
    
    @guesses = String.new
    
    @wrong_guesses = String.new
    
    @word_with_guesses = "-"*word.size
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  
  def guess letter
    #throws an error when empty i.e. '' , nil ,or when not a letter
    
    if(letter.nil? || letter=='' || letter =~ /[^A-Za-z]/)
      raise ArgumentError
    end
    
    
    if  (@word.include?letter.downcase) 
      if (!@guesses.include?letter.downcase)
        @guesses += letter.downcase
        substitute letter
        return true
      else
        return false
      end
    else
      if(!@wrong_guesses.include?letter.downcase)
        @wrong_guesses += letter.downcase
        return true
      else
        return false
      end
    end
  end
  
  def word_with_guesses 
    @word_with_guesses
  end
  
  def check_win_or_lose
    if(word_with_guesses == @word)
      return :win
    elsif(@wrong_guesses.size == 7)
      return :lose
    else
      return :play
    end
  end
  
  private 
  
  def substitute letter
    for  i in 0...@word.size
      if @word[i] == letter
        @word_with_guesses[i] = letter
      end
    end
    @word_with_guesses
  end
  
end
