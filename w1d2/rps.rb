

def comp_picker
  options = ["rock", "paper", "scissors"]
  comp_pick = options[rand(3)]
  comp_pick
end

def rps(choice)
  result = ""

  if choice == comp_pick
    result = "Draw!"
  elsif choice == "rock" && comp_pick == "paper"
    result = "You lose!"
  elsif choice == "rock" && comp_pick == "scissors"
    result = "You win!"
  elsif choice == "paper" && comp_pick == "rock"
    result = "You win!"
  elsif choice == "paper" && comp_pick == "scissors"
    result = "You lose!"
  elsif choice == "scissors" && comp_pick == "paper"
    result = "You win!"
  else
    result = "You lose!"
  end
  result
end

def result
  puts "Computer picked #{comp_picker}. #{rps(choice)}"
end

rps("paper")
