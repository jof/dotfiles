#!/usr/bin/env ruby

class Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end

print STDIN.readlines.shuffle.join
