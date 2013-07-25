class BSD.Admin.Account extends BSD.Admin.Responder
  constructor: () ->
    super
    this

  _chapterAccount: () ->
    $('.admin_account_chapter_id').hide().val('')
    $('#admin_account_type').change () ->
      if $(this).val() == 'ChapterAccount'
        $('.admin_account_chapter_id').show()
      else
        $('.admin_account_chapter_id').hide()
        $('#admin_account_chapter_id').val('')

  new: () ->
    @_chapterAccount()

  edit: () ->
    @_chapterAccount()

  update: () ->
    @_chapterAccount()
