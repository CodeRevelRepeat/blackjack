class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @on('stand', (isDealer) ->
      #if its the player then
        #remove buttons
        #dealer.ai()
      console.log(isDealer)
    )
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @, false

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

