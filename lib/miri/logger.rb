module Logger
  def self.debug(message)
    puts "[DEBUG]: #{message}" if SHOW_DEBUG
  end

  def self.info(message)
    puts "[INFO]: #{message}"
  end

  def self.error(message)
    puts "[ERROR]: #{message}" 
  end
end
