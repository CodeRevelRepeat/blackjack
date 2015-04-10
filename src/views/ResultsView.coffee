class window.ResultsView extends Backbone.View
  className: 'results-container'

  template: _.template '<%= winner %> Wins!'

  initialize: (@deck) ->
    @collection.on('stand', (isDealer) ->
      if isDealer then @render()
    )

  render: ->
    winner=@model.GetWinner()
    @$el.html @template winner:winner
    @$el.addClass 'winner'+winner
