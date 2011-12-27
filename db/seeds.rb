# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

StatusTicket.create([
  {:value => "Available", :acronym => "AVL", :user => "SYSTEM"},
  {:value => "Attended", :acronym => "ATT", :user => "SYSTEM"},
  {:value => "Called", :acronym => "CLD", :user => "SYSTEM"},
  {:value => "Canceled", :acronym => "CAN", :user => "SYSTEM"},
  {:value => "Pending", :acronym => "PEN", :user => "SYSTEM"},
  {:value => "Examed", :acronym => "XMD", :user => "SYSTEM"}
])

Status.create([
  {:value => "Active", :user => "SYSTEM"},
  {:value => "Inactive", :user => "SYSTEM"}
])
