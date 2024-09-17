# frozen_string_literal: true

class Customer
  include GraphqlResource::FinderMethods
  include Attributes

  def greet
    puts "hey, my name is #{firstName}"
  end
end
