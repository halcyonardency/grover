class sinatra {
   package { 'sinatra':
      ensure   => 'installed',
      provider => 'gem',
   }
}
