require 'colorize'

module Info
  WELCOME = "\n---  WELCOME TO TIC_TAC_TOE GAME  ---".yellow 
  CHECK_WINNER = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
end
  

class Board 
  attr_reader :board
  
  def initialize
    @board = []
    create_board
  end
  
  def create_board
    (0..9).each do |let|
      @board << let
    end
  end
  
  def show_board
    col_separator, row_separator = " | ".blue, "--+---+--".blue 
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}
    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
     
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts rows_for_display.join("\n" + row_separator + "\n")
  end
  
  def to_s 
    "#{@board}"
  end
end
  
  
class Player 
  attr_reader :name
  attr_accessor :letter
  
  def player_name
    print 'Enter your name: '
    @name = gets.chomp 
    player_name if @name == ''
    @name 
  end
  
  def choose_letter
    until @letter == 'x' || @letter == 'o'
      print "\nEnter the letter with which you will play => x <=, => o <= : "
      @letter = gets.chomp 
    end
  end
end
  

class Game < Board 
  attr_reader :player_one, :player_two, :board, :num 
  include Info 
  
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board::new
    @num = @board.board.size - 1
  end
  
  def select_position!
    puts "\n#{@board.show_board}"

    while @num > 0
      change_player! @num
      print "#{@player.name.capitalize.yellow} select a free position in the board: "
      @position = gets.chomp.to_i 
      check_free_position @player
      puts "\n#{@board.show_board }"
      
      if winner @player 
        puts "\n  ---  Congratulations #{@player.name.capitalize} is the winner!!!  ---".blue  
        return 
      elsif board_full? @board 
        puts "\n  ---  Is a draw!!!  ---".ligth_green 
        return 
      end
    end
  end
  
  def change_player! player
    if player.odd?
      @player = @player_one
    else
      @player = @player_two
    end
  end
  
  def check_free_position player
    if @position.between?(1, 9) && @board.board[@position].class != ''.class 
      @board.board[@position] = player.letter  
      @num -= 1
    else 
      puts "\nThath position is occupied, or the character does not match..."
    end
  end
  
  def winner player
    CHECK_WINNER.any? do |line|
      line.all? {|pos| @board.board[pos] == player.letter}
    end
  end

  def board_full? board 
    (1..9).all? {|pos| board.board[pos].is_a?(String) }
  end
  
  def to_s
    puts "#{@board}"
  end
end
  
  