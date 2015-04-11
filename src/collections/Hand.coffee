class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  stand: ->
    @deck.trigger( 'stand', @isDealer )

  hasBlackJack: ->
    @length == 2 and @minScore()==21

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  AI: ->
    #reveal the first card if necessary
    if not @at(0).get('revealed')
      @at(0).set('revealed', true)
      setTimeout(@AI.bind(@), 1500)
    #if score is less than SOMETHING
    else if @deck.player.minScore()>21
      @stand()
    else if @minScore() < @deck.player.minScore()
      #hit
      @hit()
      #setTimeout for AI
      setTimeout(@AI.bind(@), 1500)
    #else
    else
      #stand
      @stand()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


