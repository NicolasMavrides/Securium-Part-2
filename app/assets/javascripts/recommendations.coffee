window.quill = null
setupQuill = ->
    if $('.quill-editor').length
        window.quill = new Quill '.quill-editor', {
            theme: 'snow',
            placeholder: 'Add a description...'
        }
    true

addQuillToForm = -> $('#recommendation-content').find('form').submit -> 
    description = $("input[name='recommendation[description]']")
    description.val(window.quill.root.innerHTML)

$ -> setupQuill() && $(document).on 'content-dynamic', setupQuill
$ -> addQuillToForm() && $(document).on 'content-dynamic', addQuillToForm
