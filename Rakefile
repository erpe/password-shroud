task :default do
  puts "run 'rake make_pot_file' to collect translation keys"
end

task :make_pot_file do
  findings = []
  dir = './share/password-shroud'
  regex = Regexp.compile(/i18n.tr\(\"(.*)\"\)/)

  Dir.chdir(dir) do
    Dir.glob('*.qml').each do |f|
      puts "search in #{f}"
      File.open(f).each_with_index do |line,i|
        if data = line.match(regex)
          prefix = "#: #{dir}/#{f}"
          data.captures.each do |key|
            puts "hit in line: #{i}: #{key}"
            findings << "#{prefix}:#{i}"
            findings << "msgid \"#{key}\"" 
            findings << "msgstr \"\"" 
            findings << ""
          end
        end
      end
    end
  end
  File.open("./po/password-shroud.pot", "w+") do |file|
    file.puts(findings)
  end
end
