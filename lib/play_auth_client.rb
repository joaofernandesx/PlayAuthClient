module PlayAuthClient
	
	class User

		attr_accessor :f_name, :l_name, :email

		def initialize(fname,lname,email)
			@f_name=fname
			@l_name=lname
			@email=email
		end

		def to_s
			"Name: "+@f_name+" "+@l_name+" # Email: "+@email
		end


		def self.get_all_users
			user_path = "http://localhost:3001/users/"
			return JSON.parse(RestClient.get user_path) if user_path
		end
	
		def self.get_user_by_id(user_id)
			user_path = "http://localhost:3001/users/"
			user_req = JSON.parse(RestClient.get user_path+user_id) if user_path
			if user_req
				return User.new(user_req['first_name'],user_req['last_name'],user_req['email'])
			end
			return nil
		end
	end
end
