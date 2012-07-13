@Styx.Initializers.AccountProfiles =
  show: (data) ->
    Path.map("#!/index")
    .enter(() ->
      $('#pictures').block()
    )
    .to(() ->
      $.get(Routes.account_pictures_path(), () ->
        $('#pictures').unblock()
      )
    )

    Path.map("#!/pictures/new")
    .enter(() ->
      $('#pictures').block()
    )
    .to(() ->
      $.get(Routes.new_account_picture_path(), () ->
        $('#pictures').unblock()
      )
    )

    Path.map("#!/pictures/:id")
    .enter(() ->
      $('#pictures').block()
    )
    .to(() ->
      $.get(Routes.account_picture_path(this.params['id']), () ->
        $('#pictures').unblock()
      )
    )

    Path.map("#!/pictures/:id/edit")
    .enter(() ->
      $('#pictures').block()
    )
    .to(() ->
      $.get(Routes.edit_account_picture_path(this.params['id']), () ->
        $('#pictures').unblock()
      )
    )

    Path.root("#!/index")

    Path.listen()

    $('.back').live 'click', (e) ->
      e.preventDefault()
      history.back()

    $.fn.pictureForm = () ->
      image_tag = (src, alt, className) ->
        $('<img src="' + src + '" alt="' + alt + '" class="' + className + '" />')

      hidden_field_tag = (name, value) ->
        $('<input type="hidden" id="' + name + '" name="' + name + '" value="' + value + '" />')

      picture_hidden_field_tag = (name, value) ->
        $('<input type="hidden" id="picture_' + name + '" name="picture[' + name + ']" value="' + value + '" />')

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
              .append(image_tag(file.preview_url, 'preview', 'preview'))
              .append(picture_hidden_field_tag('original_image_cache', file.cache_name))
              .append(hidden_field_tag('original_image_url', file.url))
              .append(hidden_field_tag('original_image_preview_url', file.preview_url))
            imageArea.find('.filters').removeClass('hidden')
      form.find('.cancel').bind 'click', (e) ->
        e.preventDefault()
        history.back()

      form.find('.filters a').bind 'click', (e) ->
        e.preventDefault()
        link = $(this)

        return if link.hasClass('active')

        link.siblings().removeClass('active')
        link.addClass('active')
        imageArea = form.find('.upload').block()

        if link.hasClass('original')
          imageArea.find('.preview').attr('src', imageArea.find('input#original_image_preview_url').val())
          imageArea.find('input#picture_filter').val("")
          imageArea.append(picture_hidden_field_tag('remove_formatted_image', true))
          imageArea.unblock()
        else
          filter_name = $(this).attr('href').replace(/^#/, '')
          picture_id = form.data('id')
          imageArea = form.find('.upload').block()
          $.ajax
            url: Routes.apply_filter_account_pictures_path()
            type: 'POST'
            data: { 'filter': filter_name, 'path': imageArea.find("input#original_image_url").val() }
            complete: () ->
              imageArea.unblock()
            success: (data) ->
              if data && data.success
                imageArea.find('img.preview').attr('src', data.preview_url)
                imageArea.find('input#picture_formatted_image_cache').remove()
                imageArea.find('input#picture_remove_formatted_image').remove()
                imageArea.find('.drop-zone').append(picture_hidden_field_tag('formatted_image_cache', data.cache_name))
                imageArea.find('input#picture_filter').val(filter_name)