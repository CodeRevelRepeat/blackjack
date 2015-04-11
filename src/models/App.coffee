# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

#listener and reset hands
    @get('deck').on('newGame', =>
      @get('deck').reshuffleIfNecessary()
      @get('playerHand').deal()
      @get('dealerHand').deal()
    )
