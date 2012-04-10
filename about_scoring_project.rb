require File.expand_path(File.dirname(__FILE__) + '/edgecase')

#  This exercise took more than an hour

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# result = 0
# (1..6).each do |face|
#   count = dice.select { |n| n == face }.size
#   while count > 0
#     if count >= 3
#       result += (face == 1) ? 1000 : 100 * face
#       count -= 3
#     elsif face == 5
#       result += count * 50
#       count = 0
#     elsif face == 1
#       result += count * 100
#       count = 0
#     else
#       count = 0
#     end
#   end
# end
# result
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  return 0 if dice.empty?
  
  if dice.count == 1
    if dice[0] == 5
      return 5 * 10
    elsif dice[0] == 1
      return 1 * 100
    end
  end
  
  if dice.count == 4
    dice.sort
    one_count = count(dice, 1)
    five_count = count(dice, 5)
    
    if five_count >= 3
      score = 100 * 5
      3.times{dice.shift}
      if dice[0] == 5
        score += 50
        return score
      end
    end
    return (one_count * 100) + (five_count * 50) + 0
  end
  
  if dice.count == 3
    one_count = count(dice, 1)
    two_count = count(dice, 2) 
    three_count = count(dice, 3) 
    four_count = count(dice, 4) 
    five_count = count(dice, 5) 
    six_count = count(dice, 6) 

    if is_triple?(one_count)
      return 1000
    elsif is_triple?(two_count) 
      return 2 * 100
    elsif is_triple?(three_count)
      return 3 * 100
    elsif is_triple?(four_count)
      return 4 * 100
    elsif is_triple?(five_count)
      return 5 * 100
    elsif is_triple?(six_count)
      return 6 * 100
    end
  end
  
  if dice.count == 5
    dice.sort
    two_count = count(dice, 2)
    five_count = count(dice, 5)
    
    score = 0
    if two_count >= 3
      score += 2 * 100
    end
    3.times{dice.shift}
    
    score += five_count * 50
  end
end

def is_triple?(count)
  count == 3
end

def count(dice, number)
  dice.select{|x| x == number}.size
end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
