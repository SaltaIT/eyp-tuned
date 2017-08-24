define tuned::profile::vmrule($profile_name=$name, $key, $value) {

  include ::tuned

  concat::fragment{ "tuned.conf ${profile_name} vm data set ${name} ${key} ${value}":
    target  => "${tuned_profiles_basepath}/${profile_name}/tuned.conf",
    order   => '12',
    content => "${key}=${value}\n",
  }

}
