class GamesController < ApplicationController

    before_action :set_game, only:[:move,:assign_player,:check_player] 
    before_action :set_player, only:[:assign_player]
    before_action :check_token, only:[:move]

    def create
        @game=Game.new
        if set_player
            @game.player1=@user
            if @game.save
                render status:200, json:{id: @game.id,board1: @game.board1,board2: @game.board2,turn: @game.turn,state: @game.state,player1:@game.player1.name}
            else
                render_errors_response(@game)
            end
        end
    end

    def move
        if @game.turn==true
            @game.board1+="#{params[:pos]}"
            if @game.board1.length>=3 && @game.check_win(@game.board1)
                @game.state=2
            end
        else
            @game.board2+="#{params[:pos]}"
            if @game.board1.length>=3 && @game.check_win(@game.board2)
                @game.state=3
            end
        end
        if @game.state=="ingame" && @game.board1.length+@game.board2.length==9
            @game.state=4
        end
        @game.toggle!(:turn)
        if @game.save
            render status:200, json:{id: @game.id,board1: @game.board1,board2: @game.board2,turn: @game.turn,state: @game.state,player1:@game.player1_id,player2:@game.player2_id}
        else
            render_errors_response(@game)
        end
    end

    def check_player
        if(@game.player2==nil)
            render status:200, json:{id: @game.id,board1: @game.board1,turn: @game.turn,state: @game.state,player1:@game.player1.name}
        else
            render status:200, json:{id: @game.id,board1: @game.board1,board2: @game.board2,turn: @game.turn,state: @game.state,player1:@game.player1.name,player2:@game.player2.name}
        end
    end

    def assign_player
        if(@game.player2==nil)
            @game.player2=@user
            @game.state=1
            if @game.save
                render status:200, json:{id: @game.id,board1: @game.board1,board2: @game.board2,turn: @game.turn,state: @game.state,player1:@game.player1.name,player2:@game.player2.name}
            else
                render status:400, json:{error: "Something's wrong"}
            end
        else
            render status:400, json:{error: "Game #{@game.id} already has 2 players"}
        end
    end

    def incomplete
        @games=Game.where(state: 'waitingplayer')
        if @games.length>=1
            gamesincomplete=[]
            @games.each do |g|
                gamesincomplete.push({id:g.id,player1:g.player1.name})
            end
            render status:200, json:{games: gamesincomplete }
        else
            render status:400, json:{error: "Games with 1 player not found"}
        end
    end

    private

    def set_game
        @game=Game.find_by(id: params[:id])
        if @game.blank?
            render status:404, json:{error: "Game #{params[:id]} doesn't exist"}
            false
        end
    end

    def set_player
        @user=User.find_by(token: params[:token])
        if @user.blank?
            render status:404, json:{error: "User doesn't exist"}
            false
        else
            true
        end
    end

    def check_token
        if @game.turn==true
            if request.headers["Authorization"] != "Bearer #{@game.player1.token}"
                render status:400, json:{error: "User Token isn't valid"}
                false
            end
        else
            if request.headers["Authorization"] != "Bearer #{@game.player2.token}"
                render status:400, json:{error: "User Token isn't valid"}
                false
            end
        end
    end
end
