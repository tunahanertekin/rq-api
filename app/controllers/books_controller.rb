class BooksController < ApplicationController

    skip_before_action :verify_authenticity_token


    def index
        begin
            user = User.find(params[:user_id])
            books = user.books
            render json: {
                status: 'SUCCESS', 
                message: 'All books are displayed.',
                data: books
            }
        rescue => exception
            render json: {
                status: 'FAILED', 
                message: exception.message,
                data: []
            }
        end
    end


    def show
        begin
            user = User.find(params[:user_id])

            begin
                book = user.books.find([params[:id]])

                render json: {
                    status: 'SUCCESS',
                    message: 'Book is displayed.',
                    data: book
                }

            rescue => exception
                render json: {
                    status: 'FAILURE',
                    message: exception.message,
                    data: {}
                }
            end


        rescue => exception
            render json: {
                    status: 'FAILURE',
                    message: exception.message,
                    data: {}
                }
        end

    end

    #???
    def create

        begin
            user = User.find(params[:user_id])

            begin
                book = user.books.create(book_params)
                render json: {
                    status: "SUCCESS",
                    message: "A book is added to user's library.",
                    data: book
                }
            rescue => exception
                render json: {
                    status: "FAILURE",
                    message: exception.message,
                    data: {}

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
            user = User.find(params[:user_id])
            book = user.books.find(params[:id])
            book.update(book_params)

            render json: {
                status: "SUCCESS",
                message: "Book is updated.",
                data: book
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
            
            begin
                book = user.books.find(params[:id])
                book.destroy

                render json: {
                    status: "SUCCESS",
                    message: "Book is deleted.",
                    data: book
                }

            rescue => exception
                render json: {
                    status: "FAILURE",
                    message: exception.message,
                    data: {}
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

    def quotesdetail

        begin
            user = User.find(params[:user_id])
            book = user.books.find(params[:book_id])
            quotes = book.quotes

            quotesjson = []
            quotes.each do |quote|
                quotesjson.append(quote: quote, book: book, user: user)
            end

            render json: {
                status: "SUCCESS",
                message: "All quotes are displayed.",
                data: quotesjson
            }
        rescue => exception
            render json: {
                status: "FAILURE",
                message: exception.message,
                data: []
            }
        end

    end


    




    private def book_params
        params.require(:book).permit(:user_id, :title, :author, :publisher, :translator, :edition, :language)
    end

end
