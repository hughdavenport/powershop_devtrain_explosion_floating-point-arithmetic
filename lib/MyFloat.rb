class MyFloat
  # IEEE 754 single precesion (32 bits)
  # 1 bit sign, 8 bit exponent, 23 bit fraction
  OFFSET_BIAS = 127

  SIGN_POSITION = 31
  SIGN_BITS = 0x1
  EXPONENT_POSITION = 23
  EXPONENT_BITS = 0xff
  FRACTION_POSITION = 0
  FRACTION_BITS = 0x7fffff

  # IEEE 754 has an explicit bit set above the fraction part (as in scientific notation)
  EXPLICIT_FRACTION_BIT = 0x800000

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
    (@value >> SIGN_POSITION) & SIGN_BITS
  end

  def exponent()
    # 8 bits 23 bits offset
    (@value >> EXPONENT_POSITION) & EXPONENT_BITS
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
    @value & FRACTION_BITS
  end

  def to_s()
    @value.to_s(2)
  end

  def raw_value()
    @value
  end

  def add(other)
    result = @value
    shift = exponent() - other.exponent()
    sign = sign()
    exponent = exponent()
    fraction_bits = fraction_bits() | EXPLICIT_FRACTION_BIT # add in implicit 23rd bit
    other_fraction_bits = other.fraction_bits | EXPLICIT_FRACTION_BIT
    if shift > 0
      other_fraction_bits >>= shift
    elsif shift < 0
      exponent = other.exponent()
      fraction_bits >>= -shift
    end
    fraction_bits += other_fraction_bits
    while fraction_bits >= (EXPLICIT_FRACTION_BIT << 1)
      exponent += 1
      fraction_bits >>= 1
    end
    MyFloat.new ((sign << SIGN_POSITION) | (exponent << EXPONENT_POSITION) | (fraction_bits & FRACTION_BITS))
  end

end
