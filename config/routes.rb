Riak::Application.routes.draw do
  resources :mongodb_audios do
    member do
      get 'download'
    end
  end

  resources :mysql_audios do
    member do
      get 'download'
    end
  end

  resources :riak_audios do
    member do
      get 'download'
    end
  end

  root :to => 'riak_audios#index'
end
