class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      name_s = name.to_s

      define_method("#{name_s}=") do |val|
        instance_variable_set("@#{name_s}", val)
      end

      define_method("#{name_s}") do
        instance_variable_get("@#{name_s}")
      end
    end
  end
end
