if defined? JsRoutes
  JsRoutes.setup do |config|
    config.exclude = /^admin_/
  end
end