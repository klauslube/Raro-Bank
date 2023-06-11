require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'Relations' do
    it { should have_many(:users) }
  end

  describe 'Model' do
    subject (:classroom) { build(:classroom) }

    it 'should be valid when all attributes are valid' do
      classroom.save
      expect(classroom).to be_valid
      expect(classroom.errors).to be_empty
    end

    xit 'should be invalid when name is nil' do
      classroom.name = nil
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:name)
      expect(classroom.errors[:name]).to include("can't be blank")
    end

    xit 'should be invalid when name is less than 3 characters' do
      classroom.name = 'ab'
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:name)
      expect(classroom.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    xit 'should be invalid when name is more than 100 characters' do
      classroom.name = 'a' * 101
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:name)
      expect(classroom.errors[:name]).to include('is too long (maximum is 100 characters)')
    end

    xit 'should be invalid when start_date is nil' do
      classroom.start_date = nil
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:start_date)
      expect(classroom.errors[:start_date]).to include("can't be blank")
    end

    xit 'should be invalid when end_date is nil' do
      classroom.end_date = nil
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:end_date)
      expect(classroom.errors[:end_date]).to include("can't be blank")
    end

    xit 'should be invalid when end_date is before start_date' do
      classroom.start_date = Date.today
      classroom.end_date = Date.today - 1
      classroom.save
      expect(classroom).to be_invalid
      expect(classroom.errors).to include(:end_date)
      expect(classroom.errors[:end_date]).to include('must be after start date')
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
  end

  describe 'Scopes' do
    context 'when searching by name' do
      subject (:classroom) { build(:classroom) }
      it 'should return the correct classroom' do
        classroom.save
        expect(Classroom.by_name(classroom.name)).to include(classroom)
      end

      it 'should return an empty classroom list when not found' do
        expect(Classroom.by_name('')).to be_empty
      end
    end

    context 'when searching with name contains' do
      subject (:classroom) { build(:classroom, name: 'Ana Carolina') }
      it 'should return the correct classroom' do
        classroom.save
        expect(Classroom.name_contains('Car')).to include(classroom)
        expect(Classroom.name_contains('Ana')).to include(classroom)
        expect(Classroom.name_contains('car')).to include(classroom)
      end

      it 'should return an empty classroom list when not found' do
        expect(Classroom.name_contains('')).to be_empty
      end
    end

    context 'when searching with active scope' do
      let!(:active_classroom) { create(:classroom, start_date: Date.yesterday, end_date: Date.tomorrow) }
      let!(:inactive_classroom) {
        create(:classroom, start_date: Date.tomorrow, end_date: Date.tomorrow + 1.week)
      }
      it 'should returns actives classrooms' do
        classrooms = Classroom.active
        expect(classrooms.include?(active_classroom)).to eql(true)
      end

      it 'should not returns inactives classrooms' do
        classrooms = Classroom.active
        expect(classrooms.include?(inactive_classroom)).to eql(false)
      end
    end

    context 'when searching with inactive scope' do
      let!(:active_classroom) { create(:classroom, start_date: Date.yesterday, end_date: Date.tomorrow) }
      let!(:inactive_classroom) {
        create(:classroom, start_date: Date.tomorrow, end_date: Date.tomorrow + 1.week)
      }
      it 'should returns inactives classrooms' do
        classrooms = Classroom.inactive
        expect(classrooms.include?(inactive_classroom)).to eql(true)
      end

      it 'should not returns actives classrooms' do
        classrooms = Classroom.inactive
        expect(classrooms.include?(active_classroom)).to eql(false)
      end
    end
  end

  describe 'Callbacks' do
    context 'when association a classroom to a user' do
      let(:user) { build(:user) }
      let(:classroom) { build(:classroom) }
      it "should upgrade the user's role to premium" do
        expect(user.role).to eql('free')
        classroom.users << user
        expect(user.role).to eql('premium')
      end
      it 'should not upgrade the user role if it is already premium' do
        user.update(role: :premium)
        expect(user.role).to eql('premium')
        expect {
          classroom.users << user
          user.reload
        }.to_not change { user.role }
      end
    end
  end
end
