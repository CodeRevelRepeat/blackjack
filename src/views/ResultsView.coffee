class window.ResultsView extends Backbone.View
  className: 'results-container'

  template: _.template '<%= winner %> Wins! </br> <button class="refresh">New Game</button>'

  initialize: ->

    @collection.on('stand', (isDealer) ->
      if isDealer
        @render()
    , @)

  render: ->
    winner=@collection.GetWinner()
    @$el.html @template winner:winner
    @$el.addClass 'winner'+winner

  events:
    'click .refresh': ->
      @collection.trigger('newGame')  #trigger to app

