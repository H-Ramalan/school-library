require 'rspec'
require_relative '../teacher'
require_relative '../person'

describe Teacher do
  let(:teacher) { Teacher.new(35, 'Maths', parent_permission: true) }
  it 'initializes with name, age, specialization and parent_permission' do
    expect(teacher.age).to eq(35)
    expect(teacher.specialization).to eq('Maths')
    expect(teacher.instance_variable_get(:@parent_permission)).to be_truthy
  end
  it 'a kind of person' do
    expect(teacher).to be_a(Person)
  end

  it 'can use services without parent_permission' do
    teacher_without_permission = Teacher.new('Maths', 35, parent_permission: false)
    expect(teacher_without_permission.can_use_services?).to be_truthy
  end
end
