describe 'Ruby method selection'
  before
    read t/fixtures/sample.rb
  end

  after
    bwipeout!
  end

  it 'load the file and is in the correct line'
    5
    Expect getline('.') == '     .first(10)'
  end
end
