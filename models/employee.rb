class Employee < ActiveRecord::Base
  belongs_to :store

  validates :first_name, presence: true  
  validates :last_name, presence: true 

  after_create :employee_increment, if: :store
  after_destroy :employee_remove_count, if: :store

  def employee_increment
    if self.gender == "F"
      store.female_employees += 1
    else
      store.male_employees += 1
    end
    store.save
  end

  def employee_remove_count
    if self.gender == "F"
      store.female_employees -= 1
    else
      store.male_employees -= 1
    end
    store.save
  end

  def annual_salary
    self.hourly_rate * 1950
  end

  def self.average_hourly_rate_for(gender)
    if gender == "F"
      where(gender: 'F').average('hourly_rate').round(2)
    elsif gender == "M"
      where(gender: 'M').average('hourly_rate').round(2)
    else
      average('hourly_rate').round(2)
    end
  end

end
