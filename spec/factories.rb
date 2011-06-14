# Read about factories at http://github.com/thoughtbot/factory_girl
Factory.sequence :value do |n| 
  "Value_#{n}"
end

Factory.sequence :ip do |n|
  "127.0.0.#{n}"
end

Factory.sequence :acronym do |n|
  "#{n}"
end

Factory.define :status do |f|
  f.value {Factory.next(:value)}
  f.user "User_test"
end

Factory.define :local do |f|
  f.des_local {Factory.next(:value)}
end

Factory.define :totem do |f| 
  f.value {Factory.next(:value)}
  f.ip { Factory.next(:ip)} 
  f.user "User Test"
  f.association :status
  f.association :place
end

Factory.define :wicket do |f|
  f.value {Factory.next(:value)}
  f.user "User Test"
  f.association :status 
  f.association :place
  f.guidance true
  f.priority false
  f.association :ticket_type_group
end

Factory.define :panel do |f|
  f.value { Factory.next(:value)}
  f.ip {Factory.next(:ip)} 
  f.user "User_Test" 
  f.association :status
  f.association :place
end

Factory.define :ticket_type_group do |f|
  f.value {Factory.next(:value)}
  f.association :status
  f.user "User_test"
end

Factory.define :ticket_type do |f| 
  f.value { Factory.next(:value)}
  f.acronym { Factory.next(:acronym)}
  f.user "User_Test"
  f.association :status
  f.association :ticket_type_group
  f.priority false
end

Factory.define :status_ticket do |f|
  f.value { Factory.next(:value)}
  f.acronym { Factory.next(:acronym)}
  f.user "User_Test"
end

Factory.define :ticket do |f|
  f.association :status_ticket 
  f.association :ticket_type 
  f.association :place 
  f.association :totem 
end

Factory.define :call_history do |f| 
  f.association :ticket
  f.association :wicket 
  f.association :status_ticket
end

Factory.define :place do |f| 
  f.value {Factory.next(:value)}
  f.user "User_test"
  f.association :local 
  f.association :status
  f.ticket_type_groups { |ticket_type_groups| [ticket_type_groups.association(:ticket_type_group)] }
end

