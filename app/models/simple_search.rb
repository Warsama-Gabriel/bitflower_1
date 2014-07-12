class SimpleSearch
  include ActiveModel::Model

  #Generic Search 'q'
  attr_accessor :q
  validates_length_of :q, minimum: 2, message: 'Please enter at least 2 letters to search'

  # Add your other search params or validations here

  def persisted?
    false
  end

  def search_within scope, column_name
    #example where scope: only added when the q param is present
    unless self.q.blank?
      # SQL Injection protection example with LIKE operator
      # Which matches partial strings:
      # scope = scope.where("#{column_name} ILIKE ('%' || ? || '%')", self.q)
      
    end
    #Add your own filters here
    scope
  end

  def self.get_params(params, as = :simple_search)
    params.require(as).permit(:q) if params.has_key? as
  end
end
