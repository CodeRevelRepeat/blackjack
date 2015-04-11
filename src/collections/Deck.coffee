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
    console.log("playermin", @player.minScore());
    console.log('dealermin', @dealer.minScore());
    if (not @dealer.hasBlackJack()) and (@player.hasBlackJack() or @dealer.minScore()>21 or (@player.minScore() > @dealer.minScore() and @player.minScore() <= 21))
      'Player'
    else if (not @player.hasBlackJack()) and (@dealer.hasBlackJack() or @player.minScore()>21 or (@dealer.minScore() > @player.minScore() and @dealer.minScore() <= 21))
      'Dealer'
    else
      'Nobody'
