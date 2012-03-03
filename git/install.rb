dirname = "rc"
target = [
  ".gitignore",
  ".gitconfig"
]

target.map do |fname|
  if ARGV[0] == "-f"
    `rm ~/#{fname}`
  end

  unless `ln -s \`pwd\`/#{fname} ~/#{fname}`
    puts "create #{i} alias"
  end
end
