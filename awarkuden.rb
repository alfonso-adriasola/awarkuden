class Bean
  COLOR = { 0 => :black, 1 => :white }
  def toss
    COLOR[rand(0..1)]
  end
end

class Player
  def go
    8.times.map { Bean.new.toss }
  end
end

class Game
  def score(set)
    x = set.group_by{|e| e}
    c = x[:black].size if x[:black]
    c = x[:white].size if x[:white] and c.to_i < 4
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
  set = Player.new.go.tap{|x| puts x.inspect }
  set_2 = Player.new.go.tap{|x| puts x.inspect }
  puts a = Game.new.score(set)
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
  Game.new.score(set) == 2
end

play if test_score_rules