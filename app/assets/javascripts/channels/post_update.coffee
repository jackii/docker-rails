document.addEventListener 'turbolinks:load', ->
  article = document.querySelectorAll('article')[0]
  post_id = article.dataset.cablePostId if article

  if post_id
    App.updates = App.cable.subscriptions.create { channel: "PostUpdateChannel", post_id: post_id },
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log "Connected to " + App.updates.identifier

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log "Disconnected from " + App.updates.identifier

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        console.log "Received data from " + App.updates.identifier

        # Reload the page
        Turbolinks.visit(window.location)
