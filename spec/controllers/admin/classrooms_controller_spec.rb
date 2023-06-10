require "rails_helper"

RSpec.describe Admin::ClassroomsController, type: :controller do
  describe "GET #index" do
    xit "assigns all classrooms to @classrooms" do
      classroom1 = create(:classroom)
      classroom2 = create(:classroom)

      get :index

      expect(assigns(:classrooms)).to match_array([classroom1, classroom2])
    end

    xit "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:classroom) { create(:classroom) }

    it "assigns the requested classroom to @classroom" do
      get :show, params: { id: classroom.id }

      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the show template" do
      get :show, params: { id: classroom.id }

      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new classroom to @classroom" do
      get :new

      expect(assigns(:classroom)).to be_a_new(Classroom)
    end

    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new classroom" do
        expect {
          post :create, params: { classroom: attributes_for(:classroom) }
        }.to change(Classroom, :count).by(1)
      end

      it "redirects to the created classroom" do
        post :create, params: { classroom: attributes_for(:classroom) }

        expect(response).to redirect_to(admin_classroom_url(assigns(:classroom)))
      end
    end

    context "with invalid parameters" do
      it "does not create a new classroom" do
        expect {
          post :create, params: { classroom: attributes_for(:classroom, name: nil) }
        }.to_not change(Classroom, :count)
      end

      it "renders the new template with unprocessable_entity status" do
        post :create, params: { classroom: attributes_for(:classroom, name: nil) }

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    let(:classroom) { create(:classroom) }

    it "assigns the requested classroom to @classroom" do
      get :edit, params: { id: classroom.id }

      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the edit template" do
      get :edit, params: { id: classroom.id }

      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let(:classroom) { create(:classroom) }

    context "with valid parameters" do
      it "updates the requested classroom" do
        patch :update, params: { id: classroom.id, classroom: { name: "New Name" } }
        classroom.reload

        expect(classroom.name).to eq("New Name")
      end

      it "redirects to the classroom" do
        patch :update, params: { id: classroom.id, classroom: { name: "New Name" } }

        expect(response).to redirect_to(admin_classroom_url(classroom))
      end
    end

    context "with invalid parameters" do
      it "does not update the classroom" do
        old_name = classroom.name

        patch :update, params: { id: classroom.id, classroom: { name: nil } }
        classroom.reload

        expect(classroom.name).to eq(old_name)
      end

      it "renders the edit template with unprocessable_entity status" do
        patch :update, params: { id: classroom.id, classroom: { name: nil } }

        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:classroom) { create(:classroom) }

    context "with valid parameters" do
      it "deletes the classroom" do
        expect {
          delete :destroy, params: { id: classroom.id }
        }.to change(Classroom, :count).by(-1)
      end

      it "redirects to the classrooms list" do
        delete :destroy, params: { id: classroom.id }
        expect(response).to redirect_to(admin_classrooms_url)
      end
    end
  end

  describe "#fetch_classroom" do
    let(:classroom) { create(:classroom) }

    it "assigns the requested classroom to @classroom" do
      get :show, params: { id: classroom.id }

      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the show template" do
      get :show, params: { id: classroom.id }

      expect(response).to render_template(:show)
    end

    context "when classroom does not exist" do
      it "should throw error" do
        expect {
          get :show, params: { id: 0 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
