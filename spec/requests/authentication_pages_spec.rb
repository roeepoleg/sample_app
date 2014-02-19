require 'spec_helper'

describe "Authentication" do

	subject { page	}

	describe "signin page" do

		before { visit signin_path }

		let(:submit) { "Sign in" }

		it { should have_content('Sign in') }
		it { should have_title('Sign in') }

		describe "invalid submission" do

	       before { click_button submit }

	       it { should have_title('Sign in') }
	       it { should have_selector('div.alert.alert-error') }

	       	describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
	    end

	    describe "submission with valid information" do

	    	let(:user) { FactoryGirl.create(:user) }

	      	before do
		        fill_in "Email",    with: user.email.downcase
		        fill_in "Password",	with: user.password
		        click_button submit 
	    	end

	    	it { should have_title(user.name) }
	    	it { should have_link('Profile',     	href: user_path(user)) }
	    	it { should have_link('Sign out',     	href: signout_path(user) )}
	    	it { should have_no_link('Sign in',		href: signin_path(user)) }

	    	describe "followed by signout" do
		        before { click_link "Sign out" }
		    	it { should have_link('Sign in') }
		    end
		end
	end
end
