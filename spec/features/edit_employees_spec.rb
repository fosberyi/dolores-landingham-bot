require "rails_helper"

feature "Edit employees" do
  scenario "from list of employees" do
    old_slack_username = "testusername"
    new_slack_username = "testusername3"
    create(:employee, slack_username: old_slack_username)

    login_with_oauth
    visit employees_path
    page.find(".button-edit").click
    fill_in "Slack username", with: new_slack_username
    click_on "Update Employee"

    expect(page).to have_content "Employee updated successfully"
    expect(page).to have_content new_slack_username
  end

  scenario "unsuccessfully due to an invalid username" do
    old_slack_username = "testusername"
    new_slack_username = "fakeusername3"
    create(:employee, slack_username: old_slack_username)

    login_with_oauth
    visit employees_path
    page.find(".button-edit").click
    fill_in "Slack username", with: new_slack_username
    click_on "Update Employee"

    expect(page).to have_content(
      I18n.t(
        'employees.errors.slack_username_in_org',
        slack_username: new_slack_username
      )
    )
  end
end
