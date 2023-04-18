require 'set'
# We are going to find the most influential people in the in-it network.
# Each user in in-it follows a group of zero or more people.
# The list of "followings" are given to us as an array of pairs. Each pair is
# in the form of [x, y] which means the user with username x
# is following the user with username y.

# A user X influences a user Y if
#    Y follows X or
#    Y follows one of the users that X influences

# Also, a user cannot follow herself.

# The output should be the list of username of the users that each influence
# the most number of people in the network and no one else influences that many
# users that they each do.

# For example, suppose Ross, Monica, Phoebe, Joey, Rachel and Chandler are the
# in-it users and the input is given as follows:

#[
#  ['Ross', 'Monica'],
#  ['Ross', 'Rachel']
#  ['Rachel', 'Monica']
#  ['Joey', 'Phoebe']
#  ['Chandler', 'Joey']
#  ['Ross', 'Chandler']
#  ['Chandler', 'Ross']
#]

# Then Monica influences Rachel, Ross and Chandler
# and Phoebe influences Joey, Chandler and Ross
# and no one else in the network influences 3 or more people, therefore
# Monica and Phoebe are the most influential people in the network and a correct
# output would be ['Monica', 'Phoebe']

# Write the body of the find_influencers method below that
# gets a list of followings as input and returns the list of
# most influential users in the network.

# Once complete, hit 'run' to test your method agains sample inputs


def find_influencers(followings)
  return [] if followings == []
  final_lookup = {}
  social_lookup = build_initial_lookup(followings)
  social_lookup.each do |influencer, followers|
    collection = []
    indirect_and_direct_followers = grab_indirect_followers(social_lookup, influencer, collection)
    final_lookup[influencer] = indirect_and_direct_followers.count
  end
  max_value = final_lookup.values.max
  top_influencers = final_lookup.filter{|k, v| v == max_value}.keys
  return top_influencers
end

def grab_indirect_followers(hash, name, collection)
  return collection if Set.new(hash[name]).subset?(Set.new(collection)) || hash[name].nil?
  collection = collection | hash[name]
  followers = hash[name]
  followers.each do |f|
    if !collection.include?(f)
      collection << f
    end
    if !hash[f].nil?
      collection | hash[f]
    end
    collection = (collection | grab_indirect_followers(hash, f, collection))
  end
  collection = collection.filter{|n| n != name}
end


def build_initial_lookup(arr)
  social_lookup = Hash.new
  arr.each do |a|
    if social_lookup[a[1]].nil?
      social_lookup[a[1]] = [a[0]]
    else
      social_lookup[a[1]] << a[0]
    end
  end
  return social_lookup
end





#############################
# Do not edit below this line

inputs = [
  [
    ["Ross", "Monica"], ["Ross", "Rachel"], ["Rachel", "Monica"], ["Joey", "Phoebe"], ["Chandler", "Joey"], ["Ross", "Chandler"], ["Chandler", "Ross"]
    ],
    [],
    [
      ["a", "c"], ["c", "b"]
  ],
    [
      ["a", "b"], ["b", "c"], ["c", "a"]
  ],
    [
      ["a", "b"], ["a", "c"], ["a", "d"]
  ],
    [
      ["a", "b"], ["b", "c"], ["c", "d"]
  ],
    [
      ["a", "b"], ["b", "c"], ["c", "d"], ["c", "e"]
  ],
    [
      ["user2", "user3"], ["user2", "user6"], ["user3", "user4"], ["user3", "user10"], ["user7", "user8"], ["user8", "user6"], ["user9", "user5"], ["user9", "user10"]
  ],
    [
      ["user1", "user10"], ["user4", "user10"], ["user5", "user4"], ["user5", "user7"], ["user6", "user4"], ["user6", "user7"]
  ],
    [
      ["user1", "user11"], ["user2", "user1"], ["user2", "user5"], ["user2", "user7"], ["user2", "user9"], ["user3", "user12"], ["user4", "user1"], ["user4", "user11"], ["user5", "user7"], ["user5", "user9"], ["user6", "user4"], ["user6", "user9"], ["user7", "user1"], ["user7", "user4"], ["user8", "user3"], ["user9", "user1"], ["user9", "user3"], ["user9", "user5"], ["user9", "user7"], ["user9", "user8"], ["user9", "user11"], ["user10", "user1"], ["user10", "user5"], ["user11", "user6"], ["user11", "user9"], ["user12", "user1"], ["user12", "user4"], ["user12", "user10"]
  ],
    [
      ["user2", "user7"], ["user2", "user8"], ["user2", "user13"], ["user3", "user5"], ["user3", "user12"], ["user5", "user2"], ["user5", "user4"], ["user6", "user2"], ["user9", "user6"], ["user10", "user11"], ["user11", "user1"], ["user11", "user7"], ["user11", "user12"], ["user12", "user2"], ["user12", "user4"], ["user12", "user6"], ["user12", "user10"], ["user13", "user1"], ["user13", "user3"]
  ],
    [
      ["user1", "user5"], ["user2", "user7"], ["user2", "user9"], ["user2", "user14"], ["user4", "user1"], ["user4", "user7"], ["user6", "user7"], ["user8", "user9"], ["user8", "user13"], ["user9", "user11"], ["user9", "user13"], ["user10", "user4"], ["user10", "user13"], ["user10", "user14"], ["user11", "user2"], ["user12", "user5"], ["user12", "user10"], ["user12", "user14"], ["user14", "user10"]
  ],
    [
      ["user1", "user4"], ["user2", "user4"], ["user2", "user5"], ["user3", "user4"], ["user3", "user5"], ["user3", "user7"], ["user3", "user10"], ["user5", "user2"], ["user5", "user13"], ["user6", "user7"], ["user7", "user1"], ["user7", "user9"], ["user8", "user6"], ["user8", "user11"], ["user9", "user10"], ["user11", "user4"], ["user11", "user5"], ["user11", "user8"], ["user11", "user10"], ["user11", "user14"], ["user12", "user2"], ["user12", "user4"], ["user12", "user6"], ["user12", "user13"], ["user14", "user2"], ["user14", "user4"], ["user14", "user9"], ["user15", "user3"], ["user15", "user4"], ["user15", "user11"], ["user15", "user14"]
  ],
    [
      ["user1", "user10"], ["user1", "user11"], ["user2", "user6"], ["user2", "user11"], ["user4", "user3"], ["user4", "user16"], ["user5", "user2"], ["user5", "user13"], ["user7", "user5"], ["user7", "user6"], ["user8", "user1"], ["user9", "user3"], ["user10", "user13"], ["user11", "user12"], ["user12", "user9"], ["user13", "user2"], ["user13", "user7"], ["user13", "user10"], ["user14", "user5"], ["user14", "user6"], ["user14", "user10"], ["user15", "user16"], ["user16", "user5"]
  ],
    [
      ["user1", "user14"], ["user2", "user7"], ["user3", "user6"], ["user3", "user13"], ["user4", "user9"], ["user4", "user16"], ["user5", "user4"], ["user5", "user9"], ["user5", "user17"], ["user6", "user3"], ["user6", "user4"], ["user6", "user9"], ["user7", "user4"], ["user7", "user8"], ["user7", "user11"], ["user7", "user13"], ["user8", "user2"], ["user8", "user12"], ["user10", "user5"], ["user10", "user12"], ["user10", "user15"], ["user11", "user15"], ["user12", "user7"], ["user13", "user3"], ["user14", "user8"], ["user15", "user8"], ["user16", "user2"], ["user16", "user5"], ["user16", "user9"], ["user17", "user2"], ["user17", "user16"]
  ],
    [
      ["user1", "user6"], ["user1", "user8"], ["user6", "user7"], ["user6", "user15"], ["user6", "user18"], ["user9", "user16"], ["user10", "user12"], ["user11", "user14"], ["user13", "user8"], ["user14", "user17"], ["user15", "user3"], ["user15", "user4"]
  ],
    [
      ["user1", "user10"], ["user3", "user2"], ["user4", "user6"], ["user4", "user8"], ["user4", "user9"], ["user4", "user15"], ["user5", "user3"], ["user7", "user3"], ["user7", "user9"], ["user9", "user16"], ["user12", "user4"], ["user14", "user9"], ["user15", "user19"], ["user16", "user3"], ["user18", "user4"]], [["user1", "user6"], ["user1", "user19"], ["user2", "user6"], ["user3", "user5"], ["user4", "user5"], ["user4", "user7"], ["user4", "user11"], ["user5", "user2"], ["user5", "user12"], ["user5", "user20"], ["user11", "user6"], ["user11", "user15"], ["user11", "user19"], ["user12", "user8"], ["user12", "user13"], ["user14", "user1"], ["user14", "user18"], ["user16", "user13"], ["user17", "user16"], ["user20", "user13"]
  ],
    [
      ["user1", "user4"], ["user1", "user9"], ["user1", "user17"], ["user2", "user3"], ["user3", "user17"], ["user4", "user2"], ["user4", "user3"], ["user5", "user2"], ["user6", "user8"], ["user6", "user19"], ["user7", "user3"], ["user7", "user5"], ["user7", "user18"], ["user8", "user11"], ["user9", "user11"], ["user11", "user8"], ["user12", "user10"], ["user12", "user20"], ["user13", "user21"], ["user14", "user10"], ["user15", "user5"], ["user17", "user13"], ["user17", "user15"], ["user20", "user3"], ["user20", "user13"], ["user20", "user14"], ["user21", "user4"], ["user21", "user17"]
  ],
    [
      ["user3", "user14"], ["user3", "user17"], ["user4", "user9"], ["user4", "user20"], ["user5", "user7"], ["user5", "user18"], ["user6", "user13"], ["user8", "user1"], ["user8", "user14"], ["user10", "user8"], ["user10", "user13"], ["user11", "user13"], ["user13", "user10"], ["user14", "user3"], ["user14", "user7"], ["user19", "user15"], ["user19", "user16"], ["user21", "user5"]
  ],
    [
      ["user1", "user10"], ["user2", "user21"], ["user3", "user8"], ["user3", "user9"], ["user3", "user16"], ["user3", "user20"], ["user4", "user5"], ["user4", "user17"], ["user6", "user13"], ["user7", "user8"], ["user8", "user2"], ["user8", "user9"], ["user8", "user19"], ["user9", "user10"], ["user9", "user14"], ["user10", "user23"], ["user11", "user5"], ["user11", "user15"], ["user11", "user22"], ["user12", "user10"], ["user12", "user18"], ["user12", "user19"], ["user12", "user20"], ["user13", "user12"], ["user14", "user20"], ["user15", "user16"], ["user16", "user3"], ["user16", "user5"], ["user16", "user19"], ["user18", "user10"], ["user18", "user22"], ["user19", "user11"], ["user19", "user20"], ["user20", "user1"], ["user20", "user21"], ["user21", "user5"], ["user21", "user7"], ["user21", "user11"], ["user21", "user17"], ["user22", "user20"]
  ],
    [
      ["user3", "user16"], ["user5", "user3"], ["user7", "user13"], ["user8", "user1"], ["user8", "user11"], ["user9", "user4"], ["user9", "user18"], ["user10", "user16"], ["user12", "user24"], ["user13", "user10"], ["user13", "user15"], ["user13", "user16"], ["user15", "user19"], ["user16", "user23"], ["user17", "user5"], ["user17", "user10"], ["user18", "user4"], ["user20", "user9"], ["user22", "user4"], ["user24", "user2"]
  ],
    [
      ["user2", "user23"], ["user3", "user18"], ["user4", "user15"], ["user4", "user22"], ["user5", "user2"], ["user5", "user9"], ["user5", "user23"], ["user6", "user24"], ["user7", "user9"], ["user8", "user17"], ["user10", "user7"], ["user10", "user16"], ["user12", "user8"], ["user12", "user25"], ["user13", "user19"], ["user14", "user5"], ["user14", "user25"], ["user17", "user18"], ["user18", "user4"], ["user19", "user18"], ["user20", "user22"], ["user20", "user24"], ["user21", "user6"], ["user21", "user10"], ["user22", "user1"], ["user22", "user19"], ["user23", "user1"], ["user23", "user16"], ["user23", "user22"], ["user24", "user8"], ["user25", "user7"], ["user25", "user8"], ["user25", "user10"]
  ],
    [
      ["user1", "user10"], ["user1", "user13"], ["user2", "user6"], ["user2", "user11"], ["user2", "user12"], ["user2", "user22"], ["user3", "user15"], ["user4", "user2"], ["user4", "user18"], ["user4", "user22"], ["user5", "user11"], ["user5", "user15"], ["user5", "user19"], ["user5", "user25"], ["user6", "user10"], ["user6", "user12"], ["user7", "user18"], ["user8", "user2"], ["user8", "user3"], ["user8", "user5"], ["user8", "user7"], ["user8", "user13"], ["user8", "user24"], ["user9", "user15"], ["user11", "user24"], ["user13", "user9"], ["user13", "user17"], ["user14", "user16"], ["user15", "user6"], ["user15", "user10"], ["user15", "user13"], ["user16", "user2"], ["user16", "user25"], ["user17", "user9"], ["user17", "user11"], ["user17", "user14"], ["user17", "user20"], ["user18", "user20"], ["user19", "user9"], ["user20", "user14"], ["user20", "user18"], ["user21", "user5"], ["user21", "user6"], ["user21", "user8"], ["user22", "user3"], ["user22", "user12"], ["user22", "user13"], ["user23", "user24"], ["user24", "user14"], ["user24", "user15"], ["user24", "user26"], ["user25", "user2"], ["user25", "user14"], ["user26", "user8"], ["user26", "user11"], ["user26", "user22"], ["user26", "user23"]
  ],
    [
      ["user1", "user9"], ["user1", "user19"], ["user1", "user26"], ["user2", "user19"], ["user3", "user1"], ["user3", "user7"], ["user3", "user9"], ["user3", "user20"], ["user3", "user27"], ["user4", "user1"], ["user4", "user12"], ["user4", "user18"], ["user5", "user2"], ["user5", "user19"], ["user6", "user16"], ["user8", "user21"], ["user9", "user2"], ["user9", "user25"], ["user10", "user7"], ["user10", "user9"], ["user11", "user1"], ["user11", "user6"], ["user11", "user17"], ["user12", "user6"], ["user12", "user14"], ["user12", "user19"], ["user12", "user26"], ["user13", "user2"], ["user14", "user4"], ["user15", "user2"], ["user15", "user3"], ["user15", "user4"], ["user15", "user6"], ["user15", "user10"], ["user15", "user13"], ["user17", "user4"], ["user17", "user5"], ["user17", "user7"], ["user17", "user26"], ["user18", "user2"], ["user18", "user26"], ["user19", "user8"], ["user19", "user9"], ["user19", "user11"], ["user19", "user16"], ["user19", "user24"], ["user20", "user18"], ["user21", "user6"], ["user21", "user7"], ["user21", "user19"], ["user22", "user1"], ["user22", "user18"], ["user22", "user26"], ["user23", "user8"], ["user24", "user3"], ["user24", "user6"], ["user24", "user8"], ["user24", "user16"], ["user24", "user27"], ["user25", "user22"], ["user26", "user2"], ["user26", "user27"], ["user27", "user2"], ["user27", "user21"]
    ],
    [
      ["user1", "user7"], ["user3", "user14"], ["user4", "user28"], ["user7", "user8"], ["user7", "user12"], ["user12", "user6"], ["user12", "user14"], ["user13", "user2"], ["user13", "user9"], ["user13", "user20"], ["user13", "user24"], ["user15", "user6"], ["user16", "user3"], ["user17", "user1"], ["user17", "user10"], ["user22", "user5"], ["user22", "user16"], ["user24", "user19"], ["user24", "user27"], ["user25", "user20"], ["user25", "user27"], ["user26", "user20"], ["user26", "user23"]
      ]
    ]

outputs = [
  ["Monica", "Phoebe"],
  [],
  ["b"],
  ["a", "b", "c"],
  ["b", "c", "d"],
  ["d"],
  ["d", "e"],
  ["user10", "user6"],
  ["user10"],
  ["user1", "user10", "user11", "user12", "user3", "user4", "user5", "user6", "user7", "user8", "user9"],
  ["user1", "user4", "user7", "user8"],
  ["user5", "user7"],
  ["user4"],
  ["user3"],
  ["user9"],
  ["user3", "user4"],
  ["user2"],
  ["user13", "user6"],
  ["user13", "user15", "user17", "user2", "user21", "user3", "user4", "user5"],
  ["user7"],
  ["user23"],
  ["user23"],
  ["user1", "user15"],
  ["user10", "user12"],
  ["user16"], ["user14"]
]

score = 0
inputs.each_with_index do |input, index|
  expected_output = outputs[index]
  print "Test #{index + 1}: "
  begin
    if expected_output.sort == find_influencers(input).sort
      puts "Correct! :)"
      score += 1
    else
      puts "Incorrect :("
    end
  rescue Exception => e
    puts "Errored :|"
  end
end

puts "Score: #{score} / #{inputs.count}"
