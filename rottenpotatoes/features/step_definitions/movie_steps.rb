Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.index(e1).should < page.body.index(e2)
end

And /I should not see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.index(e1).should > page.body.index(e2)
end

Then /^(?:|I )should see all of the movies/ do
  Movie.all.each do |movie|
    title = movie["title"]
    if page.respond_to? :should
      page.should have_content(title)
    else
      assert page.has_content?(title)
    end
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end