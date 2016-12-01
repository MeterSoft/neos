class String

  def to_price
    "%.2f" % self
  end
end

class Fixnum

  def to_price
    "%.2f" % self
  end
end

class Float

  def to_price
    "%.2f" % self
  end
end