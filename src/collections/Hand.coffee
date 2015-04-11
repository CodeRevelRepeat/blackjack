class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if(@bestScore()>=21)
      @stand()
    else
      card = @deck.pop()
      @add(card)
      if(@bestScore()>=21)
        @stand()
      card
  stand: ->
    @deck.trigger( 'stand', @isDealer )

  deal: ->
    @reset()
    @push(@deck.pop())
    @push(@deck.pop())
    if(@isDealer)
      @at(0).flip()


  hasBlackJack: ->
    @length == 2 and @bestScore()==21

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
    else if @deck.player.bestScore()>21
      @stand()
    else if @bestScore() < @deck.player.bestScore()
      #hit
      @hit()
      #setTimeout for AI
      setTimeout(@AI.bind(@), 1500)
    #else
    else
      #stand
      @stand()
  bestScore: ->
    if @scores()[1]<=21
      @scores()[1]
    else
      @scores()[0]
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

   beats: (other) ->
      if other.hasBlackJack()
        console.log('Other guy has a black jack')
        false
      else if @hasBlackJack()
        console.log('I have a black jack!')
        true
      else if other.bestScore()>21
        console.log('Lol I win')
        true
      else if @bestScore()>21
        console.log('BUSTED!')
        false
      else if @bestScore() > other.bestScore()
        console.log('I win. Fair and square')
        true
      else
        console.log('uh... what?')


