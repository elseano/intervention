require 'machinist/active_record'

Sham.name    { (1..10).collect { ('a'..'z').to_a.rand } }

Priority.destroy_all
Priority.create! :name => "Low", :level => 0
Priority.create! :name => "Medium", :level => 5
Priority.create! :name => "High", :level => 10

Task.blueprint do
  name     { Sham.name }
  priority { Priority.find(:all).rand }
end

Project.blueprint do
  name      { Sham.name }
  tasks     { (0..(1+rand(10))).to_a.collect { Task.make } }
end
