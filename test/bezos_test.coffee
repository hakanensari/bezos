Bezos = require '../src/bezos'

describe 'Bezos', ->
  beforeEach ->
    bezos = new Bezos('secret')
    @signed = bezos.sign
      host:  'example.com'
      path:  '/path'
      query: 'Last=Bezos&First=Jeffrey,Preston'

  it 'sorts the parameters', ->
    @signed.query.should.match /^First=/

  it 'URL-encodes', ->
    @signed.query.should.match /Jeffrey%2CPreston/

  it 'signs', ->
    @signed.query.should.match /&Signature=.*/
