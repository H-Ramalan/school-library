require_relative '.decorator'

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capatalize
  end
end
