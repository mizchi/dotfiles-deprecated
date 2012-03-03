if ARGV[0] == '-f'
  `rm ~/.zshrc`
  `rm ~/.zsh`
end

unless `ln -s \`pwd\`/.zshrc ~/.zshrc`
end

unless `ln -s \`pwd\` ~/.zsh`
end
