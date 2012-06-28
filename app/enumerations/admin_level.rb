class AdminLevel < EnumerateIt::Base
  associate_values :global_admin => 1, :admin => 2, :editor => 3
end
