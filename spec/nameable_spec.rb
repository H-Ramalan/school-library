describe Nameable do
  before :each do
    @nameable = Nameable.new
  end

  context 'When testing a Nameable class' do
    it 'should be an instance of Nameable object' do
      expect(@nameable).to be_an_instance_of Nameable
    end
  end

  context 'When using correct_name method' do
    it 'should raise an error' do
      expect { @nameable.correct_name }.to raise_error('NotImplementedError')
    end
  end
end
