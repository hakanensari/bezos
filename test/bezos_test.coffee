Bezos = require '../src/bezos'

describe 'Bezos', ->
  beforeEach ->
    bezos = new Bezos('secret')
    @signedPath = bezos.sign 'example.com', '/path',
      'Last':  'Bezos'
      'First': 'Jeffrey,Preston'

  it 'sorts the parameters', ->
    @signedPath.should.match /\?First=/

  it 'URL-encodes', ->
    @signedPath.should.match /Jeffrey%2CPreston/

  it 'signs', ->
    @signedPath.should.match /&Signature=.*/
