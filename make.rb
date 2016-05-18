$global_pos = 1
$envs = ["field", "marsh", "forest"]

def tile_type()
	$envs.sample	
end

def make_tile()
    {"env"=> tile_type()}
end

arr = *(1 .. 16)
$my_map = arr.each_with_object({}) { |v,my_map| my_map[v] = make_tile() }
print $my_map

def n()
   $global_pos -= 4
   print $global_pos
   if $global_pos > 0 && $global_pos < 17
   print "You are in a " + $my_map[$global_pos]["env"] + "\n"
   else
   print "You can't go that way" + "\n"
   $global_pos += 4
end
end

def s()
   $global_pos += 4
   print $global_pos
   if $global_pos < 17
   print "You are in a " + $my_map[$global_pos]["env"] + "\n"
   else
   print "You can't go that way" + "\n"
   $global_pos -= 4
end
end

def e()
   $global_pos += 1
   print $global_pos
   if $global_pos > 0 && $global_pos < 5
   print "You are in a " + $my_map[$global_pos]["env"] + "\n"
   else
   print "You can't go that way" + "\n"
   $global_pos -= 1
end
end

def w()
   $global_pos -= 1
   print $global_pos
   if $global_pos > 0
   print "You are in a " + $my_map[$global_pos]["env"] + "\n"
   else
   print "You can't go that way" + "\n"
   $global_pos += 1
   end
end

while true
 eval(gets.chomp)	
end
