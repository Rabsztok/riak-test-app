Riak::Application.routes.draw do
  scope 'audios/:model' do
    get '/', to: 'audios#index', as: 'audios'
    get '/new', to: 'audios#new', as: 'new_audio'
    get '/:id/download', to: 'audios#download', as: 'download_audio'
    get '/:id/name', to: 'audios#name', as: 'audio_name'
    delete '/:id/destroy', to: 'audios#destroy', as: 'destroy_audio'
  end

  root :to => 'audios#index'
end
