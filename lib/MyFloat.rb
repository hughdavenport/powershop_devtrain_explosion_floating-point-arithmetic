class MyFloat
  # IEEE 754 single precesion (32 bits)
  # 1 bit sign, 8 bit exponent, 23 bit fraction
  OFFSET_BIAS = 127

  @value = 0

  def initialize(value = 0)
    @value = value
    # Limit to 32 bit
    @value &= (2**32-1)
  end

  def value()
    # Special value for 0
    if (fraction_bits() == 0 and exponent() == 0)
      return sign() ? -0.0 : 0.0
    end
    (-1)**sign() * fraction() * 2**(exponent()-OFFSET_BIAS)
  end

  def sign()
    # 1 bit 31 bits offset
    (@value >> 31) & 0x1
  end

  def exponent()
    # 8 bits 23 bits offset
    (@value >> 23) & 0xff
  end

  def fraction()
    # 23 bits (@value & 0x7fffff)
    # 1.b22b21b20..b2b1b0
    # 1 + sum(i=1..23)(b[23-i]*2**(-i))
    # or 1 + sum(i=0..22)(b[i]*(2**(-i-1))
    fraction = 1
    for i in 0..22
      fraction += ((@value >> (22 - i)) & 0x1) * 2**(-i-1)
    end
    fraction.to_f
  end

  def fraction_bits()
    @value & 0x7fffff
  end

  def to_s()
    @value.to_s(2)
  end

  def raw_val()
    @value
  end

end
