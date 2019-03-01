FILENAME = "water_bottles.csv" 
class Meta
	
	
	def initialize 
  	@file_name = ""
  end

	def class_name
		basedir = '.'
		files = Dir.glob("*.csv")
		full_name =files.join("")
		name_with_extsn = File.basename(full_name,File.extname(full_name))
		@file_name = name_with_extsn.split("_").map(&:capitalize).join("")
		klass = Object.const_set(@file_name, Class.new)
		p "#{klass}"
		values = read_header
		attribute(klass, values)
	end
	def attribute(klass,values)
		klass.class_eval do
			define_method :initialize do |hash = {}|
				p @id = hash[:id]
				p @type = hash[:type]
				p @price = hash[:price]
				p @company = hash[:company]
			end	
    	values.each do |i|
    		  define_method "get_#{i}"  do
      		  instance_variable_get("@#{i}")
    		 	end
    		 	define_method "set_#{i}" do |val|
      		  instance_variable_set("@#{i}", val)
    		 	end
    	end
    	
    	read = File.read(FILENAME)
    	read.split("\n").each do |x|
    		var = x.split(",")
    		if var[0] != "id"   		
    			 push = klass.new({id:var[0] , type:var[1] , price:var[2] , company:var[3]})
				end
    	end 
 		 end
	end
	

	def read_header
		read = File.read(FILENAME)
    read.split("\n").each do |x|
      var = x.split(",")
     	if var[0]=="id"
    	  return{
	    		id: var[0],
	    		type: var[1],
	    		price: var[2],
	    		company: var[3]
    		}
    	end
    
   end
   
   
	end
	

end

obj = Meta.new
obj.class_name


# define_method :initialize do |byte_string|
#       @values = byte_string.unpack(pattern)
# end