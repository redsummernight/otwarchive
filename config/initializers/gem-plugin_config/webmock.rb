if Rails.env.test?
  WebMock.disable_net_connect!(allow_localhost: true, allow: [
    ArchiveConfig.ES_URL
  ])
end
