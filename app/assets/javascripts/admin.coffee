$ ->

  ###
    Preloader
  ###
  $('body').removeClass('loading')

  ###
  Set List.js
  ###
  options =
    valueNames: [ 'name' ]

  ListLeft = new List('listLeft', options)

  options =
    valueNames: [ 'name' ]
    item: 'ulRight'

  ListRight = new List('listRight', options)

  ###
  $('.list-sort').click ->
    ColListId = $(this).parents('.col-list')[0].idP
    console.log ColListId
    return
  ###


  ###
    Event click in list <li>
  ###
  $('.list-group-item-action').click ->
    UlListId    = $(this).parent()[0].id
    LiListId    = $(this).data()['id']
    LiListName  = $(this).children('span.name').text()

    switch UlListId
      when 'ulLeft'
        DataId = $('#FormIdLeft').attr('value')
        if DataId != ""
          $(".list-group-item-action[data-id=#{DataId}]").removeClass('active')

        $('#FormIdLeft').attr('value', LiListId)
        $('.col-left > span').html(LiListName)
        $('.col-left > i').prop('hidden', true)
      when 'ulRight'
        DataId = $('#FormIdRight').attr('value')
        if DataId != ""
          $(".list-group-item-action[data-id=#{DataId}]").removeClass('active')

        $('#FormIdRight').attr('value', LiListId)
        $('.col-right > span').html(LiListName)
        $('.col-right > i').prop('hidden', true)

    $(this).addClass('active')

    if $('#FormIdLeft').attr('value') != undefined & $('#FormIdRight').attr('value') != undefined
      $('.con-selected form input[type=submit]').prop('disabled', false)

    #console.log UlListId
    #console.log LiListId
    #console.log LiListName

    return


  ###
    Form submit AJAX
  ###

  $('.con-selected form').submit (e) ->
    id_left  = $('#FormIdLeft' ).val()
    id_right = $('#FormIdRight').val()

    $.ajax
      type: 'PUT'
      url: $('.con-selected form').attr('action') + "/linked"
      dataType: 'json'
      data: $(this).serialize()

      beforeSend: (data) ->
        $(".list-group-item-action[data-id=#{id_left}]" ).removeClass("active")
        $(".list-group-item-action[data-id=#{id_right}]").removeClass("active")
        $(".list-group-item-action[data-id=#{id_left}]" ).removeClass("list-group-item-danger")
        $(".list-group-item-action[data-id=#{id_right}]").removeClass("list-group-item-danger")
        $(".list-group-item-action[data-id=#{id_left}]" ).addClass("list-group-item-success")
        $(".list-group-item-action[data-id=#{id_right}]").addClass("list-group-item-success")
        return

      success: (data) ->
        console.log data
        $(".list-group-item-action[data-id=#{id_left}]" ).remove()
        $(".list-group-item-action[data-id=#{id_right}]").remove()
        #Не разобрался. пока так, не отрабатвают методы
        ListLeft  = new List('listLeft', options)######
        ListRight = new List('listRight', options)#####
        ###############################################
        $('#FormIdLeft'       ).attr('value', undefined)
        $('#FormIdRight'      ).attr('value', undefined)
        $('.col-left > span'  ).html("")
        $('.col-right > span' ).html("")
        $('.col-left > i'     ).prop('hidden', false)
        $('.col-right > i'    ).prop('hidden', false)
        return

      error: (data) ->
        console.log data
        $(".list-group-item-action[data-id=#{id_left}]" ).removeClass("list-group-item-success")
        $(".list-group-item-action[data-id=#{id_right}]").removeClass("list-group-item-success")
        $(".list-group-item-action[data-id=#{id_left}]" ).addClass("list-group-item-danger")
        $(".list-group-item-action[data-id=#{id_right}]").addClass("list-group-item-danger")
        return

    e.preventDefault()
    return
