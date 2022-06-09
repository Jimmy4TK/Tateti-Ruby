class UsersController < ApplicationController

    before_action :set_user, only: [:show,:update,:destroy]
    before_action :check_token, only:[:update,:destroy]

    def index
        @users=User.all.select("id,name,email,state,created_at,updated_at")
    end

    def show
        render status:200, json:{id: @user.id,name: @user.name,email:@user.email,state: @user.state,created_at: @user.created_at,updated_at: @user.updated_at}
    end

    def create
        if params[:password]==params[:password2]
            @user=User.new(params.require(:user).permit(:name,:email,:password))
            if @user.save
                render status:200, json:{token: @user.token}
            else
                render_errors_response(@user)
            end
        else
            render status:400, json:{error: "Password and confirm password don't match"}
        end
    end


    def update
        @user.assign_attributes(user_params)
        if @user.save
            render status:200, json:{user: @user}
        else
            render_errors_response(@user)
        end
    end

    def destroy
        if @user.destroy
            render status:200, json:{}
        else
            render_errors_response(@user)
        end
    end

    def login
        @user=User.find_by(email: params[:email])
        if @user.blank?
            render status:404, json:{error: "User #{params[:email]} does not exist"}
        else
            if @user.authenticate("#{params[:password]}")
                render status:200,json:{token: @user.token}
            else
                render status:400,json:{error: "Password is incorrect"}
            end
        end
    end

    def signout
    end

    def current
        @user=User.find_by(token: params[:token])
        if @user.blank?
            render status:401, json:{error: "User doesn't exist"}
        else
            render status:200, json:{id: @user.id,name:@user.name,email:@user.email,state:@user.state}
        end
    end

    def password
        @user=User.find_by(token: params[:token])
        if @user.blank?
            render status:404, json:{error: "User does not exist"}
        else
            if @user.authenticate(params[:currentPassword])
                if params[:newPassword]==params[:newPassword2]
                    @user.password=params[:newPassword]
                    if @user.save
                        render status:200, json:{message: "Password change successful"}
                    else
                        render_errors_response(@user)
                    end
                else
                    render status:400,json:{error: "Confirm Password is incorrect"}
                end
            else
                render status:400,json:{error: "Password is incorrect"}
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:name,:email,:password)
    end

    def set_user
        @user=User.find_by(id: params[:id])
        if @user.blank?
            render status:404, json:{error: "User #{params[:id]} does not exist"}
            false
        end
    end

    def check_token
        if request.headers["Authorization"] != "Bearer #{@user.token}"
            render status:400, json:{error: "Token isn't valid"}
        end
    end

end