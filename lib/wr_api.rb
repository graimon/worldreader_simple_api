module WrApi
  
  def self.env
    ENV.fetch('APP_ENV', 'development')
  end

  def self.production?; env=='production';end
  def self.staging?; env=='staging';end
  def self.test?; env=='test';end
  def self.development?; env=='development';end

  def self.root
    `pwd`.gsub("\n", '')
  end
    
end
