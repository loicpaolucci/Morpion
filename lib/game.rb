class TicTacToe
  attr_accessor :board

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "] #liste des cases a remplir avec x - o
  end

  # listes des combinaisons gagnantes
  COMBINAISONS_GAGNANTES = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [6, 4, 2],
  [0, 4, 8]
]

  def display_board # le plateau de jeu du morpion
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts " ----------- "
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts " ----------- "
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input) # pour afficher les board de 0 a 8 (9 cases)
    input.to_i - 1
  end

  def move(position, token='X') # premier mouvement avec X 
    @board[position] = token
  end

  def position_taken?(input)
    @board[input] == "X" || @board[input] == "O" # choisir la case que tu veux 
  end

  def valid_move?(input)
    input.between?(0, 8) && !position_taken?(input) # choisir une case entre 0-8 et trouver la bonne case
  end


  def turn # permet de chosir la case voulue , et de passer au joueur suivant 
    puts "joueur choisi une case de 1-9"
    spot = gets.strip
    spot = input_to_index(spot)
    if valid_move?(spot)
      move(spot, current_player)
    else
      turn
    end
    display_board
  end

  def turn_count # pour commencer de 1 et pas de zero 
    taken = 0
    @board.each do |i|
      if i == "X" || i == "O"
        taken += 1
      end
    end
    return taken
  end

  def current_player # sert a passer du joueur X et O 
    player = nil
    if turn_count() % 2 == 0
      player = 'X'
    else
      player = 'O'
    end
    return player
  end


  def won? # permet de detecter les combinaisons qui sont encore possible et de passer a une autre case 
  COMBINAISONS_GAGNANTES.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full? # le jeu se fini quand les 9 cases sont pleines 
    turn_count == 9
  end

  def draw? # affiche le gagnant quand les cases sont pleines 
    !won? && full?
  end

  def over? # affiche la fin du jeu 
    won? || full? || draw?
  end

  def winner # affiche si X ou O a gagner 
    won = ""
    if winner = won?
      won = @board[winner.first]
    end
  end

  def play # relancer le fichier pour rejouer 
    until over?
      turn
    end

    if won? #permet d afficher le gagnant ou si la partie est nul 
      winner = winner()
      puts "Bravo joueur #{winner} you WIN !"
    elsif draw?
      puts "Match nul"
    end
  end
end

# fin de partie1

game = TicTacToe.new
game.play

