class Game < ApplicationRecord
    has_many :users

    enum state: {waitingplayer:0, ingame:1, winred: 2, wingreen: 3, draw: 4}
end
