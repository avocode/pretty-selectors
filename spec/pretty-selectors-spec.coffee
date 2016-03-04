PrettySelectors = require '../src/pretty-selectors'

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

    selector = PrettySelectors('koleno-44', fallbackSelectorPrefix: 'layer')
    expect(selector).toEqual('.koleno-44')

  it 'should return null', ->
    selector = PrettySelectors('900-800-700')
    expect(selector).toEqual(null)

    selector = PrettySelectors('@#$$^^&&&')
    expect(selector).toEqual(null)

    selector = PrettySelectors('$14.99')
    expect(selector).toEqual(null)

  it 'should return fallback', ->
    selector = PrettySelectors('$14.99', fallbackSelectorPrefix: 'layer')
    expect(selector).toEqual('.layer-14')

    selector = PrettySelectors('666', fallbackSelectorPrefix: 'layer')
    expect(selector).toEqual('.layer-666')

    selector = PrettySelectors('900-800-700', fallbackSelectorPrefix: 'layer')
    expect(selector).toEqual('.layer-900')

  it 'should return true for selector variable', ->
    expect(selector).toEqual(null)
