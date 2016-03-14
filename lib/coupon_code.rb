class CouponCode

  # based on http://ericlippert.com/2013/11/14/a-practical-use-of-multiplicative-inverses/
  
  BASE = Time.parse 'January 1, 2016'
  PRODUCTS = (10..19)
  
  # Products: 10=english print, 11=english ebook, 12=spanish print,
  #   13=spanish ebook, 14=br print, 15=br ebook

  FORMAT = '%02d%04d%02d%04d'  # prod,day,seq
  FORMAT_REGEX = /^(\d\d)(\d\d\d\d)(\d\d)(\d\d\d\d)$/
  ALLOWED_CHARS = 'ABCDEFGH' + 'JKLMNPQR' + 'STUVWXYZ' + '23456789'

  attr_reader :sequence_base, :generator
  delegate :generate, :to => :generator
  
  def initialize(product=10, date = Time.now.midnight)
    @sequence_base = (sprintf FORMAT, product, days_since_base(date), product, 0).to_i
    @generator = CodeGenerator.new(@sequence_base)
  end

  def self.decode(val)
    obj = self.new(10) # any product will do
    result = obj.generator.decipher(val.to_i).to_s
    return nil unless result.to_s =~ FORMAT_REGEX
    product1, day, product2, seq = [$1,$2,$3,$4].map(&:to_i)
    return nil unless product1==product2  &&  PRODUCTS.include?(product1)
    {:product => product1, :day => BASE + day.days, :seq => seq}
  end

  private

  def days_since_base(date)
    ((date - BASE) / 1.day).floor
  end

end
