class IdiomsController < ApplicationController
  skip_before_filter :authenticate, only: [:show, :index]

  def new
  end

  def create
    @idiom= Idiom.new
    @idiom.title= params[:idiom][:title]
    @idiom.description= params[:idiom][:description]

    if @idiom.save
      redirect_to @idiom, flash: { notice: "#{@idiom.title} created"}
    else
      render 'new'
    end
  end

  def destroy
  end

  def update
    @idiom= Idiom.find(params[:id])
    @idiom.title= params[:idiom][:title]
    @idiom.description= params[:idiom][:description]

    if @idiom.save
      redirect_to @idiom, flash: { notice: "#{@idiom.title} updated"}
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
  end

  def index
  end
end
