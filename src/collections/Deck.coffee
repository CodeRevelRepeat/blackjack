class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @on('stand', (isDealer) ->
      if not isDealer
        @dealer.AI()
    )
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> @player = new Hand [@pop(), @pop()], @, false

  dealDealer: -> @dealer = new Hand [@pop().flip(), @pop()], @, true

  GetWinner: ->
    if @player.minScore > @dealer.minScore
      'player'
    else
      'dealer'
