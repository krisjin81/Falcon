class Locale < EnumerateIt::Base
  associate_values(
      :en => ['en', 'English'],
      :fr => ['fr', 'Français'],
      :fr => ['ru', 'Русский']
  )
end
