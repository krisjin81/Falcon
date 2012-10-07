class AdminLevel < EnumerateIt::Base
  associate_values :view=>1, :user=>2, :site=>3, :super=>4
end
