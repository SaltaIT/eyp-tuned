define tuned::profile::vmrule (
                                $key,
                                $value,
                                $profile_name = $name,
                              ) {

  include ::tuned

  concat::fragment{ "tuned.conf ${profile_name} vm data set ${name} ${key} ${value}":
    target  => "${tuned::params::tuned_profiles_basepath}/${profile_name}/tuned.conf",
    order   => '12',
    content => "${key}=${value}\n",
  }

}
