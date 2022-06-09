class GamesController < ApplicationController

    before_action :set_game, only:[:show,:update,:destroy,:assign_player] 
    before_action :set_player, only:[:assign_player]

    def index
        @games=Game.all
        render status:200, json:{games:@games}
    end
    
    def show
        render status:200, json:{game: @game, players: @game.users}
    end

    def create
        @game=Game.new
        if set_player
            if @game.save
                render status:200, json:{game: @game}
            else
                render_errors_response(@game)
            end
        end
    end

    def update
        @game=Game.assign_attributes(game_params)
        finish?
        if @game.save
            render status:200, json:{game: @game}
        else
            render_errors_response(@game)
        end
    end

    def destroy
        if @game.destroy
            render status:200
        else
            render_errors_response(@game)
        end
    end

    def assign_player
        if @game.user_ids.length==1
            @game.user_ids+=[@user.id]
            @game.state=1
            @game.users.first.state=3
            @game.users.first.save
            @game.users.second.state=3
            @game.users.second.save
            render status:200, json:{game: @game}
        else
            render status:400, json:{error: "Game #{@game.id} already has 2 players"}
        end
    end

    def incomplete
        @games=Game.where(state: 'waitingplayer')
        if @games.length>=1
            render status:200, json:{games: @games}
        else
            render status:400, json:{error: "Games with 1 player not found"}
        end
    end

    private

    def game_params
        params.require(:game).permit("pos")
    end

    def set_game
        @game=Game.find_by(id: params[:id])
        if @game.blank?
            render status:404, json:{error: "Game #{params[:id]} does not exist"}
            false
        end
    end

    def set_player
        @user=User.find_by(token: params[:token])
        if @user.blank?
            render status:404, json:{error: "User does not exist"}
            false
        else
            @game.user_ids+=[@user.id]
            @user.state=2
            if !@user.save
                render_errors_response(@user)
                false
            else
                true
            end
        end
    end

    def game
        
    end

    def finish?
        @pos=@game.pos.split(',')
        if ((@pos[0]==value && @pos[1]==value && @pos[2]==value) || 
            (@pos[3]==value && @pos[4]==value && @pos[5]==value) || 
            (@pos[6]==value && @pos[7]==value && @pos[8]==value) || 
            (@pos[0]==value && @pos[3]==value && @pos[6]==value) || 
            (@pos[1]==value && @pos[4]==value && @pos[7]==value) || 
            (@pos[2]==value && @pos[5]==value && @pos[8]==value) || 
            (@pos[0]==value && @pos[4]==value && @pos[8]==value) || 
            (@pos[2]==value && @pos[4]==value && @pos[6]==value))
            if @game.team
                @game.state=2
                false
            else
                @game.state=3
                false
            end
        else
            @game.w.each do |w|
                if w==0
                    i=+1
                end
            end
            if i==0
                @game.state=4
                false
            end
        end
    end
end