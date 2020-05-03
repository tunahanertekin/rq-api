class QuotesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index 

        begin
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quotes = book.quotes

            render json: {
                status: "SUCCESS",
                message: "All quotes are displayed.",
                data: quotes
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
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quote = book.quotes.find(params[:id])

            render json: {
                status: "SUCCESS",
                message: "Quote is displayed.",
                data: quote
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end

    end

    def create

        begin
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quote = book.quotes.create(quote_params)

            render json: {
                status: "SUCCESS",
                message: "A quote is created.",
                data: quote
            }
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
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quote = book.quotes.find(params[:id])

            quote.update(quote_params)

            render json: {
                status: "SUCCESS",
                message: "Quote is updated.",
                data: quote
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end

        
    end

    def destroy
        begin
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quote = book.quotes.find(params[:id])

            quote.destroy
            render json: {
                status: "SUCCESS",
                message: "Quote is deleted.",
                data: quote
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }
        end
    end


    private def quote_params
        params.require(:quote).permit(:book_id, :title, :body, :owner, :favnum, :page)
    end


end
