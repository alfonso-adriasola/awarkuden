class Bean
  COLOR = { 1 => :white, 0 => :black }
  def toss
    @value = COLOR[rand(0..1)]
    self
  end

  def to_s
    @value == :black ? '▢' : '▣'
  end

  def value
    @value
  end
end

class Player < Struct.new(:name)
  def go
    puts "#{name} throws" 
    8.times.map do  
        Bean.new.toss
     end
  end
end

class Game
  def score(set)
    if set.first.is_a? Bean 
      pp set.map(&:to_s)
      set = set.map{|h| h.value }
    end
    x = set.tally
    pp x
    c = x[:black] if x[:black]
    c = x[:white] if x[:white] and c.to_i < 4
    case c
    when 4
      1
    when 7..8
      2
    else
      0
    end
  end
end

def play
  set = Player.new('player 1').go
  puts a = Game.new.score(set)
  set_2 = Player.new('player 2').go
  puts b = Game.new.score(set_2)
  puts "player 1 wins" if a > b
  puts "player 2 wins" if b > a
  puts "tied" if a == b
end

def test_score_rules
  set = [:white,:white,:white,:white,:white,:white,:white,:white]
  raise unless Game.new.score(set) == 2
  set = [:black,:black,:black,:black,:white,:white,:white,:white]
  raise unless Game.new.score(set) == 1
  set = [:black,:black,:black,:white,:white,:white,:white,:white]
  raise unless Game.new.score(set) == 0
  set = [:black,:white,:white,:white,:white,:white,:white,:white]
  raise unless Game.new.score(set) == 2
  set = [:black,:black,:black,:black,:black,:black,:black,:black]
  raise unless Game.new.score(set) == 2
  puts "----------  passed tests --------------"
  true
end

play if test_score_rules
