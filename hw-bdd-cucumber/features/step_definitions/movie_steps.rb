# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
     Movie.create(movie)
  end

end

  
# Make sure that one string (regexp) occurs before or after another one
#   on the same page

When(/^I check the 'PG' and 'R' checkboxes$/) do
  visit movies_path
  check('ratings_PG')
  check('ratings_R')
end

And (/^I uncheck all other checkboxes$/) do
  uncheck('ratings_PG-13')
  uncheck('ratings_NC-17')
  uncheck('ratings_G')
end

And (/^I submit$/) do
  click_button('ratings_submit')
end
And (/^I should see PG and R in ratings colums$/) do
  if page.respond_to? :should
    page.find('#movies').should have_content("PG")
    page.find('#movies').should have_content("R")
  else
    assert page.find('#movies').has_content?("PG")
    assert page.find('#movies').has_content?("R")
  end
end
And (/^I should not see PG-13, G and NC-17 in ratings colums$/) do
  if page.respond_to? :should
    page.find('#movies').should have_no_content("PG-13")
    page.find('#movies').should have_no_content("<td>G</td>")
    page.find('#movies').should have_no_content("NC-17")
  else
    assert page.find('#movies').has_no_content?("PG-13")
    assert page.find('#movies').has_no_content?("<td>G</td>")
    assert page.find('#movies').has_no_content?("NC-17")
  end 
end
   
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    ex = e1+" "+e2
    expect(page).to have_content(ex)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  if uncheck.nil?
    rating_list.delete!("\"")
    rating_list.split(",").each do |a|
      uncheck("ratings_"+a.strip)
    end
  else
    rating_list.delete!("\"")
    rating_list.split(",").each do |a|
      uncheck("ratings_"+a.strip)
    end
  end
end

Then /I should see all the movies/ do
   page.should have_css("table#movies tr", :count=>11)
end
