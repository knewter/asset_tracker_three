Given /^the following clients:$/ do |clients|
  Client.create!(clients.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) client$/ do |pos|
  visit clients_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following clients:$/ do |expected_clients_table|
  expected_clients_table.diff!(tableish('table tr', 'td,th'))
end
