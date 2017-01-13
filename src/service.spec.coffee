describe 'FlaskRestless Query Options', ->

  beforeEach module('app')

  it 'should add filter options', inject (ngQueryOptions)->
    options = ngQueryOptions
      .addFilterOption('f', '==', 'v')
      .addFilterOption('q', '!=', 'p')
      .build()
    expected =
      q: '{"filters":[{"name":"f","op":"==","val":"v"},{"name":"q","op":"!=","val":"p"}]}'
    assert.equal(options.q, expected.q)

  it 'should add filter', inject (ngQueryOptions)->
    options = ngQueryOptions
      .addFilter(
        name:'f'
        op: '=='
        val: 'v')
      .addFilter(
        name:'q'
        op: '!='
        val: 'p')
      .build()
    expected =
      q: '{"filters":[{"name":"f","op":"==","val":"v"},{"name":"q","op":"!=","val":"p"}]}'
    assert.equal(options.q, expected.q)

  it 'should add order by option', inject (ngQueryOptions)->
    options = ngQueryOptions
      .addOrderByOption('field', 'desc')
      .build()
    expected =
      q: '{"order_by":[{"field":"field","direction":"desc"}]}'
    assert.equal(options.q, expected.q)

  it 'should set page number', inject (ngQueryOptions)->
    options = ngQueryOptions
      .setPageNumber(11)
      .build()
    expected =
      page: 11
    assert.equal(options.page, expected.page)
