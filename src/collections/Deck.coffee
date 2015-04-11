class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @on('stand', (isDealer) ->
      if not isDealer
        @dealer.AI()
    )
    @reshuffle()

  dealPlayer: ->
    if(not @player)
      @player = new Hand [], @, false
    @player.deal()
    @player


  dealDealer: ->
    if(not @dealer)
      @dealer = new Hand [], @, true
    @dealer.deal()
    @dealer

  GetWinner: ->
    if @player.beats(@dealer)
      'Player'
    else if @dealer.beats(@player)
      'Dealer'
    else
      'Nobody'

  reshuffle: ->
    @reset()
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  reshuffleIfNecessary: ->
    if @length < 15
      @reshuffle()

