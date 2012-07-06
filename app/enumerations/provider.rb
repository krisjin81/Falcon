class Provider < EnumerateIt::Base
  associate_values(
    :facebook => ['facebook', 'Facebook'],
    :twitter => ['twitter', 'Twitter'],
    :google => ['google', 'Google']
  )
end