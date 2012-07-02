if ARGV[0] == "-f"
  `rm ~/.tmux.conf`
end
unless `ln -s ~/dofiles/tmux/.tmux.conf ~/.tmux.conf`
  puts 'create ~/.tmux.conf'
end
