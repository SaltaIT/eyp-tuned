define tuned::profile::vmrule($profile_name=$name, $key, $value) {

  concat::fragment{ "tuned.conf ${profile_name} vm data set ${name} ${key} ${value}":
    target  => "/etc/tuned/${profile_name}/tuned.conf",
    order   => '12',
    content => "${key}=${value}\n",
  }

}
