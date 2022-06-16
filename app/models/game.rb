class Game < ApplicationRecord
    belongs_to :player1, class_name: "User"
    belongs_to :player2, class_name: "User", optional: true

    enum state: {waitingplayer:0, ingame:1, winplayer1: 2, winplayer2: 3, draw: 4}

    def check_win(board)
        boardarray=board.split("")
        win=[["0","1","2"],["3","4","5"],["6","7","8"],["0","3","6"],["1","4","7"],["2","5","8"],["0","4","8"],["2","4","6"]]
        win.map{|x| if(boardarray.to_set.superset?(x.to_set))
            return true
        end}
        return false
    end
end