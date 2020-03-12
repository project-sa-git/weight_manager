Rails.application.routes.draw do
  devise_for :users
# get 'graphs/index' は削除
root 'graphs#index'
# resource「s」ではない（updateに「:id」は不要）
resource :graphs, only: %i[index create update]
end
