Bezos = require '../src/bezos'

describe 'Bezos', ->
  beforeEach ->
    params =
      'Last':  'Bezos'
      'First': 'Jeffrey,Preston'
    bezos = new Bezos('secret')
    @signed = bezos.sign 'GET'
                       , 'example.com'
                       , '/path'
                       , params

  it 'sorts the parameters', ->
    @signed.should.match /\?First=/

  it 'URL-encodes', ->
    @signed.should.match /Jeffrey%2CPreston/

  it 'signs', ->
    @signed.should.match /&Signature=.*/

  it 'timestamps', ->
    @signed.should.match /&Timestamp=.*/
