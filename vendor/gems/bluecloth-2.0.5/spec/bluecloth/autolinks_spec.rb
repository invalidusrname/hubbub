#!/usr/bin/env ruby
# encoding: utf-8

BEGIN {
	require 'pathname'
	basedir = Pathname.new( __FILE__ ).dirname.parent.parent
	
	libdir = basedir + 'lib'
	extdir = basedir + 'ext'
	
	$LOAD_PATH.unshift( libdir ) unless $LOAD_PATH.include?( libdir )
	$LOAD_PATH.unshift( extdir ) unless $LOAD_PATH.include?( extdir )
}

require 'spec'
require 'bluecloth'

require 'spec/lib/helpers'
require 'spec/lib/constants'
require 'spec/lib/matchers'


#####################################################################
###	C O N T E X T S
#####################################################################

describe BlueCloth, "auto-links" do
	include BlueCloth::TestConstants,
	        BlueCloth::Matchers

	it "supports HTTP auto-links" do
		the_indented_markdown( <<-"---" ).should be_transformed_into(<<-"---").without_indentation
		This is a reference to <http://www.FaerieMUD.org/>. You should follow it.
		---
		<p>This is a reference to <a href="http://www.FaerieMUD.org/">http://www.FaerieMUD.org/</a>. You should follow it.</p>
		---
	end

	it "supports FTP auto-link" do
		the_indented_markdown( <<-"---" ).should be_transformed_into(<<-"---").without_indentation
		Why not download your very own chandelier from <ftp://ftp.usuc.edu/pub/foof/mir/>?
		---
		<p>Why not download your very own chandelier from <a href="ftp://ftp.usuc.edu/pub/foof/mir/">ftp://ftp.usuc.edu/pub/foof/mir/</a>?</p>
		---
	end

end


