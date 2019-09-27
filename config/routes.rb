Rails.application.routes.draw do
  root to: "articles#index"
  get 'articles' => 'articles#index'

end
