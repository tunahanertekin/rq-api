class UsersController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index

        begin
            users = User.all

            render json: {
                status: "SUCCESS",
                message: "All users are displayed.",
                data: users
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: []
            }
        end

    end


    def show

        begin
            user = User.find(params[:id])
            render json: {
                status: 'SUCCESS',
                message: 'User is loaded.',
                data: user
            }
        rescue => exception
            render json: {
                status: 'FAILURE',
                message: exception.message,
                data: {}
            }
        end
        
    end


    def create

        begin
            user = User.new(user_params)

            if user.save
                render json: {
                    status: "SUCCESS",
                    message: "A user is added.",
                    data: user
                }
            else
                render json: {
                    status: "FAILURE",
                    message: exception.message,
                    data: []
                }
            end
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end

    end

    def update

        begin
            user = User.find(params[:id])
            user.update(user_params)

            render json:{
                status: "SUCCESS",
                message: "User is updated.",
                data: user
            }
        rescue => exception
            render json:{
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end

    end

    def destroy

        begin
            user = User.find(params[:id])
            user.destroy
            
            render json: {
                status: "SUCCESS",
                message: "User is deleted.",
                data: user
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: user
            }
        end
          
    end



    private def user_params
        params.require(:user).permit(:username, :email, :favouriteUsers, :favouriteBooks, :favouriteQuotes, :avatar, :pinned)
    end

end
