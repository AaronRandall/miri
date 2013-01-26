module Logger
  def self.info(message)
    puts "[INFO]: #{message}"
  end

  def self.error(message)
    puts "[ERROR]: #{message}"
  end
end
