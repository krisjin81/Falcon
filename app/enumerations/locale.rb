class Locale < EnumerateIt::Base
  associate_values(
      :en => ['en', 'English'],
      :fr => ['fr', 'French'],
      :ru => ['ru', 'Russian']
  )
end
