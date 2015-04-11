assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47


  describe 'has blackjack', ->
    it 'should return true if hand has blackjack', ->
      hand.pop()
      hand.pop()
      hand.push(new Card
        rank: 1
        suit: 1
      )
      hand.push(new Card
        rank: 10
        suit: 1
      )
      console.log(hand.at(0),hand.at(1))
      console.log(hand.bestScore())
      console.log(hand.length)
      assert.strictEqual hand.hasBlackJack(), true

  describe 'player wins', ->
    it 'should return player wins', ->
      hand.pop()
      hand.pop()
      hand.push(new Card
        rank: 1
        suit: 1
      )
      hand.push(new Card
        rank: 10
        suit: 1
      )
      dealerHand.pop()
      dealerHand.pop()
      dealerHand.push(new Card
        rank: 4
        suit: 2
      )
      dealerHand.push(new Card
        rank: 5
        suit: 3
      )
      assert.strictEqual hand.beats(dealerHand), true

