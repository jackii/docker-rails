class Posts
  index: ->
    new TableRowLink()

  edit: ->
    new Upload()

  new: ->
    new Upload()

Punchbox.on('Posts', Posts)
