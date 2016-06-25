describe 'JavaScript method selection'
  before
    new
    read t/fixtures/sample.js
    setfiletype javascript
    syntax on
  end

  after
    close!
  end

  it 'loads the file and is in the correct line'
    8
    Expect getline('.') == '            .filter(function (x) { return x != 4; })'
  end

  it 'identifies a single parenthesis methodcall'
    8
    Expect textobj#methodcall#select_i() == ['v', [0, 8, 13, 0], [0, 8, 52, 0]]
  end
end
