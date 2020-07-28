linkTrack = []

contentHandler = (link) ->
    dynamicContent = $(link).closest('.content-dynamic')
    context = if dynamicContent.length then dynamicContent else $(document)
    target = $(link).data('remote-target')
    $(target).html($ '<loading-filler />')
    
    context.find("a[data-remote-target='#{target}']").removeClass 'active disabled'
    $(link).addClass 'active disabled'

changeHandler = (evt, target) ->
    lastXHR = null
    target ||= document

    links = $(target).find("a[data-remote-target]")
    links.on "ajax:send", (evt, xhr) ->
        if linkTrack.slice(-1)[0] != evt.target then linkTrack.push(evt.target)
        contentHandler(evt.target)
        if lastXHR then lastXHR.abort()
        lastXHR = xhr

$ -> changeHandler() && $(document).on 'content-dynamic', changeHandler
$ -> window.onpopstate = -> 
    linkTrack.pop()
    last = $(linkTrack.slice(-1)[0])
    while last.length && !$("a[href='#{last.attr 'href'}']").length
        linkTrack.pop()
        last = $(linkTrack.slice(-1)[0])
    if last.length then last.click() else location.reload()
