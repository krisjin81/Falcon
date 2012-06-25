class Locale < EnumerateIt::Base
  associate_values(
      :en => ['en', 'English'],
      :fr => ['fr', 'French'],
      :fr => ['ru', 'Русский']
  )
end
