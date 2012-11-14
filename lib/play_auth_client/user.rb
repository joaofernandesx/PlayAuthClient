class User

	#attr_accessor :email, :first_name, :last_name

	#def initialize(email, fname, lname)

		#@email = email
		#@first_name = fname
		#@last_name = lname

	#end

	def self.posts_for(feed_url, length=2, perform_validation=false)
    posts = []
    open(feed_url) do |rss|
      posts = RSS::Parser.parse(rss, perform_validation).items
    end
    posts[0..length - 1] if posts.size > length
  end
  
end