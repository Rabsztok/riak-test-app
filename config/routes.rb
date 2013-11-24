Riak::Application.routes.draw do
  resources :riak_audios do
    member do
      get 'download'
    end
  end

  root :to => 'riak_audios#index'
end
