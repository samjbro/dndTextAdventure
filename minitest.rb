newFile = File.new(fileName, 'w+')
      File.open(fileName, 'w') {|f| f.write(YAML.dump($party)) }