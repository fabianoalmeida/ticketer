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
  f.des_local "Home"
end

Factory.define :place do |f| 
  f.value {Factory.next(:value)}
  f.user "User_test"
  f.association :local 
  f.association :status
end

Factory.define :totem do |f| 
  f.value {Factory.next(:value)}
  f.ip { Factory.next(:ip)} 
  f.user "User Test"
  f.association :status
  f.association :place
end

Factory.define :guidance do |f| 
  f.value {Factory.next(:value)}
  f.user "User Test"
end

Factory.define :wicket do |f|
  f.value {Factory.next(:value)}
  f.user "User Test"
  f.association :status 
  f.association :place
  f.association :guidance
end

Factory.define :panel do |f|
  f.value { Factory.next(:value)}
  f.ip {Factory.next(:ip)} 
  f.user "User_Test" 
  f.association :status
  f.association :place
end

Factory.define :ticket_type do |f| 
  f.value { Factory.next(:value)}
  f.acronym { Factory.next(:acronym)}
  f.user "User_Test"
  f.association :status
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

Factory.define :call_history_type do |f| 
  f.value { Factory.next(:value)}
  f.acronym { Factory.next(:acronym)}
  f.user "User_Test"
end

Factory.define :call_history do |f| 
  f.association :ticket
  f.association :wicket 
  f.association :call_history_type
end

