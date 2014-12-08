# helper fn isNumber
isNumber = (n) -> not isNaN(parseFloat(n)) and isFinite(n)

# empty instance var
instance = null

# singleton
PrettySelectors = (text, obj) ->
  instance ?= new Selectors()
  instance.init(text, obj)
  instance.doTasks()
  return instance.result()

# class def
class Selectors
  init: (@input, @config = {}) ->
    @config.separator ?= 'dash'
    @config.selector ?= 'class'
    @config.maxWords ?= 0
    @output = null

  doTasks: ->
    if @input
      do @tokenize
      do @clean if @arr isnt false
      do @cook if @arr isnt false

    if @arr is false
      if @config.fallbackSelectorPrefix
        @input = @config.fallbackSelectorPrefix
        do @doTasks
      else
        @output = null

  tokenize: ->
    @arr = @input.match(/[a-z]+|[0-9]+/gi)
    return @arr = false unless @arr

  clean: ->
    while @arr.length
      item = @arr[0]
      if isNumber(item) is true then @arr.shift() else break

    result = []
    for item in @arr
      result.push(item)
      break if isNumber(item) is true

    @arr = result.length and result or false

  cook: ->
    @arr = (item.toLowerCase() for item in @arr)

    if @config.maxWords
      @arr.length = @config.maxWords if @arr.length > @config.maxWords

    separatorDictionary =
      dash: '-'
      'dash-case': '-'
      '-': '-'
      snake: '_'
      'snake_case': '_'
      '_': '_'
      camel: 'camel'
      'camelCase': 'camel'

    chosenSeparator = separatorDictionary[@config.separator]

    selectorDictionary =
      class: '.'
      id: '#'
      element: ''

    chosenSelector = selectorDictionary[@config.selector]

    if chosenSeparator is 'camel'
      for item, index in @arr
        if index > 0
          @arr[index] = item[0].toUpperCase() + item.slice(1)
        else
          @arr[index] = item

      @output = chosenSelector + @arr.join('')
    else
      @output = chosenSelector + @arr.join(chosenSeparator)

  result: ->
    @output

# exports
module.exports = PrettySelectors
