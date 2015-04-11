class window.ResultsView extends Backbone.View
  className: 'results-container'

  template: _.template '<%= winner %> Wins!'

  initialize: ->

    @collection.on('stand', (isDealer) ->
      if isDealer
        @render()
    , @)

  render: ->
    winner=@collection.GetWinner()
    @$el.html @template winner:winner
    @$el.addClass 'winner'+winner
