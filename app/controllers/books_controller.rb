class BooksController < ApplicationController
  def index
    @books = Book.all
    @book_new = Book.new
    # @user = User.all
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to book_path(@book.id)
    end
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @books = Book.all
    if @book_new.save
      redirect_to user_path(@user.id), flash:{notice:"You have created book successfully."}
    else
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), flash:{notice:"You have updated book successfully."}
    else
      render:edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end


  private
  def book_params
    params.require(:book).permit(:title,:body,:introduction)
  end

end

