# frozen_string_literal: true

class TimelogsBaseController < ApplicationController
  def index
    @timelogs = Timelog.all
  end

  def new
    @timelog = Timelog.new
  end

  def show
    find_timelog
  end

  def create
    @timelog = Timelog.new(timelog_params)
    if @timelog.save
      redirect_to my_timelog, notice: 'Timelog was successfully created.'
    else
      render :new
    end
  end

  def edit
    find_timelog
  end

  def update
    find_timelog
    if @timelog.update(timelog_params)
      redirect_to my_timelog, notice: 'Timelog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_timelog
    @timelog.destroy
    redirect_to my_timelog, notice: 'Timelog was successfully destroyed.'
  end

  private

  def find_timelog
    @timelog = Timelog.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @timelog
  end

  def timelog_params
    params.require(:timelog).permit(:hours)
  end
end
