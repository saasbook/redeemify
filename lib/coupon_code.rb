class CouponCode
  # based on http://ericlippert.com/2013/11/14/a-practical-use-of-multiplicative-inverses/
  
  BASE = Time.parse 'January 1, 2016'
  PRODUCTS = (10..99)
  
  # Products: 10=english print, 11=english ebook, 12=spanish print,
  #   13=spanish ebook, 14=br print, 15=br ebook

  attr_reader :sequence_base, :generator, :errors
  delegate :generate, :format_string, :format_regex, :to => :generator
  
  def initialize(product=10, date = Time.now.midnight)
    raise ArgumentError.new("Product code must be in range #{PRODUCTS}") unless PRODUCTS.include? product
    @sequence_base = (sprintf CodeGenerator.format, product, days_since_base(date), 0, product).to_i
    @generator = CodeGenerator.new(@sequence_base)
    @errors = ActiveModel::Errors.new(self)
  end

  def self.generate_codes(product, howmany)
    gen = CouponCode.new(product)
    howmany.times { puts gen.generate }
  end
  
  def self.decode(val)
    obj = self.new(10) # any product will do
    result = obj.generator.decipher(val.to_i).to_s
    obj.errors.add(:base, "Invalid code (format mismatch)") and return nil unless result.to_s =~ CodeGenerator.format_regex
    product1, day, seq, product2 = [$1,$2,$3,$4].map(&:to_i)
    obj.errors.add(:base, "Invalid code (malformed)") and return nil unless product1==product2  &&  PRODUCTS.include?(product1)
    {:product => product1, :day => BASE + day.days, :seq => seq}
  end

  private

  def days_since_base(date)
    ((date - BASE) / 1.day).floor
  end

end
