class Game < ApplicationRecord
    has_many :users

    enum state: {waitingplayer:0, ingame:1, winred: 2, wingreen: 3, tie: 4}
end
