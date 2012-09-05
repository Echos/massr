# -*- coding: utf-8; -*-
require 'mongo_mapper'

module Massr
	class User
		include MongoMapper::Document
		safe
		
		key :massr_id,   :type => String,  :required => true ,:unique => true
		key :twitter_id, :type => String,  :required => true ,:unique => true
		key :name,       :type => String,  :required => true
		key :email,      :type => String,  :required => true

		timestamps!

		def self.create_by_registration_form( request )
			user = User.new( :massr_id => request[:massr_id] )
			user.update_profile( request )
			return user
		end

		def update_profile(request)
			self[:twitter_id] = request[:twitter_id]
			self[:name] = request[:name]
			self[:email] = request[:email]

			save!
			return self
		end
	end
end