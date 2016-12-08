class CodeGenerator
  COPRIME = Figaro.env.code_coprime!.to_i
  GENERATOR = Figaro.env.code_generator!.to_i

  attr_reader :coprime, :generator, :seq

  def initialize(sequence_start=0,coprime=COPRIME,generator=GENERATOR)
    @coprime,@generator = coprime,generator
    @seq = 0 + sequence_start
  end
  def generate
    code = @seq * @coprime % @generator
    @seq += 1
    code
  end
  def decipher(num)
    num * coprime_inverse % @generator
  end

  def coprime_inverse
    @coprime_inverse ||= multiplicative_inverse(@coprime,@generator)
  end
  
  private

  def multiplicative_inverse(num, mod)
    extended_euclidean_division(num, mod)[0] % mod
  end
  def extended_euclidean_division(a,b)
    if b.zero?
      [1, 0]
    else
      q = a/b
      r = a%b
      s,t = extended_euclidean_division(b, r)
      [t, s-q*t]
    end
  end

end
