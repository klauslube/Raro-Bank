module Admin
  class ClassroomsController < ApplicationController
    before_action :fetch_classroom, only: %i[show edit update destroy]

    # GET /admin/classrooms or /admin/classrooms.json
    def index
      @classrooms = Classroom.all
    end

    # GET /admin/classrooms/1 or /admin/classrooms/1.json
    def show; end

    # GET /admin/classrooms/new
    def new
      @classroom = Classroom.new
    end

    # GET /admin/classrooms/1/edit
    def edit; end

    # POST /admin/classrooms or /admin/classrooms.json
    def create
      @classroom = Classroom.new(classroom_params)

      return redirect_to admin_classroom_url(@classroom), notice: t(".success") if @classroom.save

      render :new, status: :unprocessable_entity
    end

    # PATCH/PUT /admin/classrooms/1 or /admin/classrooms/1.json
    def update
      return redirect_to admin_classroom_url(@classroom), notice: t(".success") if @classroom.update(classroom_params)

      render :edit, status: :unprocessable_entity
    end

    # DELETE /admin/classrooms/1 or /admin/classrooms/1.json
    def destroy
      return redirect_to admin_classrooms_url, notice: t(".success") if @classroom.destroy

      render :edit, status: :unprocessable_entity
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def fetch_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.fetch(:classroom).permit(:name, :start_date, :end_date, user_ids: [])
    end
  end
end
