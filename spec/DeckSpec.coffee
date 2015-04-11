assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49


  describe 'has blackjack', ->
    it 'should return true if hand has blackjack', ->
      hand.at(0).value = 10
      hand.at(1).value = 11
      assert.strictEqual hand.hasBlackJack(), true

