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


    def random

        begin
            quotes = Quote.order("RANDOM()").limit(10)
            
            qjson = []

            quotes.each do |quote|
                book = Book.find(quote.book_id)
                user = User.find(book.user_id)
                qjson.append(user: user, book: book, quote: quote)
            end

            render json: {
                status: "SUCCESS",
                message: "10 random quotes are listed.",
                data: qjson
            }
        rescue => exception
            
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: {}
            }

        end

    end

    def flow

        begin
            quotes = Quote.order(created_at: :desc).limit(50)

            qjson = []

            quotes.each do |quote|
                book = Book.find(quote.book_id)
                user = User.find(book.user_id)
                qjson.append(user: user, book: book, quote: quote)
            end

            render json: {
                status: "SUCCESS",
                message: "Last 50 quotes are listed.",
                data: qjson
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
