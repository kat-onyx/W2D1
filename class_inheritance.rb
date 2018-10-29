# Managers should get a bonus based on the total salary of all of their subordinates,
# as well as the manager's subordinates' subordinates, and the subordinates' subordinates' subordinates, etc.
#
# bonus = (total salary of all sub-employees) * multiplier
# Testing
# If we have a company structured like this:
#
# Name	Salary	Title	Boss
# Ned	$1,000,000	Founder	nil
# Darren	$78,000	TA Manager	Ned
# Shawna	$12,000	TA	Darren
# David	$10,000	TA	Darren
# then we should have bonuses like this:
#
# ned.bonus(5) # => 500_000
# darren.bonus(4) # => 88_000
# david.bonus(3) # => 30_000
require 'byebug'

class Employee
  attr_reader :name, :title, :salary, :boss, :subordinates

  def initialize(name, title, salary, boss, subordinates = [])
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @subordinates = subordinates
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee
  # using a queue
  def bonus(multiplier)
    total = 0
    sub_employee = self.subordinates.dup
    until sub_employee.empty?
      employee = sub_employee.first
      sub_employee += employee.subordinates unless employee.subordinates.empty?
      total += employee.salary
      sub_employee.shift
    end
    total * multiplier
  end

end
