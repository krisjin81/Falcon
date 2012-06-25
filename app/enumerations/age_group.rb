class AgeGroup < EnumerateIt::Base
  associate_values(
      :under_15       => [1, '15 under'],
      :from_15_to_25  => [2, '15-25'],
      :from_25_to_40  => [3, '25-40'],
      :over_40        => [4, '40+']
  )
end
