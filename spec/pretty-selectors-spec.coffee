PrettySelectors = require '..'

describe 'Transform boring text to beautiful CSS selectors', ->
  selector = null
  random = null

  beforeEach ->
    selector = null

  it 'should transform given text to a selector', ->
    selector = PrettySelectors('Moje mama', { separator: 'snake', selector: 'id', maxWords: 3})
    expect(selector).toEqual('#moje_mama')

    selector = PrettySelectors('23456 ahoj')
    expect(selector).toEqual('.ahoj')

    selector = PrettySelectors('tomas je pan', {separator: 'camel'})
    expect(selector).toEqual('.tomasJePan')

    selector = PrettySelectors('Tento text 666 a take 999', {selector: 'element'})
    expect(selector).toEqual('tento-text-666')

  it 'should return null', ->
    selector = PrettySelectors('900-800-700')
    expect(selector).toEqual(null)

    selector = PrettySelectors('@#$$^^&&&')
    expect(selector).toEqual(null)

    selector = PrettySelectors('$14.99')
    expect(selector).toEqual(null)

  it 'should return fallbackPrefix', ->
    selector = PrettySelectors('$14.99', fallbackSelectorPrefix: 'layer 42')
    expect(selector).toEqual('.layer-42')

  it 'should return true for selector variable', ->
    expect(selector).toEqual(null)
