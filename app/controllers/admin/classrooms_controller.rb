module Admin
  class ClassroomsController < ApplicationController
    before_action :fetch_classroom, only: %i[show edit update destroy]

    def index
      @classrooms = Classroom.all
    end

    def show; end

    def new
      @classroom = Classroom.new
    end

    def edit; end

    def create
      @classroom = Classroom.new(admin_classroom_params)

      return redirect_to admin_classroom_url(@classroom), notice: t('.success') if @classroom.save

      render :new, status: :unprocessable_entity
    end

    def update
      return redirect_to admin_classroom_url(@classroom), notice: t('.success') if @classroom.update(admin_classroom_params)

      render :edit, status: :unprocessable_entity
    end

    def destroy
      return redirect_to admin_classrooms_path, notice: t('.success') if @classroom.destroy

      render :index, status: :unprocessable_entity
    end

    private

    def fetch_classroom
      @classroom = Classroom.find(params[:id])
    end

    def admin_classroom_params
      params.fetch(:classroom).permit(:name, :start_date, :end_date, user_ids: [])
    end
  end
end
