module Admin
  class ClassroomsController < ApplicationController
    before_action :set_classroom, only: %i[show edit update destroy]

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

      respond_to do |format|
        if @classroom.save
          format.html { redirect_to admin_classroom_url(@classroom), notice: 'Classroom was successfully created.' }
          format.json { render :show, status: :created, location: @classroom }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @classroom.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/classrooms/1 or /admin/classrooms/1.json
    def update
      respond_to do |format|
        if @classroom.update(admin_classroom_params)
          format.html { redirect_to admin_classroom_url(@classroom), notice: 'Classroom was successfully updated.' }
          format.json { render :show, status: :ok, location: @classroom }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @classroom.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/classrooms/1 or /admin/classrooms/1.json
    def destroy
      @classroom.destroy

      respond_to do |format|
        format.html { redirect_to admin_classrooms_url, notice: 'Classroom was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.fetch(:classroom).permit(:name, :start_date, :end_date)
    end
  end
end
