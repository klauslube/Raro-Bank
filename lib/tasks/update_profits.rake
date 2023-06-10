namespace :investments do
  desc 'Update investment profits'
  task update_profits: :environment do
    UserInvestment.find_each do |user_investment|
      UserInvestments::UpdateProfitJob.perform_later(user_investment.id)
    end
  end
end
