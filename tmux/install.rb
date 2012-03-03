if ARGV[0] == "-f"
  `rm ~/.tmux.conf`
end
unless `ln -s ~/rc/tmux/.tmux.conf ~/.tmux.conf`
  puts 'create ~/.tmux.conf'
end
