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

    def login
        
        begin
            user = User.find_by username: user_params[:username]

            if user.blank?

                render json: {
                    status: "FAILURE",
                    message: "No such a user found.",
                    data: {}
                }
            
            else

                if user.hashedPassword == user_params[:hashedPassword]

                    user.update({
                        lastLogin: Time.now.utc
                    })

                    render json: {
                        status: "SUCCESS",
                        message: "Login is successful.",
                        data: user
                    }

                else
                    render json: {
                        status: "FAILURE",
                        message: "Your password is wrong.",
                        data: {}
                    }
                end
                
            end
            
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end

    end

    def booksdetail
        begin
            #details can be added
            books = User.find(params[:user_id]).books

            booksjson = []
            books.each do |book|
                booksjson.append(book: book, quoteNum: book.quotes.length())
            end

            render json: {
                status: "SUCCESS",
                message: "Books and further details are displayed.",
                data: booksjson,
                booknum: booksjson.length()
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end
        
    end


    private def user_params
        params.require(:user).permit(:username, :email, :favouriteUsers, :favouriteBooks, :favouriteQuotes, :avatar, :pinned, :hashedPassword, :lastLogin)
    end

end
