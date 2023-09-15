require 'rspec'
require_relative '../classroom'

describe Classroom do
  let(:student) { double('Student') }
  let(:classroom) { Classroom.new('Class') }

  describe '#initialize' do
    it 'initializes a classroom object' do
      expect(classroom.label).to eq('Class')
    end

    it 'initializes a classroom object with empty students array' do
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'makes the classroom of the added student to the current classroom' do
      expect(student).to receive(:classroom=).with(classroom)
      classroom.add_student(student)
    end
  end
end
