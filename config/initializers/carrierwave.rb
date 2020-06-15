CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAURMLGVLIBRI3DC5K',        # required unless using use_iam_profile
    aws_secret_access_key: '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',    # required unless using use_iam_profile

  }
  config.fog_directory  = 'bien-reviews-zomback'               # required
end
