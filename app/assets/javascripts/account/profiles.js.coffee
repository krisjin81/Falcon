@Styx.Initializers.AccountProfiles =
  show: (data) ->
    Path.map("#!/index").to(() ->
      $.get(Routes.account_pictures_path())
    )

    Path.map("#!/pictures/new").to(() ->
      $.get(Routes.new_account_picture_path())
    )

    Path.map("#!/pictures/:id").to(() ->
      $.get(Routes.account_picture_path(this.params['id']))
    )

    Path.map("#!/pictures/:id/edit").to(() ->
      $.get(Routes.edit_account_picture_path(this.params['id']))
    )

    Path.root("#!/index")

    Path.listen()

    $('.back').live 'click', (e) ->
      e.preventDefault()
      history.back()

    $.fn.pictureForm = () ->
      form = $(this)
      form.find('input[type=file]').each () ->
        $(this).fileupload
          url: Routes.upload_account_pictures_path(),
          formData: false,
          dataType: 'json',
          dropZone: $('.drop-zone'),
          limitMultiFileUploads: 1,
          xhrFields:
            withCredentials: true
          send: (e, data) ->
            $(e.target).parents('.upload').block()
          done: (e, data) ->
            file = JSON.parse(data.jqXHR.responseText)
            imageArea = $(e.target).parents('.upload').unblock()
            imageArea.find('.drop-zone').empty()
              .append($('<img src="' + file.preview_url + '" alt="preview" />'))
              .append($('<input type="hidden" name="picture[image_cache]" value="' + file.cache_name + '" />'))
      form.find('.cancel').bind 'click', (e) ->
        e.preventDefault()
        history.back()