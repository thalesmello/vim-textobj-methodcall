describe 'Ruby method selection'
  before
    new
    read t/fixtures/sample.rb
    setfiletype ruby
    syntax on
  end

  after
    close!
  end

  it 'load the file and is in the correct line'
    5
    Expect getline('.') == '     .first(10)'
  end

  it 'identifies a single parenthesis methodcall'
    5
    Expect textobj#methodcall#select_i() == ['v', [0, 5, 6, 0], [0, 5, 15, 0]]
  end
end
