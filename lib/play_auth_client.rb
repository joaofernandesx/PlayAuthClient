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
			@email=email || "not defined"
		end

		def to_s
			"ID: "+@id.to_s+" # Name: "+@f_name+" "+@l_name+" # Email: "+@email
		end

		#return all users in json format
		def self.get_all_users_json
			vars = APP_CONFIG
			user_path = vars['url_server']+vars['url_port']+vars['default_api'] + vars['url_get_users']
			json_users = JSON.parse(RestClient.get user_path) if user_path
			return json_users
		end

		#return all users on array of user objects
		def self.get_all_users 
			users = Array.new
			User.get_all_users_json.each do |u|
				users.push  User.new(u['id'],u['first_name'],u['last_name'],u['email'])
			end
			return users
		end
	
		#return user from user_id input, if found
		def self.get_user_by_id(user_id)
			#user_path = APP_CONFIG['url_get_users']
			vars = APP_CONFIG
			user_path = vars['url_server']+vars['url_port']+vars['default_api'] + vars['url_get_users']
			user_req = JSON.parse(RestClient.get user_path+user_id) if user_path
			if user_req
				return User.new(user_req['id'].to_s,user_req['first_name'],user_req['last_name'],user_req['email'])
			end
			return nil
		end

		#return user from any input parameter with value
		def self.get_user_by_?(param,val)
			users = User.get_all_users_json
			if users
				users.each do |u|
					if u[param].include? val
						return User.new(u['id'],u['first_name'],u['last_name'],u['email'])
					end
				end
			end
			return nil
		end

	end
end
