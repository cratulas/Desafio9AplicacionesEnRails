class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_statuses, only: %i[edit new]

  # GET /books or /books.json
  def index
    
    if params[:search]
        if params[:search] == 'On_shelf'
          params[:search] = 1
          @bookses = Book.where('status = ?', params[:search])
        elsif params[:search] == 'Borrow'
          params[:search] = 0
          @bookses = Book.where('status = ?', params[:search])
        else 
          redirect_to books_path notice: 'El dato ingresado no es correcto'
        end

    elsif params[:sort] == 'title'
      @bookses = Book.order(params[:sort])
    else 
      @bookses = Book.all
    end

    
    # if params[:q]
    #   if params[:q] == 'On_shelf'
    #     params[:q] = 1
    #   elsif params[:q] == 'Borrow'
    #     params[:q] = 0
    #   else 
    #     redirect_to books_path notice: 'El dato ingresado no es correcto'
    #   end
    #   @books = Book.where('status = ?', params[:q])
      
    #   if @books.nil?
    #     @books = Book.all
    #   end
    # else
    #   @books = Book.all
    # end

    # @bookses = Book.order(params[:sort])

  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    
    @book = Book.new(book_params)

    if @book.nil?
      format.html { render :new, status: :unprocessable_entity }
    end

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_statuses
    @statuses = Book.statuses.keys
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :status, :loan_date, :return_date)
    end
end
