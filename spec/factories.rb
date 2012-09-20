# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence( :value ) { |n| "Value_#{n}" }
  sequence( :ip ) { |n| "127.0.0.#{n}" }
  sequence( :acronym ) { |n| "#{n}" }
  
  factory :status do |f|
    f.value { generate( :value ) }
    f.user "User_test"
  end
  
  factory :local do |f|
    f.des_local { generate( :value ) }
  end
  
  factory :totem do |f| 
    f.value {generate(:value)}
    f.ip { generate(:ip)} 
    f.user "User Test"
    f.association :status
    f.association :place
  end

  factory :wicket do |f|
    f.value {generate(:value)}
    f.user "User Test"
    f.association :status 
    f.association :place
    f.guidance true
    f.priority false
    f.association :ticket_type_group
  end

  factory :panel do |f|
    f.value { generate(:value)}
    f.ip {generate(:ip)} 
    f.user "User_Test" 
    f.association :status
    f.association :place
  end

  factory :ticket_type_group do |f|
    f.value {generate(:value)}
    f.association :status
    f.user "User_test"
  end

  factory :ticket_type do |f| 
    f.value { generate(:value)}
    f.acronym { generate(:acronym)}
    f.user "User_Test"
    f.association :status
    f.association :ticket_type_group
    f.priority false
  end

  factory :status_ticket do |f|
    f.value { generate(:value)}
    f.acronym { generate(:acronym)}
    f.user "User_Test"
  end

  factory :ticket do |f|
    f.association :status_ticket 
    f.association :ticket_type 
    f.association :place 
    f.association :totem 
  end

  factory :call_history do |f| 
    f.association :ticket
    f.association :wicket 
    f.association :status_ticket
  end

  factory :place do |f| 
    f.value {generate(:value)}
    f.user "User_test"
    f.association :local 
    f.association :status
    f.ticket_type_groups { |ticket_type_groups| [ticket_type_groups.association(:ticket_type_group)] }
  end
end

