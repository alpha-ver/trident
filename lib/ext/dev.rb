class D

	def self.r()
    Dir['lib/ext/*.rb'].each do |file|
      reload file
    end

    Dir['config/initializers/*.rb'].each do |file|
      reload file
    end
  end

  def self.reload(file)
    ap "⟳ Reload file: " + file
    ap load file
  end

end

