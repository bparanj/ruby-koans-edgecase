# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  raise TriangleError if (a < 1) or (b < 1) or (c < 1)
  raise TriangleError if side_lengths_not_triangular?(a, b, c)
  
  return :equilateral if (a == b) and (a == c)
  return :isosceles if (a == b) and (a != c)
  return :isosceles if (a != b) and (b == c)
  return :isosceles if (a == c) and (b != c)
  return :scalene if (a != b) and (b != c) and (c != a)  
end

def side_lengths_not_triangular?(a, b, c)
   ((a + b) <= c) || ((b + c) <= a) || ((a + c) <= b)  
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end


