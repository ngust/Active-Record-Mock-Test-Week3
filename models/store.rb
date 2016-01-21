class Store < ActiveRecord::Base
  has_many :employees

  validates :name, presence: true, length: {maximum: 25}
  validates :annual_revenue, numericality: { greater_than_or_equal_to: 0 }
  validates :male_employees, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :female_employees, numericality: { greater_than_or_equal_to: 0, only_integer: true } 



  def annual_expense
    # total = 0
    # employees.each do |guy|
    #   total += guy.annual_salary
    # end
    # total
    Employee.sum('hourly_rate') * 1950

  end

  def annual_profit
    annual_revenue - annual_expense
  end

end
