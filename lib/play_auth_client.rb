require 'yaml'

module PlayAuthClient
	
	path = File.expand_path '../',__FILE__
	APP_CONFIG = YAML.load_file(path + '/config.yml')

	class User

		attr_accessor :id, :f_name, :l_name, :email

		def initialize(id,fname,lname,email)
			@id=id
			@f_name=fname
			@l_name=lname
			@email=email
		end

		def to_s
			"ID: "+@id.to_s+" # Name: "+@f_name+" "+@l_name+" # Email: "+@email
		end


		def self.get_all_users 
			
			user_path = APP_CONFIG['url_get_users']
			json_users = JSON.parse(RestClient.get user_path) if user_path

			users = Array.new

			json_users.each do |u|

				users.push  User.new(u['id'],u['first_name'],u['last_name'],u['email'])

			end

			return users
		end
	
		def self.get_user_by_id(user_id)
			user_path = APP_CONFIG['url_get_users']
			user_req = JSON.parse(RestClient.get user_path+user_id) if user_path
			if user_req
				return User.new(user_req['id'].to_s,user_req['first_name'],user_req['last_name'],user_req['email'])
			end
			return nil
		end
	end
end
