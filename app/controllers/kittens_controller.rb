class KittensController < ApplicationController
  
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = 'Good Kitty!!'
      redirect_to @kitten
    else
      flash[:error] = 'Bad Kitty!'
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = 'Nice Kitty!!'
      redirect_to @kitten
    else
      flash[:error] = 'Bad Kitty!!'
      render 'edit'
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = 'Kitty Go Bye Bye :('
    redirect_to root_path
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end

end
