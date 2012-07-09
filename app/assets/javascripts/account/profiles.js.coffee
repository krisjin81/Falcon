$ ->
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
      record_id = $(this).parents('.picture-form').data('id')
      if record_id
        $('.picture-form[data-id=' + record_id + ']').remove()
        $('.picture[data-id=' + record_id + ']').show()
      else
        if form.parents('#pictures').find('.picture').length > 0
          form.remove()
        else
          $.get(Routes.new_account_picture_path())

  $('.picture-form').pictureForm()

  $.fn.pictureList = () ->
    $(this).find('a.full-details').bind 'click', (e) ->
      e.preventDefault()
      $.get(Routes.account_picture_path($(this).parents('.picture').data('id')))

  $('#pictures').pictureList()

  $.fn.pictureDetails = () ->
    $(this).find('a.close-details').bind 'click', (e) ->
      e.preventDefault()
      $(this).parents('.picture-details').prev().show();
      $(this).parents('.picture-details').remove();

  $('.picture-details').pictureDetails()